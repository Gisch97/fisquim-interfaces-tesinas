### 
declare -a Energia=("0.6" "1.0" "1.4");
slabm='/home/gkulemeyer.ifir/GSRD/Sample_gsrd/slab'
RS='/home/gkulemeyer.ifir/GSRD/Sample_gsrd/RS'
GSRD='submit_gsrd.sh'
NN='009NN'

##################################################################################
path='/home/gkulemeyer.ifir/GSRD/Entrenamiento7'
##################################################################################
#### RS
mkdir $path/RS_99;
pathRS="$path/RS_99"
for E in ${Energia[@]}; do
    Ei='Ei'$E
    mkdir $pathRS/$Ei
    cp $RS/* $pathRS/$Ei ;
    sed -i "s/GSRD-test/RS-99-CH4Pt110-$E/" $pathRS/$Ei/$GSRD;# NOMBRE
    sed -i "s/partition=ib16/partition=ib40/" $pathRS/$Ei/$GSRD;
    sed -i "s/nodes=2/nodes=2/" $pathRS/$Ei/$GSRD;
    sed -i "s/ntasks-per-node=16/ntasks-per-node=40/" $pathRS/$Ei/$GSRD;
    sed -i "s/c\[1-4,9,12,15\]/c\[1-4,16,23,26,27,29-32\]/" $pathRS/$Ei/$GSRD;# COLA
    sed -i "s/004NN/${NN}/" $pathRS/$Ei/$GSRD;# RED NN
    sed -i "s/0.6/$E /" $pathRS/$Ei/input.in;# Ei
done;
##################################################################################
### Slab_num(1) - Temp(2)
arr1=($echo {100..114});
arr2=($echo {50..750..50});
##################################################################################
mkdir $path/slabmotions
for (( i=0; i<${#arr1[@]}; i++ )); do
    mkdir $path/slabmotions/${arr1[i]}/ ;
    cp $slabm/* $path/slabmotions/${arr1[i]}/ ;
    sed -i "s/GSRD-test/S-${arr1[i]}-${arr2[i]}K-CH4Pt110 /" $path/slabmotions/${arr1[i]}/$GSRD;# NOMBRE
    sed -i "s/004NN/${NN}/" $path/slabmotions/${arr1[i]}/$GSRD;# RED NN
    sed -i "s/ib16/ib16/" $path/slabmotions/${arr1[i]}/$GSRD;
    sed -i "s/nodes=2/nodes=2/" $path/slabmotions/${arr1[i]}/$GSRD;
    sed -i "s/ntasks-per-node=16/ntasks-per-node=16/" $path/slabmotions/${arr1[i]}/$GSRD;
    sed -i "s/c\[1-4,9,12,15\]/c\[1-4,16,23,26,27,29-32\]/" $path/slabmotions/${arr1[i]}/$GSRD;# COLA
    sed -i "s/999/${arr2[i]}/" $path/slabmotions/${arr1[i]}/input.in;# Temperatura de la superficie
done

