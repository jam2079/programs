#mol load psf ionized_apo.psf ionized_apo.pdb
set all [atomselect 0 "all"]
set to_fix [atomselect 0 "(resname POPE and name N HN1 HN2 HN3 C12 H12A H12B C11 H11A H11B P O11 O12 O13 O14 C1 HA HB C2 HS) or (resname POPG and name C13 H13A H13B OC3 HO3 C12 H12A OC2 HO2 C11 H11A H11B P O11 O12 O13 O14 C1 HA HB C2 HS)"]
set to_fix2 [atomselect 0 "protein or water or ions or segid INT"]
$all set beta 0
$to_fix set beta 1
$to_fix2 set beta 1
$all writepdb rho_phase1_fix.pdb

