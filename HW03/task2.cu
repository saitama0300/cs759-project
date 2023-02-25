#include <cstdio>
#include <cstdlib>
#include <ctime>

#define ARRAY_SIZE 16
#define MAX_RAND 100

__global__ void task2(int a, int *output) {
    
    //Calculate the index using block and thread indexes
    int index = blockIdx.x*blockDim.x + threadIdx.x;
  

    //Calculate ax+b for the output
    int x,y;
    x = threadIdx.x;
    y = blockIdx.x;
    output[index] = x*a + y;
    
}

int main() {

    int hA[ARRAY_SIZE];

    std::srand((unsigned int)std::time(NULL));
 
    // Declare pointers that will point to the memory allocated on the device.
    int* dA;
 
    // Allocate memory on the device
    cudaMalloc(&dA, sizeof(int)*ARRAY_SIZE);
    
    // Launch the kernel on the device
    int a = std::rand()%MAX_RAND;
    task2<<<2, 8>>>(a, dA);

    // Copy the output array back from the device to the host and print its values
    cudaMemcpy(hA, dA, sizeof(int)*ARRAY_SIZE, cudaMemcpyDeviceToHost);
    for(int i = 0; i < ARRAY_SIZE-1; i++)
    {
        std::printf("%d ", hA[i]);
    }
    std::printf("%d\n",hA[ARRAY_SIZE-1]);
 
    // Free resources
    cudaFree(dA);

    return 0;
}
