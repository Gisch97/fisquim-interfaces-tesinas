#!/bin/bash

path="/home/gkulemeyer.ifir/Dynamics/CH4Pt110/Entrenamiento4"

# Buscar todos los archivos "statistics.out" en todas las carpetas de un directorio
files=$(find $path/ -name "statistics.out")
echo $files
# Extraer la primera línea de cualquier archivo "statistics.out" como encabezado

echo "folder         nint        nrefl       nstick  nstickearly   nsticklate    nstickpat       nadmol       nprobl" > $path/stats.out

# Para cada archivo encontrado, extraer la carpeta y la segunda línea (los valores que deseas unificar)
for file in $files; do
	# Extraer la carpeta donde se encuentra el archivo
	folder=$(dirname $file)
    # Eliminar la parte común del directorio
    folder=$(echo $folder | sed 's#/home/gkulemeyer.ifir/Dynamics/CH4Pt110/##g')
	# Extraer la segunda línea del archivo
	values=$(awk 'NR==2 {print $0}' $file)
	# Guardar la carpeta y los valores en el archivo temporal, separados por una coma
	echo "$folder $values" >> $path/stats.out
done

