#include "scan.h"
#include <iostream>
#include <cstdlib>
#include <ctime>
#include <chrono>
#include <cmath>

using std::cout;
using std::chrono::high_resolution_clock;
using std::chrono::duration;

#define MAX_RAND 1000

int main(int argc, char *argv[]) {
    high_resolution_clock::time_point start;
    high_resolution_clock::time_point end;

    srand((unsigned int)time(NULL));

    std::size_t SIZE = atoll(argv[1]);
    float* array = (float *) malloc(SIZE * sizeof(float));
    float* output = (float *) malloc(SIZE * sizeof(float));


    for(std::size_t i=0;i<SIZE;i++) {
        array[i] = ((float(rand()%MAX_RAND)*2.0)/MAX_RAND)-1;
    }  

    duration<double, std::milli> duration_sec;
    start = high_resolution_clock::now();
    scan(array,output,SIZE);
    end = high_resolution_clock::now();


    duration_sec = std::chrono::duration_cast<duration<double, std::milli>>(end - start);
    std::cout << duration_sec.count() << "\n";
    std::cout << output[0]<< "\n";
    std::cout << output[SIZE-1]<< "\n";

    free(array);
    free(output);
    return 0;
}