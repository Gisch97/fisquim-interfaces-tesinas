### 
declare -a Energia=("0.6" "1.0" "1.4");
slabm='/home/gkulemeyer.ifir/GSRD/Sample_gsrd/slab'
GSRD='submit_gsrd.sh'
NN='009NN'

##################################################################################
path='/home/gkulemeyer.ifir/GSRD/Entrenamiento7'
##################################################################################
##################################################################################
### Slab_num(1) - Temp(2)
arr1=($echo {9001..9040});
arr2=($echo {550..750..5});
##################################################################################
mkdir $path/fallados
for (( i=0; i<${#arr1[@]}; i++ )); do
    mkdir $path/fallados/${arr1[i]}/ ;
    cp $slabm/* $path/fallados/${arr1[i]}/ ;
    sed -i "s/GSRD-test/N-${arr1[i]}-${arr2[i]}K/" $path/fallados/${arr1[i]}/$GSRD;# NOMBRE
    sed -i "s/004NN/${NN}/" $path/fallados/${arr1[i]}/$GSRD;# RED NN
    sed -i "s/partition=ib16/partition=ib16/" $path/fallados/${arr1[i]}/$GSRD;
    sed -i "s/nodes=2/nodes=2/" $path/fallados/${arr1[i]}/$GSRD;
    sed -i "s/ntasks-per-node=16/ntasks-per-node=16/" $path/fallados/${arr1[i]}/$GSRD;
    sed -i "s/c\[1-4,9,12,15\]/c\[1-4,15,16,23,26,27,29-32\]/" $path/fallados/${arr1[i]}/$GSRD;# COLA
    sed -i "s/999/${arr2[i]}/" $path/fallados/${arr1[i]}/input.in;# Temperatura de la superficie
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


