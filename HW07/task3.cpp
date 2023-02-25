#include <cstdio>
#include <omp.h>

int fact(int n) {
    //This function simply calculated factorial for a number n

    int res=1;
    for(int i=2;i<n+1;i++){
        res*=i;
    }

    //return factorial value 
    return res;
}

int main() {

    //Define the number of threads here
    int num_threads = 4;
    omp_set_num_threads(num_threads);
    std::printf("Number of threads: %d\n", num_threads);

    //Printing thread number in omp pragma parallel
#pragma omp parallel
    {
       std::printf("I am thread No.: %d\n", omp_get_thread_num()); 
    }

    //Calculating factorials using omp threads as printed above
#pragma omp parallel for 
        for(int i=1;i<=8;i++){
            std::printf("%d!=%d\n", i, fact(i));
        }

    return 0;
}