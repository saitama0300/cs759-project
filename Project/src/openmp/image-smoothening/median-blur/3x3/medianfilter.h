#define NUM_CHANNELS 3

#define KERNEL_SIZE 3
#define NUM_ELEMENTS 9

void apply_filter(unsigned char* image, unsigned char* output, int height, int width, int x, int y);

void medianfilter(unsigned char* rgb_image, unsigned char* output_img, int height, int width);