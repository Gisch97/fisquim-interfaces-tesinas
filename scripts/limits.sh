#!/bin/bash
#### Script para obtener los limites de energia
path='/home/gkulemeyer.ifir/Dynamics/CH4Pt110/Entrenamiento2/RS/DFT_NN3'
E_lim=-140
### Semillas
E_max=-160	
E_min=0
for file in $path/xsf-files/*.xsf; do
	E=$(head -n 1 $file | cut -d " " -f 5)  #Filtrado de E0
	if (( $(echo "$E $E_max" | awk '{print ($1 > $2)}') ));	then E_max=$E; fi;
	if (( $(echo "$E $E_min" | awk '{print ($1 < $2)}') )); then E_min=$E; fi ;
done
echo "E_max = $E_max, E_min = $E_min , E_lim = $E_lim" >> $path/limits.out 
