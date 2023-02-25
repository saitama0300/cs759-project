#include <algorithm>
#include <chrono>
#include <iostream>
#include <omp.h>
#include <random>
#include <cstdio>

#include "reduce.h"

#define MAX_RAND 1000

using namespace std;
using namespace std::chrono;

int main(int argc, char *argv[]) {
    srand((unsigned int)time(NULL));

    int n = atol(argv[1]);
    int t = atol(argv[2]);
    
    omp_set_num_threads(t);

    float *arr = new float[n];
    for (int i = 0; i < n; i++) {
    	arr[i] = ((float(rand()%MAX_RAND)*2.0)/MAX_RAND)-1.0;
    }
    
    reduce(arr, 0, n);
    
  	auto start = high_resolution_clock::now();
  	float result = reduce(arr, 0, n);
  	auto end = high_resolution_clock::now();
  	double d = duration_cast<duration<double, std::milli>>(end - start).count();
  	
  	printf("%f\n%f\n", result, d);
}