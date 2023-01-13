#### Este script sirve para editar un archivo DF GSRD sh.
path='/home/gkulemeyer.ifir/Dynamics/CH4Pt110/Entrenamiento2/slabmotion_T50-750'
GSRD=run-gsrd_ann.sh
## Rename
# for i in {21..34}; do
#	cd $path/$i/
#	sed -i "s/-N /-N slabm-$i-ch4pt110 \# /" $GSRD
# done
## Change queue
for i in {21..27}; do
 	cd $path/$i/
 	sed -i "s/-q /-q parallel_amd,long_amd,medium_amd \# /" $GSRD
 	sed -i "s/-pe /-pe impi_32 32 \# /" $GSRD
done

#################################################
#################################################
###### pe list #####
### -q colisiones
## -pe impi impi-node impi_16 impi_4 impi_8 make mpi mpich \ mpitest openmp openmp_16 openmp_32 orte
### -q fiquin
## -pe impi impi-node impi_4 make mpi mpich mpitest openmp orte
### -q parallel_amd
## -pe impi_16 impi_32 openmp_16 openmp_32
### -q long_amd // -q medium_amd
## -pe impi impi-node impi_16 impi_32 impi_4 impi_8 make mpi \ mpich mpitest openmp openmp_16 openmp_32 orte
