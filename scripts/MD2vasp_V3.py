#!/usr/bin/env python3
import os
import argparse
import numpy as np
from glob import glob
from ase import Atoms
from ase.io import read, write
from shutil import rmtree


###################################################################################################
parser=argparse.ArgumentParser(description='''This script finds all the OUTCAR files contained
                                              in tgz, and writes the energy and configuration
                                   into a configs.in file suitable for GSRD fitting''',
                        allow_abbrev=True)

# Set the arguments we want to implement
parser.add_argument("--dir", help="base directory for the resursive search of VASP output files (default: current directory")
parser.add_argument("--first_file", help="number for the first file ###.xsf (default: 0")


# Apply the arguments so they can be used
args=parser.parse_args()

# Set the folder from which tgz files will be searched recursively
if args.dir:
    print(args.dir)
    base_dir=os.path.expanduser(args.dir)
    print("Searching from {} directory".format(base_dir))
else:
    base_dir=os.getcwd()
    print("Searching from current directory: {}".format(base_dir))

# Set the initial number for xsf file
if args.first_file:
    numfiles=int(args.first_file)
else:
    numfiles=1
###################################################################################################
dft_cell = [[8.0400000000000000,  0.0000000000000000,   0.0000000000000000],
            [0.0000000000000000,  8.5277077811097630,   0.0000000000000000],
            [0.0000000000000000,  0.0000000000000000,  31.3702770414796817]] 

###################################################################################################

E_ref = np.loadtxt('refstructureFF_eneroptim.out', usecols=1 )[-1]

conf_files = [ 'config_probl.xyz', 'config_stick.xyz', 'config_sticklate.xyz', 'config_stickearly.xyz', 'config_stickpat.xyz' ]
traj_files = [ 'traj_probl.out', 'traj_stick.out', 'traj_sticklate.out', 'traj_stickearly.out', 'traj_stickpat.out' ]

for t_file, c_file in zip(traj_files, conf_files):


    #########################################################################################
    # Es estos if se deben poner las condiciones que debe cumplir la trayectoria
    # para ser seleccionada.
    # 
    # El parametro usecols debe coincidir con la columna que tiene la energia
    # potencial en el archivo traj_XXXXX.out (recordar que en python los indices empiezan en 
    # cero, asi que para columna 5 -> usecols=4)
    # 
    # cond es la condicion que se debe cumplir para ser seleccionada, por ejemplo que v>2.0 eV
    #
    # Los archivos que no tienen un bloque especifico, se seleccionana todas las confs.
    # por ejemplo, de traj_probl.out se seleccionan todas para calcular por DFT
    #
    if (t_file == 'traj_admol.out'):
        try:
            atoms = read(c_file, index=':', format='xyz')
            v, vint = np.loadtxt(t_file, usecols=(4, 5), unpack=True) 
        except OSError:
            continue
#        cond = np.logical_or( v > 2.0, vint < -0.5 )
        cond = np.full(len(atoms), True, dtype=bool)

    elif (t_file in ['traj_stick.out', 'traj_sticklate.out', 'traj_stickearly.out', 'traj_stickpat.out']):
        try:
            atoms = read(c_file, index=':', format='xyz')
            v = np.loadtxt(t_file, usecols=6) 
        except OSError:
            continue
#        cond = v > 2.0
        cond = np.full(len(atoms), True, dtype=bool)

    elif (t_file == 'traj_refl.out'):
        try:
            atoms = read(c_file, index=':', format='xyz')
            v = np.loadtxt(t_file, usecols=4) 
        except OSError:
            continue
#        cond = v > 2.0
        cond = np.full(len(atoms), True, dtype=bool)
    else :
        try:
            atoms = read(c_file, index=':', format='xyz')
        except OSError:
            continue
        v = np.loadtxt(t_file, usecols=5) 
        cond = np.full(len(atoms), True, dtype=bool)
    print('{}: {}'.format(t_file, cond))
            
    #########################################################################################
    # Aca se escriben los POSCAR correspondientes    
    for ind in np.arange(len(atoms)):
        if  cond[ind]:
            atoms[ind].set_cell(dft_cell)
            atoms[ind].translate([0.0, 0.0, -atoms[ind][0].z])
            output_dir = "files_for_DFT/conf{}".format(str(numfiles))
            try:
                os.makedirs(output_dir)
            except OSError:
                print("Creation of the directory {} failed".format(output_dir))
            poscar_file = os.path.join(output_dir, "POSCAR")
 
            if (v.size > 1):
                label = '# ann energy = {} eV'.format(v[ind]+E_ref)
            else :
                label = '# ann energy = {} eV'.format(v+E_ref)
            write(poscar_file, atoms[ind], label=label, format='vasp', vasp5=True)
            numfiles += 1

