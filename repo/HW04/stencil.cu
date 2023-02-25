
__global__ void stencil_kernel(const float* image, const float* mask, float* output, unsigned int n, unsigned int R)
{
    //Image, mask & output shared memory instances
    extern __shared__ float shared_memory[];

    float *image_shared = shared_memory;
    float *mask_shared = (float *)&image_shared[2*R+blockDim.x];
    float *output_shared = (float *)&mask_shared[2*R+1];
    //Calculate thread index
    long long int thread_index = threadIdx.x + blockIdx.x*blockDim.x;

    if(threadIdx.x==0) {
            if(thread_index-R<0){
                for(long long int i=0;i<R;i++){
                    image_shared[i] = 1.0; 
                }
            }
            else{
                for(long long int i=0;i<R;i++){
                    image_shared[i] = image[thread_index-R+i];
                }
            }
            image_shared[R] = image[thread_index];
    }
    else if(threadIdx.x==blockDim.x-1) {
        
            if(thread_index+R>=n){
                for(long long int i=0;i<R;i++) {
                    image_shared[R+blockDim.x+i] = 1.0;
                }
            }
            else {
                for(long long int i=0;i<R;i++) {
                    image_shared[blockDim.x+R+i] = image[thread_index+1+i];
                }
            }
            image_shared[blockDim.x+R-1] = image[thread_index]; 
    }
    else{
        image_shared[R+threadIdx.x] = image[thread_index];
    }

    //CORNER CASE HANDLED - for n not being a multiple of number of threads per block
    if(thread_index==n-1) {
        for(long long int i=0;i<R;i++) {
            image_shared[R+threadIdx.x+1+i] = 1.0;
        }
    }

    output_shared[threadIdx.x] = 0;

    if(threadIdx.x<=2*R) {
        mask_shared[threadIdx.x] = mask[threadIdx.x];
    }

    //Wait for all threads to finish copying 
    __syncthreads(); 

    if(thread_index<n) {
        //Compute the output of stencil
        for(int j= 0;j<=2*R;j++) {
                output_shared[threadIdx.x] += image_shared[threadIdx.x+j]*mask_shared[j];     
        }

        //Send result of output shared memory to output in global device memory
        __syncthreads(); 
        
        output[thread_index] = output_shared[threadIdx.x];  
       
    }
}

__host__ void stencil(const float* image, const float* mask, float* output, unsigned int n, unsigned int R, unsigned int threads_per_block)
{
    //Calculate the number of blocks
    std::size_t num_blocks = (threads_per_block-1+n)/threads_per_block;

    //Call kernel with dynamic shared memory
    stencil_kernel<<<num_blocks,threads_per_block,((threads_per_block+2*R)*2+1)*sizeof(float)>>> (image, mask, output, n, R);

    //Cuda device synchronizer
    cudaDeviceSynchronize();
}