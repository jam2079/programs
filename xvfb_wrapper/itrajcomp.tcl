# Call itrajcomp
package require itrajcomp
itrajcomp_tk_cb 

# Set selections
$::itrajcomp::tab_sel.mol1.a.sel delete 1.0 end
$::itrajcomp::tab_sel.mol1.a.sel insert end "protein"
set ::itrajcomp::mol1_def id
set ::itrajcomp::mol1_m_list 0

$::itrajcomp::tab_sel.mol2.a.sel delete 1.0 end
$::itrajcomp::tab_sel.mol2.a.sel insert end "protein"
set ::itrajcomp::mol2_def id
set ::itrajcomp::mol2_m_list 1

# Calculations
#  Look in calctype.tcl for other guiopts (ie rmsd.tcl)
set ::itrajcomp::calctype rmsd
set ::itrajcomp::calc_rmsd_guiopts(byres) 1
set ::itrajcomp::diagonal 0

# Calculate
set obj [::itrajcomp::NewObject]

# Save to file
#  ::itrajcomp::saveData object "filename" format
#      filename: when "" output is redirected to stdout
#      format: tab tab_raw postcript matrix plotmtv plotmtv_binary
::itrajcomp::saveData $obj "luis.tab" tab

# Exit
quit
