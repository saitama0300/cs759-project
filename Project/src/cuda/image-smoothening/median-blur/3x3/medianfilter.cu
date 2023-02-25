#include "medianfilter.cuh"
#include<cstdio>

__global__ void apply_filter(unsigned char* input, unsigned char* output, int height, int width) {
    extern __shared__ unsigned char shared_memory[];
    unsigned char *image = shared_memory;

    int tx = threadIdx.x;
    int ty = threadIdx.y;

    int im_x = tx+1;
    int im_y = ty+1;

    int smem_x = (blockDim.x+2);
    int smem_y = (blockDim.y+2);

    int bx = blockIdx.x;
    int by = blockIdx.y;

    int thread_idx = bx*blockDim.x+tx;
    int thread_idy = by*blockDim.y+ty;

    if(tx==0 && ty==0) {
      
        for(int i=1;i<smem_x-1;i++){
          image[NUM_CHANNELS*(i*smem_y+0)] = (by==0) ? 0 : (input[NUM_CHANNELS*((thread_idx+i-1)*height+thread_idy-1)]);
          image[NUM_CHANNELS*(i*smem_y+0)+1] = (by==0) ? 0 : (input[NUM_CHANNELS*((thread_idx+i-1)*height+thread_idy-1)+1]);
          image[NUM_CHANNELS*(i*smem_y+0)+2] = (by==0) ? 0 : (input[NUM_CHANNELS*((thread_idx+i-1)*height+thread_idy-1)+2]);
        }

        for(int i=1;i<smem_x-1;i++){
          image[NUM_CHANNELS*(i*smem_y+smem_x-1)] = (by==(gridDim.y-1)) ? 0 : (input[NUM_CHANNELS*((thread_idx+i-1)*height+thread_idy+blockDim.y)]);
          image[NUM_CHANNELS*(i*smem_y+smem_x-1)+1] = (by==(gridDim.y-1)) ? 0 :(input[NUM_CHANNELS*((thread_idx+i-1)*height+thread_idy+blockDim.y)+1]);
          image[NUM_CHANNELS*(i*smem_y+smem_x-1)+2] = (by==(gridDim.y-1)) ? 0 : (input[NUM_CHANNELS*((thread_idx+i-1)*height+thread_idy+blockDim.y)+2]); 
        }

        for(int i=1;i<smem_y-1;i++){
          image[NUM_CHANNELS*(0*smem_y+i)] = (bx==0) ? 0 : (input[NUM_CHANNELS*((thread_idx-1)*height+thread_idy+i-1)]);
          image[NUM_CHANNELS*(0*smem_y+i)+1] = (bx==0) ? 0 : (input[NUM_CHANNELS*((thread_idx-1)*height+thread_idy+i-1)+1]);
          image[NUM_CHANNELS*(0*smem_y+i)+2] = (bx==0) ? 0 : (input[NUM_CHANNELS*((thread_idx-1)*height+thread_idy+i-1)+2]);
        }
    
        for(int i=1;i<smem_y-1;i++){
          image[NUM_CHANNELS*((smem_x-1)*smem_y+i)] = (bx==(gridDim.x-1)) ? 0 : (input[NUM_CHANNELS*((thread_idx+blockDim.x)*height+thread_idy+i-1)]);
          image[NUM_CHANNELS*((smem_x-1)*smem_y+i)+1] = (bx==(gridDim.x-1)) ? 0 : (input[NUM_CHANNELS*((thread_idx+blockDim.x)*height+thread_idy+i-1)+1]);
          image[NUM_CHANNELS*((smem_x-1)*smem_y+i)+2] = (bx==(gridDim.x-1)) ? 0 : (input[NUM_CHANNELS*((thread_idx+blockDim.x)*height+thread_idy+i-1)+2]); 
        }

        //(0,0)
        image[NUM_CHANNELS*((0)*smem_y+0)] = (bx==0 || by==0) ? 0 : (input[NUM_CHANNELS*((thread_idx-1)*height+thread_idy-1)]);
        image[NUM_CHANNELS*((0)*smem_y+0)+1] = (bx==0 || by==0) ? 0 : (input[NUM_CHANNELS*((thread_idx-1)*height+thread_idy-1)+1]);
        image[NUM_CHANNELS*((0)*smem_y+0)+2] = (bx==0 || by==0) ? 0 : (input[NUM_CHANNELS*((thread_idx-1)*height+thread_idy-1)+2]);
        
        //(0,0)
        image[NUM_CHANNELS*((0)*smem_y+smem_y-1)] = (bx==0 || by==gridDim.y-1) ? 0 : (input[NUM_CHANNELS*((thread_idx-1)*height+thread_idy+blockDim.y)]);
        image[NUM_CHANNELS*((0)*smem_y+smem_y-1)+1] = (bx==0 || by==gridDim.y-1) ? 0 : (input[NUM_CHANNELS*((thread_idx-1)*height+thread_idy+blockDim.y)+1]);
        image[NUM_CHANNELS*((0)*smem_y+smem_y-1)+2] = (bx==0 || by==gridDim.y-1) ? 0 : (input[NUM_CHANNELS*((thread_idx-1)*height+thread_idy+blockDim.y)+2]); 

        //(0,0)
        image[NUM_CHANNELS*((smem_x-1)*smem_y+0)] = (bx==gridDim.x-1 || by==0) ? 0 : (input[NUM_CHANNELS*((thread_idx+blockDim.x)*height+thread_idy-1)]);
        image[NUM_CHANNELS*((smem_x-1)*smem_y+0)+1] = (bx==gridDim.x-1 || by==0) ? 0 : (input[NUM_CHANNELS*((thread_idx+blockDim.x)*height+thread_idy-1)+1]);
        image[NUM_CHANNELS*((smem_x-1)*smem_y+0)+2] = (bx==gridDim.x-1 || by==0) ? 0 : (input[NUM_CHANNELS*((thread_idx+blockDim.x)*height+thread_idy-1)+2]); 
    
        //(0,0)
        image[NUM_CHANNELS*((smem_x-1)*smem_y+smem_y-1)] = (bx==gridDim.x-1 || by==gridDim.y-1) ? 0 : (input[NUM_CHANNELS*((thread_idx+blockDim.x)*height+thread_idy+blockDim.y)]);
        image[NUM_CHANNELS*((smem_x-1)*smem_y+smem_y-1)+1] = (bx==gridDim.x-1 || by==gridDim.y-1) ? 0 : (input[NUM_CHANNELS*((thread_idx+blockDim.x)*height+thread_idy+blockDim.y)+1]);
        image[NUM_CHANNELS*((smem_x-1)*smem_y+smem_y-1)+2] = (bx==gridDim.x-1 || by==gridDim.y-1) ? 0 : (input[NUM_CHANNELS*((thread_idx+blockDim.x)*height+thread_idy+blockDim.y)+2]); 

    }

    if(thread_idx<width && thread_idy<height){
        image[NUM_CHANNELS*(im_x*smem_y+im_y)] = (input[NUM_CHANNELS*(thread_idx*height+thread_idy)]);
        image[NUM_CHANNELS*(im_x*smem_y+im_y)+1] = (input[NUM_CHANNELS*(thread_idx*height+thread_idy)+1]);
        image[NUM_CHANNELS*(im_x*smem_y+im_y)+2] = (input[NUM_CHANNELS*(thread_idx*height+thread_idy)+2]);    
    }
    else{
        image[NUM_CHANNELS*(im_x*smem_y+im_y)] = 0;
        image[NUM_CHANNELS*(im_x*smem_y+im_y)+1] = 0;
        image[NUM_CHANNELS*(im_x*smem_y+im_y)+2] = 0;
    }

    __syncthreads();
    unsigned char elements_r[NUM_ELEMENTS] =  {image[NUM_CHANNELS*((im_x-1)*smem_y+im_y-1)],
        image[NUM_CHANNELS*(im_x*smem_y+im_y-1)],
        image[NUM_CHANNELS*((im_x+1)*smem_y+im_y-1)],
        image[NUM_CHANNELS*((im_x-1)*smem_y+im_y)],
        image[NUM_CHANNELS*((im_x)*smem_y+im_y)],
        image[NUM_CHANNELS*((im_x+1)*smem_y+im_y+1)],
        image[NUM_CHANNELS*((im_x-1)*smem_y+im_y+1)],
        image[NUM_CHANNELS*((im_x)*smem_y+im_y+1)],
        image[NUM_CHANNELS*((im_x+1)*smem_y+im_y+1)]
    };
    unsigned char elements_g[NUM_ELEMENTS] =  {image[NUM_CHANNELS*((im_x-1)*smem_y+im_y-1)+1],
        image[NUM_CHANNELS*(im_x*smem_y+im_y-1)+1],
        image[NUM_CHANNELS*((im_x+1)*smem_y+im_y-1)+1],
        image[NUM_CHANNELS*((im_x-1)*smem_y+im_y)+1],
        image[NUM_CHANNELS*((im_x)*smem_y+im_y)+1],
        image[NUM_CHANNELS*((im_x+1)*smem_y+im_y+1)+1],
        image[NUM_CHANNELS*((im_x-1)*smem_y+im_y+1)+1],
        image[NUM_CHANNELS*((im_x)*smem_y+im_y+1)+1],
        image[NUM_CHANNELS*((im_x+1)*smem_y+im_y+1)+1]
    };
    unsigned char elements_b[NUM_ELEMENTS] =  {image[NUM_CHANNELS*((im_x-1)*smem_y+im_y-1)+2],
        image[NUM_CHANNELS*(im_x*smem_y+im_y-1)+2],
        image[NUM_CHANNELS*((im_x+1)*smem_y+im_y-1)+2],
        image[NUM_CHANNELS*((im_x-1)*smem_y+im_y)+2],
        image[NUM_CHANNELS*((im_x)*smem_y+im_y)+2],
        image[NUM_CHANNELS*((im_x+1)*smem_y+im_y+1)+2],
        image[NUM_CHANNELS*((im_x-1)*smem_y+im_y+1)+2],
        image[NUM_CHANNELS*((im_x)*smem_y+im_y+1)+2],
        image[NUM_CHANNELS*((im_x+1)*smem_y+im_y+1)+2]
    };
     
    for(int i=0;i<=NUM_ELEMENTS/2;i++){
        for(int j=i+1;j<NUM_ELEMENTS;j++){
            unsigned char temp;
            if(elements_r[j]<elements_r[i]){
                temp = elements_r[i];
                elements_r[i] = elements_r[j];
                elements_r[j] = temp;
            }
            if(elements_g[j]<elements_g[i]){
                temp = elements_g[i];
                elements_g[i] = elements_g[j];
                elements_g[j] = temp;
            }
            if(elements_b[j]<elements_b[i]){
                temp = elements_b[i];
                elements_b[i] = elements_b[j];
                elements_b[j] = temp;
            }
        }
    }

    output[NUM_CHANNELS*(thread_idx*height+thread_idy)] = elements_r[NUM_ELEMENTS/2];
    output[NUM_CHANNELS*(thread_idx*height+thread_idy)+1] = elements_g[NUM_ELEMENTS/2];
    output[NUM_CHANNELS*(thread_idx*height+thread_idy)+2] = elements_b[NUM_ELEMENTS/2];

}

