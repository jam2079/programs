#!/usr/local/bin/namd2
# need membrane be in the XY plane!

# This script will adjust the lipid positions 

# # lipidCheckFreq must be an integer multiple of po4CheckFreq .



###################################################################
# user definitions begin
###################################################################

print "Starting Tcl forces"

# define force constant per group (Kcal/(mol*A))
set fconst 2.5
set pressure 1.0
set fconstUp [expr $fconst*$pressure]
set fconstDown [expr -$fconst*$pressure]

# define lipid names
set lipResName "POPE"
set lipAtomName " C1 "
set lipResName1 "POPE"
set po4AtomName " P  "
set c2AtomName " C2 "
set c218AtomName "C218"
set c316AtomName "C316"

set po4boundary 19.5
set c2boundary 16.5
set po4threshold 4.0
set c2threshold 4.0

set c218threshold 6.0
set c316threshold 6.0

set po4upup       [expr $po4boundary + $po4threshold]
set po4updown     [expr $po4boundary - $po4threshold]
set po4downup     [expr -$po4boundary + $po4threshold]
set po4downdown   [expr -$po4boundary - $po4threshold]

set c2upup     [expr $c2boundary + $c2threshold]
set c2updown   [expr $c2boundary - $c2threshold]
set c2downup   [expr -$c2boundary + $c2threshold]
set c2downdown [expr -$c2boundary - $c2threshold]




# BE CAREFUL, MEMBRANE IS IN 0 z!!!!

###################################################################
# user definitions stop here!
###################################################################



###################################################################
# preprocessing for calcforces
###################################################################

# define all P1 atoms of PO4 and lipid C21 :

set c21plus_list  {}
set c21minus_list {}
set po4plus_list  {}
set po4minus_list {}
set c2plus_list  {}
set c2minus_list {}
set c218plus_list  {}
set c218minus_list {}
set c316_list {}

set inStream [open $allatompdb r]
foreach line [split [read $inStream] \n] {
    set string1 [string range $line 0 3]
    set string2 [string range $line 6 10]
    set string3 [string range $line 17 20]	
    set string4 [string range $line 12 15]
    set string5 [string range $line 46 53]
    set string6 [string range $line 72 75]
    set string7 [string range $line 22 25]  

	if { ([string equal $string1 {ATOM}] || [string equal $string1 {HETA}]) &&\
          [string equal $lipResName $string3] } {
	#C21
		if { [string equal $lipAtomName $string4] } {
			if { [string trim $string5] >= 0 } {
				lappend c21plus_list  "[string trim $string6]\
						[string trim $string7] $lipAtomName"
            } else {
				lappend c21minus_list "[string trim $string6]\
						[string trim $string7] $lipAtomName"
			}
		}

	#PO4	
		if { [string equal $po4AtomName $string4] } {
			if { [string trim $string5] >= 0 } {
				lappend po4plus_list  "[string trim $string6]\
						[string trim $string7] $po4AtomName"
			} else {
				lappend po4minus_list "[string trim $string6]\
						[string trim $string7] $po4AtomName"
			}
		}

	#C2
		if { [string equal $c2AtomName $string4] } {
			if { [string trim $string5] >= 0 } {

				set flag "up"
				print "c2, $string5, $string6, $string7, $flag"

				lappend c2plus_list  "[string trim $string6]\
						[string trim $string7] $c2AtomName"
			} else {

				set flag "down"
				print "c2, $string5, $string6, $string7, $flag"

				lappend c2minus_list "[string trim $string6]\
						[string trim $string7] $c2AtomName"
			}
		}

	#C218
		if { [string equal $c218AtomName $string4] } {
			#THIS DEPENDS ON THE C2 COORDIDATES APPEAR BEFORE C218
			if { [string equal $flag "up"] } {
				print "c218, $string5, $string6, $string7, $flag"
				lappend c218plus_list  "[string trim $string6]\
						[string trim $string7] $c218AtomName"
			} else {
				print "c218, $string5, $string6, $string7, $flag"
				lappend c218minus_list "[string trim $string6]\
						[string trim $string7] $c218AtomName"
			}
		}

	#C316    
		if { [string equal $c316AtomName $string4] } {
				lappend c316_list "[string trim $string6]\
						[string trim $string7] $c316AtomName"
		}
    }
}
close $inStream

# make list of indices

set c21plus  {}
set c21minus {}
set po4plus  {}
set po4minus {}
set c2plus  {}
set c2minus {}
set c218plus  {}
set c218minus {}
set c316pm {}

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
foreach atomrecord $c2plus_list {
    foreach {segname resid atom} $atomrecord  { break }
    set atomindex [atomid $segname $resid $atom]
    lappend c2plus $atomindex
    addatom  $atomindex
}
foreach atomrecord $c2minus_list {
    foreach {segname resid atom} $atomrecord  { break }
    set atomindex [atomid $segname $resid $atom]
    lappend c2minus $atomindex
    addatom  $atomindex
}
foreach atomrecord $c218plus_list {
    foreach {segname resid atom} $atomrecord  { break }
    set atomindex [atomid $segname $resid $atom]
    lappend c218plus $atomindex
    addatom  $atomindex
}
foreach atomrecord $c218minus_list {
    foreach {segname resid atom} $atomrecord  { break }
    set atomindex [atomid $segname $resid $atom]
    lappend c218minus $atomindex
    addatom  $atomindex
}
foreach atomrecord $c316_list {
    foreach {segname resid atom} $atomrecord  { break }
    set atomindex [atomid $segname $resid $atom]
    lappend c316pm $atomindex
    addatom  $atomindex
}

