#include "convolution.h"

void convolve(const float *image, float *output, std::size_t n, const float *mask, std::size_t m){

 //Unwinds nested loops to single loop shared by threads
#pragma omp parallel for collapse(2)
    for(std::size_t x=0;x<n;x++) {
        for(std::size_t y=0;y<n;y++) {
            for(std::size_t i=0;i<m;i++) {
                for(std::size_t j=0;j<m;j++) {
                    //Handline corner cases
                    std::size_t idx = x + i - ((m-1)/2);
                    std::size_t idy = y + j - ((m-1)/2);

                    //Important part of convolution
                    if(((idx<0) || (idx>=n)) && ((idy<0) || (idy>=n))) {
                        output[x*n+y] += 0;
                    }
                    else if(((idx<0) || (idx>=n)) || ((idy<0) || (idy>=n))) {
                        output[x*n+y] += mask[i*m+j];
                    }
                    else {
                        output[x*n+y] += mask[i*m+j]*image[idx*n+idy];
                    }
                }
            } 
        }
    }
}