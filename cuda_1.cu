#include<iostream>
using namespace std;
__global__ void MatrixMulKernel(float *Md,float *Nd,float *Pd,int Width){
    int tx=threadIdx.x;
    int ty=threadIdx.y;
    float Pvalue=0;
    for(int k=0;k<Width;k++){
        float Mdelement=Md[ty*Width+k];
        float Ndelement=Nd[k*Width+ty];
        Pvalue+=Mdelement*Ndelement;
        
    }
    Pd[ty*Width+tx]=Pvalue;
}

void MatrixMultiplication(float *M,float *N,float *P,int Width){
     int size=Width*Width*sizeof(float);
     float *Md,*Nd,*Pd;
     cudaMalloc((void **)&Md,size);
     cudaMemcpy(Md,M,size,cudaMemcpyHostToDevice);
     cudaMalloc((void **)&Nd,size);
     cudaMemcpy(Nd,N,size,cudaMemcpyHostToDevice);
     cudaMalloc((void **)&Pd,size);
     dim3 dimBlock(Width,Width);
     dim3 dimGrid(1,1);
     MatrixMulKernel<<<dimGrid,dimBlock>>>(Md,Nd,Pd,Width);
     cudaMemcpy(P,Pd,size,cudaMemcpyDeviceToHost);
     cudaFree(Md);
     cudaFree(Nd);
     cudaFree(Pd);

 }
 int main(){
     float M[3][3]={1,2,3,4,5,6,7,8,9};
     float N[3][3]={9,8,7,6,5,4,3,2,1};
     float P[3][3]={0};
     MatrixMultiplication(*M,*N,*P,3);
     cout << "P[3][3] = " << endl;
     for(int m=0;m<3;m++){
         for(int n=0;n<3;n++){
             cout << P[m][n] << " ";
         }
         cout << endl;
     }
 }