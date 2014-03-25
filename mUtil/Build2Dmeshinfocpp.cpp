#include "mex.h"

/* Input Arguments */
#define	A_IN	    prhs[0]

#define	B_OUT       plhs[0]

void mexFunction(int nlhs, mxArray *plhs[],int nrhs, const mxArray *prhs[])
{
    double *A, *B;
    int i,j,ii,jj;
    double nd1i, nd2i, nd1j, nd2j;
    bool stopi=false;
    mwSize N;
    double ind[4];
    ind[0]=0;ind[1]=1;ind[2]=2;ind[3]=0;
    
    /*  get the INPUTS */
    A = mxGetPr( A_IN );
    
    N=mxGetN(A_IN);
    
     /* Create matrices for the return arguments */
    B_OUT = mxCreateDoubleMatrix( 3, N,   mxREAL );
    B = mxGetPr( B_OUT );
    
    for(i=0;i<N;i++){
        //printf("%d\n", i );
        //fflush(stdout);
        for(j=i+1;j<N;j++){
            for (ii=0;ii<3;ii++){
                if (B[ii+3*i]==0){
                    nd1i=A[(int)ind[ii]+3*i];
                    nd2i=A[(int)ind[ii+1]+3*i];
                    for (jj=0;jj<3;jj++){
                        nd1j=A[(int)ind[jj]+3*j];
                        nd2j=A[(int)ind[jj+1]+3*j];
                        if ((nd1i==nd1j && nd2i==nd2j) || (nd1i==nd2j && nd2i==nd1j)){
                            B[ii+3*i]=j+1;
                            B[jj+3*j]=i+1;
                            if (B[0+3*i]!=0 && B[1+3*i]!=0 && B[2+3*i]!=0){
                                stopi=true;
                            }
                            break;
                        }
                    }
                    
                }
            }
            if (stopi==true){
                stopi=false;
                break;
            }
        }
    }
}