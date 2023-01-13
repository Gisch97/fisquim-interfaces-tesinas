#!/bin/bash
###################################################################################################
## Este script es para generar VASP para las MD a T con energias de incidencia 0.6, 1.0, 1.4. 
##  Hay configuraciones problematicas y de stick.
###################################################################################################
module load Miniconda3;
Sample_VASP='/home/gkulemeyer.ifir/VASP/Sample_input_files';
MD2VASP='/home/gkulemeyer.ifir/scripts';
###################################################################################################
## Apunta a la carpeta de los slabmotions
path='/home/gkulemeyer.ifir/GSRD/Entrenamiento7/RS_99';
###################################################################################################
## Simulaciones
N=99; #Sim
declare -a Energia=("0.6" "1.0" "1.4");
##################################################################################################
## Script
########################@@@@@@@@@@@@ 0.6
mkdir $path/DFT_$N;############ Carpeta DFT_i
for E in ${Energia[@]}; do
    cd $path;
    Ei='Ei'$E
    mkdir $path/DFT_$N/$Ei;
#    mkdir $path/DFT_$N/$Ei/probl;########@@ Carpeta DFT_i/Ei0.6/Probl
#    cp $path/$Ei/traj_probl* $path/$Ei/config_probl* $path/$Ei/refstructureFF_eneroptim.out $path/DFT_$N/$Ei/probl;
#    cp $MD2VASP/MD2vasp_V3.py $path/DFT_$N/$Ei/probl;
#    cd $path/DFT_$N/$Ei/probl;
#    python3 MD2vasp_V3.py;####### exe MD2vasp
#    rm MD2vasp_V3.py traj_probl* config_probl* refstructureFF_eneroptim.out;
#    num=$(ls $path/DFT_$N/$Ei/probl/files_for_DFT/|wc -l);
#    cd $path/DFT_$N/$Ei/probl/files_for_DFT/;
#    for ((NUM=1; NUM<=$num; NUM++)); do
#        cp $Sample_VASP/* conf$NUM/;####### SET DFT            
#        vasp=$path/DFT_$N/$Ei/probl/files_for_DFT/conf$NUM/submit_vasp.sh;
#        INCAR=$path/DFT_$N/$Ei/probl/files_for_DFT/conf$NUM/INCAR;
#        sed -i "s/test-01/RS$NUM($N-$E)-probl-CH4Pt110/" $vasp;
#        sed -i "s/eth20/ib16/" $vasp;
#        sed -i "s/nodes=1/nodes=2/" $vasp;
#        sed -i "s/ntasks-per-node=20/ntasks-per-node=16/" $vasp;
#        sed -i "s/c\[1-4,9,12,15,26,27\]/c\[1-4,15,16,23,26,27,29-32\]/" $vasp;# COLA
#        sed -i "s/NPAR=1/NCORE=16/" $INCAR;
#    done
#    echo "###### $N ##@@@@@@@@ $Ei @@#### $N ####@@ Probl @@@@@@@@@@ $Ei @@#### $N ####@@ Probl @@########";
#    echo "###### $N ##@@@@@@@@ $Ei @@#### $N ####@@ Probl @@@@@@@@@@ $Ei @@#### $N ####@@ Probl @@########";
#    cd $path;
    mkdir $path/DFT_$N/$Ei/stick;########@@ stick
    cp $path/$Ei/traj_stick* $path/$Ei/config_stick* $path/$Ei/refstructureFF_eneroptim.out $path/DFT_$N/$Ei/stick;
    cp $MD2VASP/MD2vasp_V3.py $path/DFT_$N/$Ei/stick;
    cd $path/DFT_$N/$Ei/stick;
    python3 MD2vasp_V3.py;
    rm  MD2vasp_V3.py traj_stick* config_stick* refstructureFF_eneroptim.out;
    num=$(ls $path/DFT_$N/$Ei/stick/files_for_DFT/|wc -l);
    cd $path/DFT_$N/$Ei/stick/files_for_DFT/;
    for ((NUM=1; NUM<=$num; NUM++)); do
        cp $Sample_VASP/* conf$NUM/;####### SET DFT
        vasp=$path/DFT_$N/$Ei/stick/files_for_DFT/conf$NUM/submit_vasp.sh;
        INCAR=$path/DFT_$N/$Ei/stick/files_for_DFT/conf$NUM/INCAR;
        sed -i "s/test-01/RS$NUM($N-$E)-probl-CH4Pt110/" $vasp;
        sed -i "s/eth20/ib16/" $vasp;
        sed -i "s/nodes=1/nodes=2/" $vasp;
        sed -i "s/ntasks-per-node=20/ntasks-per-node=16/" $vasp;
        sed -i "s/c\[1-4,9,12,15,26,27\]/c\[1-4,15,16,23,26,27,29-32\]/" $vasp;# COLA
        sed -i "s/NPAR=1/NCORE=16/" $INCAR;
    done;
    echo "###### $N ##@@@@@@@@ $Ei @@#### $N ####@@ Stick @@@@@@@@@@ $Ei @@#### $N ####@@ Stick @@########";
    echo "###### $N ##@@@@@@@@ $Ei @@#### $N ####@@ Stick @@@@@@@@@@ $Ei @@#### $N ####@@ Stick @@########";
done;

