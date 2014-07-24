#source parameter.tcl
#set transporter ../5ht_3p

proc dimension {atomselection} {
	set minmax [measure minmax $atomselection]
	set min [lindex $minmax 0]
	set max [lindex $minmax 1]
	set outfile [open "../phase1/COORDS" w]
	puts $outfile "cellBasisVector1   [expr [lindex $max 0] - [lindex $min 0]] 0 0"
	puts $outfile "cellBasisVector2   0 [expr [lindex $max 1] - [lindex $min 1]] 0"
	puts $outfile "cellBasisVector3   0 0 [expr [lindex $max 2] - [lindex $min 2]]"
	set centercoor [measure center $atomselection]
	set x [lindex $centercoor 0]
	set y [lindex $centercoor 1]
	set z [lindex $centercoor 2]
	
	puts $outfile "cellOrigin         [format "%.3f %.3f %.3f" $x $y $z]"
	puts $outfile "wrapAll            on"
	close $outfile
}


set everyone [atomselect top all]
dimension $everyone
	

