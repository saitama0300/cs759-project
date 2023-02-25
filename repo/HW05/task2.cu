#include <cstdio>
#include <cstdlib>
#include <ctime>
#include "matmul.cuh"

#define MAX_RAND 1000

int main(int argc, char* argv[]) {

    std::srand((unsigned int)std::time(NULL));

    std::size_t n = std::atoll(argv[1]);
    std::size_t block_dim = std::atoll(argv[2]); 

    //Allocating memory to host arrays
    int * A = (int *) std::malloc(n*n*sizeof(int));
    int * B = (int *) std::malloc(n*n*sizeof(int));

    int * C = (int *) std::malloc(n*n*sizeof(int)); 
 
    //Populating values within the host arrays
    for(std::size_t i=0;i<n*n;i++) {
        A[i] = (std::rand()%MAX_RAND); //RANDOM VALUE
        B[i] = (std::rand()%MAX_RAND); //RANDOM VALUE
    }  

    // Declare pointers that will point to the memory allocated on the device.
    int *dA, *dB, *dC;
 
    // Allocate memory on the device
    cudaMalloc(&dA, sizeof(int)*n*n);
    cudaMalloc(&dB, sizeof(int)*n*n);

    //Final result array on device
    cudaMalloc(&dC, sizeof(int)*n*n);

    //Copy data from host to device
    cudaMemcpy(dA, A, sizeof(int)*n*n, cudaMemcpyHostToDevice);
    cudaMemcpy(dB, B, sizeof(int)*n*n, cudaMemcpyHostToDevice);

    //For recording time:
    cudaEvent_t start;
    cudaEvent_t stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    cudaEventRecord(start); //START EVENT

    // Launch the kernel on the device
    matmul_1(dA,dB,dC,n,block_dim);

    cudaEventRecord(stop); //STOP EVENT
    cudaEventSynchronize(stop);

    // Get the elapsed time in milliseconds
    float ms;
    cudaEventElapsedTime(&ms, start, stop);

    // Copy the output array back from the device to the host and print its values
    cudaMemcpy(C, dC, sizeof(int)*n*n, cudaMemcpyDeviceToHost);

    //Print results
    //for(int i=0;i<n;i++){
      //  for(int j=0;j<n;j++){
        //   std::printf("%d\t", C[i*n+j]);
      //  }
       // printf("\n");
    //}
    std::printf("%d\n", C[0]);
    std::printf("%d\n", C[n*n-1]);
    std::printf("%f\n", ms); 
 
    // Free resources
    cudaFree(dA);
    cudaFree(dB);
    cudaFree(dC);
    std::free(A);
    std::free(B);
    std::free(C);
    

    //Allocating memory to host arrays
    float * Af = (float *) std::malloc(n*n*sizeof(float));
    float * Bf = (float *) std::malloc(n*n*sizeof(float));

    float * Cf = (float *) std::malloc(n*n*sizeof(float)); 
 
    //Populating values within the host arrays
    for(std::size_t i=0;i<n*n;i++) {
        Af[i] = ((float(std::rand()%MAX_RAND)*2.0)/MAX_RAND)-1.0; //Value between -1.0 and 1.0
        Bf[i] = ((float(std::rand()%MAX_RAND)*2.0)/MAX_RAND)-1.0; //Value between -1.0 and 1.0
    }  

    // Declare pointers that will point to the memory allocated on the device.
    float *dAf, *dBf, *dCf;
 
    // Allocate memory on the device
    cudaMalloc(&dAf, sizeof(float)*n*n);
    cudaMalloc(&dBf, sizeof(float)*n*n);

    //Final result array on device
    cudaMalloc(&dCf, sizeof(float)*n*n);

    //Copy data from host to device
    cudaMemcpy(dAf, Af, sizeof(float)*n*n, cudaMemcpyHostToDevice);
    cudaMemcpy(dBf, Bf, sizeof(float)*n*n, cudaMemcpyHostToDevice);

    //For recording time:
    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    cudaEventRecord(start); //START EVENT

    // Launch the kernel on the device
    matmul_2(dAf,dBf,dCf,n,block_dim);

    cudaEventRecord(stop); //STOP EVENT
    cudaEventSynchronize(stop);

    // Get the elapsed time in milliseconds
    cudaEventElapsedTime(&ms, start, stop);

    // Copy the output array back from the device to the host and print its values
    cudaMemcpy(Cf, dCf, sizeof(float)*n*n, cudaMemcpyDeviceToHost);

    //Print results
    std::printf("%f\n", Cf[0]);
    std::printf("%f\n", Cf[n*n-1]);
    std::printf("%f\n", ms); 
 
    // Free resources
    cudaFree(dAf);
    cudaFree(dBf);
    cudaFree(dCf);
    std::free(Af);
    std::free(Bf);
    std::free(Cf);

   //Allocating memory to host arrays
   double * Ad = (double *) std::malloc(n*n*sizeof(double));
   double * Bd = (double *) std::malloc(n*n*sizeof(double));

   double * Cd = (double *) std::malloc(n*n*sizeof(double)); 

   //Populating values within the host arrays
   for(std::size_t i=0;i<n*n;i++) {
       Ad[i] = ((double(std::rand()%MAX_RAND)*2.0)/MAX_RAND)-1.0; //Value between -1.0 and 1.0
       Bd[i] = ((double(std::rand()%MAX_RAND)*2.0)/MAX_RAND)-1.0; //Value between -1.0 and 1.0
   }  

   // Declare pointers that will point to the memory allocated on the device.
   double *dAd, *dBd, *dCd;

   // Allocate memory on the device
   cudaMalloc(&dAd, sizeof(double)*n*n);
   cudaMalloc(&dBd, sizeof(double)*n*n);

   //Final result array on device
   cudaMalloc(&dCd, sizeof(double)*n*n);

   //Copy data from host to device
   cudaMemcpy(dAd, Ad, sizeof(double)*n*n, cudaMemcpyHostToDevice);
   cudaMemcpy(dBd, Bd, sizeof(double)*n*n, cudaMemcpyHostToDevice);

   //For recording time:
   cudaEventCreate(&start);
   cudaEventCreate(&stop);

   cudaEventRecord(start); //START EVENT

   // Launch the kernel on the device
   matmul_3(dAd,dBd,dCd,n,block_dim);

   cudaEventRecord(stop); //STOP EVENT
   cudaEventSynchronize(stop);

   // Get the elapsed time in milliseconds
   cudaEventElapsedTime(&ms, start, stop);

   // Copy the output array back from the device to the host and print its values
   cudaMemcpy(Cd, dCd, sizeof(double)*n*n, cudaMemcpyDeviceToHost);

   //Print results
   std::printf("%lf\n", Cd[0]);
   std::printf("%lf\n", Cd[n*n-1]);
   std::printf("%f\n", ms); 

   // Free resources
   cudaFree(dAd);
   cudaFree(dBd);
   cudaFree(dCd);
   std::free(Ad);
   std::free(Bd);
   std::free(Cd); 

   return 0;
}
