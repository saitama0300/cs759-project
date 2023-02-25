#include "matmul.h"
#include <iostream>
#include <cstdlib>
#include <ctime>
#include <chrono>
#include <cmath>

using std::cout;
using std::chrono::high_resolution_clock;
using std::chrono::duration;

#define MAX_RAND 100000
#define NUM_ROWS 1000
#define NUM_COLUMNS 1000

int main(int argc, char *argv[]) {
    high_resolution_clock::time_point start;
    high_resolution_clock::time_point end;

    srand((unsigned int)time(NULL));

    double * A = (double *) calloc(NUM_COLUMNS*NUM_ROWS, sizeof(double));
    double * B = (double *) calloc(NUM_COLUMNS*NUM_ROWS, sizeof(double));
    double * C = (double *) calloc(NUM_COLUMNS*NUM_ROWS, sizeof(double));
 
    for(std::size_t i=0;i<NUM_COLUMNS*NUM_ROWS;i++) {
        A[i] = ((double(rand()%MAX_RAND)*1000.0)/MAX_RAND);
    }  

    for(std::size_t i=0;i<NUM_COLUMNS*NUM_ROWS;i++) {
        B[i] = ((double(rand()%MAX_RAND)*1000.0)/MAX_RAND);
    } 
    std::cout << NUM_ROWS << "\n"; 
//MATMUL 1
    duration<double, std::milli> duration_sec;
    start = high_resolution_clock::now();
    mmul1(A, B, C, NUM_ROWS);  
    end = high_resolution_clock::now();

    duration_sec = std::chrono::duration_cast<duration<double, std::milli>>(end - start);
    std::cout << duration_sec.count() << "\n";
    std::cout << C[(NUM_COLUMNS*NUM_ROWS)-1] << "\n";


    memset(C,0,NUM_COLUMNS*NUM_ROWS*sizeof(double));

//MATMUL 2

    start = high_resolution_clock::now();
    mmul2(A, B, C, NUM_ROWS);  
    end = high_resolution_clock::now();

    duration_sec = std::chrono::duration_cast<duration<double, std::milli>>(end - start);
    std::cout << duration_sec.count() << "\n";
    std::cout << C[(NUM_COLUMNS*NUM_ROWS)-1] << "\n";

  
    memset(C,0,NUM_COLUMNS*NUM_ROWS*sizeof(double));
//MATMUL 3

    start = high_resolution_clock::now();
    mmul3(A, B, C, NUM_ROWS);  
    end = high_resolution_clock::now();

    duration_sec = std::chrono::duration_cast<duration<double, std::milli>>(end - start);
    std::cout << duration_sec.count() << "\n";
    std::cout << C[(NUM_COLUMNS*NUM_ROWS)-1] << "\n";

    memset(C,0,NUM_COLUMNS*NUM_ROWS*sizeof(double));

//MATMUL 4
    std::vector<double> A_vec(A, A+(NUM_COLUMNS*NUM_ROWS));
    std::vector<double> B_vec(B, B+(NUM_COLUMNS*NUM_ROWS));

    start = high_resolution_clock::now();
    mmul4(A_vec, B_vec, C, NUM_COLUMNS);  
    end = high_resolution_clock::now();

    duration_sec = std::chrono::duration_cast<duration<double, std::milli>>(end - start);
    std::cout << duration_sec.count() << "\n";
    std::cout << C[(NUM_COLUMNS*NUM_ROWS)-1] << "\n";

    delete A;
    delete B;
    delete C;

    return 0;
}