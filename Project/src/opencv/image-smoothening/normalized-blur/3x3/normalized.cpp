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

Mat src, normalized_dst;

int main( int argc, char** argv )
{
  cv::String keys =
        "{@input |<none>           | input image path}"         // input image is the first argument (positional)
        "{@output |<none>          | output image path}";       // output image is the first argument (positional)
  /// Load an image
  CommandLineParser parser( argc, argv, keys);
  src = imread(samples::findFile( parser.get<String>( "@input" ) ), IMREAD_COLOR);

   //TIME START & END POINTERS
  high_resolution_clock::time_point start;
  high_resolution_clock::time_point end;

  cout<<"-- NORMALIZED -- 3x3"<<endl;
  cout<<"IMAGE FILE: "<<parser.get<String>( "@input" )<<endl;
  cout<<"WIDTH OF IMAGE: "<<src.size().width<<endl;
  cout<<"HEIGHT OF IMAGE: "<<src.size().height<<endl;
  
  if( src.empty() )
  {
    cout << "Could not open or find the image!\n" << endl;
    cout << "Usage: " << argv[0] << " <Input image>" << endl;
    return -1;
  }

  duration<double, std::milli> duration_sec;
  start = high_resolution_clock::now();
  blur(src, normalized_dst, Size(KERNEL_SIZE, KERNEL_SIZE), Point(-1,-1) );
  end = high_resolution_clock::now();
  duration_sec = std::chrono::duration_cast<duration<double, std::milli>>(end - start);
  cout <<"Runtime: "<<duration_sec.count() << "\n";


  imwrite(parser.get<String>( "@output" ),normalized_dst);
  cout<<"SAVED OUTPUT IMAGE FILE: "<<parser.get<String>( "@output" )<<endl<<endl;

  return 0;
}