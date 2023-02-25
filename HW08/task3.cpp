#include "msort.h"
#include <iostream>
#include <cstdlib>
#include <omp.h>
#include <ctime>

using namespace std;

#define MAX_RAND 1000

int main(int argc, char *argv[]) {

    //Fetch commandline arguments
    std::size_t n = atoll(argv[1]);
    std::size_t t = atoll(argv[2]);
    std::size_t ts = atoll(argv[3]);

    //Allocate memory to array
    int * arr = (int *) malloc(n*sizeof(int));

    //Initialize the array
    for(std::size_t i=0;i<n;i++) {
        arr[i] = (((rand()%MAX_RAND)*2000)/MAX_RAND)-1000;
    }  

    //Set number of threads
    omp_set_num_threads(t);
    double start_time = omp_get_wtime(); //Start event
        msort(arr, n, ts); 
    double end_time = omp_get_wtime(); //End event
    double ms = (end_time - start_time) * 1000; //Calculate runtime

    //Print outputs
    cout<<arr[0]<<endl;
    cout<<arr[n-1]<<endl;
    cout<<ms<<endl;

    //Free memory
    free(arr);
    return 0;
}