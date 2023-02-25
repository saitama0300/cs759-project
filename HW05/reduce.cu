#include<cstdio>

__global__ void reduce_kernel(float *g_idata, float *g_odata, unsigned int n) {

    extern __shared__ float shared_memory[];
    float *s_idata = shared_memory;

    //For add on Load (Reference #4)
    std::size_t i = blockDim.x*(2*blockIdx.x) + threadIdx.x;

    //Populate the shared memory
    if(i<n) {
        if(i+blockDim.x<n){
            //Add on Load (Reference #4)
            s_idata[threadIdx.x] = g_idata[i]+g_idata[i+blockDim.x];
        }
        else {
            //Corner Case
            s_idata[threadIdx.x] = g_idata[i];
        }
    }
    else {
        //Corner Case
        s_idata[threadIdx.x] = 0.0;
    }

    __syncthreads();
  
    //Calculate partial sum across s_idata
    for(std::size_t j=blockDim.x/2;j>0;j>>=1) {
        if(threadIdx.x<j){
            s_idata[threadIdx.x] += s_idata[threadIdx.x+j];
        }
     
        __syncthreads();
    }
 
    //Populate g_odata & g_idata with new final sum (stored in s_idata
    g_odata[blockIdx.x] = s_idata[0];
    g_idata[blockIdx.x] = s_idata[0];

    __syncthreads();
}
__host__ void reduce(float **input, float **output, unsigned int N,
                     unsigned int threads_per_block){

    //Initializing loop variables
    std::size_t num_blocks = (N+(2*threads_per_block-1))/(2*threads_per_block); 
    std::size_t input_size = N;

    while(input_size>1){

        //kernel launch
        reduce_kernel<<<num_blocks,threads_per_block,threads_per_block*sizeof(float)>>>(*(input), *(output), input_size);
        cudaDeviceSynchronize();
        //Input size change for next kernel launch
        input_size = num_blocks;
        //Get new number of blocks every iteration
        num_blocks = (input_size+(2*threads_per_block-1))/(2*threads_per_block); 
    }

}