#include "medianfilter.h"
#include<omp.h>

void apply_filter(unsigned char* image, unsigned char* output, int height, int width, int x, int y) {

    unsigned char r_out[NUM_ELEMENTS] = {0};
    unsigned char g_out[NUM_ELEMENTS] = {0};
    unsigned char b_out[NUM_ELEMENTS] = {0};
    //MANUALLY UNROLLING THE FOR LOOP TO EXTRACT HIGHER PERFORMANCE AND REDUCED EXECUTION TIME FOR SEQUENTIAL CODE 

    //FOR UPPER ROW ELEMENTS INDEX 0 TO 2 IN THE KERNEL
    if((x>=1) && (y>=1)) { //INDEX 0
        r_out[0]=image[NUM_CHANNELS*((x-1)*height+y-1)];
        g_out[0]=image[NUM_CHANNELS*((x-1)*height+y-1)+1];
        b_out[0]=image[NUM_CHANNELS*((x-1)*height+y-1)+2];
    } 

    if((y>=1)) { //INDEX 1
        r_out[1]=image[NUM_CHANNELS*(x*height+y-1)];
        g_out[1]=image[NUM_CHANNELS*(x*height+y-1)+1];
        b_out[1]=image[NUM_CHANNELS*(x*height+y-1)+2];
    }

    if((x<width-1)&&(y>=1)) { //INDEX 2
        r_out[2]=image[NUM_CHANNELS*((x+1)*height+y-1)];
        g_out[2]=image[NUM_CHANNELS*((x+1)*height+y-1)+1];
        b_out[2]=image[NUM_CHANNELS*((x+1)*height+y-1)+2];
    } 
    
    //FOR MIDDLE ROW ELEMENTS INDEX 3 TO 5 IN THE KERNEL
    if((x>=1)) { //INDEX 3
        r_out[3]=image[NUM_CHANNELS*((x-1)*height+y)];
        g_out[3]=image[NUM_CHANNELS*((x-1)*height+y)+1];
        b_out[3]=image[NUM_CHANNELS*((x-1)*height+y)+2];
    } 

    r_out[4]=image[NUM_CHANNELS*((x)*height+y)];
    g_out[4]=image[NUM_CHANNELS*((x)*height+y)+1];
    b_out[4]=image[NUM_CHANNELS*((x)*height+y)+2]; 

    if((x<width-1)) { //INDEX 5
        r_out[5]=image[NUM_CHANNELS*((x+1)*height+y)];
        g_out[5]=image[NUM_CHANNELS*((x+1)*height+y)+1];
        b_out[5]=image[NUM_CHANNELS*((x+1)*height+y)+2];
    } 

    //FOR LOWER ROW ELEMENTS INDEX 6 TO 8 IN THE KERNEL
    if((x>=1) && (y<height-1)) { //INDEX 6
        r_out[6]=image[NUM_CHANNELS*((x-1)*height+y+1)];
        g_out[6]=image[NUM_CHANNELS*((x-1)*height+y+1)+1];
        b_out[6]=image[NUM_CHANNELS*((x-1)*height+y+1)+2];
    } 

    if((y<height-1)) { //INDEX 7
        r_out[7]=image[NUM_CHANNELS*(x*height+y+1)];
        g_out[7]=image[NUM_CHANNELS*(x*height+y+1)+1];
        b_out[7]=image[NUM_CHANNELS*(x*height+y+1)+2];
    }

    if((x<width-1)&&(y<height-1)) { //INDEX 8
        r_out[8]=image[NUM_CHANNELS*((x+1)*height+y+1)];
        g_out[8]=image[NUM_CHANNELS*((x+1)*height+y+1)+1];
        b_out[8]=image[NUM_CHANNELS*((x+1)*height+y+1)+2];
    }   

    for(int i=0;i<=NUM_ELEMENTS/2;i++){
        for(int j=i+1;j<NUM_ELEMENTS;j++){
            unsigned char temp;
            if(r_out[j]<r_out[i]){
                temp = r_out[i];
                r_out[i] = r_out[j];
                r_out[j] = temp;
            }
            if(g_out[j]<g_out[i]){
                temp = g_out[i];
                g_out[i] = g_out[j];
                g_out[j] = temp;
            }
            if(b_out[j]<b_out[i]){
                temp = b_out[i];
                b_out[i] = b_out[j];
                b_out[j] = temp;
            }
        }
    }

    output[NUM_CHANNELS*(x*height+y)] = r_out[NUM_ELEMENTS/2];
    output[NUM_CHANNELS*(x*height+y)+1] = g_out[NUM_ELEMENTS/2];
    output[NUM_CHANNELS*(x*height+y)+2] = b_out[NUM_ELEMENTS/2];
}

void medianfilter(unsigned char* rgb_image, unsigned char* output_img, int height, int width){
    #pragma omp parallel for collapse(2)
    for(int i=0;i<width;i++){
        for(int j=0;j<height;j++){
            apply_filter(rgb_image,output_img,height,width,i,j);
        }
    }
}