#include "montecarlo.h"
#include <iostream>
#include <cstdlib>
#include <omp.h>
#include <ctime>

using namespace std;

#define NUM_ITER 10
#define MAX_RAND 10000

int main(int argc, char *argv[]) {
    std::srand((unsigned int)std::time(NULL));
    
    //Fetch commandline arguments
    std::size_t n = atoll(argv[1]);
    std::size_t t = atoll(argv[2]);

    float r = 1.0;

    //Allocate memory to arrays
    float * x = (float *) malloc(n*sizeof(float));
    float * y = (float *) malloc(n*sizeof(float));
 
    //Initialize arrays for input and mask
    for(std::size_t i=0;i<n;i++) {
        x[i] = ((float(std::rand()%MAX_RAND)*2*r)/MAX_RAND)-r; //RANDOM VALUE
        y[i] = ((float(std::rand()%MAX_RAND)*2*r)/MAX_RAND)-r; //RANDOM VALUE
    }  

    double total_time = 0.0;
    double average_time = 0.0;
    double pi;
   
    for(int k=0;k<NUM_ITER;k++) {
        //Set number of threads
        omp_set_num_threads(t);

        double start_time = omp_get_wtime(); //Start Event
        pi = 4.0 * montecarlo(n, x, y, r)/n;
        double end_time = omp_get_wtime(); //End Event

        double ms = (end_time - start_time) * 1000;
        total_time += ms;
    }
    average_time = total_time/NUM_ITER;

    //Print outputs
    cout<<pi<<endl;
    cout<<average_time<<endl;

    //Deallocate memory
    free(x);
    free(y);

    return 0;
}