#!/usr/local/bin/namd2
# keep water from entering gaps between protein and lipids
# need membrane be in the XY plane!
# (C) A. Aksimentiev (alek@ks.uiuc.edu) 

# This script will prevent water molecules in your namd simulations 
# from entering into the hydrophobic part of the membrane. This can be very 
# useful for initial equilibration of a protein/lipid/water system.  
# It works with recent NAMD binaries (version 2.4 and higher), which 
# has clearconfig command.

# Brief description:
# At initialization, the arrays of namd atom indices of all water oxygens 
# and of all lipid c21 carbons are created. They will be used later to 
# determine which water molecules to push out of the membrane and to compute 
# membrane dimensions. At every simulation step the pushing forces are applied 
# to a minor number of atoms, which doesn't affect NAMD performance. The 
# membrane dimensions are recalculated every N steps (regulated by the global 
# parameter $lipidCheckFreq) as well as the indices of the 
# water molecules that will be pushed during the next N steps (regulated by 
# the global parameter $waterCheckFreq). The membrane should be in XY plane. 
# To use this script one has to add the following lines to the namd 
# configuration script (without "#" symbol): 
# 
#
#  set waterCheckFreq              100
#  set lipidCheckFreq              100
#  set allatompdb                  a1b2c5_init.pdb
#  tclForces                       on
#  tclForcesScript                 keep_water_out.tcl
#
# # lipidCheckFreq must be an integer multiple of waterCheckFreq .



###################################################################
# user definitions begin
###################################################################

print "Starting Tcl forces"

# define force constant per group (Kcal/(mol*A))
set fconst 5.0
set pressure 1.0
set fconstUp [expr {$fconst*$pressure}]
set fconstDown [expr {-$fconst*$pressure}]

# define water and lipid names
set watResName "TIP3"
set watAtomName "OH2"
set lipResName "POPE"
set lipAtomName "C1 "
set lipResName2 "POPE"
set po4AtomName "P  "

# BE CAREFUL, MEMBRANE IS IN 0 z!!!!

###################################################################
# user definitions stop here!
###################################################################



###################################################################
# preprocessing for calcforces
###################################################################

# define all water oxigens and lipid C21 :

set waters_list   {}
set c21plus_list  {}
set c21minus_list {}
set po4plus_list  {}
set po4minus_list {}

set inStream [open $allatompdb r]
foreach line [split [read $inStream] \n] {
    set string1 [string range $line 0 3]
    set string2 [string range $line 6 10]
    set string3 [string range $line 17 20]	
    set string4 [string range $line 13 15]
    set string5 [string range $line 46 53]
    set string6 [string range $line 72 75]
    set string7 [string range $line 22 25]
   
    if { ([string equal $string1 {ATOM}] || \
	      [string equal $string1 {HETA}] ) && \
	     [string equal $watResName $string3] &&\
	     [string equal $watAtomName $string4] } {
		if { [string equal [string trim $string6] "INW"] } {
			
        } else {
	     	
			lappend waters_list "[string trim $string6]\
			    [string trim $string7] $watAtomName"
		}	    
    }  

    if { ([string equal $string1 {ATOM}] || \
	      [string equal $string1 {HETA}] ) && \
	     [string equal $lipResName $string3] &&\
	     [string equal $lipAtomName $string4] } {
# CHANGE HERE POSITION OF MEMBRANE IN Z	
	if { [string trim $string5] >= 0 } {
	    lappend c21plus_list  "[string trim $string6]\
			    [string trim $string7] $lipAtomName"
	} else {
	    lappend c21minus_list "[string trim $string6]\
			    [string trim $string7] $lipAtomName"
	}
        }

    if { ([string equal $string1 {ATOM}] || \
	      [string equal $string1 {HETA}] ) && \
	     [string equal $lipResName2 $string3] &&\
	     [string equal $po4AtomName $string4] } {
	if { [string trim $string5] >= 0 } {
	    lappend po4plus_list  "[string trim $string6]\
			    [string trim $string7] $po4AtomName"
	} else {
	    lappend po4minus_list "[string trim $string6]\
			    [string trim $string7] $po4AtomName"
	}
    } 
}
close $inStream

# make list of indices

set waters   {}
set c21plus  {}
set c21minus {}
set po4plus  {}
set po4minus {}

foreach atomrecord $c21plus_list {
    foreach {segname resid atom} $atomrecord  { break }
    set atomindex [atomid $segname $resid $atom]
    lappend c21plus $atomindex
    addatom  $atomindex
}
foreach atomrecord $c21minus_list {
    foreach {segname resid atom} $atomrecord  { break }
    set atomindex [atomid $segname $resid $atom]
    lappend c21minus $atomindex
    addatom  $atomindex
}
foreach atomrecord $po4plus_list {
    foreach {segname resid atom} $atomrecord  { break }
    set atomindex [atomid $segname $resid $atom]
    lappend po4plus $atomindex
    addatom  $atomindex
}
foreach atomrecord $po4minus_list {
    foreach {segname resid atom} $atomrecord  { break }
    set atomindex [atomid $segname $resid $atom]
    lappend po4minus $atomindex
    addatom  $atomindex
}
foreach atomrecord $waters_list {
    foreach {segname resid atom} $atomrecord  { break }
    set atomindex [atomid $segname $resid $atom]
    lappend waters $atomindex
    addatom  $atomindex
}

