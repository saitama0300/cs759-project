#include <cstdio>
#include <cstdlib>
#include <ctime>
#include "scan.cuh"

#define MAX_RAND 1000

int main(int argc, char* argv[]) {
 
    std::srand((unsigned int)std::time(NULL));

    //Command line options
    std::size_t n = std::atoll(argv[1]);
    std::size_t threads_per_block = std::atoll(argv[2]); 

    // Declare pointers that will point to the memory allocated 
    float *input, *output;
   
    // Allocate memory (Managed)
    cudaMallocManaged(&input, sizeof(float)*n);
    cudaMallocManaged(&output, sizeof(float)*n);

    //Populating values within the host arrays
    for(std::size_t i=0;i<n;i++) {
        input[i] = ((float(std::rand()%MAX_RAND)*2.0)/MAX_RAND)-1.0; //RANDOM VALUE
    }  
    
    //For recording time:

    cudaEvent_t start;
    cudaEvent_t stop;

    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    cudaEventRecord(start); //START EVENT

    // Call the scan funtion from host
    scan(input, output, n, threads_per_block);

    cudaEventRecord(stop); //STOP EVENT
    cudaEventSynchronize(stop);

    // Get the elapsed time in milliseconds
    float ms;
    cudaEventElapsedTime(&ms, start, stop);

    std::printf("%f\n", output[n-1]); 
    std::printf("%f\n", ms); 
 
    // Free resources
    cudaFree(input);
    cudaFree(output);
}