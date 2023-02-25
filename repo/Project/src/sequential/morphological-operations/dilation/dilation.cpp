#include <iostream>
#include <string>
#include <cstdlib>
#include <ctime>
#include <chrono>
#include <cmath>

#include "dilationfilter.h"

#define STB_IMAGE_IMPLEMENTATION
#include "../../../image.hpp"

#define STB_IMAGE_WRITE_IMPLEMENTATION
#include "../../../image_write.hpp"

using std::cout;
using std::chrono::high_resolution_clock;
using std::chrono::duration;
using namespace std;

int main(int argc, char *argv[]) {

            char* inputImg = argv[1];
            char* outputImg = argv[2];

            //TIME START & END POINTERS
            high_resolution_clock::time_point start;
            high_resolution_clock::time_point end;
            
            int width, height, channel;

            //WHY DO WE USE UNSIGNED CHAR ? AS EACH RGB PIXEL VALUE IS BETWEEN 0 and 255. HENCE USING LARGER DATATYPES MAKES
            //NO SENSE UNNECCESARILY TO STORE THE IMAGE IN GLOBAL/MAIN MEMORY AS IMAGE FILES ARE ANYWAYS LARGE IN SIZE

            cout<<"-- DILATION -- 3x3"<<endl;
            unsigned char* rgb_image = stbi_load(inputImg, &width, &height, &channel, 3); // 3 means RGB
            cout<<"IMAGE FILE: "<<inputImg<<endl;
            cout<<"WIDTH OF IMAGE: "<<width<<endl;
            cout<<"HEIGHT OF IMAGE: "<<height<<endl;

            unsigned char* output_img = (unsigned char*)calloc(width*height*NUM_CHANNELS,sizeof(unsigned char));


            duration<double, std::milli> duration_sec;
            start = high_resolution_clock::now();
            dilationfilter(rgb_image, output_img, height, width);
            end = high_resolution_clock::now();

            duration_sec = std::chrono::duration_cast<duration<double, std::milli>>(end - start);
            std::cout <<"Runtime: "<<duration_sec.count() << "\n";

            stbi_write_jpg(outputImg, width, height, channel, output_img, 100);
            cout<<"SAVED OUTPUT IMAGE FILE: "<<outputImg<<endl<<endl;

            stbi_image_free(rgb_image);
            free(output_img);
}