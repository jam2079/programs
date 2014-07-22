package require psfgen
topology top_all27_prot_lipid_ligands.rtf
topology top_all22_prot_ntligands.inp
topology top_BHY_hyd_mod.rtf
topology BHY_hyd_mod.rtf
readpsf protein.psf
coordpdb protein.pdb
readpsf ligand.psf
coordpdb ligand.pdb
readpsf ions.psf
coordpdb ions.pdb
#readpsf SOLV.psf
#coordpdb SOLV.pdb

writepsf combined.psf
writepdb combined.pdb

exit
