#include<iostream>
using namespace std;
 void MatrixMultiplication(float *M,float * N,float *P,int Width){
     int size=Width*Width*sizeof(float);
     float *Md,Nd,Pd;
     cudaMalloc((void **)&Md,size);
     cudaMemcpy(Md,M,size,cudaMemcpyHostToDevice);
     cudaMalloc((void **)&Nd,size);
     cudaMemcpy(Nd,N,size,cudaMemcpyHostToDevice);
     cudaMalloc((void **)&Pd,size)



    cudaMemcpy(P,Pd,size,cudaMemcpyDeviceToHost);
    cudafree(Md);
    cudafree(Nd);
    cudafree(Pd);

 }