#include <cublas_v2.h>

void mmul(cublasHandle_t handle, const float* A, const float* B, float* C, int n){
    float alpha = 1.0;
    float beta = 1.0;
    //Callmto cublas function for GEMM
    cublasSgemm(handle,
            CUBLAS_OP_N, CUBLAS_OP_N,
            n, n, n,
            &alpha, // We have to add AB to final result, so we use Beta as 1
            A, n,
            B, n,
            &beta, // We have to add C, so we use Beta as 1
            C, n);

    //Device Synchronize Call
    cudaDeviceSynchronize();
}
