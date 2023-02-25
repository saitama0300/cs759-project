__global__ void vscale(const float *a, float *b, unsigned int n) {
    unsigned int index = blockIdx.x*blockDim.x + threadIdx.x;

    //Do this for only n values in the vectors
    if(index<n){
        //compute the eltwise mult here
        b[index] = b[index]*a[index];
    }
}
