!! Programa utilizado para hacer un shift a configuraciones obtenidas de slabmotions que no convergen.
program sumoz
implicit none
integer :: i
real(8) :: x,y,z,shift

open(10,file='config.in', status='old')
open(20,file='poscar', status='new')
write(20,*)'Pt H C : CH4/Pt(110)-2x1 (1x3 supercell)'        
write(20,*)'1.0'
write(20,*)'+8.0400000000  +0.0000000000  +0.0000000000' 
write(20,*)'+0.0000000000  +8.5277077811  +0.0000000000' 
write(20,*)'+0.0000000000  +0.0000000000 +31.3702770415' 
write(20,*)'Pt  H  C'
write(20,*)'51  4  1'
write(20,*)'Selective'
write(20,*)'Cartesian'
do i=1,51
   read(10,*)x,y,z
   if (i==1) shift=z
   if (i <= 12) then
      write(20,*)x,y,z-shift,' F F F'
   else
      write(20,*)x,y,z-shift,' T T T'
   endif
enddo
close(10)
write(20,*)'  4.7020649105944274        3.5451374627682810        20.8222483809770758      T T T'
write(20,*)'  3.4384435610795014        2.2815601561981489        20.8222584542356444      T T T'
write(20,*)'  4.7019475455655577        2.2815587204181540        22.0859325380777847      T T T'
write(20,*)'  3.4381334594848862        3.5452746264160711        22.0857728987941755      T T T'
write(20,*)'  4.0702570725264264        2.9132825770511208        21.4540823266182699      T T T'
close(20)
end program sumoz
