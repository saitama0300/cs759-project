#include <cstdio>
#include <cstdlib>
#include <ctime>
#include "mmul.h"

#define MAX_RAND 1000

int main(int argc, char* argv[]) {

    std::srand((unsigned int)std::time(NULL));

    std::size_t n = std::atoll(argv[1]);
    std::size_t n_tests = std::atoll(argv[2]); 

    // Declare pointers that will point to the memory allocated on the device.
    float *A, *B, *C;

    // Allocate memory (Managed)
    cudaMallocManaged(&A, sizeof(float)*n*n);
    cudaMallocManaged(&B, sizeof(float)*n*n);
    cudaMallocManaged(&C, sizeof(float)*n*n);

    //Populating values within the host arrays
    for(std::size_t i=0;i<n*n;i++) {
        A[i] = ((float(std::rand()%MAX_RAND)*2.0)/MAX_RAND)-1.0; //RANDOM VALUE
        B[i] = ((float(std::rand()%MAX_RAND)*2.0)/MAX_RAND)-1.0; //RANDOM VALUE
        C[i] = ((float(std::rand()%MAX_RAND)*2.0)/MAX_RAND)-1.0; //RANDOM VALUE
    }  

    //Cublas handle
    cublasHandle_t handle;
    cublasCreate(&handle);

    //Runtime calculation variables
    float total_runtime=0;
    float average_runtime=0;

    for(std::size_t i=0;i<n_tests;i++){
        //For recording time:

        cudaEvent_t start;
        cudaEvent_t stop;
        cudaEventCreate(&start);
        cudaEventCreate(&stop);

        cudaEventRecord(start); //START EVENT

        // Call to the function
        mmul(handle, A, B, C, n);

        cudaEventRecord(stop); //STOP EVENT
        cudaEventSynchronize(stop);

        // Get the elapsed time in milliseconds
        float ms;
        cudaEventElapsedTime(&ms, start, stop);

        total_runtime = total_runtime + ms;
    }

    //Get average runtime and print it
    average_runtime = total_runtime/n_tests;

    std::printf("%f\n", average_runtime); 
 
    // Free resources
    cublasDestroy(handle);
    cudaFree(A);
    cudaFree(B);
    cudaFree(C);
}