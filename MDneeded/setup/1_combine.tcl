package require psfgen
topology top_all27_prot_lipid_ligands.rtf
topology top_all22_prot_ntligands.inp
readpsf protein_final.psf
coordpdb protein_final.pdb
readpsf ligand_final.psf
coordpdb ligand_final.pdb
readpsf ions_final.psf
coordpdb ions_final.pdb
#readpsf SOLV_final.psf
#coordpdb SOLV_final.pdb

writepsf combined_proteinligint.psf
writepdb combined_proteinligint.pdb

exit
