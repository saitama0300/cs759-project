#include <cstdio>
#include <cstdlib>
#include <ctime>
#include "stencil.cuh"

#define MAX_RAND 1000

int main(int argc, char* argv[]) {

    std::srand((unsigned int)std::time(NULL));
    
    std::size_t n = std::atoll(argv[1]);
    std::size_t R = std::atoll(argv[2]); 
    std::size_t threads_per_block = std::atoll(argv[3]); 

    //Allocating memory to host arrays
    float * image = (float *) std::malloc(n*sizeof(float));
    float * mask = (float *) std::malloc((2*R+1)*sizeof(float));

    float * output = (float *) std::malloc(n*sizeof(float)); 
 
    //Populating values within the host arrays
    for(std::size_t i=0;i<n;i++) {
        image[i] = ((float(std::rand()%MAX_RAND)*2.0)/MAX_RAND)-1.0; //Value between -1.0 and 1.0
    }  

    for(std::size_t i=0;i<=2*R;i++) {
        mask[i] = ((float(std::rand()%MAX_RAND)*2.0)/MAX_RAND)-1.0; //Value between -1.0 and 1.0
    } 

    // Declare pointers that will point to the memory allocated on the device.
    float *dImage, *dMask, *dOutput;
 
    // Allocate memory on the device
    cudaMalloc(&dImage, sizeof(float)*n);
    cudaMalloc(&dMask, sizeof(float)*(2*R+1));

    //Final result array on device
    cudaMalloc(&dOutput, sizeof(float)*n);

    //Copy data from host to device
    cudaMemcpy(dImage, image, sizeof(float)*n, cudaMemcpyHostToDevice);
    cudaMemcpy(dMask, mask, sizeof(float)*(2*R+1), cudaMemcpyHostToDevice);

    //For recording time:
    cudaEvent_t start;
    cudaEvent_t stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    cudaEventRecord(start); //START EVENT

    // Launch the kernel on the device
    stencil(dImage,dMask,dOutput,n,R,threads_per_block);

    cudaEventRecord(stop); //STOP EVENT
    cudaEventSynchronize(stop);

    // Get the elapsed time in milliseconds
    float ms;
    cudaEventElapsedTime(&ms, start, stop);

    // Copy the output array back from the device to the host and print its values
    cudaMemcpy(output, dOutput, sizeof(float)*n, cudaMemcpyDeviceToHost);

    //Print results
    std::printf("%f\n", output[n-1]);
    std::printf("%f\n", ms); 
 
    // Free resources
    cudaFree(dImage);
    cudaFree(dMask);
    cudaFree(dOutput);
    std::free(image);
    std::free(mask);
    std::free(output);

    return 0;
}
