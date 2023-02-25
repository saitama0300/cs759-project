#!/usr/bin/env zsh

#SBATCH -J 759Project

#SBATCH -p wacc

#SBATCH -t 0-00:30:30

#SBATCH --job-name=759Project

#SBATCH -o ../../759Project-%j.out -e ../../759Project-%j.err

#SBATCH --cpus-per-task=1 
#SBATCH --gres=gpu:1

hostname

module purge

module load nvidia/cuda

input_image='3.jpg'
num_threads_per_block=16

code_type="cuda"

operation_type="image-smoothening"

filter='gaussian'
kernel_size='3x3'

echo "" > out_cuda.txt

nvcc src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.cu src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}filter.cu -Xcompiler -O3 -Xcompiler -Wall -Xptxas -O3 -std c++17 -o src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.out
src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${input_image}-out.jpg ${num_threads_per_block}
src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${input_image}-out.jpg ${num_threads_per_block} >> out_cuda.txt


kernel_size='5x5'
nvcc src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.cu src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}filter.cu -Xcompiler -O3 -Xcompiler -Wall -Xptxas -O3 -std c++17 -o src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.out
src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${input_image}-out.jpg ${num_threads_per_block}
src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${input_image}-out.jpg ${num_threads_per_block} >> out_cuda.txt

filter='median'
kernel_size='3x3'

nvcc src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.cu src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}filter.cu -Xcompiler -O3 -Xcompiler -Wall -Xptxas -O3 -std c++17 -o src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.out
src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${input_image}-out.jpg ${num_threads_per_block}
src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${input_image}-out.jpg ${num_threads_per_block} >> out_cuda.txt

kernel_size='5x5'
nvcc src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.cu src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}filter.cu -Xcompiler -O3 -Xcompiler -Wall -Xptxas -O3 -std c++17 -o src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.out
src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${input_image}-out.jpg${num_threads_per_block}
src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${input_image}-out.jpg ${num_threads_per_block} >> out_cuda.txt

filter='normalized'
kernel_size='3x3'

nvcc src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.cu src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}filter.cu -Xcompiler -O3 -Xcompiler -Wall -Xptxas -O3 -std c++17 -o src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.out
src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${input_image}-out.jpg ${num_threads_per_block}
src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${input_image}-out.jpg ${num_threads_per_block} >> out_cuda.txt

kernel_size='5x5'
nvcc src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.cu src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}filter.cu -Xcompiler -O3 -Xcompiler -Wall -Xptxas -O3 -std c++17 -o src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.out
src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${input_image}-out.jpg ${num_threads_per_block}
src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${input_image}-out.jpg ${num_threads_per_block} >> out_cuda.txt

operation_type="edge-detection"
filter='sobel'
kernel_size=''

nvcc src/${code_type}/${operation_type}/${filter}/${kernel_size}/${filter}.cu src/${code_type}/${operation_type}/${filter}/${kernel_size}/${filter}filter.cu -Xcompiler -O3 -Xcompiler -Wall -Xptxas -O3 -std c++17 -o src/${code_type}/${operation_type}/${filter}/${kernel_size}/${filter}.out
src/${code_type}/${operation_type}/${filter}/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}/${kernel_size}/${input_image}-out.jpg ${num_threads_per_block}
src/${code_type}/${operation_type}/${filter}/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}/${kernel_size}/${input_image}-out.jpg ${num_threads_per_block} >> out_cuda.txt


operation_type="morphological-operations"
filter='dilation'
kernel_size=''

nvcc src/${code_type}/${operation_type}/${filter}/${kernel_size}/${filter}.cu src/${code_type}/${operation_type}/${filter}/${kernel_size}/${filter}filter.cu -Xcompiler -O3 -Xcompiler -Wall -Xptxas -O3 -std c++17 -o src/${code_type}/${operation_type}/${filter}/${kernel_size}/${filter}.out
src/${code_type}/${operation_type}/${filter}/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}/${kernel_size}/${input_image}-out.jpg ${num_threads_per_block}
src/${code_type}/${operation_type}/${filter}/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}/${kernel_size}/${input_image}-out.jpg ${num_threads_per_block} >> out_cuda.txt

operation_type="morphological-operations"
filter='erosin'
kernel_size=''

nvcc src/${code_type}/${operation_type}/${filter}/${kernel_size}/${filter}.cu src/${code_type}/${operation_type}/${filter}/${kernel_size}/${filter}filter.cu -Xcompiler -O3 -Xcompiler -Wall -Xptxas -O3 -std c++17 -o src/${code_type}/${operation_type}/${filter}/${kernel_size}/${filter}.out
src/${code_type}/${operation_type}/${filter}/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}/${kernel_size}/${input_image}-out.jpg ${num_threads_per_block}
src/${code_type}/${operation_type}/${filter}/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}/${kernel_size}/${input_image}-out.jpg ${num_threads_per_block} >> out_cuda.txt