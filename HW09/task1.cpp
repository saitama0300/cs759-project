#include "cluster.h"
#include <iostream>
#include <cstdlib>
#include <omp.h>
#include <ctime>

using namespace std;

#define NUM_ITER 10

int main(int argc, char *argv[]) {
    std::srand((unsigned int)std::time(NULL));
    
    //Fetch commandline arguments
    std::size_t n = atoll(argv[1]);
    std::size_t t = atoll(argv[2]);

    //Allocate memory to arrays
    float * arr = (float *) malloc(n*sizeof(float));
    float * centers = (float *) malloc(t*sizeof(float));
    float * dists = (float *) malloc(t*sizeof(float));
 
    //Initialize arrays for input and mask
    for(std::size_t i=0;i<n;i++) {
        arr[i] = float(rand()%(n+1));
    }  
  
    for(std::size_t i=0;i<t;i++) {
        centers[i] = (2.0*i-1)*n/(2.0*t);
		dists[i] = 0.0;
    }


    double total_time = 0.0;
    double average_time = 0.0;
   
    for(int k=0;k<NUM_ITER;k++) {
        //Set number of threads
        omp_set_num_threads(t);

        double start_time = omp_get_wtime(); //Start Event
        cluster(n, t, arr, centers, dists);
        double end_time = omp_get_wtime(); //End Event

        double ms = (end_time - start_time) * 1000;
        total_time += ms;
    }
    average_time = total_time/NUM_ITER;

    float max_value = -999.0;
  	int max_position = 0;
  	for (std::size_t i = 0; i < t; i++) {
  		if (dists[i] > max_value) {
  			max_value = dists[i];
  			max_position = i;
  		}
  	}

    //Print outputs
    cout<<max_value<<endl;
    cout<<max_position<<endl;
    cout<<average_time<<endl;

    //Deallocate memory
    free(arr);
    free(centers);
    free(dists);

    return 0;
}