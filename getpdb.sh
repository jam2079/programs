#!bin.bash/

#mkdir -p $1
#cp -rf MDneeded/* $1
wget -O $1.pdb "http://www.rcsb.org/pdb/download/downloadFile.do?fileFormat=pdb&compression=NO&structureId=$1"

