package require psfgen
topology top_all27_prot_lipid_ligands.rtf
pdbalias residue HOH TIP3
pdbalias atom HOH O OH2

segment SOLV {
    auto none
    pdb chainA_waters.pdb
}
coordpdb chainA_waters.pdb SOLV

guesscoord
writepdb SOLV.pdb
writepsf SOLV.psf

exit
