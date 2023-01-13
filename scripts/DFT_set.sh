#####Este script sirve para editar un archivo DFT VASP sh.
# use pwd to open the folders where the DFT configurations are.
Sample_Vasp='/home/gkulemeyer.ifir/VASP_CALCDIR/Sample_input_files'
#path='/home/gkulemeyer.ifir/Dynamics/CH4Pt110/Entrenamiento3/35-RS/DFT_NN5/Ei1.4/files_for_DFT'
path='/home/gkulemeyer.ifir/Dynamics/CH4Pt110/Entrenamiento3/slabmotion_36-49/DFT_36/Ei0.6/probl/files_for_DFT'
name='CH4Pt110-36-06'

for i in {1..120}; do
	cd $path/conf$i/
	cp $Sample_Vasp/* .
	#sed -i "s/-N CH4Pt110-/-N $name-$i \# /" vasp5.4.4-par-piluso.sh
	sed -i "s/-q /-q colisiones \# /" vasp5.4.4-par-piluso.sh
	sed -i "s/-pe /-pe impi_4 4 \# /" vasp5.4.4-par-piluso.sh
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
