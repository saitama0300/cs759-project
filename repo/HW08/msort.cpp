#include "msort.h"
#include <algorithm>
using namespace std;

void merge_sort(int* arr, const std::size_t n, const std::size_t threshold, int num_threads){

    if(n<threshold) {
        //Case where input size is less than threshold
        std::size_t i;
        int key,j;
        //Use insertion sort algorithm
        for (i = 1; i < n; i++)
        {
            key = arr[i];
            j = i - 1;
    
            while (j>=0 && arr[j]>key)
            {
                arr[j+1] = arr[j];
                j -= 1;
            }
            arr[j+1] = key;
        }
        
        return;
    }

    if(num_threads==1) { //Special Case to handle using of task in omp
        merge_sort(arr,n/2,threshold,1);
        merge_sort(arr+(n/2),n-(n/2),threshold,1);
    }
    else {
    //Tasks help us parallelize execution to multiple threads
    #pragma omp task
        { merge_sort(arr,n/2,threshold,num_threads/2);
        }
    #pragma omp task
        { merge_sort(arr+(n/2),n-(n/2),threshold,num_threads-(num_threads/2));
        }
    //Primary task waits till other tasks finish 
    #pragma omp taskwait
    }
    //Merging of the two sorted arrays
    std::inplace_merge(arr, arr + (n/2), arr + n);
}

void msort(int* arr, const std::size_t n, const std::size_t threshold){
    #pragma omp parallel
    { 
    #pragma omp single
    { merge_sort(arr,n,threshold,omp_get_num_threads());
    }
    }
}