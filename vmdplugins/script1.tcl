# RMSDTT scripting example
# Setting options.

# Call rmsdtt
::rmsdtt::rmsdtt

# Set selection
$::rmsdtt::w.top.left.sel delete 1.0 end
$::rmsdtt::w.top.left.sel insert end "residue 1 to 10"

# Set modifiers
set ::rmsdtt::bb_only 1
set ::rmsdtt::trace_only 0
set ::rmsdtt::noh 0

# Set reference
set ::rmsdtt::rmsd_base top

# Set options
set ::rmsdtt::file_out_sw 0
set ::rmsdtt::plot_sw 0

# Add all molecules
::rmsdtt::mol_add

# Calculate rmsd
::rmsdtt::doRmsd
