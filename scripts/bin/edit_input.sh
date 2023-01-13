path=$HOME/Dynamics/CH4Pt110/Entrenamiento2/slabmotion_T50-750
#for i in {21..34}; do
#sed -i "s/999/$i/" $HOME/Dynamics/CH4Pt110/Entrenamiento2/slabmotion_T50-750/input.in; 
#done
#arr1=(21 22 23 24 25 26 27 28 29 30 31 32 33 34)
arr1=(36 37 38 39 40 41 42 43 44 45 46 47 48 49)
arr2=(50 100 150 200 250 300 350 400 450 500 550 600 650 700 750)
for (( i=0; i<${#arr1[@]}; i++ )); do sed -i "s/999/${arr2[i]}/" $path/${arr1[i]}/input.in; done


