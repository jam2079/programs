
awk -F" " '{print $5}' aligned_membrane.pdb > tmp

data=`cat tmp`

for i in $data; do echo $(( $i + $1 )); done > tmp2

rm tmp

mv tmp2 tmp

