#vamos a setear SLABAN 
path='/home/gkulemeyer.ifir/GSRD/Entrenamiento6/slabmotions'
Sample_SLABAN='/home/gkulemeyer.ifir/GSRD/Sample_gsrd/slaban'
slaban='submit_slaban.sh'
NN='008NN'
for i in {84..92}; do
    cd $path/$i/;
    cp $Sample_SLABAN/* .;
    sed -i "s/SLABAN/sAn-$i-CH4Pt110 /" $slaban;# NOMBRE
    sed -i "s/004NN/${NN}/" $slaban;# RED NN
    sbatch $slaban;
done



