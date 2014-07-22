#source parameter.tcl

#mol load psf 5ht_ionized.psf pdb 5ht_ionized.pdb
set all [atomselect 0 "all"]

set to_constrain [atomselect 0 "(protein and backbone) or (segid INT)"]
$all set beta 0

set k 1
$to_constrain set beta $k
$all writepdb rho_2brestrain_$k.pdb

set k 0.5
$to_constrain set beta $k
$all writepdb rho_restrain_$k.pdb

set k 0.1
$to_constrain set beta $k
$all writepdb rho_restrain_$k.pdb

