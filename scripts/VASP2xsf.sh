#!/bin/bash
###################################################################################################
#### Este script es para armar la carpeta xsf-files
###################################################################################################
module load Miniconda3;
VASP2xsf='/home/gkulemeyer.ifir/scripts';
###################################################################################################
declare -a Energia=("Ei0.6" "Ei1.0" "Ei1.4");
path='/home/gkulemeyer.ifir/GSRD/Entrenamiento6/slabmotions';
slabs='/home/gkulemeyer.ifir/GSRD/Entrenamiento6/fallados/slabs_DFT';
RS='/home/gkulemeyer.ifir/GSRD/Entrenamiento6/RS_83/DFT_83';
savepath='/home/gkulemeyer.ifir/GSRD/Entrenamiento6/Configs';
savepathRS=$savepath'/xsf_RS_83'
ALL=$savepath'/xsf_8'
#SIM_I='36';# Numero de simulacion inicial
#SIM_F='40';# Numero de simulacion final
initial_conf='17278';
###################################################################################################
##### vasp2xsf.py en PATH/DFT_$i/Ei0.6/probl, copiarlo en c/u y ejecutarlo guardando una variable first_file = initial_conf+num+1 . borrarlo

first_file=$initial_conf;
mkdir $savepath
mkdir $path/temp
######################################### Slabs ######################################
mkdir $savepath/xsf_slabs
cd $slabs;
num=$(ls $slabs|wc -l);
echo "####START#### slabmotions ##START## $first_file + $num + 1 ##START######";
cp $VASP2xsf/vasp2xsf.py .;
python3 vasp2xsf.py --first_file=$first_file;
rm vasp2xsf.py;
first_file=$((first_file+num));
echo "#####DONE#### slabmotions  ####DONE#### $first_file #######DONE######";
name="Slabs"
echo "Energy" >> $savepath/$name.csv;
for file in $slabs/xsf-files/*.xsf; do
    E=$(head -n 1 $file | cut -d " " -f 5);  #Filtrado de E0
    echo "$E" >> $savepath/$name.csv;
done;
echo "#####DONE#### slabmotions  ####CSV#### $name #######CSV######";
mv xsf-files/* $savepath/xsf_slabs/
rmdir xsf-files
######################################### RS ######################################
mkdir $savepathRS
for Ei in ${Energia[@]}; do
    #### PROBL
    cd $path/temp
    cd $RS/$Ei/probl;
    num=$(ls $RS/$Ei/probl/files_for_DFT|wc -l);
    echo "####START#### RS / $Ei / probl ##START## $first_file + $num + 1 ##START######";
    cp $VASP2xsf/vasp2xsf.py .;
    python3 vasp2xsf.py --first_file=$first_file;
    rm vasp2xsf.py;
    first_file=$((first_file+num));
    echo "#####DONE#### RS / $Ei / ####DONE#### $first_file #######DONE######";
    name="RS-$Ei"
    echo "Energy" >> $savepath/$name.csv
    for file in $RS/$Ei/probl/xsf-files/*.xsf; do
        E=$(head -n 1 $file | cut -d " " -f 5);  #Filtrado de E0
        echo "$E" >> $savepath/$name.csv  ;
    done;
    echo "#####DONE#### RS / $Ei / probl ####CSV#### $name #######CSV######";
    mv xsf-files/* $savepathRS
    rmdir xsf-files
    ############# STICK
    cd $path/temp
    cd $RS/$Ei/stick;
    num=$(ls  $RS/$Ei/stick/files_for_DFT|wc -l);
    echo "####START#### RS / $Ei / stick ##START## $first_file + $num + 1 ##START######";
    cp $VASP2xsf/vasp2xsf.py  .;
    python3 vasp2xsf.py --first_file=$first_file;
    rm vasp2xsf.py;
    first_file=$((first_file+num));
    echo "#######DONE###### RS / $Ei / stick####DONE#### $first_file #######DONE######";
    name="RS-$Ei-stick"
    echo "Energy" >> $savepath/$name.csv
    for file in $RS/$Ei/probl/xsf-files/*.xsf; do
        E=$(head -n 1 $file | cut -d " " -f 5);  #Filtrado de E0
        echo "$E" >> $savepath/$name.csv  ;
    done;
    echo "#####DONE#### RS / $Ei / probl ####CSV#### $name #######CSV######";
    mv xsf-files/* $savepathRS
    rmdir xsf-files
done;
name="RS"
echo "Energy" >> $savepath/$name.csv
for file in $savepathRS/*.xsf; do
    E=$(head -n 1 $file | cut -d " " -f 5);  #Filtrado de E0
    echo "$E" >> $savepath/$name.csv  ;
done;    




######################################### MD  ######################################

for NUM_SIM in {84..94..5}; do
    mkdir $savepath/xsf_$NUM_SIM
    for Ei in ${Energia[@]}; do
        #### NADMOL
        cd $path/temp
        cd $path/DFT_$NUM_SIM/$Ei/nadmol;
        num=$(ls $path/DFT_$NUM_SIM/$Ei/nadmol/files_for_DFT|wc -l);
        echo "####START#### $NUM_SIM / $Ei / nadmol ##START## $first_file + $num + 1 ##START######";
        cp $VASP2xsf/vasp2xsf.py .;
        python3 vasp2xsf.py --first_file=$first_file;
        rm vasp2xsf.py;
        first_file=$((first_file+num));
        echo "#####DONE#### $NUM_SIM / $Ei / nadmol ####DONE#### $first_file #######DONE######";
        name="$NUM_SIM-$Ei-nadmol"
        echo "Energy" >> $savepath/$name.csv
        for file in $path/DFT_$NUM_SIM/$Ei/nadmol/xsf-files/*.xsf; do
	        E=$(head -n 1 $file | cut -d " " -f 5);  #Filtrado de E0
	        echo "$E" >> $savepath/$name.csv  ;
        done;
        echo "#####DONE#### $NUM_SIM / $Ei / nadmol ####CSV#### $name #######CSV######";
        mv xsf-files/* $savepath/xsf_$NUM_SIM/
        rmdir xsf-files
        ############# STICK
        cd $path/temp
        cd $path/DFT_$NUM_SIM/$Ei/stick;
        num=$(ls  $path/DFT_$NUM_SIM/$Ei/stick/files_for_DFT|wc -l);
        echo "####START#### $NUM_SIM / $Ei / stick ##START## $first_file + $num + 1 ##START######";
        cp $VASP2xsf/vasp2xsf.py  .;
        python3 vasp2xsf.py --first_file=$first_file;
        rm vasp2xsf.py;
        first_file=$((first_file+num));
        echo "#######DONE###### $NUM_SIM / $Ei / stick ####DONE#### $first_file #######DONE######";
        name="$NUM_SIM-$Ei-stick"
        echo "Energy" >> $savepath/$name.csv
        for file in $path/DFT_$NUM_SIM/$Ei/stick/xsf-files/*.xsf; do
	        E=$(head -n 1 $file | cut -d " " -f 5);  #Filtrado de E0
	        echo "$E" >> $savepath/$name.csv  ;
        done;
        echo "#####DONE#### $NUM_SIM / $Ei / stick ####CSV#### $name #######CSV######";
        mv xsf-files/* $savepath/xsf_$NUM_SIM/
        rmdir xsf-files
    done;
    name="$NUM_SIM"
    echo "Energy" >> $savepath/$name.csv
    for file in $savepath/xsf_$NUM_SIM/*.xsf; do
	    E=$(head -n 1 $file | cut -d " " -f 5);  #Filtrado de E0
	    echo "$E" >> $savepath/$name.csv  ;
    done;    
done;
rmdir $path/temp
mkdir $ALL
cd $savepath
cp $savepath/xsf_*/* $ALL/
tar -czf xsf8.tar.gz $ALL
