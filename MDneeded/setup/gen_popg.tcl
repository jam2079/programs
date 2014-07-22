package require psfgen
topology top_all36_lipid.rtf
mol load popg.pdb

segment POPG {pdb popg.pdb}
coordpdb popg.pdb POPG

#regenerate dihedrals angles
#guesscoord

writepsf popg.psf

exit
