#include <cstdio>
#include <cstdlib>
#include <ctime>
#include "reduce.cuh"

#define MAX_RAND 1000

int main(int argc, char* argv[]) {

    std::srand((unsigned int)std::time(NULL));
    
    std::size_t N = std::atoll(argv[1]);
    std::size_t threads_per_block = std::atoll(argv[2]);    

    std::size_t num_blocks = (N+(2*threads_per_block-1))/(2*threads_per_block);

    //Allocating memory to host arrays
    float * input = (float *) std::malloc(N*sizeof(float));
    float * output = (float *) std::malloc(num_blocks*sizeof(float));
    
    //Populating values within the host arrays
    for(std::size_t i=0;i<N;i++) {
        input[i] = ((float(std::rand()%MAX_RAND)*2.0)/MAX_RAND)-1.0; //Value between -1.0 and 1.0
    }  

    // Declare pointers that will point to the memory allocated on the device.
    float *dInput,*dOutput;

 
    // Allocate memory on the device for input
    cudaMalloc(&dInput, sizeof(float)*N);

    //Final result array on device
    cudaMalloc(&dOutput, sizeof(float)*num_blocks);

    //Copy data from host to device
    cudaMemcpy(dInput, input, sizeof(float)*N, cudaMemcpyHostToDevice);

    //For recording time:
    cudaEvent_t start;
    cudaEvent_t stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    cudaEventRecord(start); //START EVENT

    // Launch the kernel on the device
    
    reduce(&dInput, &dOutput, N, threads_per_block);

    cudaEventRecord(stop); //STOP EVENT
    cudaEventSynchronize(stop);

    // Get the elapsed time in milliseconds
    float ms;
    cudaEventElapsedTime(&ms, start, stop);

    // Copy the output array back from the device to the host and print its values
    cudaMemcpy(output, dOutput, sizeof(float), cudaMemcpyDeviceToHost);
    cudaMemcpy(input, dInput, sizeof(float), cudaMemcpyDeviceToHost);

    //Print results
    std::printf("%f\n", input[0]);
    std::printf("%f\n", ms); 
 
    // Free resources
    cudaFree(dInput);
    cudaFree(dOutput);
    std::free(input);
    std::free(output);

    return 0;
}
