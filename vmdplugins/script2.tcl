# RMSDTT scripting example
# Calculate the rmsd over a trajectory with different frames as reference.

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
set ::rmsdtt::save_sw 1
set ::rmsdtt::plot_sw 0

# Add top molecule only
foreach m [molinfo list] {
  mol inactive $m
}
mol active top
::rmsdtt::mol_add 1

# Calculate rmsd for each reference frame
set n [molinfo top get numframes]
for {set f 0} {$f < $n} {incr f 1} {
  set ::rmsdtt::save_file "frameref_$f.dat"
  set ::rmsdtt::traj_ref $f
  ::rmsdtt::doRmsd
}


