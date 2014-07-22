package require psfgen
topology top_all36_lipid.rtf
readpsf pope.psf
coordpdb pope.pdb
readpsf popg.psf
coordpdb popg.pdb

writepsf combined_memb.psf
writepdb combined_memb.pdb

exit

