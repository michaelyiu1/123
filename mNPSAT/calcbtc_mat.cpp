/* Matlab Include */
#include "mex.h"

// ind takes i ,j and number of rows and returns the linear index
#define ind(i,j,ni) (i+ni*j)

/* mSim include */
#include "Convoluteurf.h"

/* array U is for URF*/
/* array S is for Source
 Source also defines the simulation time*/



void mexFunction(int nlhs, mxArray *plhs[],int nrhs, const mxArray *prhs[])
{
    double *URF,*LF,*BTC;
    int Ns, Nt;
    
    /*  get the URFs in URF */
    URF = mxGetPr(prhs[0]);
    
    /*  get the Loading functions in LF */
    LF = mxGetPr(prhs[1]);
    
    /*  get the dimensions of the matrix input S */
 	// read the number of rows of the second matrix
    Ns = (int)mxGetM(prhs[1]);
    // read the number of columns of the second matrix
    Nt = (int)mxGetN(prhs[1]);
    
    /*  set the output pointer to the output matrix */
    plhs[0] = mxCreateDoubleMatrix(Ns,Nt, mxREAL);

    
    /*  create a C pointer to a copy of the output matrix */
    BTC = mxGetPr(plhs[0]);

    
    /*  call the C subroutine */
    clcbtc(BTC, URF, LF, Ns, Nt);
    
    
}