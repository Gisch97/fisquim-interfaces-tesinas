#vamos a configurar guardar y comprimir los resultados.
path='/home/gkulemeyer.ifir/GSRD/Entrenamiento6/slabmotions'
files=''
mkdir $path/SLABAN
for i in {84..92}; do
	mkdir $path/SLABAN/$i;
	cd $path/$i/;
	cp $files $path/SLABAN/$i;
done
tar -cvzf $path/E6.tar.gz $path/SLABAN
rm -r $path/SLABAN

