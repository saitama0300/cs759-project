__global__ void hillis_steele(float*g_odata, const float*g_idata, float *b_odata, unsigned int n){
    extern volatile __shared__ float t_odata[];

    //Calculate the index to get cumulative thread count
    unsigned int thread_index = blockIdx.x*blockDim.x + threadIdx.x;

    if(thread_index < n) {
        //Bring data to shared memory
        t_odata[threadIdx.x] = g_idata[thread_index];
        int pin=1, pout=0;

        __syncthreads();

        //Only adds up elements within the shared memory (those elements lying between blockIdx.x to blockIdx+1 blocks)
        for(std::size_t i=1;i<blockDim.x;i*=2) {
            //pin and pout toggle their values
            pin = 1 - pin;
            pout = 1 - pout;

            //Add elements
            if(threadIdx.x >= i) {
                t_odata[pout * blockDim.x + threadIdx.x] = t_odata[pin * blockDim.x + threadIdx.x] + t_odata[pin * blockDim.x + threadIdx.x - i];
            }
            else {
                t_odata[pout * blockDim.x + threadIdx.x] = t_odata[pin * blockDim.x + threadIdx.x]; 
            }

            __syncthreads();
        }
        
        //Store temporary data in output array
        g_odata[thread_index] = t_odata[pout*blockDim.x+threadIdx.x];
        __syncthreads();

        //Get cummulative sum across a block (basically sum of all elements in shared memory of this block)
        if(b_odata!=NULL) {
             b_odata[blockIdx.x] = g_odata[blockIdx.x*blockDim.x+blockDim.x-1];
        }
    }

}

__global__ void add_b_odata(float *g_odata, float *b_odata, unsigned int n) {
    //Adds partial block level sums to output array to get final result
    if(blockIdx.x < n-1) {
        g_odata[blockDim.x*(blockIdx.x+1)+threadIdx.x] += b_odata[blockIdx.x];
    }
}

__global__ void add_tail(float *g_odata, float *tail_odata, unsigned int n) {
    //Used to adding tail elements (for case when array input size is not divisible by threads_per_block)
    g_odata[threadIdx.x] += tail_odata[n-1];    
}


__host__ void scan(const float* input, float* output, unsigned int n, unsigned int threads_per_block){
    unsigned int num_tail_data = n % threads_per_block;

    //Case when n is a multiple of threads_per_block
    if(num_tail_data == 0) {
        unsigned int num_blocks = (n+threads_per_block-1)/threads_per_block;
        
        float *b_odata, *b_odata_post_scan;

        //Allocate temporary memory instances to store partial sums across blocks
        cudaMalloc((void**)&b_odata, num_blocks * sizeof(float));
        cudaMalloc((void**)&b_odata_post_scan, num_blocks * sizeof(float));

        if(n>threads_per_block) {
            //Gives partial sums across all elements in al block
            hillis_steele<<<num_blocks, threads_per_block, 2*threads_per_block*sizeof(float)>>>(output,input,b_odata,n);

            //Apply scan over previous stage partial sum to get Cummulative sum across block sums
            hillis_steele<<<1, num_blocks, 2*num_blocks*sizeof(float)>>>(b_odata_post_scan,b_odata,NULL,num_blocks); 

            //Add the final block sums to all partial outputs of output array to get final result 
            add_b_odata<<<num_blocks, threads_per_block>>> (output,b_odata_post_scan,num_blocks);
        }
        else {
            //Case when number of blocks is only 1
            hillis_steele<<<num_blocks, n, 2*n*sizeof(float)>>>(output,input,b_odata,n); 
        }
        //Free allocated memory
        cudaFree(b_odata);
        cudaFree(b_odata_post_scan);
    }
    else {

        //n_adjusted is the number of elements not considering the remainder when n is not a multiple of threads_per_block
        unsigned int n_adjusted = n - num_tail_data;
        unsigned num_blocks = (n_adjusted+threads_per_block-1)/threads_per_block;

        float *b_odata, *b_odata_post_scan;

        //Allocate temporary memory instances to store partial sums across blocks
        cudaMalloc((void**)&b_odata, num_blocks * sizeof(float));
        cudaMalloc((void**)&b_odata_post_scan, num_blocks * sizeof(float));

        //Gives partial sums across all elements in al block
        hillis_steele<<<num_blocks, threads_per_block, 2*threads_per_block*sizeof(float)>>>(output,input,b_odata,n_adjusted);

        //Apply scan over previous stage partial sum to get Cummulative sum across block sums
        hillis_steele<<<1, num_blocks, 2*num_blocks*sizeof(float)>>>(b_odata_post_scan,b_odata,NULL,num_blocks); 

        //Add the final block sums to all partial outputs of output array to get final result
        add_b_odata<<<num_blocks, threads_per_block>>> (output,b_odata_post_scan,num_blocks);

        //Reference the tail elements (the remainder left out if n is not a multiple of threads_per_block)
        const float *tail_idata = &(input[n_adjusted]); //PART OF INPUT DATA
        float *tail_odata = &(output[n_adjusted]); //PART OF OUTPUT DATA

        //Scan the tail ements
        hillis_steele<<<1, num_tail_data, 2*num_tail_data*sizeof(float)>>>(tail_odata, tail_idata,NULL,num_tail_data);

        //Add scanned cummulative block sums to tail elements to have consistent result
        add_tail<<<1, num_tail_data>>>(tail_odata, b_odata_post_scan, num_blocks);

        //Free memory allocated
        cudaFree(b_odata);
        cudaFree(b_odata_post_scan);
    }

    //Call to device synchronize
    cudaDeviceSynchronize();
}
