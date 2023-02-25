#include "medianfilter.h"
#include<omp.h>

void apply_filter(unsigned char* image, unsigned char* output, int height, int width, int x, int y) {

    unsigned char r_out[NUM_ELEMENTS] = {0};
    unsigned char g_out[NUM_ELEMENTS] = {0};
    unsigned char b_out[NUM_ELEMENTS] = {0};
 
    //MANUALLY UNROLLING THE FOR LOOP TO EXTRACT HIGHER PERFORMANCE AND REDUCED EXECUTION TIME FOR SEQUENTIAL CODE 

    if((x>=2) && (y>=2)) { //INDEX 0
        r_out[0]=image[NUM_CHANNELS*((x-2)*height+y-2)];
        g_out[0]=image[NUM_CHANNELS*((x-2)*height+y-2)+1];
        b_out[0]=image[NUM_CHANNELS*((x-2)*height+y-2)+2];
    } 

    if((x>=1) && (y>=2)) { //INDEX 1
        r_out[1]=image[NUM_CHANNELS*((x-1)*height+y-2)];
        g_out[1]=image[NUM_CHANNELS*((x-1)*height+y-2)+1];
        b_out[1]=image[NUM_CHANNELS*((x-1)*height+y-2)+2];
    }

    if((y>=2)) { //INDEX 2
        r_out[2]=image[NUM_CHANNELS*((x)*height+y-2)];
        g_out[2]=image[NUM_CHANNELS*((x)*height+y-2)+1];
        b_out[2]=image[NUM_CHANNELS*((x)*height+y-2)+2];
    } 

    if((x<width-1) && (y>=2)) { //INDEX 3
        r_out[3]=image[NUM_CHANNELS*((x+1)*height+y-2)];
        g_out[3]=image[NUM_CHANNELS*((x+1)*height+y-2)+1];
        b_out[3]=image[NUM_CHANNELS*((x+1)*height+y-2)+2];
    }
    if((x<width-1) && (y>=2)) { //INDEX 4
        r_out[4]=image[NUM_CHANNELS*((x+2)*height+y-2)];
        g_out[4]=image[NUM_CHANNELS*((x+2)*height+y-2)+1];
        b_out[4]=image[NUM_CHANNELS*((x+2)*height+y-2)+2];
    }

    if((x>=2) && (y>=1)) { //INDEX 5
        r_out[5]=image[NUM_CHANNELS*((x-2)*height+y-1)];
        g_out[5]=image[NUM_CHANNELS*((x-2)*height+y-1)+1];
        b_out[5]=image[NUM_CHANNELS*((x-2)*height+y-1)+2];
    } 

    if((x>=1) && (y>=1)) { //INDEX 6
        r_out[6]=image[NUM_CHANNELS*((x-1)*height+y-1)];
        g_out[6]=image[NUM_CHANNELS*((x-1)*height+y-1)+1];
        b_out[6]=image[NUM_CHANNELS*((x-1)*height+y-1)+2];
    }

    if((y>=1)) { //INDEX 7
        r_out[7]=image[NUM_CHANNELS*((x)*height+y-1)];
        g_out[7]=image[NUM_CHANNELS*((x)*height+y-1)+1];
        b_out[7]=image[NUM_CHANNELS*((x)*height+y-1)+2];
    } 

    if((x<width-1) && (y>=1)) { //INDEX 8
        r_out[8]=image[NUM_CHANNELS*((x+1)*height+y-1)];
        g_out[8]=image[NUM_CHANNELS*((x+1)*height+y-1)+1];
        b_out[8]=image[NUM_CHANNELS*((x+1)*height+y-1)+2];
    }
    if((x<width-2) && (y>=1)) { //INDEX 9
        r_out[9]=image[NUM_CHANNELS*((x+2)*height+y-1)];
        g_out[9]=image[NUM_CHANNELS*((x+2)*height+y-1)+1];
        b_out[9]=image[NUM_CHANNELS*((x+2)*height+y-1)+2];
    }
    
    if((x>=2)) { //INDEX 10
        r_out[10]=image[NUM_CHANNELS*((x-2)*height+y)];
        g_out[10]=image[NUM_CHANNELS*((x-2)*height+y)+1];
        b_out[10]=image[NUM_CHANNELS*((x-2)*height+y)+2];
    } 

    if((x>=1)) { //INDEX 11
        r_out[11]=image[NUM_CHANNELS*((x-1)*height+y)];
        g_out[11]=image[NUM_CHANNELS*((x-1)*height+y)+1];
        b_out[11]=image[NUM_CHANNELS*((x-1)*height+y)+2];
    }

    //INDEX 12
    r_out[12]=image[NUM_CHANNELS*((x)*height+y)];
    g_out[12]=image[NUM_CHANNELS*((x)*height+y)+1];
    b_out[12]=image[NUM_CHANNELS*((x)*height+y)+2];
     

    if((x<width-1)) { //INDEX 13
        r_out[13]=image[NUM_CHANNELS*((x+1)*height+y)];
        g_out[13]=image[NUM_CHANNELS*((x+1)*height+y)+1];
        b_out[13]=image[NUM_CHANNELS*((x+1)*height+y)+2];
    }
    if((x<width-2)) { //INDEX 14
        r_out[14]=image[NUM_CHANNELS*((x+2)*height+y)];
        g_out[14]=image[NUM_CHANNELS*((x+2)*height+y)+1];
        b_out[14]=image[NUM_CHANNELS*((x+2)*height+y)+2];
    }
    
    if((x>=2) && (y<width-1)) { //INDEX 15
        r_out[15]=image[NUM_CHANNELS*((x-2)*height+y+1)];
        g_out[15]=image[NUM_CHANNELS*((x-2)*height+y+1)+1];
        b_out[15]=image[NUM_CHANNELS*((x-2)*height+y+1)+2];
    } 

    if((x>=1) && (y<width-1)) { //INDEX 16
        r_out[16]=image[NUM_CHANNELS*((x-1)*height+y+1)];
        g_out[16]=image[NUM_CHANNELS*((x-1)*height+y+1)+1];
        b_out[16]=image[NUM_CHANNELS*((x-1)*height+y+1)+2];
    }

    if((y<width-1)) { //INDEX 17
        r_out[17]=image[NUM_CHANNELS*((x)*height+y+1)];
        g_out[17]=image[NUM_CHANNELS*((x)*height+y+1)+1];
        b_out[17]=image[NUM_CHANNELS*((x)*height+y+1)+2];
    } 

    if((x<width-1) && (y<width-1)) { //INDEX 18
        r_out[18]=image[NUM_CHANNELS*((x+1)*height+y+1)];
        g_out[18]=image[NUM_CHANNELS*((x+1)*height+y+1)+1];
        b_out[18]=image[NUM_CHANNELS*((x+1)*height+y+1)+2];
    }
    if((x<width-2) && (y<width-1)) { //INDEX 19
        r_out[19]=image[NUM_CHANNELS*((x+2)*height+y+1)];
        g_out[19]=image[NUM_CHANNELS*((x+2)*height+y+1)+1];
        b_out[19]=image[NUM_CHANNELS*((x+2)*height+y+1)+2];
    }

    if((x>=2) && (y<width-2)) { //INDEX 20
        r_out[20]=image[NUM_CHANNELS*((x-2)*height+y+2)];
        g_out[20]=image[NUM_CHANNELS*((x-2)*height+y+2)+1];
        b_out[20]=image[NUM_CHANNELS*((x-2)*height+y+2)+2];
    } 

    if((x>=1) && (y<width-2)) { //INDEX 21
        r_out[21]=image[NUM_CHANNELS*((x-1)*height+y+2)];
        g_out[21]=image[NUM_CHANNELS*((x-1)*height+y+2)+1];
        b_out[21]=image[NUM_CHANNELS*((x-1)*height+y+2)+2];
    }

    if((y<width-2)) { //INDEX 17
        r_out[22]=image[NUM_CHANNELS*((x)*height+y+2)];
        g_out[22]=image[NUM_CHANNELS*((x)*height+y+2)+1];
        b_out[22]=image[NUM_CHANNELS*((x)*height+y+2)+2];
    } 

    if((x<width-1) && (y<width-2)) { //INDEX 18
        r_out[23]=image[NUM_CHANNELS*((x+1)*height+y+2)];
        g_out[23]=image[NUM_CHANNELS*((x+1)*height+y+2)+1];
        b_out[23]=image[NUM_CHANNELS*((x+1)*height+y+2)+2];
    }
    if((x<width-2) && (y<width-2)) { //INDEX 19
        r_out[24]=image[NUM_CHANNELS*((x+2)*height+y+2)];
        g_out[24]=image[NUM_CHANNELS*((x+2)*height+y+2)+1];
        b_out[24]=image[NUM_CHANNELS*((x+2)*height+y+2)+2];
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
    for(int i=0;i<width;i++){
        for(int j=0;j<height;j++){
            apply_filter(rgb_image,output_img,height,width,i,j);
        }
    }
}