package require psfgen
topology top_all27_prot_lipid_ligands.rtf
mol load internal_ions.pdb

segment INT {pdb internal_ions.pdb}
coordpdb internal_ions.pdb INT 

#regenerate dihedrals angles
#guesscoord

writepsf ions.psf
writepdb ions.pdb

exit