set c21plus [concat $c21plus] 
set c21minus [concat $c21minus]
set po4plus [concat $po4plus] 
set po4minus [concat $po4minus]
set waters   [concat $waters]

if {([llength $c21plus] > 0) && ([llength $c21minus] > 0)} {
    set push 1
} else {
    print "WARNING: membrane has not been detected"
    set push 0
}

# initialize printing counter (independent on step counter)

set  pushCount $waterCheckFreq
set checkCount $lipidCheckFreq
set printcount 0
set waterstopushUp   {}
set waterstopushDown {}



###################################################################
# this procedure is executed at each time step
###################################################################

print "Starting calcforces..."
proc calcforces {} {
    global fconstUp fconstDown  stateread fstate fcount
    global stepcount lipidCheckFreq waterCheckFreq
    global pushCount checkCount printcount
    global waters c21plus c21minus po4plus po4minus zplus zminus po4zplus po4zminus
    global waterstopushUp waterstopushDown pressure
    global push

    if {$push == 1} {

##-------------------------  apply forces  ----------------------------###

#    print "  Up: $waterstopushUp"
#    print "Down: $waterstopushDown"
    foreach i $waterstopushUp  {
	set f [list 0.0 0.0 $fconstUp ]
#	print "Push up atom $i at z $z with force $f "
	addforce $i $f
    }

    foreach i $waterstopushDown {
	set f [list 0.0 0.0 $fconstDown ]
#	print "Push down atom $i at z $z with force $f "
	addforce $i $f
    }

###------- get atom indeces from NAMD before recalculation ----###

    if { $pushCount == [expr {$waterCheckFreq -1}] } {

	loadcoords coord	
#	print "Reconfiguring I ..."

	clearconfig
#	reconfig

	foreach atom $c21plus {
	    addatom  $atom
	}
	foreach atom $c21minus {
	    addatom  $atom
	}
	foreach atom $po4plus {
	    addatom  $atom
	}
	foreach atom $po4minus {
	    addatom  $atom
	}	
	foreach atom $waters {
	    addatom  $atom
	}
	

    }
###------------ recalculate membrane size and waters to push -----------###

    if { $checkCount == $lipidCheckFreq } {

	loadcoords coord

	set zplus 0.0
	foreach index $c21plus {
	    foreach {x y z} $coord($index) { break }
#	    print "Z($index): $z"
	    set zplus [expr {$zplus + $z}]
	}
	set zplus [expr {$zplus/double([llength $c21plus])}]

	set zminus 0.0
	foreach index $c21minus {
	    foreach {x y z} $coord($index) { break }
#	    print "Z($index): $z"
	    set zminus [expr {$zminus + $z}]
	}
	set zminus [expr {$zminus/double([llength $c21minus ] )}]


	set po4zplus 0.0
	foreach index $po4plus {
	    foreach {x y z} $coord($index) { break }
	    set po4zplus [expr {$po4zplus + $z}]
	}
	set po4zplus [expr {$po4zplus/double([llength $po4plus])}]

	set po4zminus 0.0
	foreach index $po4minus {
	    foreach {x y z} $coord($index) { break }
	    set po4zminus [expr {$po4zminus + $z}]
	}
	set po4zminus [expr {$po4zminus/double([llength $po4minus ] )}]

	print "membrane dimensions at step $printcount: {$zplus $zminus}"
	print "membrane PO4 dimensions at step $printcount: {$po4zplus $po4zminus}"
	
	set checkCount 0
    }
    

    if { $pushCount == $waterCheckFreq } {

	set waterstopushUp   {}
	set waterstopushDown {}
	set zHalf [expr  {($zplus - $zminus)/2.0} ]
	set zplus [expr {$zplus -1}]
	set zminus [expr {$zminus +1}]

	foreach index $waters {
	    foreach {x y z} $coord($index) { break }
###	    print "$z"
	    if { $z >= $zminus && $z <= $zplus } {
#		print "$z in $index"
		if { [expr {$zplus - $z}] <= $zHalf } {
		    lappend waterstopushUp $index
		} else {
		    lappend waterstopushDown $index
		}
	    }
	}
	
	print "Waters to push Up:   $waterstopushUp"
	print "Waters to push Down: $waterstopushDown"

	print "Reassign waters to push at step: $printcount"

	set pushCount 0

	clearconfig 
#	reconfig
#	print "Reconfiguring II ..."
	
	set waterstopush [concat $waterstopushUp $waterstopushDown]
	
	foreach atom $waterstopush {
	    addatom $atom
	}

    }


    incr printcount
    incr pushCount
    incr checkCount

    }

    return
}

