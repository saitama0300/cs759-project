#include "matmul.h"
#include <iostream>
#include <cstdlib>
#include <omp.h>
#include <ctime>

using namespace std;

#define MAX_RAND 1000

int main(int argc, char *argv[]) {
    srand((unsigned int)time(NULL));

    //Fetch commandline arguments
    size_t n = atol(argv[1]);
	size_t t = atol(argv[2]); // number of threads to be used

    //Allocate memory for Matrices
    float * A = (float *) calloc(n*n, sizeof(float));
    float * B = (float *) calloc(n*n, sizeof(float));
    float * C = (float *) calloc(n*n, sizeof(float));
 
    //Populate the matrices
    for(std::size_t i=0;i<n*n;i++) {
        A[i] = ((float(rand()%MAX_RAND)*100.0)/MAX_RAND);
    }  

    //Populate the matrices
    for(std::size_t i=0;i<n*n;i++) {
        B[i] = ((float(rand()%MAX_RAND)*100.0)/MAX_RAND);
    } 

    //Set number of threads
    omp_set_num_threads(t);

    double start_time = omp_get_wtime(); //START EVENT
    mmul(A, B, C, n);  
    double end_time = omp_get_wtime(); //STOP EVENT

    double ms = (end_time - start_time) * 1000; //CALCULATE DURATION in millisecond

    //Print output values
    cout<<C[0]<<endl;
    cout<<C[n*n-1]<<endl;
    cout<<ms<<endl;

    //Free up memory
    free(A);
    free(B);
    free(C);
    return 0;
}