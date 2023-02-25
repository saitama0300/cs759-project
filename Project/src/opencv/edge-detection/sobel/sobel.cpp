#include "opencv2/imgproc.hpp"
#include "opencv2/highgui.hpp"
#include <iostream>
#include <string>
#include <cstdlib>
#include <ctime>
#include <chrono>
#include <cmath>

#define KERNEL_SIZE 3

using namespace cv;
using std::cout;
using std::chrono::high_resolution_clock;
using std::chrono::duration;
using namespace std;

Mat src, sobel_dst;

int main( int argc, char** argv )
{
   cv::String keys =
        "{@input |<none>           | input image path}"         // input image is the first argument (positional)
        "{@output |<none>          | output image path}";       // output image is the first argument (positional)
   // Load an image
   CommandLineParser parser( argc, argv, keys);
   src = imread(samples::findFile( parser.get<String>( "@input" ) ), IMREAD_COLOR);
    
    //TIME START & END POINTERS
    high_resolution_clock::time_point start;
    high_resolution_clock::time_point end;

   cout<<"-- SOBEL -- 3x3"<<endl;
   cout<<"IMAGE FILE: "<<parser.get<String>( "@input" )<<endl;
   cout<<"WIDTH OF IMAGE: "<<src.size().width<<endl;
   cout<<"HEIGHT OF IMAGE: "<<src.size().height<<endl;
  
    if( src.empty() )
    {
        cout << "Could not open or find the image!\n" << endl;
        cout << "Usage: " << argv[0] << " <Input image>" << endl;
        return -1;
    }

    Mat grad_x, grad_y,abs_grad_x,abs_grad_y;
    Mat grad_x_sq, grad_y_sq, grad_temp;

    duration<double, std::milli> duration_sec;
    start = high_resolution_clock::now();
    
    Sobel(src, grad_x, 2, 1, 0, KERNEL_SIZE, 1, 0, BORDER_DEFAULT);
    Sobel(src, grad_y, 2, 0, 1, KERNEL_SIZE, 1, 0, BORDER_DEFAULT);
    // converting back to CV_8U
    grad_x.convertTo(grad_x,CV_64F);
    grad_y.convertTo(grad_y,CV_64F);

    cv::pow(grad_x,2,grad_x_sq);
    cv::pow(grad_y,2,grad_y_sq);
    cv::add(grad_x_sq,grad_y_sq,grad_temp);
    cv::sqrt(grad_temp,sobel_dst);
    end = high_resolution_clock::now();

    duration_sec = std::chrono::duration_cast<duration<double, std::milli>>(end - start);
    cout <<"Runtime: "<<duration_sec.count() << "\n";
    imwrite(parser.get<String>( "@output" ),sobel_dst);
    cout<<"SAVED OUTPUT IMAGE FILE: "<<parser.get<String>( "@output" )<<endl<<endl;

    return 0;
}