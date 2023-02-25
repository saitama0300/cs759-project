#include "convolution.h"

void convolve(const float *image, float *output, std::size_t n, const float *mask, std::size_t m){
    for(int x=0;x<n;x++) {
        for(int y=0;y<n;y++) {
            for(int i=0;i<m;i++) {
                for(int j=0;j<m;j++) {
                    int idx = x + i - ((m-1)/2);
                    int idy = y + j - ((m-1)/2);

                    if(((idx<0) && (idx>=n)) && ((idy<0) && (idy>=n))) {
                        output[x*n+y] = 0;
                    }
                    else if(((idx<0) && (idx>=n)) || ((idy<0) && (idy>=n))) {
                        output[x*n+y] = mask[i*m+j];
                    }
                    else {
                        output[x*n+y] = mask[i*m+j]*image[idx*n+idy];
                    }
                }
            } 
        }
    }
}