set c21plus [concat $c21plus] 
set c21minus [concat $c21minus]
set po4plus [concat $po4plus] 
set po4minus [concat $po4minus]
set c2plus [concat $c2plus] 
set c2minus [concat $c2minus]
set c218plus [concat $c218plus] 
set c218minus [concat $c218minus]
set c316pm [concat $c316pm]

if {([llength $c21plus] > 0) && ([llength $c21minus] > 0)} {
    set push 1
} else {
    print "WARNING: membrane has not been detected"
    set push 0
}

# initialize printing counter (independent on step counter)

set  pushCount $po4CheckFreq
#set checkCount $lipidCheckFreq
set printcount 0
set po4topushUp   {}
set po4topushDown {}



###################################################################
# this procedure is executed at each time step
###################################################################

print "Starting calcforces..."
proc calcforces {} {
    global fconstUp fconstDown  stateread fstate fcount 
    global po4upup po4updown po4downup po4downdown
    global c2upup c2updown c2downup c2downdown
    global c218threshold c316threshold
    global stepcount lipidCheckFreq po4CheckFreq
    global pushCount printcount 
    #global checkCount
    global c21plus c21minus po4plus po4minus c2plus c2minus c218plus c218minus c316pm zplus zminus po4zplus po4zminus
    global po4topushUp po4topushDown pressure
    global push

    if {$push == 1} {

	##-------------------------  apply forces  ----------------------------###

	#    print "  Up: $po4topushUp"
	#    print "Down: $po4topushDown"
		foreach i $po4topushUp  {
		set f [list 0.0 0.0 $fconstUp ]
	#	print "Push up atom $i at z $z with force $f "
		addforce $i $f
		}

		foreach i $po4topushDown {
		set f [list 0.0 0.0 $fconstDown ]
	#	print "Push down atom $i at z $z with force $f "
		addforce $i $f
    }

###------- get atom indeces from NAMD before recalculation ----###

    if { $pushCount == [expr $po4CheckFreq -1] } {

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
		foreach atom $c2plus {
			addatom  $atom
		}
		foreach atom $c2minus {
			addatom  $atom
		}
		foreach atom $c218plus {
			addatom  $atom
		}
		foreach atom $c218minus {
			addatom  $atom
		}	
		foreach atom $c316pm {
			addatom  $atom
		}	

    }
###------------ recalculate membrane size and PO4 to push -----------###

    #if { $checkCount == $lipidCheckFreq } {
	#	set checkCount 0
    #}

    if { $pushCount == $po4CheckFreq } {
		loadcoords coord
		set po4topushUp   {}
		set po4topushDown {}
	#PO4
		foreach index $po4plus {
			foreach {x y z} $coord($index) { break }
			if { $z >= $po4upup } {
				print $z, $index, "po4+ down";
				lappend po4topushDown $index
			} elseif { $z <= $po4updown } {
				print $z, $index, "po4+ up";
				lappend po4topushUp $index
			}
		}
		foreach index $po4minus {
			foreach {x y z} $coord($index) { break }
			if { $z >= $po4downup } {
				print $z, $index, "po4- down";
				lappend po4topushDown $index
			} elseif { $z <= $po4downdown } {
				print $z, $index, "po4- up";
				lappend po4topushUp $index
			}
		}

	#C2
		foreach index $c2plus {
			foreach {x y z} $coord($index) { break }
			if { $z >= $c2upup } {
				print $z, $index, "c2+ down";
				lappend po4topushDown $index
			} elseif { $z <= $c2updown } {
				print $z, $index, "c2+ up";
				lappend po4topushUp $index
			}
		}

		foreach index $c2minus {
			foreach {x y z} $coord($index) { break }
			if { $z >= $c2downup } {
				print $z, $index, "c2- down";
				lappend po4topushDown $index
			} elseif { $z <= $c2downdown } {
				print $z, $index, "c2- up";
				lappend po4topushUp $index
			}
		}

	#C218
		foreach index $c218plus {
			foreach {x y z} $coord($index) { break }
			if { $z >= $c218threshold } {
				print $z, $index, "c218+ down";
				lappend po4topushDown $index
			}
		}

		foreach index $c218minus {
			foreach {x y z} $coord($index) { break }
			if { $z <= - $c218threshold } {
				print $z, $index, "c218- up";
				lappend po4topushUp $index
			}
		}

	#C316	
		foreach index $c316pm {
			foreach {x y z} $coord($index) { break }
			if { $z >= $c316threshold } {
				print $z, $index, "c316 down";
				lappend po4topushDown $index
			} elseif { $z <= -$c316threshold } {
				print $z, $index "c316 up";
				lappend po4topushUp $index
			}
		}

		set toUp [llength $po4topushUp]
		set toDown [llength $po4topushDown]
		print "$toUp to push Up:   $po4topushUp"
		print "$toDown to push Down: $po4topushDown"

		print "Reassign PO4 to push at step: $printcount"

		set pushCount 0

		clearconfig 
	#	reconfig
	#	print "Reconfiguring II ..."

		set po4topush [concat $po4topushUp $po4topushDown]

		foreach atom $po4topush {
			addatom $atom
		}

    }

    incr printcount
    incr pushCount
    #incr checkCount

    }

    return
}

