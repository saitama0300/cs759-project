//Large Part of the code has been copied from Prof. Dan's repository

#define CUB_STDERR // print CUDA runtime errors to console
#include <stdio.h>
#include <cub/util_allocator.cuh>
#include <cub/device/device_reduce.cuh>
#include "cub/util_debug.cuh"

#define MAX_RAND 1000

using namespace cub;
CachingDeviceAllocator  g_allocator(true);  // Caching allocator for device memory

int main(int argc, char* argv[]) {
    std::srand((unsigned int)std::time(NULL));

    //Fetch n from the argument
    std::size_t n = std::atoll(argv[1]);

    //Host array pointer
    float * h_in = (float *) std::malloc(n*sizeof(float));

    //Initialize the h_vector
    for(std::size_t i=0;i<n;i++) {
        h_in[i] = ((float(std::rand()%MAX_RAND)*2.0)/MAX_RAND)-1.0; //RANDOM VALUE
    }  

    // Set up device arrays
    float* d_in = NULL;
    CubDebugExit(g_allocator.DeviceAllocate((void**)& d_in, sizeof(float) * n));

    // Initialize device input
    CubDebugExit(cudaMemcpy(d_in, h_in, sizeof(float) * n, cudaMemcpyHostToDevice));

    // Setup device output array
    float* d_sum = NULL;
    CubDebugExit(g_allocator.DeviceAllocate((void**)& d_sum, sizeof(float) * 1));
    // Request and allocate temporary storage
    void* d_temp_storage = NULL;
    size_t temp_storage_bytes = 0;
    CubDebugExit(DeviceReduce::Sum(d_temp_storage, temp_storage_bytes, d_in, d_sum, n));
    CubDebugExit(g_allocator.DeviceAllocate(&d_temp_storage, temp_storage_bytes));

    //Recording Time
    cudaEvent_t start;
    cudaEvent_t stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);
    cudaEventRecord(start); //START EVENT
    // Do the actual reduce operation

    DeviceReduce::Sum(d_temp_storage, temp_storage_bytes, d_in, d_sum, n);

    cudaEventRecord(stop); //STOP EVENT
    cudaEventSynchronize(stop);
    // Get the elapsed time in milliseconds
    float ms;
    cudaEventElapsedTime(&ms, start, stop);

    float result;
    CubDebugExit(cudaMemcpy(&result, d_sum, sizeof(float) * 1, cudaMemcpyDeviceToHost));
    // Check for correctness
    printf("%f\n", result);
    printf("%f\n", ms);

    // Cleanup
    if (d_in) CubDebugExit(g_allocator.DeviceFree(d_in));
    if (d_sum) CubDebugExit(g_allocator.DeviceFree(d_sum));
    if (d_temp_storage) CubDebugExit(g_allocator.DeviceFree(d_temp_storage));
    
    return 0;
}
