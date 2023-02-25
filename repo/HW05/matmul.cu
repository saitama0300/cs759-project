#include<cstdlib>

template <class TYPE>
__global__ void matmul_kernel(const TYPE* A, const TYPE* B, TYPE* C, unsigned int n) {
        //Reference to Shared Memory
        extern __shared__ char shared_memory_char[];
        TYPE* shared_memory = reinterpret_cast<TYPE*>(shared_memory_char);

        TYPE *aS = shared_memory;
        TYPE *bS = (TYPE *)&aS[blockDim.x*blockDim.y];

        //Calculate indices for block, thread and loop variables
        unsigned int bx = blockIdx.x;
        unsigned int by = blockIdx.y;
      
        unsigned int tx = threadIdx.x;
        unsigned int ty = threadIdx.y;

        unsigned int astart = n*blockDim.x*by;

        unsigned int aend = astart + n - 1;

        unsigned int astep = blockDim.x;

        unsigned int bstart = blockDim.x*bx;
        
        unsigned int bstep = blockDim.x*n;

        //To store the partial sum
        TYPE csub = 0;

        //Loop to execute tiled matrix matrix multiplication
        for(unsigned int a = astart, b = bstart, b_row=0; a<=aend; a+=astep, b+=bstep, b_row+=blockDim.y) {
            //Row & Column transerval index variables
            unsigned int cA = a + tx - blockDim.y * by * n;
            unsigned int rA = blockDim.y * by + ty;

            //Handling corner cases for the shared memory
            if(rA<n && cA<n){
                aS[blockDim.x*ty+tx] = A[a + n*ty + tx];
            }
            else{
                aS[blockDim.x*ty+tx] = 0;
            }

            //Row & Column transerval index variables
            unsigned int cB = blockDim.x * bx + tx;
            unsigned int rB = b_row+ ty;

            //Handling corner cases for the shared memory
            if(rB<n && cB<n) {
                bS[blockDim.y*ty+tx] = B[b + n*ty + tx]; 
            }
            else {
                bS[blockDim.y*ty+tx] = 0; 
            }
            __syncthreads();

            //Calculate partial dot product for Row of A & column of B
            for(unsigned int k=0;k<blockDim.x;k++) {
                csub += aS[ty*blockDim.x+k]*bS[k*blockDim.x+tx];
            }

            __syncthreads();
        }

        //Calculate index variables for storing output of csub to output matrix
        unsigned int c_index = n*blockDim.y*by + blockDim.x*bx;
        unsigned int rC = blockDim.y*by+ty;
        unsigned int cC = blockDim.x*bx+tx;

        //Corner cases handled so matrix C
        if(rC<n && cC<n){
            C[c_index+n*ty+tx] = csub;
        }
    
}

__host__ void matmul_1(const int *A, const int *B, int *C, unsigned int n,
    unsigned int block_dim){
        //Handling Corner cases
        if(block_dim>n){
            block_dim = n;
        }
        
        //Calculating number of blocks based on block_dim
        std::size_t num_blocks = (n+block_dim-1)/block_dim;

        dim3 dimBlock(block_dim, block_dim);
        dim3 dimGrid(num_blocks, num_blocks);   

        //Launch Kernel
        matmul_kernel<int><<<dimGrid,dimBlock,block_dim*block_dim*2*sizeof(int)>>>(A, B, C, n);
        cudaDeviceSynchronize();
}
__host__ void matmul_2(const float *A, const float *B, float *C, unsigned int n,
    unsigned int block_dim){
        //Handling Corner cases
        if(block_dim>n){
            block_dim = n;
        }

        //Calculating number of blocks based on block_dim
        std::size_t num_blocks = (n+block_dim-1)/block_dim;

        dim3 dimBlock(block_dim, block_dim);
        dim3 dimGrid(num_blocks, num_blocks);

        //Launch Kernel
        matmul_kernel<float><<<dimGrid,dimBlock,block_dim*block_dim*2*sizeof(float)>>>(A, B, C, n);
        cudaDeviceSynchronize();
}
__host__ void matmul_3(const double *A, const double *B, double *C,
    unsigned int n, unsigned int block_dim){
        //Handling corner case
        if(block_dim>n){
            block_dim = n;
        }
        
        //Calculating number of blocks based on block_dim
        std::size_t num_blocks = (n+block_dim-1)/block_dim;

        dim3 dimBlock(block_dim, block_dim);
        dim3 dimGrid(num_blocks, num_blocks);

        //Launch Kernel
        matmul_kernel<double><<<dimGrid,dimBlock,block_dim*block_dim*2*sizeof(double)>>>(A, B, C, n);
        cudaDeviceSynchronize();
}