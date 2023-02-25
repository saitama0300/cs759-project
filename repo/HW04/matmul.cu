__global__ void matmul_kernel(const float* A, const float* B, float* C, size_t n) {

    //Fetch the index from thread and block IDs
    std::size_t thread_index = threadIdx.x + blockIdx.x*blockDim.x;
    std::size_t i = (thread_index)/n; 
    std::size_t j = (thread_index)%n;

    float sum = 0;

    if(i<n && j<n) {
        //Compute Sum across index k for i and j: i->Row; j-> Column

        for(std::size_t k=0;k<n;k++){
            sum += A[i*n+k]*B[k*n+j];
        }

        //Send the sum back to output in device memory
        C[i*n+j] = sum;
    }
}

void matmul(const float* A, const float* B, float* C, size_t n, unsigned int threads_per_block){

    //Calculate the number of blocks for 1D kernel configuration
    std::size_t num_blocks = (threads_per_block-1+(n*n))/threads_per_block;

    // Launch the kernel on the device
    matmul_kernel<<<num_blocks,threads_per_block>>> (A, B, C, n);

    cudaDeviceSynchronize();
}
