package require psfgen
topology top_all22_prot_ntligands.inp
topology top_all27_prot_lipid_ligands.rtf
pdbalias residue HIS HSE
pdbalias atom ILE CD1 CD

segment PROT {
	pdb protein_trans.pdb
	first NTER
	last CTER
}
coordpdb protein_trans.pdb PROT

#patch GLUP PROT:112
#patch GLUP PROT:287
#patch GLUP PROT:419
regenerate dihedrals angles

guesscoord
writepdb protein_final.pdb
writepsf protein_final.psf

exit
