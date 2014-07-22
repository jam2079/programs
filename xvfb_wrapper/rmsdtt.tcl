# Call rmsdtt
::rmsdtt::rmsdtt

# Set selection
$::rmsdtt::w.top.left.sel delete 1.0 end
$::rmsdtt::w.top.left.sel insert end "protein"

# Set modifiers
::rmsdtt::ctrlbb trace

# Set reference
set ::rmsdtt::rmsd_base top

# Set options
set ::rmsdtt::save_sw 1
set ::rmsdtt::save_file "test1.dat"

# Add all molecules
::rmsdtt::mol_add

# Calculate rmsd
::rmsdtt::doAlign
::rmsdtt::doRmsd

# Get results (individual and total)
puts "[$rmsdtt::datalist(id) get 0] [$rmsdtt::datalist(mol) get 0] [$rmsdtt::datalist(avg) get 0]"
puts $rmsdtt::datatot(avg)

# Exit
quit
