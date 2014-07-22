#!/usr/local/bin/vmd
# add more water molecules on both sides of the membrane

#source parameter.tcl
set DAT merge_prot_memb

# set echo on for debugging
echo on

# need solvate module
package require solvate
solvate $DAT.psf $DAT.pdb -b 3.3 -z 8 +z 8 -o solvated
#solvate $DAT.psf $DAT.pdb -z 8 +z 12 -o $DAT\_solvated

# need psfgen module and topology
package require psfgen
topology top_all36_lipid.rtf

# load structures
resetpsf
readpsf solvated.psf
coordpdb solvated.pdb

# write temporary structure
set temp "temp"
writepsf $temp.psf
writepdb $temp.pdb

# reload full structure (do NOT resetpsf!)
mol load psf $temp.psf pdb $temp.pdb

#delete water in the lipid-protein interface or lipid-lipid interface
set selwat [atomselect top "resname TIP3 and not segid SOLV"]
set lseglist [lsort -unique [$selwat get segid]]
foreach lseg $lseglist {
  # find water backbone atoms
  set selover [atomselect top "segid $lseg and name OH2 and (z<13 and z>-13)"]
  # delete these residues
  set resover [lsort -unique [$selover get resid]]
  foreach res $resover {
    delatom $lseg $res
  }
}

# write full structure
writepsf solvated_trimmed.psf
writepdb solvated_trimmed.pdb

# clean up
file delete $temp.psf
file delete $temp.pdb

# non-interactive script: vmd -dispdev text < combine.tcl > combine.log
#quit

exit
