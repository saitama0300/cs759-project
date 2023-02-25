#include <cstdio>
#include <cstdlib>
#include <ctime>
#include "matmul.cuh"

#define MAX_RAND 1000

int main(int argc, char* argv[]) {

    std::srand((unsigned int)std::time(NULL));
    
    std::size_t n = std::atoll(argv[1]);
    std::size_t threads_per_block = std::atoll(argv[2]); 

    //Allocating memory to host arrays
    float * A = (float *) std::malloc(n*n*sizeof(float));
    float * B = (float *) std::malloc(n*n*sizeof(float));

    float * C = (float *) std::malloc(n*n*sizeof(float)); 
 
    //Populating values within the host arrays
    for(std::size_t i=0;i<n*n;i++) {
        A[i] = ((float(std::rand()%MAX_RAND)*2.0)/MAX_RAND)-1.0; //Value between -1.0 and 1.0
        B[i] = ((float(std::rand()%MAX_RAND)*2.0)/MAX_RAND)-1.0; //Value between -1.0 and 1.0
    }  

    // Declare pointers that will point to the memory allocated on the device.
    float *dA, *dB, *dC;
 
    // Allocate memory on the device
    cudaMalloc(&dA, sizeof(float)*n*n);
    cudaMalloc(&dB, sizeof(float)*n*n);

    //Final result array on device
    cudaMalloc(&dC, sizeof(float)*n*n);

    //Copy data from host to device
    cudaMemcpy(dA, A, sizeof(float)*n*n, cudaMemcpyHostToDevice);
    cudaMemcpy(dB, B, sizeof(float)*n*n, cudaMemcpyHostToDevice);

    //For recording time:
    cudaEvent_t start;
    cudaEvent_t stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    cudaEventRecord(start); //START EVENT

    // Launch the kernel on the device
    matmul(dA,dB,dC,n,threads_per_block);

    cudaEventRecord(stop); //STOP EVENT
    cudaEventSynchronize(stop);

    // Get the elapsed time in milliseconds
    float ms;
    cudaEventElapsedTime(&ms, start, stop);

    // Copy the output array back from the device to the host and print its values
    cudaMemcpy(C, dC, sizeof(float)*n*n, cudaMemcpyDeviceToHost);

    //Print results
    std::printf("%f\n", C[n*n-1]);
    std::printf("%f\n", ms); 
 
    // Free resources
    cudaFree(dA);
    cudaFree(dB);
    cudaFree(dC);
    std::free(A);
    std::free(B);
    std::free(C);

    return 0;
}
