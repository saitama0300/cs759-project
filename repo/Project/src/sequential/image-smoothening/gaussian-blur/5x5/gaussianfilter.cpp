#include "gaussianfilter.h"

void apply_filter(unsigned char* image, unsigned char* output, int height, int width, int x, int y) {

    //MID INDEX VALUE OF THE KERNEL IS 4.0
    float r_out=36.0*((float)image[NUM_CHANNELS*(x*height+y)])/255;
    float g_out=36.0*((float)image[NUM_CHANNELS*(x*height+y)+1])/255;
    float b_out=36.0*((float)image[NUM_CHANNELS*(x*height+y)+2])/255;

    //MANUALLY UNROLLING THE FOR LOOP TO EXTRACT HIGHER PERFORMANCE AND REDUCED EXECUTION TIME FOR SEQUENTIAL CODE 

    //FOR UPPERMOST ROW ELEMENTS INDEX 0 TO 4 IN THE KERNEL
    if((x>=2) && (y>=2)) { //INDEX 0
        r_out+=((float)image[NUM_CHANNELS*((x-2)*height+y-2)])/255;
        g_out+=((float)image[NUM_CHANNELS*((x-2)*height+y-2)+1])/255;
        b_out+=((float)image[NUM_CHANNELS*((x-2)*height+y-2)+2])/255;
    } 

    if((x>=1) && (y>=2)) { //INDEX 1
        r_out+=4.0*((float)image[NUM_CHANNELS*((x-1)*height+y-2)])/255;
        g_out+=4.0*((float)image[NUM_CHANNELS*((x-1)*height+y-2)+1])/255;
        b_out+=4.0*((float)image[NUM_CHANNELS*((x-1)*height+y-2)+2])/255;
    } 

    if((y>=2)) { //INDEX 2
        r_out+=6.0*((float)image[NUM_CHANNELS*(x*height+y-2)])/255;
        g_out+=6.0*((float)image[NUM_CHANNELS*(x*height+y-2)+1])/255;
        b_out+=6.0*((float)image[NUM_CHANNELS*(x*height+y-2)+2])/255;
    }

    if((x<width-1)&&(y>=2)) { //INDEX 3
        r_out+=4.0*((float)image[NUM_CHANNELS*((x+1)*height+y-2)])/255;
        g_out+=4.0*((float)image[NUM_CHANNELS*((x+1)*height+y-2)+1])/255;
        b_out+=4.0*((float)image[NUM_CHANNELS*((x+1)*height+y-2)+2])/255;
    }

    if((x<width-2)&&(y>=2)) { //INDEX 4
        r_out+=((float)image[NUM_CHANNELS*((x+2)*height+y-2)])/255;
        g_out+=((float)image[NUM_CHANNELS*((x+2)*height+y-2)+1])/255;
        b_out+=((float)image[NUM_CHANNELS*((x+2)*height+y-2)+2])/255;
    }  

    //FOR 2nd UPPERMOST ROW ELEMENTS INDEX 5 TO 9 IN THE KERNEL
    if((x>=2) && (y>=1)) { //INDEX 5
        r_out+=4.0*((float)image[NUM_CHANNELS*((x-2)*height+y-1)])/255;
        g_out+=4.0*((float)image[NUM_CHANNELS*((x-2)*height+y-1)+1])/255;
        b_out+=4.0*((float)image[NUM_CHANNELS*((x-2)*height+y-1)+2])/255;
    } 

    if((x>=1) && (y>=1)) { //INDEX 6
        r_out+=16.0*((float)image[NUM_CHANNELS*((x-1)*height+y-1)])/255;
        g_out+=16.0*((float)image[NUM_CHANNELS*((x-1)*height+y-1)+1])/255;
        b_out+=16.0*((float)image[NUM_CHANNELS*((x-1)*height+y-1)+2])/255;
    } 

    if((y>=1)) { //INDEX 7
        r_out+=24.0*((float)image[NUM_CHANNELS*(x*height+y-1)])/255;
        g_out+=24.0*((float)image[NUM_CHANNELS*(x*height+y-1)+1])/255;
        b_out+=24.0*((float)image[NUM_CHANNELS*(x*height+y-1)+2])/255;
    }

    if((x<width-1)&&(y>=1)) { //INDEX 8
        r_out+=16.0*((float)image[NUM_CHANNELS*((x+1)*height+y-1)])/255;
        g_out+=16.0*((float)image[NUM_CHANNELS*((x+1)*height+y-1)+1])/255;
        b_out+=16.0*((float)image[NUM_CHANNELS*((x+1)*height+y-1)+2])/255;
    }

    if((x<width-2)&&(y>=1)) { //INDEX 9
        r_out+=4.0*((float)image[NUM_CHANNELS*((x+2)*height+y-1)])/255;
        g_out+=4.0*((float)image[NUM_CHANNELS*((x+2)*height+y-1)+1])/255;
        b_out+=4.0*((float)image[NUM_CHANNELS*((x+2)*height+y-1)+2])/255;
    }     

    //FOR MIDDLE ROW ELEMENTS INDEX 10 TO 14 IN THE KERNEL

    if((x>=2)) { //INDEX 10
        r_out+=6.0*((float)image[NUM_CHANNELS*((x-2)*height+y)])/255;
        g_out+=6.0*((float)image[NUM_CHANNELS*((x-2)*height+y)+1])/255;
        b_out+=6.0*((float)image[NUM_CHANNELS*((x-2)*height+y)+2])/255;
    } 

    if((x>=1)) { //INDEX 11
        r_out+=24.0*((float)image[NUM_CHANNELS*((x-1)*height+y)])/255;
        g_out+=24.0*((float)image[NUM_CHANNELS*((x-1)*height+y)+1])/255;
        b_out+=24.0*((float)image[NUM_CHANNELS*((x-1)*height+y)+2])/255;
    } 

    if((x<width-1)) { //INDEX 13
        r_out+=24.0*((float)image[NUM_CHANNELS*((x+1)*height+y)])/255;
        g_out+=24.0*((float)image[NUM_CHANNELS*((x+1)*height+y)+1])/255;
        b_out+=24.0*((float)image[NUM_CHANNELS*((x+1)*height+y)+2])/255;
    }
    
    if((x<width-2)) { //INDEX 14
        r_out+=6.0*((float)image[NUM_CHANNELS*((x+2)*height+y)])/255;
        g_out+=6.0*((float)image[NUM_CHANNELS*((x+2)*height+y)+1])/255;
        b_out+=6.0*((float)image[NUM_CHANNELS*((x+2)*height+y)+2])/255;
    }

    //FOR 2nd LOWERMOST ROW ELEMENTS INDEX 15 TO 19 IN THE KERNEL
    if((x>=2) && (y<height-1)) { //INDEX 15
        r_out+=4.0*((float)image[NUM_CHANNELS*((x-2)*height+y+1)])/255;
        g_out+=4.0*((float)image[NUM_CHANNELS*((x-2)*height+y+1)+1])/255;
        b_out+=4.0*((float)image[NUM_CHANNELS*((x-2)*height+y+1)+2])/255;
    }

    if((x>=1) && (y<height-1)) { //INDEX 16
        r_out+=16.0*((float)image[NUM_CHANNELS*((x-1)*height+y+1)])/255;
        g_out+=16.0*((float)image[NUM_CHANNELS*((x-1)*height+y+1)+1])/255;
        b_out+=16.0*((float)image[NUM_CHANNELS*((x-1)*height+y+1)+2])/255;
    }  

    if((y<height-1)) { //INDEX 17
        r_out+=24.0*((float)image[NUM_CHANNELS*(x*height+y+1)])/255;
        g_out+=24.0*((float)image[NUM_CHANNELS*(x*height+y+1)+1])/255;
        b_out+=24.0*((float)image[NUM_CHANNELS*(x*height+y+1)+2])/255;
    }

    if((x<width-1)&&(y<height-1)) { //INDEX 18
        r_out+=16.0*((float)image[NUM_CHANNELS*((x+1)*height+y+1)])/255;
        g_out+=16.0*((float)image[NUM_CHANNELS*((x+1)*height+y+1)+1])/255;
        b_out+=16.0*((float)image[NUM_CHANNELS*((x+1)*height+y+1)+2])/255;
    }   

    if((x<width-2)&&(y<height-1)) { //INDEX 19
        r_out+=4.0*((float)image[NUM_CHANNELS*((x+2)*height+y+1)])/255;
        g_out+=4.0*((float)image[NUM_CHANNELS*((x+2)*height+y+1)+1])/255;
        b_out+=4.0*((float)image[NUM_CHANNELS*((x+2)*height+y+1)+2])/255;
    }   

    //FOR LOWERMOST ROW ELEMENTS INDEX 20 TO 24 IN THE KERNEL
    if((x>=2) && (y<height-2)) { //INDEX 20
        r_out+=((float)image[NUM_CHANNELS*((x-2)*height+y+2)])/255;
        g_out+=((float)image[NUM_CHANNELS*((x-2)*height+y+2)+1])/255;
        b_out+=((float)image[NUM_CHANNELS*((x-2)*height+y+2)+2])/255;
    }

    if((x>=1) && (y<height-2)) { //INDEX 21
        r_out+=4.0*((float)image[NUM_CHANNELS*((x-1)*height+y+2)])/255;
        g_out+=4.0*((float)image[NUM_CHANNELS*((x-1)*height+y+2)+1])/255;
        b_out+=4.0*((float)image[NUM_CHANNELS*((x-1)*height+y+2)+2])/255;
    }  

    if((y<height-2)) { //INDEX 22
        r_out+=6.0*((float)image[NUM_CHANNELS*(x*height+y+2)])/255;
        g_out+=6.0*((float)image[NUM_CHANNELS*(x*height+y+2)+1])/255;
        b_out+=6.0*((float)image[NUM_CHANNELS*(x*height+y+2)+2])/255;
    }

    if((x<width-1)&&(y<height-2)) { //INDEX 23
        r_out+=4.0*((float)image[NUM_CHANNELS*((x+1)*height+y+2)])/255;
        g_out+=4.0*((float)image[NUM_CHANNELS*((x+1)*height+y+2)+1])/255;
        b_out+=4.0*((float)image[NUM_CHANNELS*((x+1)*height+y+2)+2])/255;
    }   

    if((x<width-2)&&(y<height-2)) { //INDEX 24
        r_out+=((float)image[NUM_CHANNELS*((x+2)*height+y+2)])/255;
        g_out+=((float)image[NUM_CHANNELS*((x+2)*height+y+2)+1])/255;
        b_out+=((float)image[NUM_CHANNELS*((x+2)*height+y+2)+2])/255;
    }   

    r_out /= 256.0;
    g_out /= 256.0;
    b_out /= 256.0;
    
    r_out *= 255.0;
    g_out *= 255.0;
    b_out *= 255.0;

    output[NUM_CHANNELS*(x*height+y)] = (r_out>255)?255:((unsigned char)r_out);
    output[NUM_CHANNELS*(x*height+y)+1] = (g_out>255)?255:((unsigned char)g_out);
    output[NUM_CHANNELS*(x*height+y)+2] = (b_out>255)?255:((unsigned char)b_out);
}

void gaussianfilter(unsigned char* rgb_image, unsigned char* output_img, int height, int width){
    for(int i=0;i<width;i++){
        for(int j=0;j<height;j++){
            apply_filter(rgb_image,output_img,height,width,i,j);
        }
    }
}