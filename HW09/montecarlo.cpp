#include <cstddef>
#include <omp.h>


int montecarlo(const size_t n, const float *x, const float *y, const float radius){
    
    int incircle = 0;
#pragma omp parallel for simd reduction(+ : incircle)
	for (size_t i = 0; i < n; i++) {
			//DONE TO AVOID IF STATEMENT
			float x_temp = x[i];
            float y_temp = y[i];
			incircle += (x_temp  * x_temp  + y_temp * y_temp <= radius * radius);
	}
	return incircle;

}
