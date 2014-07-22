#!/usr/local/bin/vmd
# place NaCl molecules randomly on both sides of the membrane, 
# 0.3 is 300mM, total concentration--#Na+#Cl/V 

#source parameter.tcl
set DAT solvated_trimmed
#set DAT test

# set echo on for debugging
echo on

# need solvate module
package require autoionize
autoionize -psf $DAT.psf -pdb $DAT.pdb -is 0.15

exit
