#include <cstdio>
#include <cstdlib>
#include <ctime>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>

#define MAX_RAND 1000

int main(int argc, char* argv[]) {

    std::srand((unsigned int)std::time(NULL));

    //Fetch n from the argument
    std::size_t n = std::atoll(argv[1]);

    //Create thrust host vector here-
    thrust::host_vector<float> h_vector(n);

    //Initialize the h_vector
    for(std::size_t i=0;i<n;i++) {
        h_vector[i] = ((float(std::rand()%MAX_RAND)*2.0)/MAX_RAND)-1.0; //RANDOM VALUE
    }  

    //Instantiate device vector
    thrust::device_vector<float> d_vector = h_vector;
    
    cudaEvent_t start;
    cudaEvent_t stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    cudaEventRecord(start); //START EVENT

    // Call to the function for reduction (you add here so use plus functor)
    float result = thrust::reduce(d_vector.begin() , d_vector.end(), 0.0, thrust::plus<float>());

    cudaEventRecord(stop); //STOP EVENT
    cudaEventSynchronize(stop);

    // Get the elapsed time in milliseconds
    float ms;
    cudaEventElapsedTime(&ms, start, stop);

    //Print final results
    std::printf("%f\n", result);  
    std::printf("%f\n", ms); 
}