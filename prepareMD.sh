#!bin.bash/

mkdir -p $1
cd $1
cp -rf /home/jam2079/programs/MDneeded/* .
wget -O $1.pdb "http://www.rcsb.org/pdb/download/downloadFile.do?fileFormat=pdb&compression=NO&structureId=$1"
cp $1.pdb setup

find . -type f -print0 | xargs -0 sed -i 's/XXXX/'$1'/g'

