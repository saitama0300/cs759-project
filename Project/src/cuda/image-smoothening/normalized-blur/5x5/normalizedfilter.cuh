#define NUM_CHANNELS 3

__global__ void apply_filter(unsigned char* input, unsigned char* output, int height, int width, int x, int y);


__host__ void normalizedfilter(unsigned char** rgb_image, unsigned char** output_img, int height, int width, int threads_per_block_dim);