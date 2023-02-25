#include <iostream>
#include <string>
#include <omp.h>
#include "medianfilter.h"

#define STB_IMAGE_IMPLEMENTATION
#include "../../../../image.hpp"

#define STB_IMAGE_WRITE_IMPLEMENTATION
#include "../../../../image_write.hpp"

using namespace std;

int main(int argc, char *argv[]) {

            char* inputImg = argv[1];
            char* outputImg = argv[2];
            
            int width, height, channel;

            //WHY DO WE USE UNSIGNED CHAR ? AS EACH RGB PIXEL VALUE IS BETWEEN 0 and 255. HENCE USING LARGER DATATYPES MAKES
            //NO SENSE UNNECCESARILY TO STORE THE IMAGE IN GLOBAL/MAIN MEMORY AS IMAGE FILES ARE ANYWAYS LARGE IN SIZE

            cout<<"-- MEDIAN BLUR -- 3x3"<<endl;
            unsigned char* rgb_image = stbi_load(inputImg, &width, &height, &channel, 3); // 3 means RGB
            cout<<"IMAGE FILE: "<<inputImg<<endl;
            cout<<"WIDTH OF IMAGE: "<<width<<endl;
            cout<<"HEIGHT OF IMAGE: "<<height<<endl;

            unsigned char* output_img = (unsigned char*)calloc(width*height*NUM_CHANNELS,sizeof(unsigned char));
            
            std::size_t t = atoll(argv[3]); 
            omp_set_num_threads(t);
            double start_time = omp_get_wtime(); //Start Event
            medianfilter(rgb_image, output_img, height, width);
            double end_time = omp_get_wtime(); //End Event
            double ms = (end_time - start_time) * 1000;
            cout<<"Runtime: "<<ms<<endl;

            stbi_write_jpg(outputImg, width, height, channel, output_img, 100);
            cout<<"SAVED OUTPUT IMAGE FILE: "<<outputImg<<endl<<endl;

            stbi_image_free(rgb_image);
            free(output_img);
}