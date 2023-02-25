#include <algorithm>
#include <chrono>
#include <iostream>
#include <omp.h>
#include <random>
#include <cstdio>
#include <mpi.h>

#include "reduce.h"

#define MAX_RAND 1000

using namespace std;
using namespace std::chrono;

int main(int argc, char *argv[]) {
    srand((unsigned int)time(NULL));

    MPI_Init(&argc, &argv);
    int n = atol(argv[1]);
    int t = atol(argv[2]);
    omp_set_num_threads(t);
    
    float *arr = new float[n];
    for (int i = 0; i < n; i++) {
    	arr[i] = ((float(rand()%MAX_RAND)*2.0)/MAX_RAND)-1.0;
        //GENERATES RANDOM NUMBERS BETWEEN -1 AND 1
    }
    
    float global_res = 0;
    int rank;
    //MPI --- REDUCE CALL 
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    reduce(arr, 0, n);
    MPI_Barrier(MPI_COMM_WORLD);

    // start timing
    auto start = high_resolution_clock::now();
    float result = reduce(arr, 0, n);
    MPI_Reduce(&result, &global_res, 1, MPI_FLOAT, MPI_SUM, 0, MPI_COMM_WORLD);
    auto end = high_resolution_clock::now();
    double d = duration_cast<duration<double, std::milli>>(end - start).count();
    
    if (rank == 0) {
    	printf("%f\n%f\n", global_res, d);
    }
    
    MPI_Finalize();
}