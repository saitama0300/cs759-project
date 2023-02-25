#include <chrono>
#include <cstring>
#include <random>
#include <algorithm>
#include <random>
#include <iostream>
#include <stdio.h>
#include <mpi.h>

using namespace std;
using namespace std::chrono;

#define MAX_RAND 1000

int main(int argc, char *argv[]) {
	MPI_Init(&argc, &argv);
	
    std::srand((unsigned int)std::time(NULL));
    
    //Fetch commandline arguments
    std::size_t n = atoll(argv[1]);

    //Allocate memory to arrays
    float * x = (float *) malloc(n*sizeof(float));
    float * y = (float *) malloc(n*sizeof(float));
 
    //Initialize arrays for input and mask
    for(std::size_t i=0;i<n;i++) {
        x[i] = ((float(std::rand()%MAX_RAND)*2.0)/MAX_RAND)-1.0; //RANDOM VALUE
        y[i] = ((float(std::rand()%MAX_RAND)*2.0)/MAX_RAND)-1.0; //RANDOM VALUE
    }  
	int rank;
	MPI_Comm_rank(MPI_COMM_WORLD, &rank);
	double t0 = 0;
	double t1 = 0;
	
	if (rank == 0) {
		auto start = high_resolution_clock::now(); //START EVENT

		MPI_Send(x, n, MPI_FLOAT, 1, 0, MPI_COMM_WORLD);
		
		MPI_Recv(y, n, MPI_FLOAT, 1, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);

		auto end = high_resolution_clock::now(); //END EVENT

		t0 = duration_cast<duration<double, std::milli>>(end - start).count(); //CAST TO DOUBLE

		MPI_Recv(&t1, 1, MPI_DOUBLE, 1, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);

		std::cout<<(t0+t1)<<std::endl; //PRINT TOTAL TIME
	} else if (rank == 1) {

		auto start = high_resolution_clock::now(); //START EVENT

		MPI_Recv(x, n, MPI_FLOAT, 0, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE); //RECIEVE

		MPI_Send(y, n, MPI_FLOAT, 0, 0, MPI_COMM_WORLD); //SEND

		auto end = high_resolution_clock::now();  //END EVENT

		t1 = duration_cast<duration<double, std::milli>>(end - start).count(); //CAST TO DOUBLE

		MPI_Send(&t1, 1, MPI_DOUBLE, 0, 0, MPI_COMM_WORLD); //RECIEVE
	}
	
	MPI_Finalize();
}

