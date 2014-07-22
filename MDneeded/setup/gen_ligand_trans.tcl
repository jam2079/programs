package require psfgen
topology top_BHY_hyd_mod.rtf
topology BHY_hyd_mod.rtf
mol load ligand_trans.pdb

segment LIG {pdb ligand_trans.pdb}
coordpdb ligand_trans.pdb LIG 

#regenerate dihedrals angles
#guesscoord

writepsf ligand_final.psf
writepdb ligand_final.pdb

exit
