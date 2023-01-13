#!/bin/bash
### Este script genera un archivo csv con las energias obtenidas en una carpeta
### xsf-files
savepath='/home/gkulemeyer.ifir/Dynamics/CH4Pt110/Entrenamiento2/slabmotion_T50-750/Confs_csv'


path='/home/gkulemeyer.ifir/Dynamics/CH4Pt110/Entrenamiento2/'
name='Entrenamiento2'
echo "Energy" >> $savepath/$name.csv
for file in $path/xsf-files/*.xsf; do
	E=$(head -n 1 $file | cut -d " " -f 5)  #Filtrado de E0
	echo "$E" >> $savepath/$name.csv  ;
done

