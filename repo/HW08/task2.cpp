#include "convolution.h"
#include <iostream>
#include <cstdlib>
#include <omp.h>
#include <ctime>

using namespace std;

#define MAX_RAND 100000

int main(int argc, char *argv[]) {
    //Fetch commandline arguments
    std::size_t n = atoll(argv[1]);
    std::size_t t = atoll(argv[2]);

    //Allocate memory to arrays
    float * image = (float *) malloc(n*n*sizeof(float));
    float * mask = (float *) malloc(3*3*sizeof(float));
    float * output = (float *) malloc(n*n*sizeof(float));
 
    //Initialize arrays for input and mask
    for(std::size_t i=0;i<n*n;i++) {
        image[i] = ((float(rand()%MAX_RAND)*20.0)/MAX_RAND)-10.0;
    }  
  
    for(std::size_t i=0;i<3*3;i++) {
        mask[i] = ((float(rand()%MAX_RAND)*2.0)/MAX_RAND)-1.0;
    }

    //Set number of threads
    omp_set_num_threads(t);

    double start_time = omp_get_wtime(); //Start Event
    convolve(image, output, n, mask, 3);
    double end_time = omp_get_wtime(); //End Event

    double ms = (end_time - start_time) * 1000;

    //Print outputs
    cout<<output[0]<<endl;
    cout<<output[n*n-1]<<endl;
    cout<<ms<<endl;

    //Deallocate memory
    free(image);
    free(mask);
    free(output);
    return 0;
}