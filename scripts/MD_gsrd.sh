###################################################################################################
## Este script es para generar carpetas con calculos de MD (GSRD) para los slabmotiones que 
##  hicieron al menos 50000 pasos, con energias de incidencia 0.6, 1.0, 1.4.
## slabmotions-1-14/1/Ei/(MD)
###################################################################################################
## Definicion de caminos necesarios:
Sample_MD='/home/gkulemeyer.ifir/GSRD/Sample_gsrd/MD' 
GSRD='submit_gsrd.sh'
declare -a Energia=("0.6" "1.0" "1.4");
###################################################################################################
## Este path apunta a la carpeta slabmotions con los slabmotions en numeros $i
path='/home/gkulemeyer.ifir/GSRD/Entrenamiento7/slabmotions';
NN='009NN';
###################################################################################################
## Variables
arr1=($echo {100..110..5}) #Sim
arr2=($echo {50..550..250}) # Temp
###################################################################################################
## Script
for (( i=0; i<${#arr1[@]}; i++ )); do 
    cd $path/${arr1[i]};
    mkdir slabmotion;
    mv * slabmotion/;
    for E in ${Energia[@]}; do
        Ei='Ei'$E
        mkdir $Ei;
        cp slabmotion/slabmotion.in $Ei/;
        cp $Sample_MD/* $Ei/;
        sed -i "s/GSRD-test/MD-${arr1[i]}-${arr2[i]}K-$E-CH4Pt110 \# /" $path/${arr1[i]}/$Ei/$GSRD;# NOMBRE
        sed -i "s/partition=ib16/partition=ib16/" $path/${arr1[i]}/$Ei/$GSRD;
        sed -i "s/nodes=2/nodes=2/" $path/${arr1[i]}/$Ei/$GSRD;
        sed -i "s/ntasks-per-node=16/ntasks-per-node=16/" $path/${arr1[i]}/$Ei/$GSRD;
        sed -i "s/c\[1-4,9,12,15\]/c\[1-4,16,23,26,27,29-32\]/" $path/${arr1[i]}/$Ei/$GSRD;# COLA
        sed -i "s/004NN/${NN}/" $path/${arr1[i]}/$Ei/$GSRD;# RED NN
        sed -i "s/999/${arr2[i]}/" $path/${arr1[i]}/$Ei/input.in;# Temperatura de la superficie
        sed -i "s/0.6/$E/" $path/${arr1[i]}/$Ei/input.in;# Temperatura de la superficie
    done
done

