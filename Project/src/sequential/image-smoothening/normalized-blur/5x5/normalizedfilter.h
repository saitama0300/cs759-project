#define NUM_CHANNELS 3

void apply_filter(unsigned char* image, unsigned char* output, int height, int width, int x, int y);

void normalizedfilter(unsigned char* rgb_image, unsigned char* output_img, int height, int width);