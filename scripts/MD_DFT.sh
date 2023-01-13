###################################################################################################
## Este script es para generar VASP para las MD a T con energias de incidencia 0.6, 1.0, 1.4. 
##  Hay configuraciones problematicas y de stick.
###################################################################################################
module load Miniconda3;
Sample_VASP='/home/gkulemeyer.ifir/VASP/Sample_input_files';
MD2VASP='/home/gkulemeyer.ifir/scripts';
###################################################################################################
## Apunta a la carpeta de los slabmotions
path='/home/gkulemeyer.ifir/GSRD/Entrenamiento7/slabmotions';
###################################################################################################
## Simulaciones
arr1=($echo {100..110..5}); #Sim
declare -a Energia=("0.6" "1.0" "1.4");
##################################################################################################
## Script
for (( i=0; i<${#arr1[@]}; i++ )); do 
########################@@@@@@@@@@@@ 0.6
    mkdir $path/DFT_${arr1[i]};############ Carpeta DFT_i
    for E in ${Energia[@]}; do
        cd $path;
        Ei='Ei'$E
        mkdir $path/DFT_${arr1[i]}/$Ei;
#        mkdir $path/DFT_${arr1[i]}/$Ei/probl;########@@ Carpeta DFT_i/Ei0.6/Probl
#        cp $path/${arr1[i]}/$Ei/traj_probl* $path/${arr1[i]}/$Ei/config_probl* $path/${arr1[i]}/$Ei/refstructureFF_eneroptim.out $path/DFT_${arr1[i]}/$Ei/probl;
#        cp $MD2VASP/MD2vasp_V3.py $path/DFT_${arr1[i]}/$Ei/probl;
#        cd $path/DFT_${arr1[i]}/$Ei/probl;
#        python3 MD2vasp_V3.py;####### exe MD2vasp
#        rm MD2vasp_V3.py traj_probl* config_probl* refstructureFF_eneroptim.out;
#        num=$(ls $path/DFT_${arr1[i]}/$Ei/probl/files_for_DFT/|wc -l);
#        cd $path/DFT_${arr1[i]}/$Ei/probl/files_for_DFT/;
#        for ((NUM=1; NUM<=$num; NUM++)); do
#            cp $Sample_VASP/* conf$NUM/;####### SET DFT            
#            vasp=$path/DFT_${arr1[i]}/$Ei/probl/files_for_DFT/conf$NUM/submit_vasp.sh;
#            sed -i "s/test-01/MD$NUM($N-$E)-probl-CH4Pt110/" $vasp;
#            sed -i "s/eth20/ib16/" $vasp;
#            sed -i "s/nodes=1/nodes=2/" $vasp;
#            sed -i "s/ntasks-per-node=20/ntasks-per-node=16/" $vasp;
#            sed -i "s/NPAR=1/NCORE=16/" INCAR
#            sed -i "s/c\[1-4,9,12,15\]/c\[1-19\]/" $VASP
#        done;
#        echo "###### ${arr1[i]} ##@@@@@@@@ $Ei @@#### ${arr1[i]} ####@@ Probl @@@@@@@@@@ $Ei @@#### ${arr1[i]} ####@@ Probl @@########";
#        echo "###### ${arr1[i]} ##@@@@@@@@ $Ei @@#### ${arr1[i]} ####@@ Probl @@@@@@@@@@ $Ei @@#### ${arr1[i]} ####@@ Probl @@########";
#        cd $path;
        mkdir $path/DFT_${arr1[i]}/$Ei/stick;########@@ stick
        cp $path/${arr1[i]}/$Ei/traj_stick* $path/${arr1[i]}/$Ei/config_stick* $path/${arr1[i]}/$Ei/refstructureFF_eneroptim.out $path/DFT_${arr1[i]}/$Ei/stick;
        cp $MD2VASP/MD2vasp_V3.py $path/DFT_${arr1[i]}/$Ei/stick;
        cd $path/DFT_${arr1[i]}/$Ei/stick;
        python3 MD2vasp_V3.py;
        rm  MD2vasp_V3.py traj_stick* config_stick* refstructureFF_eneroptim.out;
        num=$(ls $path/DFT_${arr1[i]}/$Ei/stick/files_for_DFT/|wc -l);
        cd $path/DFT_${arr1[i]}/$Ei/stick/files_for_DFT/;
        for ((NUM=1; NUM<=$num; NUM++)); do
            cp $Sample_VASP/* conf$NUM/;####### SET DFT
            vasp=$path/DFT_${arr1[i]}/$Ei/stick/files_for_DFT/conf$NUM/submit_vasp.sh;
	    INCAR=$path/DFT_${arr1[i]}/$Ei/stick/files_for_DFT/conf$NUM/INCAR;
            sed -i "s/test-01/MD$NUM($N-$E)-stick-CH4Pt110/" $vasp;
            sed -i "s/eth20/ib16/" $vasp;
            sed -i "s/nodes=1/nodes=2/" $vasp;
            sed -i "s/ntasks-per-node=20/ntasks-per-node=16/" $vasp;
            sed -i "s/NPAR=1/NCORE=16/" $INCAR;
            sed -i "s/c\[1-4,9,12,15,26,27\]/c\[1-4,15,16,23,26,27,29-32\]/" $vasp;
        done;
        echo "###### ${arr1[i]} ##@@@@@@@@ $Ei @@#### ${arr1[i]} ####@@ Stick @@@@@@@@@@ $Ei @@#### ${arr1[i]} ####@@ Stick @@########";
        echo "###### ${arr1[i]} ##@@@@@@@@ $Ei @@#### ${arr1[i]} ####@@ Stick @@@@@@@@@@ $Ei @@#### ${arr1[i]} ####@@ Stick @@########";
#        mkdir $path/DFT_${arr1[i]}/$Ei/nadmol;########@@ Carpeta DFT_i/Ei0.6/nadmol;
#        cp $path/${arr1[i]}/$Ei/traj_admol* $path/${arr1[i]}/$Ei/config_admol.xyz $path/${arr1[i]}/$Ei/refstructureFF_eneroptim.out $path/DFT_${arr1[i]}/$Ei/nadmol;
#        cp $MD2VASP/MD2vasp_V3.py $path/DFT_${arr1[i]}/$Ei/nadmol;
#        cd $path/DFT_${arr1[i]}/$Ei/nadmol;
#        python3 MD2vasp_V3.py;####### exe MD2vasp
#        rm MD2vasp_V3.py traj_admol* config_admol* refstructureFF_eneroptim.out;
#        num=$(ls $path/DFT_${arr1[i]}/$Ei/nadmol/files_for_DFT/|wc -l);
#        cd $path/DFT_${arr1[i]}/$Ei/nadmol/files_for_DFT/;
#        for ((NUM=1; NUM<=$num; NUM++)); do
#            cp $Sample_VASP/* conf$NUM/;####### SET DFT
#            vasp=$path/DFT_${arr1[i]}/$Ei/nadmol/files_for_DFT/conf$NUM/submit_vasp.sh;
#            sed -i "s/test-01/MD$NUM($N-$E)-nadmol-CH4Pt110/" $vasp;
#            sed -i "s/eth20/ib16/" $vasp;
#            sed -i "s/nodes=1/nodes=2/" $vasp;
#            sed -i "s/ntasks-per-node=20/ntasks-per-node=16/" $vasp;
#            sed -i "s/NPAR=1/NCORE=16/" $path/DFT_${arr1[i]}/$Ei/nadmol/files_for_DFT/conf$NUM/INCAR;
#            sed -i "s/c\[1-4,9,12,15\]/c\[1-19\]/" $VASP;
#        done;
#        echo "###### ${arr1[i]} ##@@@@@@@@ $Ei @@#### ${arr1[i]} ####@@ NADMOL @@@@@@@@@@ $Ei @@#### ${arr1[i]} ####@@ NADMOL @@########";
#        echo "###### ${arr1[i]} ##@@@@@@@@ $Ei @@#### ${arr1[i]} ####@@ NADMOL @@@@@@@@@@ $Ei @@#### ${arr1[i]} ####@@ NADMOL @@########";
     done;
done;
########################@@@@@@@@@@@@ 1.0
#    cd $path;
#    mkdir /DFT_$i/Ei1.0;########@@@@@@@@ 1.0
#    mkdir /DFT_$i/Ei1.0/probl;########@@ Probl
#    cp $i/Ei1.0/traj_probl* $i/Ei1.0/config_probl* $i/Ei1.0/refstructureFF_eneroptim.out /DFT_$i/Ei1.0/probl;
#    cp $MD2VASP/MD2vasp_V3.py $path/DFT_$i/Ei1.0/probl;
#    cd $path/DFT_$i/Ei1.0/probl;
#    python3 MD2vasp_V3.py;
#    rm MD2vasp_V3.py Ei1.0/traj_stick* Ei1.0/config_stick* Ei1.0/refstructureFF_eneroptim.out;
#    echo='########@@@@@@@@ 1.0 @@########@@ Probl @@########'
#    cd $path;
#    mkdir /DFT_$i/Ei1.0/stick;########@@ stick
#    cp $i/Ei1.0/traj_stick* $i/Ei1.0/config_stick* $i/Ei1.0/refstructureFF_eneroptim.out /DFT_$i/Ei1.0/stick;
#    cp $MD2VASP/MD2vasp_V3.py $path/DFT_$i/Ei1.0/stick;
#    cd $path/DFT_$i/Ei1.0/stick;
#    python3 MD2vasp_V3.py;
#    rm MD2vasp_V3.py Ei1.0/traj_stick* Ei1.0/config_stick* Ei1.0/refstructureFF_eneroptim.out;
#########################@@@@@@@@@@@@ 1.4
#    echo='########@@@@@@@@ 1.0 @@########@@ Stick @@########'
#    cd $path;
#    mkdir /DFT_$i/Ei1.4;########@@@@@@@@ 1.4
#    mkdir /DFT_$i/Ei1.4/probl;########@@ Probl
#    cp $i/Ei1.4/traj_probl* $i/Ei1.4/config_probl* $i/Ei1.4/refstructureFF_eneroptim.out /DFT_$i/Ei1.4/probl;
#    cp $MD2VASP/MD2vasp_V3.py $path/DFT_$i/Ei1.4/probl;
#    cd $path/DFT_$i/Ei1.4/probl;
#    python3 MD2vasp_V3.py;
#    rm MD2vasp_V3.py Ei1.4/traj_stick* Ei1.4/config_stick* Ei1.4/refstructureFF_eneroptim.out;
#    echo='########@@@@@@@@ 1.4 @@########@@ Probl @@########'
#    cd $path;
#    mkdir /DFT_$i/Ei1.4/stick;########@@ stick
#    cp $i/Ei1.4/traj_stick* $i/Ei1.4/config_stick* $i/Ei1.4/refstructureFF_eneroptim.out /DFT_$i/Ei1.4/stick;
#    cp $MD2VASP/MD2vasp_V3.py $path/DFT_$i/Ei1.4/stick;
#    cd $path/DFT_$i/Ei1.4/stick;
#    python3 MD2vasp_V3.py;
#    rm MD2vasp_V3.py Ei1.4/traj_stick* Ei1.4/config_stick* Ei1.4/refstructureFF_eneroptim.out;
#    echo='########@@@@@@@@ 1.4 @@########@@ Stick @@########'
#done
#
