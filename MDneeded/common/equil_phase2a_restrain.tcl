#source parameter.tcl

#mol load psf ../5ht_3p.psf pdb ../5ht_3p.pdb
set all [atomselect 0 all]

set to_constrain [atomselect 0 "(protein and backbone) or (segid INT)"]
$all set beta 0

set k 1
$to_constrain set beta $k
$all writepdb rho_restrain_$k.pdb
