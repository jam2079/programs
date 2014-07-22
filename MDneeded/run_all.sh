#!/bin/bash -l
#$ -N Leu31
#$ -j y
#$ -cwd
#$ -pe charmrun 24
#$ -q standard.q
#$ -l t2050=0
#$ -R y
#$ -l mib=1
#$ -l excl=1
##$ -hold_jid 6040


#BUILD_ROOT=/home/jason/namd_gpu_pug
#GPU_CLAUSE="+idlepoll"
BUILD_ROOT=/home/jason/namd_nogpu_pug
GPU_CLAUSE=""

cd $SGE_O_WORKDIR

$BUILD_ROOT/NAMD_2.7_Source/Linux-x86_64-g++/charmrun \
 ++nodelist $TMPDIR/machines ++batch 24 \
 +p$PBTECH_NSLOTS_REQ \
 $BUILD_ROOT/NAMD_2.7_Source/Linux-x86_64-g++/namd2 \
 +isomalloc_sync \
 $GPU_CLAUSE \
 phase1/rho_equil.in > phase1/rho_equil.out

 sleep 60

$BUILD_ROOT/NAMD_2.7_Source/Linux-x86_64-g++/charmrun \
 ++nodelist $TMPDIR/machines ++batch 24 \
 +p$PBTECH_NSLOTS_REQ \
 $BUILD_ROOT/NAMD_2.7_Source/Linux-x86_64-g++/namd2 \
 +isomalloc_sync \
 $GPU_CLAUSE \
 phase1b/rho_equil_phase1b.in > phase1b/rho_equil_phase1b.out

sleep 60

$BUILD_ROOT/NAMD_2.7_Source/Linux-x86_64-g++/charmrun \
 ++nodelist $TMPDIR/machines ++batch 24 \
 +p$PBTECH_NSLOTS_REQ \
 $BUILD_ROOT/NAMD_2.7_Source/Linux-x86_64-g++/namd2 \
 +isomalloc_sync \
 $GPU_CLAUSE \
 phase1b/rho_equil_phase1b2.in > phase1b/rho_equil_phase1b2.out

sleep 60

$BUILD_ROOT/NAMD_2.7_Source/Linux-x86_64-g++/charmrun \
 ++nodelist $TMPDIR/machines ++batch 24 \
 +p$PBTECH_NSLOTS_REQ \
 $BUILD_ROOT/NAMD_2.7_Source/Linux-x86_64-g++/namd2 \
 +isomalloc_sync \
 $GPU_CLAUSE \
 phase1c/rho_equil_phase1c.in > phase1c/rho_equil_phase1c.out

sleep 60

$BUILD_ROOT/NAMD_2.7_Source/Linux-x86_64-g++/charmrun \
 ++nodelist $TMPDIR/machines ++batch 24 \
 +p$PBTECH_NSLOTS_REQ \
 $BUILD_ROOT/NAMD_2.7_Source/Linux-x86_64-g++/namd2 \
 +isomalloc_sync \
 $GPU_CLAUSE \
 phase2a/rho_equil_phase2a1.np.in > phase2a/rho_equil_phase2a1.np.out

sleep 60


$BUILD_ROOT/NAMD_2.7_Source/Linux-x86_64-g++/charmrun \
 ++nodelist $TMPDIR/machines ++batch 24 \
 +p$PBTECH_NSLOTS_REQ \
 $BUILD_ROOT/NAMD_2.7_Source/Linux-x86_64-g++/namd2 \
 +isomalloc_sync \
 $GPU_CLAUSE \
 phase2a/rho_equil_phase2a1.in > phase2a/rho_equil_phase2a1.out

sleep 60


$BUILD_ROOT/NAMD_2.7_Source/Linux-x86_64-g++/charmrun \
 ++nodelist $TMPDIR/machines ++batch 24 \
 +p$PBTECH_NSLOTS_REQ \
 $BUILD_ROOT/NAMD_2.7_Source/Linux-x86_64-g++/namd2 \
 +isomalloc_sync \
 $GPU_CLAUSE \
 phase2a/rho_equil_phase2a2.np.in > phase2a/rho_equil_phase2a2.np.out

sleep 60

$BUILD_ROOT/NAMD_2.7_Source/Linux-x86_64-g++/charmrun \
 ++nodelist $TMPDIR/machines ++batch 24 \
 +p$PBTECH_NSLOTS_REQ \
 $BUILD_ROOT/NAMD_2.7_Source/Linux-x86_64-g++/namd2 \
 +isomalloc_sync \
 $GPU_CLAUSE \
 phase2a/rho_equil_phase2a2.in > phase2a/rho_equil_phase2a2.out

sleep 60

$BUILD_ROOT/NAMD_2.7_Source/Linux-x86_64-g++/charmrun \
 ++nodelist $TMPDIR/machines ++batch 24 \
 +p$PBTECH_NSLOTS_REQ \
 $BUILD_ROOT/NAMD_2.7_Source/Linux-x86_64-g++/namd2 \
 +isomalloc_sync \
 $GPU_CLAUSE \
 phase2a/rho_equil_phase2a3.np.in > phase2a/rho_equil_phase2a3.np.out

