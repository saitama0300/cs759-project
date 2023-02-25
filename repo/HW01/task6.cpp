#include<iostream>

using namespace std;

int main(int argc, char *argv[]){
    //take command line argument
    int N = atoi(argv[1]);

    //print ascending sequence
    for(int i=0;i<N;i++) {
        printf("%d ",i);
    }
    printf("%d\n",N);

    //print descending sequence
    for(int i=N;i>0;i--) {
        printf("%d ",i);
    }
    printf("%d\n",0);

    return 0;
}