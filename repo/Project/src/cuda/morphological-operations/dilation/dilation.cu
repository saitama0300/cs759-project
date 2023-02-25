#include <iostream>
#include <string>

#include "dilationfilter.cuh"

#define STB_IMAGE_IMPLEMENTATION
#include "../../../image.hpp"

#define STB_IMAGE_WRITE_IMPLEMENTATION
#include "../../../image_write.hpp"

using namespace std;

int main(int argc, char *argv[]) {

            char* inputImg = argv[1];
            char* outputImg = argv[2];  
            std::size_t threads_per_block = atoll(argv[3]);   
            
            int width, height, channel;

            //WHY DO WE USE UNSIGNED CHAR ? AS EACH RGB PIXEL VALUE IS BETWEEN 0 and 255. HENCE USING LARGER DATATYPES MAKES
            //NO SENSE UNNECCESARILY TO STORE THE IMAGE IN GLOBAL/MAIN MEMORY AS IMAGE FILES ARE ANYWAYS LARGE IN SIZE

            cout<<"-- DILATION-- 3x3"<<endl;
            unsigned char* rgb_image = stbi_load(inputImg, &width, &height, &channel, 3); // 3 means RGB

            unsigned char* input_img_device;
            unsigned char* output_img;

            cudaMalloc(&input_img_device, sizeof(unsigned char)*height*width*NUM_CHANNELS);
            cudaMallocManaged(&output_img, sizeof(unsigned char)*height*width*NUM_CHANNELS);

            cudaMemcpy(input_img_device, rgb_image, sizeof(unsigned char)*height*width*NUM_CHANNELS, cudaMemcpyHostToDevice);

            cout<<"IMAGE FILE: "<<inputImg<<endl;
            cout<<"WIDTH OF IMAGE: "<<width<<endl;
            cout<<"HEIGHT OF IMAGE: "<<height<<endl;

            dilationfilter(&input_img_device, &output_img, height, width, threads_per_block);

            stbi_write_jpg(outputImg, width, height, channel, output_img, 100);

            cout<<"SAVED OUTPUT IMAGE FILE: "<<outputImg<<endl<<endl;

            stbi_image_free(rgb_image);
            cudaFree(input_img_device);
            cudaFree(output_img);
        
}