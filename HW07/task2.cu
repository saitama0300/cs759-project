#include <cstdio>
#include <cstdlib>
#include <ctime>
#include <iostream>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "count.cuh"

#define MAX_RAND 501

int main(int argc, char* argv[]) {

    std::srand((unsigned int)std::time(NULL));

    //Fetch n from the argument
    std::size_t n = std::atoll(argv[1]);

    //Create thrust host vector here
    thrust::host_vector<int> h_vector(n);

    //Initialize the h_vector
    for(std::size_t i=0;i<n;i++) {
        h_vector[i] = (int(std::rand()%MAX_RAND)); //RANDOM VALUE
    }  

    //Instantiate device vector, value vector & count storing vector
    thrust::device_vector<int> d_vector = h_vector;
    thrust::device_vector<int> values(n);
    thrust::device_vector<int> counts(n);
    
    //Needed for value to be used in the count function
    values = d_vector;

    cudaEvent_t start;
    cudaEvent_t stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    cudaEventRecord(start); //START EVENT

    // Call to the function
    count(d_vector,values,counts);

    cudaEventRecord(stop); //STOP EVENT
    cudaEventSynchronize(stop);

    // Get the elapsed time in milliseconds
    float ms;
    cudaEventElapsedTime(&ms, start, stop);

    //Print final results
    std::cout << values.back() << std::endl;
    std::cout << counts.back() << std::endl; 
    std::printf("%f\n", ms); 
}