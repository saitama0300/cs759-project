#include "convolution.h"
#include <iostream>
#include <cstdlib>
#include <ctime>
#include <chrono>
#include <cmath>

using std::cout;
using std::chrono::high_resolution_clock;
using std::chrono::duration;

#define MAX_RAND 100000

int main(int argc, char *argv[]) {
    high_resolution_clock::time_point start;
    high_resolution_clock::time_point end;

    srand((unsigned int)time(NULL));

    std::size_t n = atoll(argv[1]);
    std::size_t m = atoll(argv[2]);
    float * image = (float *) malloc(n*n*sizeof(float));
    float * mask = (float *) malloc(m*m*sizeof(float));
    float * output = (float *) malloc(n*n*sizeof(float));
 
    for(std::size_t i=0;i<n*n;i++) {
        image[i] = ((float(rand()%MAX_RAND)*20.0)/MAX_RAND)-10.0;
    }  
  
    for(std::size_t i=0;i<m*m;i++) {
        mask[i] = ((float(rand()%MAX_RAND)*2.0)/MAX_RAND)-1;
    }


    duration<double, std::milli> duration_sec;
    start = high_resolution_clock::now();
    convolve((float *) image,  (float *) output, n, (float *) mask, m);
    end = high_resolution_clock::now();

    duration_sec = std::chrono::duration_cast<duration<double, std::milli>>(end - start);
    std::cout << duration_sec.count() << "\n";
    std::cout << output[0] << "\n";
    std::cout << output[(n*n)-1] << "\n";

    delete image;
    delete mask;
    delete output;
    return 0;
}