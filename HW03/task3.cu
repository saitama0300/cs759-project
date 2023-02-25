#include <cstdio>
#include <cstdlib>
#include <ctime>
#include "vscale.cuh"

#define NUM_THREADS_PER_BLOCK 512
#define MAX_RAND 1000

int main(int argc, char* argv[]) {

    std::srand((unsigned int)std::time(NULL));
    
    std::size_t n = std::atoll(argv[1]);

    //Allocating memory to host arrays
    float * a = (float *) std::malloc(n*sizeof(float));
    float * b = (float *) std::malloc(n*sizeof(float));
 
    //Populating values within the host arrays
    for(std::size_t i=0;i<n;i++) {
        a[i] = ((float(std::rand()%MAX_RAND)*20.0)/MAX_RAND)-10.0; //Value between -10.0 and 10.0
        b[i] = ((float(std::rand()%MAX_RAND)*1.0)/MAX_RAND); //Value between 0.0 & 1.0
    }  

    // Declare pointers that will point to the memory allocated on the device.
    float *dA, *dB;
 
    // Allocate memory on the device
    cudaMalloc(&dA, sizeof(float)*n);
    cudaMalloc(&dB, sizeof(float)*n);

    //Copy data from host to device
    cudaMemcpy(dA, a, sizeof(float)*n, cudaMemcpyHostToDevice);
    cudaMemcpy(dB, b, sizeof(float)*n, cudaMemcpyHostToDevice);

    std::size_t num_blocks = ((n+NUM_THREADS_PER_BLOCK-1)/NUM_THREADS_PER_BLOCK); 

    //For recording time:
    cudaEvent_t start;
    cudaEvent_t stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    cudaEventRecord(start); //START EVENT

    // Launch the kernel on the device
    vscale<<<num_blocks, NUM_THREADS_PER_BLOCK>>>(dA,dB,n);

    cudaEventRecord(stop); //STOP EVENT
    cudaEventSynchronize(stop);

    // Get the elapsed time in milliseconds
    float ms;
    cudaEventElapsedTime(&ms, start, stop);

    // Copy the output array back from the device to the host and print its values
    cudaMemcpy(b, dB, sizeof(float)*n, cudaMemcpyDeviceToHost);

    //Print results
    std::printf("%f\n", ms); 
    std::printf("%f\n", b[0]);
    std::printf("%f\n", b[n-1]);
 
    // Free resources
    cudaFree(dA);
    cudaFree(dB);
    std::free(a);
    std::free(b);

    return 0;
}