__host__ void medianfilter(unsigned char** rgb_image, unsigned char** output_img, int height, int width, int threads_per_block_dim){
   dim3 blockSize(threads_per_block_dim,threads_per_block_dim);
   dim3 gridSize((width+threads_per_block_dim-1)/threads_per_block_dim,(height+threads_per_block_dim-1)/threads_per_block_dim); 

   std::size_t shared_memory = (threads_per_block_dim+2)*(threads_per_block_dim+2)*sizeof(unsigned char)*NUM_CHANNELS;
   cudaEvent_t start;
   cudaEvent_t stop;
   cudaEventCreate(&start);
   cudaEventCreate(&stop);

   cudaEventRecord(start); //START EVENT

   // Launch the kernel on the device
   apply_filter<<<gridSize,blockSize,shared_memory>>>(*(rgb_image),*(output_img),height,width);

   cudaEventRecord(stop); //STOP EVENT
   cudaEventSynchronize(stop);

   //Calculate total runtime using events
   float ms;
   cudaEventElapsedTime(&ms, start, stop);

   printf("Runtime: %f\n", ms); 
   cudaError_t error = cudaGetLastError();
    if(error != cudaSuccess)
    {
        // print the CUDA error message and exit
        printf("CUDA error: %s\n", cudaGetErrorString(error));

    }
    cudaDeviceSynchronize();
}