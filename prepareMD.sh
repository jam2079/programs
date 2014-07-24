#!bin.bash/

mkdir -p $1
cp -rf ~/programs/MDneeded/* $1
wget -O $1/setup/$1.pdb "http://www.rcsb.org/pdb/download/downloadFile.do?fileFormat=pdb&compression=NO&structureId=$1"

