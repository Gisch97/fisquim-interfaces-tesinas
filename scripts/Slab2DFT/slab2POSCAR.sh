## Colocar la ruta hacia los slabmotion
pfiles='/home/gkulemeyer.ifir/scripts/Slab2DFT';
Sample_Vasp='/home/gkulemeyer.ifir/VASP/Sample_input_files';
VASP='submit_vasp.sh';

path='/home/gkulemeyer.ifir/GSRD/Entrenamiento7/fallados';
name='CH4Pt110';

mkdir $path/slabs_DFT
for i in {9001..9040}; do
	cd $path/$i/
	cp $pfiles/sumoz.sh .
	#cat slabmotion.in |tail -n 53|head -n 51 > config.in
	bash sumoz.sh
	#cut -c 2- poscar>POSCAR
    	mv poscar POSCAR
	#rm poscar
	mkdir $path/slabs_DFT/$i
	mv POSCAR $path/slabs_DFT/$i
	rm sumoz.sh config.in;
	cd $path/slabs_DFT/$i
	cp $Sample_Vasp/* .
	sed -i "s/test-01/S$i-Vasp-$name/" $VASP
	sed -i "s/eth20/eth20/" $VASP
	sed -i "s/nodes=1/nodes=1/" $VASP
	sed -i "s/ntasks-per-node=20/ntasks-per-node=20/" $VASP
	sed -i "s/NPAR=1/NCORE=20/" INCAR
	sed -i "s/c\[1-4,9,12,15,26,27\]/c\[1-4,15,16,23,26,27,29-32\]/" $VASP;#
	sbatch $VASP
done
