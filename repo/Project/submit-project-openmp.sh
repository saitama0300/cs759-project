#!/usr/bin/env zsh

#SBATCH -J 759Project

#SBATCH -p wacc

#SBATCH -t 0-00:30:30

#SBATCH --job-name=759Project

#SBATCH -o ../../759Project-%j.out -e ../../759Project-%j.err

#SBATCH --cpus-per-task=20

hostname

module purge

module load gcc/9.4.0 mpi/mpich/4.0.2


input_image='4.jpg'
code_type="openmp"
num_threads=20

operation_type="image-smoothening"

filter='gaussian'
kernel_size='3x3'

echo "" > out_openmp.txt

g++ src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.cpp src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}filter.cpp -Wall -O3 -std=c++17 -o src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.out -fopenmp
src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${input_image}-out.jpg ${num_threads}
src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${input_image}-out.jpg ${num_threads} >> out_openmp.txt

kernel_size='5x5'

g++ src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.cpp src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}filter.cpp -Wall -O3 -std=c++17 -o src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.out -fopenmp
src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${input_image}-out.jpg ${num_threads}
src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${input_image}-out.jpg ${num_threads} >> out_openmp.txt 

filter='median'
kernel_size='3x3'

g++ src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.cpp src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}filter.cpp -Wall -O3 -std=c++17 -o src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.out -fopenmp
src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${input_image}-out.jpg ${num_threads}
src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${input_image}-out.jpg ${num_threads} >> out_openmp.txt  

kernel_size='5x5'

g++ src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.cpp src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}filter.cpp -Wall -O3 -std=c++17 -o src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.out -fopenmp
src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${input_image}-out.jpg ${num_threads}
src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${input_image}-out.jpg ${num_threads} >> out_openmp.txt   

filter='normalized'
kernel_size='3x3'

g++ src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.cpp src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}filter.cpp -Wall -O3 -std=c++17 -o src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.out -fopenmp
src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${input_image}-out.jpg ${num_threads}
src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${input_image}-out.jpg ${num_threads} >> out_openmp.txt

kernel_size='5x5'
g++ src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.cpp src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}filter.cpp -Wall -O3 -std=c++17 -o src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.out -fopenmp
src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${input_image}-out.jpg ${num_threads}
src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${input_image}-out.jpg ${num_threads} >> out_openmp.txt

operation_type="edge-detection"
filter='sobel'
kernel_size=''

g++ src/${code_type}/${operation_type}/${filter}/${kernel_size}/${filter}.cpp src/${code_type}/${operation_type}/${filter}/${kernel_size}/${filter}filter.cpp -Wall -O3 -std=c++17 -o src/${code_type}/${operation_type}/${filter}/${kernel_size}/${filter}.out -fopenmp
src/${code_type}/${operation_type}/${filter}/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}/${kernel_size}/${input_image}-out.jpg ${num_threads}
src/${code_type}/${operation_type}/${filter}/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}/${kernel_size}/${input_image}-out.jpg ${num_threads} >> out_openmp.txt 


operation_type="morphological-operations"
filter='erosin'
kernel_size=''

g++ src/${code_type}/${operation_type}/${filter}/${kernel_size}/${filter}.cpp src/${code_type}/${operation_type}/${filter}/${kernel_size}/${filter}filter.cpp -Wall -O3 -std=c++17 -o src/${code_type}/${operation_type}/${filter}/${kernel_size}/${filter}.out -fopenmp
src/${code_type}/${operation_type}/${filter}/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}/${kernel_size}/${input_image}-out.jpg ${num_threads}
src/${code_type}/${operation_type}/${filter}/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}/${kernel_size}/${input_image}-out.jpg ${num_threads} >> out_openmp.txt

filter='dilation'
kernel_size=''

g++ src/${code_type}/${operation_type}/${filter}/${kernel_size}/${filter}.cpp src/${code_type}/${operation_type}/${filter}/${kernel_size}/${filter}filter.cpp -Wall -O3 -std=c++17 -o src/${code_type}/${operation_type}/${filter}/${kernel_size}/${filter}.out -fopenmp
src/${code_type}/${operation_type}/${filter}/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}/${kernel_size}/${input_image}-out.jpg ${num_threads}
src/${code_type}/${operation_type}/${filter}/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}/${kernel_size}/${input_image}-out.jpg ${num_threads} >> out_openmp.txt