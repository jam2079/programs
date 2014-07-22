package require psfgen
topology top_BHY_hyd_mod.rtf
topology BHY_hyd_mod.rtf
mol load chainA_ligand.pdb

segment LIG {pdb chainA_ligand.pdb}
coordpdb chainA_ligand.pdb LIG 

#regenerate dihedrals angles
#guesscoord

writepsf ligand.psf
writepdb ligand.pdb

exit
