#!/bin/bash/

TMPFILE=./tmp.$$
for filename in *.in; do
sed 's/XXXX/XXXX/g' $filename > $TMPFILE
mv $TMPFILE $filename
done
