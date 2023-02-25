#include "sobelfilter.h"
#include<cmath>

#define WT1 2

void applyfilter(unsigned char* image, unsigned char* output, int height, int width, int x, int y) {

    //INITIALIZE OUT VARIABLES FOR GX
    float rx_out=0;
    float gx_out=0;
    float bx_out=0;

    //INITIALIZE OUT VARIABLES FOR GY
    float ry_out=0;
    float gy_out=0;
    float by_out=0;

    //MANUALLY UNROLLING THE FOR LOOP TO EXTRACT HIGHER PERFORMANCE AND REDUCED EXECUTION TIME FOR SEQUENTIAL CODE 

    //FOR UPPER ROW ELEMENTS INDEX 0 TO 2 IN THE KERNEL
    if((x>=1) && (y>=1)) { //INDEX 0
        rx_out+=((float)image[NUM_CHANNELS*((x-1)*height+y-1)])/255;
        gx_out+=((float)image[NUM_CHANNELS*((x-1)*height+y-1)+1])/255;
        bx_out+=((float)image[NUM_CHANNELS*((x-1)*height+y-1)+2])/255;

        ry_out+=((float)image[NUM_CHANNELS*((x-1)*height+y-1)])/255;
        gy_out+=((float)image[NUM_CHANNELS*((x-1)*height+y-1)+1])/255;
        by_out+=((float)image[NUM_CHANNELS*((x-1)*height+y-1)+2])/255;
    } 


    if((y>=1)) { //INDEX 1
        ry_out+=WT1*((float)image[NUM_CHANNELS*(x*height+y-1)])/255;
        gy_out+=WT1*((float)image[NUM_CHANNELS*(x*height+y-1)+1])/255;
        by_out+=WT1*((float)image[NUM_CHANNELS*(x*height+y-1)+2])/255;
    }

    if((x<width-1)&&(y>=1)) { //INDEX 2
        rx_out-=((float)image[NUM_CHANNELS*((x+1)*height+y-1)])/255;
        gx_out-=((float)image[NUM_CHANNELS*((x+1)*height+y-1)+1])/255;
        bx_out-=((float)image[NUM_CHANNELS*((x+1)*height+y-1)+2])/255;

        ry_out+=((float)image[NUM_CHANNELS*((x+1)*height+y-1)])/255;
        gy_out+=((float)image[NUM_CHANNELS*((x+1)*height+y-1)+1])/255;
        by_out+=((float)image[NUM_CHANNELS*((x+1)*height+y-1)+2])/255;
    } 
    rx_out = (rx_out>0)?rx_out:0;
    gx_out = (gx_out>0)?gx_out:0;
    bx_out = (bx_out>0)?bx_out:0;   

    //FOR MIDDLE ROW ELEMENTS INDEX 3 TO 5 IN THE KERNEL
    if((x>=1)) { //INDEX 3
        rx_out+=WT1*((float)image[NUM_CHANNELS*((x-1)*height+y)])/255;
        gx_out+=WT1*((float)image[NUM_CHANNELS*((x-1)*height+y)+1])/255;
        bx_out+=WT1*((float)image[NUM_CHANNELS*((x-1)*height+y)+2])/255;
    } 

    if((x<width-1)) { //INDEX 5
        rx_out-=WT1*((float)image[NUM_CHANNELS*((x+1)*height+y)])/255;
        gx_out-=WT1*((float)image[NUM_CHANNELS*((x+1)*height+y)+1])/255;
        bx_out-=WT1*((float)image[NUM_CHANNELS*((x+1)*height+y)+2])/255;
    } 

    rx_out = (rx_out>0)?rx_out:0;
    gx_out = (gx_out>0)?gx_out:0;
    bx_out = (bx_out>0)?bx_out:0; 

    //FOR LOWER ROW ELEMENTS INDEX 6 TO 8 IN THE KERNEL
    if((x>=1) && (y<height-1)) { //INDEX 6
        rx_out+=((float)image[NUM_CHANNELS*((x-1)*height+y+1)])/255;
        gx_out+=((float)image[NUM_CHANNELS*((x-1)*height+y+1)+1])/255;
        bx_out+=((float)image[NUM_CHANNELS*((x-1)*height+y+1)+2])/255;

        ry_out-=((float)image[NUM_CHANNELS*((x-1)*height+y+1)])/255;
        gy_out-=((float)image[NUM_CHANNELS*((x-1)*height+y+1)+1])/255;
        by_out-=((float)image[NUM_CHANNELS*((x-1)*height+y+1)+2])/255;
    }

    ry_out = (ry_out>0)?ry_out:0;
    gy_out = (gy_out>0)?gy_out:0;
    by_out = (by_out>0)?by_out:0;  
    
    if((y<height-1)) { //INDEX 7
        ry_out-=WT1*((float)image[NUM_CHANNELS*(x*height+y+1)])/255;
        gy_out-=WT1*((float)image[NUM_CHANNELS*(x*height+y+1)+1])/255;
        by_out-=WT1*((float)image[NUM_CHANNELS*(x*height+y+1)+2])/255;
    }

    ry_out = (ry_out>0)?ry_out:0;
    gy_out = (gy_out>0)?gy_out:0;
    by_out = (by_out>0)?by_out:0; 

    if((x<width-1)&&(y<height-1)) { //INDEX 8
        rx_out-=((float)image[NUM_CHANNELS*((x+1)*height+y+1)])/255;
        gx_out-=((float)image[NUM_CHANNELS*((x+1)*height+y+1)+1])/255;
        bx_out-=((float)image[NUM_CHANNELS*((x+1)*height+y+1)+2])/255;

        ry_out-=((float)image[NUM_CHANNELS*((x+1)*height+y+1)])/255;
        gy_out-=((float)image[NUM_CHANNELS*((x+1)*height+y+1)+1])/255;
        by_out-=((float)image[NUM_CHANNELS*((x+1)*height+y+1)+2])/255;
    }

    rx_out = (rx_out>0)?rx_out:0;
    gx_out = (gx_out>0)?gx_out:0;
    bx_out = (bx_out>0)?bx_out:0;
    
    ry_out = (ry_out>0)?ry_out:0;
    gy_out = (gy_out>0)?gy_out:0;
    by_out = (by_out>0)?by_out:0; 

    rx_out *= 255.0;
    gx_out *= 255.0;
    bx_out *= 255.0;
    
    ry_out *= 255.0;
    gy_out *= 255.0;
    by_out *= 255.0;

    double r_out = sqrt(pow(rx_out,2)+pow(ry_out,2));
    double g_out = sqrt(pow(gx_out,2)+pow(gy_out,2));
    double b_out = sqrt(pow(bx_out,2)+pow(by_out,2));

    output[NUM_CHANNELS*(x*height+y)] = (unsigned char) (r_out>255)?255:((unsigned char)r_out);
    output[NUM_CHANNELS*(x*height+y)+1] = (unsigned char) (g_out>255)?255:((unsigned char)g_out);
    output[NUM_CHANNELS*(x*height+y)+2] = (unsigned char) (b_out>255)?255:((unsigned char)b_out);
}

void sobelfilter(unsigned char* rgb_image, unsigned char* output_img, int height, int width){

    for(int i=0;i<width;i++){
        for(int j=0;j<height;j++){
            applyfilter(rgb_image,output_img,height,width,i,j);
        }
    }
}