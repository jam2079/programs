#mol load psf ../5ht_3p.psf pdb ../5ht_3p.pdb
set all [atomselect 0 "all"]
set to_fix [atomselect 0 "protein and backbone"]
set to_fix2 [atomselect 0 "noh and segid INT"]
$all set beta 0
$to_fix set beta 1
$to_fix2 set beta 1
$all writepdb rho_equil_phase1b_fix.pdb
