#!/bin/bash/

cd phase1
sh ../replace.sh
cd ..
cd phase1b
sh ../replace.sh
cd ..
cd phase1c
sh ../replace.sh
cd ..
cd phase2a
sh ../replace.sh
cd ..
cd phase2b
sh ../replace.sh
cd ..
cd phase3
sh ../replace.sh
cd ..
sh replace.sh

find . -size  0 -print0 |xargs -0 rm
