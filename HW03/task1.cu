#include <cstdio>
#include <cstdlib>

//Kernel defined here
__global__ void factorial() {
   
    int fact = 1;
    //Calculating Factorial
    for(int i=threadIdx.x+1;i>1;i--){
        fact = fact*i;
    }   

    //Printing Result
    std::printf("%d!=%d\n",threadIdx.x+1,fact);
}

int main() {
    
    //Calling Kernel
    factorial<<<1,8>>> ();

    //Calling Device Sync function
    cudaDeviceSynchronize();

    return 0;
}