sleep 60

$BUILD_ROOT/NAMD_2.7_Source/Linux-x86_64-g++/charmrun \
 ++nodelist $TMPDIR/machines ++batch 24 \
 +p$PBTECH_NSLOTS_REQ \
 $BUILD_ROOT/NAMD_2.7_Source/Linux-x86_64-g++/namd2 \
 +isomalloc_sync \
 $GPU_CLAUSE \
 phase2a/rho_equil_phase2a3.in > phase2a/rho_equil_phase2a3.out

sleep 60

$BUILD_ROOT/NAMD_2.7_Source/Linux-x86_64-g++/charmrun \
 ++nodelist $TMPDIR/machines ++batch 24 \
 +p$PBTECH_NSLOTS_REQ \
 $BUILD_ROOT/NAMD_2.7_Source/Linux-x86_64-g++/namd2 \
 +isomalloc_sync \
 $GPU_CLAUSE \
 phase2a/rho_equil_phase2a4.np.in > phase2a/rho_equil_phase2a4.np.out

sleep 60

$BUILD_ROOT/NAMD_2.7_Source/Linux-x86_64-g++/charmrun \
 ++nodelist $TMPDIR/machines ++batch 24 \
 +p$PBTECH_NSLOTS_REQ \
 $BUILD_ROOT/NAMD_2.7_Source/Linux-x86_64-g++/namd2 \
 +isomalloc_sync \
 $GPU_CLAUSE \
 phase2a/rho_equil_phase2a4.in > phase2a/rho_equil_phase2a4.out

sleep 60



$BUILD_ROOT/NAMD_2.7_Source/Linux-x86_64-g++/charmrun \
 ++nodelist $TMPDIR/machines ++batch 24 \
 +p$PBTECH_NSLOTS_REQ \
 $BUILD_ROOT/NAMD_2.7_Source/Linux-x86_64-g++/namd2 \
 +isomalloc_sync \
 $GPU_CLAUSE \
 phase2a/rho_equil_phase2a5.np.in > phase2a/rho_equil_phase2a5.np.out

sleep 60

$BUILD_ROOT/NAMD_2.7_Source/Linux-x86_64-g++/charmrun \
 ++nodelist $TMPDIR/machines ++batch 24 \
 +p$PBTECH_NSLOTS_REQ \
 $BUILD_ROOT/NAMD_2.7_Source/Linux-x86_64-g++/namd2 \
 +isomalloc_sync \
 $GPU_CLAUSE \
 phase2a/rho_equil_phase2a5.in > phase2a/rho_equil_phase2a5.out

sleep 60



$BUILD_ROOT/NAMD_2.7_Source/Linux-x86_64-g++/charmrun \
 ++nodelist $TMPDIR/machines ++batch 24 \
 +p$PBTECH_NSLOTS_REQ \
 $BUILD_ROOT/NAMD_2.7_Source/Linux-x86_64-g++/namd2 \
 +isomalloc_sync \
 $GPU_CLAUSE \
 phase2a/rho_equil_phase2a6.np.in > phase2a/rho_equil_phase2a6.np.out

sleep 60

$BUILD_ROOT/NAMD_2.7_Source/Linux-x86_64-g++/charmrun \
 ++nodelist $TMPDIR/machines ++batch 24 \
 +p$PBTECH_NSLOTS_REQ \
 $BUILD_ROOT/NAMD_2.7_Source/Linux-x86_64-g++/namd2 \
 +isomalloc_sync \
 $GPU_CLAUSE \
 phase2a/rho_equil_phase2a6.in > phase2a/rho_equil_phase2a6.out

sleep 60

$BUILD_ROOT/NAMD_2.7_Source/Linux-x86_64-g++/charmrun \
 ++nodelist $TMPDIR/machines ++batch 24 \
 +p$PBTECH_NSLOTS_REQ \
 $BUILD_ROOT/NAMD_2.7_Source/Linux-x86_64-g++/namd2 \
 +isomalloc_sync \
 $GPU_CLAUSE \
 phase2b/rho_equil_phase2b1.in > phase2b/rho_equil_phase2b1.out

sleep 60

$BUILD_ROOT/NAMD_2.7_Source/Linux-x86_64-g++/charmrun \
 ++nodelist $TMPDIR/machines ++batch 24 \
 +p$PBTECH_NSLOTS_REQ \
 $BUILD_ROOT/NAMD_2.7_Source/Linux-x86_64-g++/namd2 \
 +isomalloc_sync \
 $GPU_CLAUSE \
 phase2b/rho_equil_phase2b2.in > phase2b/rho_equil_phase2b2.out

sleep 60

$BUILD_ROOT/NAMD_2.7_Source/Linux-x86_64-g++/charmrun \
 ++nodelist $TMPDIR/machines ++batch 24 \
 +p$PBTECH_NSLOTS_REQ \
 $BUILD_ROOT/NAMD_2.7_Source/Linux-x86_64-g++/namd2 \
 +isomalloc_sync \
 $GPU_CLAUSE \
 phase2b/rho_equil_phase2b3.in > phase2b/rho_equil_phase2b3.out


