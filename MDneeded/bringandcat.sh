rsync -razvu jmedina@carver.nersc.gov:~/Pathrover/XXXX/* .
if [ ! -f phase3/dat_phase3_01.dcd ]
        then
        text1='phase1/dat_phase1.dcd phase1b/dat_phase1b.dcd phase1b/dat_phase1b2.dcd phase1c/dat_phase1c.dcd '
        text2='phase2a/dat_equil_phase2a1.np.dcd phase2a/dat_equil_phase2a1.dcd phase2a/dat_equil_phase2a2.np.dcd phase2a/dat_equil_phase2a2.dcd phase2a/dat_equil_phase2a3.np.dcd phase2a/dat_equil_phase2a3.dcd phase2a/dat_equil_phase2a4.np.dcd phase2a/dat_equil_phase2a4.dcd phase2a/dat_equil_phase2a5.np.dcd phase2a/dat_equil_phase2a5.dcd phase2a/dat_equil_phase2a6.np.dcd phase2a/dat_equil_phase2a6.dcd '
        text3='phase2b/dat_phase2b1.dcd phase2b/dat_phase2b2.dcd phase2b/dat_phase2b3.dcd'
        text=$text1$text2$text3
        /home/jam2079/programs/catdcd -o equil.dcd $text
fi
if [ -f phase3/dat_phase3_01.dcd ]
        then
        /home/jam2079/programs/catdcd -o prod.dcd phase3/*dcd
fi
touch bring.sh
