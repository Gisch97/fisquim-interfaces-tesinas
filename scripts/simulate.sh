### Script para ejecutar simulaciones en piluso.
### PROGRAM
declare -a Energia=("0.6" "1.0" "1.4");
VASP='submit_vasp.sh';
GSRD='submit_gsrd.sh';
path='/home/gkulemeyer.ifir/GSRD/Entrenamiento7/slabmotions/DFT_110';
# ###########################################
echo '@@@@@@   EXECUTE SIMULATIONS   @@@@@@';
mkdir $path/temp
#for i in {9002..9040}; do
#	cd $path/$i/;
#	sbatch $GSRD;
#	cd $path/temp;
#done;
#rmidir $path/temp
for E in ${Energia[@]}; do
	Ei='Ei'$E
	cd $path/temp;
	cd $path/$Ei/stick/files_for_DFT;
	num=$(ls|wc -l);
	for ((i=1; i<=$num; i++)); do
		cd $path/temp;
		cd $path/$Ei/stick/files_for_DFT/conf$i/;
		sbatch $VASP;
	done;
#	cd $path/$Ei/probl/files_for_DFT;
#	num=$(ls|wc -l);
#	for ((i=1; i<=$num; i++)); do
#	cd $path/temp;
#		cd $path/$Ei/probl/files_for_DFT/conf$i/;
#		sbatch $VASP;
#	done;
done;

#for i in {100..110..5}; do
#	cd $path/temp
#	cd $path/$i/Ei0.6;
#	sbatch $GSRD;
#	cd $path/temp
#	cd $path/$i/Ei1.0;
#	sbatch $GSRD;
#	cd $path/temp
#	cd $path/$i/Ei1.4;
#	sbatch $GSRD;
#done





# cd $path/Ei0.6;
# sed -i "s/-q /-q long_amd,medium_amd \# /" $GSRD;
# sed -i "s/-pe /-pe impi_32 32 \# /" $GSRD;
# qsub $GSRD;
# cd $path/Ei1.0;
# sed -i "s/-q /-q long_amd,medium_amd \# /" $GSRD;
# sed -i "s/-pe /-pe impi_32 32 \# /" $GSRD;
# qsub $GSRD;
# cd $path/Ei1.4;
# sed -i "s/-q /-q long_amd,medium_amd \# /" $GSRD;
# sed -i "s/-pe /-pe impi_32 32 \# /" $GSRD;
# qsub $GSRD;

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
