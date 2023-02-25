#include <thrust/device_vector.h>

void count(const thrust::device_vector<int>& d_in, thrust::device_vector<int>& values, thrust::device_vector<int>& counts) {
    
	//Initialize initial count to 1 for all elements as we inted to use reduce_by_key function in thrust
    thrust::device_vector<int> initial_count(int(d_in.size()));
    thrust::fill(initial_count.begin(), initial_count.end(), 1);

	//Sort the values array
	thrust::sort(values.begin(), values.end());

	//Use reduce_by_key here, new_back is a pair of iterators to values & count vectors respectively
	auto new_back = thrust::reduce_by_key(values.begin(), values.end(), initial_count.begin(), values.begin(), counts.begin());

	//Resize vectors as now every entry is unique
	values.resize(new_back.first - values.begin());
	counts.resize(new_back.second - counts.begin());
}