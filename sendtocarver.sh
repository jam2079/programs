foo=`pwd`
mol=${foo##*/}
echo $mol
rsync -razvu common jmedina@carver.nersc.gov:~/Pathrover/$mol/
rsync -razvu phase* jmedina@carver.nersc.gov:~/Pathrover/$mol/
