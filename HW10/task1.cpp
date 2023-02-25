#include <algorithm>
#include <chrono>
#include <iostream>
#include <random>
#include <cstdio>
#include "optimize.h"

using namespace std;
using namespace chrono;

#define MAX_RAND 5
#define MAX_ITERS 10

double time_optimize1(vec *v, data_t *dest) {	
	auto start = high_resolution_clock::now();
  	optimize1(v, dest);
  	auto end = high_resolution_clock::now();
    return duration_cast<duration<double, std::milli>>(end - start).count();
}

double time_optimize2(vec *v, data_t *dest) {
	auto start = high_resolution_clock::now();
	optimize2(v, dest);
	auto end = high_resolution_clock::now();
    return duration_cast<duration<double, std::milli>>(end - start).count();
}

double time_optimize3(vec *v, data_t *dest) {
	auto start = high_resolution_clock::now();
	optimize3(v, dest);
	auto end = high_resolution_clock::now();
    return duration_cast<duration<double, std::milli>>(end - start).count();
}

double time_optimize4(vec *v, data_t *dest) {
	auto start = high_resolution_clock::now();
	optimize4(v, dest);
	auto end = high_resolution_clock::now();
    return duration_cast<duration<double, std::milli>>(end - start).count();
}

double time_optimize5(vec *v, data_t *dest) {
	auto start = high_resolution_clock::now();
	optimize5(v, dest);
	auto end = high_resolution_clock::now();
    return duration_cast<duration<double, std::milli>>(end - start).count();
}

int main(int argc, char *argv[]) {
    srand((unsigned int)time(NULL));

	int n = atol(argv[1]);
	data_t *data = new data_t[n];
	vec v = vec(n);
	
	for (int i = 0; i < n; i++) {
		data[i] = (std::rand()%MAX_RAND); //Module values between 0 to MAX_RAND-1
	}
	v.data = data;
	data_t dest;
	
	// timing is for optimize 1
	double time = 0;
	for (int i = 0; i < MAX_ITERS; i++) {
		time += time_optimize1(&v, &dest);
	}
    time /= MAX_ITERS;
    cout << dest << endl;
    cout << time << endl;
    
    // timing is for optimize 2
	time = 0;
	for (int i = 0; i < MAX_ITERS; i++) {
		time += time_optimize2(&v, &dest);
	}
    time /= MAX_ITERS;
    cout << dest << endl;
    cout << time << endl;
    
    // timing is for optimize 3
	time = 0;
	for (int i = 0; i < MAX_ITERS; i++) {
		time += time_optimize3(&v, &dest);
	}
    time /= MAX_ITERS;
    cout << dest << endl;
    cout << time << endl;
    
    // timing is for optimize 4
	time = 0;
	for (int i = 0; i < MAX_ITERS; i++) {
		time += time_optimize4(&v, &dest);
	}
    time /= MAX_ITERS;
    cout << dest << endl;
    cout << time << endl;
    
    // next is for optimize 5
	time = 0;
	for (int i = 0; i < MAX_ITERS; i++) {
		time += time_optimize5(&v, &dest);
	}
    time /= MAX_ITERS;
    cout << dest << endl;
    cout << time << endl;
}
