package require psfgen
topology top_all27_prot_lipid_ligands.rtf
topology top_all22_prot_ntligands.inp
topology top_all36_lipid.rtf
topology top_build_sgm2.inp
topology top_BHY_hyd_mod.rtf
topology BHY_hyd_mod.rtf
readpsf combined_proteinligint.psf
coordpdb combined_proteinligint.pdb
readpsf combined_memb.psf
coordpdb combined_memb.pdb

writepsf merge_prot_memb.psf
writepdb merge_prot_memb.pdb

exit
