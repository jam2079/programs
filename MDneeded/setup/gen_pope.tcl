package require psfgen
topology top_all36_lipid.rtf
mol load pope.pdb

segment POPE {pdb pope.pdb}
coordpdb pope.pdb POPE

#regenerate dihedrals angles
#guesscoord

writepsf pope.psf

exit
