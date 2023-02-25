#include "gaussianfilter.h"
#include<omp.h>

void apply_filter(unsigned char* image, unsigned char* output, int height, int width, int x, int y) {

    //MID INDEX VALUE OF THE KERNEL IS 4.0
    float r_out=4.0*((float)image[NUM_CHANNELS*(x*height+y)])/255;
    float g_out=4.0*((float)image[NUM_CHANNELS*(x*height+y)+1])/255;
    float b_out=4.0*((float)image[NUM_CHANNELS*(x*height+y)+2])/255;

    //MANUALLY UNROLLING THE FOR LOOP TO EXTRACT HIGHER PERFORMANCE AND REDUCED EXECUTION TIME FOR SEQUENTIAL CODE 

    //FOR UPPER ROW ELEMENTS INDEX 0 TO 2 IN THE KERNEL
    if((x>=1) && (y>=1)) { //INDEX 0
        r_out+=((float)image[NUM_CHANNELS*((x-1)*height+y-1)])/255;
        g_out+=((float)image[NUM_CHANNELS*((x-1)*height+y-1)+1])/255;
        b_out+=((float)image[NUM_CHANNELS*((x-1)*height+y-1)+2])/255;
    } 

    if((y>=1)) { //INDEX 1
        r_out+=2.0*((float)image[NUM_CHANNELS*(x*height+y-1)])/255;
        g_out+=2.0*((float)image[NUM_CHANNELS*(x*height+y-1)+1])/255;
        b_out+=2.0*((float)image[NUM_CHANNELS*(x*height+y-1)+2])/255;
    }

    if((x<width-1)&&(y>=1)) { //INDEX 2
        r_out+=((float)image[NUM_CHANNELS*((x+1)*height+y-1)])/255;
        g_out+=((float)image[NUM_CHANNELS*((x+1)*height+y-1)+1])/255;
        b_out+=((float)image[NUM_CHANNELS*((x+1)*height+y-1)+2])/255;
    } 
    
    //FOR MIDDLE ROW ELEMENTS INDEX 3 TO 5 IN THE KERNEL
    if((x>=1)) { //INDEX 3
        r_out+=2.0*((float)image[NUM_CHANNELS*((x-1)*height+y)])/255;
        g_out+=2.0*((float)image[NUM_CHANNELS*((x-1)*height+y)+1])/255;
        b_out+=2.0*((float)image[NUM_CHANNELS*((x-1)*height+y)+2])/255;
    } 

    if((x<width-1)) { //INDEX 5
        r_out+=2.0*((float)image[NUM_CHANNELS*((x+1)*height+y)])/255;
        g_out+=2.0*((float)image[NUM_CHANNELS*((x+1)*height+y)+1])/255;
        b_out+=2.0*((float)image[NUM_CHANNELS*((x+1)*height+y)+2])/255;
    } 

    //FOR LOWER ROW ELEMENTS INDEX 6 TO 8 IN THE KERNEL
    if((x>=1) && (y<height-1)) { //INDEX 6
        r_out+=((float)image[NUM_CHANNELS*((x-1)*height+y+1)])/255;
        g_out+=((float)image[NUM_CHANNELS*((x-1)*height+y+1)+1])/255;
        b_out+=((float)image[NUM_CHANNELS*((x-1)*height+y+1)+2])/255;
    } 

    if((y<height-1)) { //INDEX 7
        r_out+=2.0*((float)image[NUM_CHANNELS*(x*height+y+1)])/255;
        g_out+=2.0*((float)image[NUM_CHANNELS*(x*height+y+1)+1])/255;
        b_out+=2.0*((float)image[NUM_CHANNELS*(x*height+y+1)+2])/255;
    }

    if((x<width-1)&&(y<height-1)) { //INDEX 8
        r_out+=((float)image[NUM_CHANNELS*((x+1)*height+y+1)])/255;
        g_out+=((float)image[NUM_CHANNELS*((x+1)*height+y+1)+1])/255;
        b_out+=((float)image[NUM_CHANNELS*((x+1)*height+y+1)+2])/255;
    }   

    r_out /= 16.0;
    g_out /= 16.0;
    b_out /= 16.0;

    r_out *= 255.0;
    g_out *= 255.0;
    b_out *= 255.0;

    output[NUM_CHANNELS*(x*height+y)] = (r_out>255)?255:((unsigned char)r_out);
    output[NUM_CHANNELS*(x*height+y)+1] = (g_out>255)?255:((unsigned char)g_out);
    output[NUM_CHANNELS*(x*height+y)+2] = (b_out>255)?255:((unsigned char)b_out);
}

void gaussianfilter(unsigned char* rgb_image, unsigned char* output_img, int height, int width){
    #pragma omp parallel for collapse(2)
    for(int i=0;i<width;i++){
        for(int j=0;j<height;j++){
            apply_filter(rgb_image,output_img,height,width,i,j);
        }
    }
}