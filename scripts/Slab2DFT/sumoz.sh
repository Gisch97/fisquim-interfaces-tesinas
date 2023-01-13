#!/bin/bash

shift=0
cat slabmotion.in |tail -n 53 | head -n 51|rev | cut -c3- | rev >config.in
echo "Pt H C : CH4/Pt(110)-2x1 (1x3 supercell)" > poscar
echo "1.0" >> poscar
echo "+8.0400000000  +0.0000000000  +0.0000000000" >> poscar
echo "+0.0000000000  +8.5277077811  +0.0000000000" >> poscar
echo "+0.0000000000  +0.0000000000 +31.3702770415" >> poscar
echo "Pt  H  C" >> poscar
echo "51  4  1" >> poscar
echo "Selective" >> poscar
echo "Cartesian" >> poscar

i=1
while read -r x y z; do
  if [ $i -eq 1 ]; then
    shift=$(echo "$z" | awk '{print $1}')
  fi
  if [ $i -le 12 ]; then
    echo "$x 	$y	$(echo "$z $shift" | awk '{print $1-$2}') 	F F F" >> poscar
  else
    echo "$x 	$y 	$(echo "$z $shift" | awk '{print $1-$2}') 	T T T" >> poscar
  fi
  i=$(($i+1))
done < config.in

echo "4.7020649105944274        3.5451374627682810        20.8222483809770758      T T T" >> poscar
echo "3.4384435610795014        2.2815601561981489        20.8222584542356444      T T T" >> poscar
echo "4.7019475455655577        2.2815587204181540        22.0859325380777847      T T T" >> poscar
echo "3.4381334594848862        3.5452746264160711        22.0857728987941755      T T T" >> poscar
echo "4.0702570725264264        2.9132825770511208        21.4540823266182699      T T T" >> poscar

