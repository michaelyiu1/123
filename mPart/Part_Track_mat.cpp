/* Matlab Include */
#include "mex.h"
#include "matrix.h"

/* C++ includes */
#include <iomanip>
#include <iostream>
#include <string>
#include <math.h>
#include <vector>
#include <algorithm>

/* mSim include */
#include "include/pTrack_definitions.h"
#include "include/pTrack_options_mat.h"
#include "include/findelem.h"
#include "include/velocity_computations.h"
#include "include/find_next_point.h"
#include "include/main_loop.h"


/* Input Arguments */
#define	SP_IN	    prhs[0] // starting points
#define	XY_IN	    prhs[1] // x-y xoordinates
#define	Z_IN	    prhs[2] // Elevations
#define	MSH_IN	    prhs[3] // Mesh
#define	B_IN	    prhs[4] //Mesh connctivity
#define	H_IN	    prhs[5] //Hydraulic head
#define	KX_IN	    prhs[6] //hydraulic conductivity
#define	KY_IN	    prhs[7] //hydraulic conductivity
#define	KZ_IN	    prhs[8] //hydraulic conductivity
#define	POR_IN	    prhs[9] //porosity
#define	OPT_IN	    prhs[10] //hydraulic conductivity

/* Output Arguments */
#define	XYZ_OUT plhs[0]
#define	VXYZ_OUT plhs[1]
#define	FLAG_OUT plhs[2]



void double2int(int*& iA, double *A, int nr, int nc){
	for (int i=1;i<=nr;i++){
		for (int j=1;j<=nc;j++){
			iA[ind(i,j,nr)]=(int)A[ind(i,j,nr)];
		}
	}
}


void mexFunction(int nlhs, mxArray *plhs[], int	nrhs, const mxArray	*prhs[])
{

/*	std::cout << "|______________________________|\n";
	std::cout << "|______________________________|\n";
	std::cout << "|______________________________|\n";
	std::cout << "|                              |\n";
	std::cout << "|      Particle Tracking       |\n";
	std::cout << "|______________________________|\n";
	std::cout << "|______________________________|\n";
	std::cout << "|________George Kourakos_______|\n";
	std::cout << "|_______giorgk@gmail.com_______|\n";
	std::cout << "|______________________________|\n";
*/

	double *sp, *XY, *Z, *H, *Kx, *Ky, *Kz, *por, *dMSH, *dB;
	int *iMSH, *iB;
	double *xyz, *vxyz, *exitflag;
	partoptions opt;

	sp = mxGetPr( SP_IN );
	XY = mxGetPr( XY_IN );
	Z = mxGetPr( Z_IN );
	dMSH = mxGetPr( MSH_IN );
	dB = mxGetPr( B_IN );
	H = mxGetPr( H_IN );
	Kx = mxGetPr( KX_IN );
	Ky = mxGetPr( KY_IN );
	Kz = mxGetPr( KZ_IN );
	por = mxGetPr( POR_IN );
	if (!mxIsStruct(OPT_IN)){
		mexErrMsgIdAndTxt( "mSim:Part_Track_mat:inputNotStruct",
                "The option input must be a structure.");
	}
	else {
		opt = validate_options(OPT_IN);
	}


	iMSH = new int [opt.Nsh * opt.Nel];
	double2int(iMSH, dMSH, opt.Nel, opt.Nsh);
	iB = new int [opt.Nsides * opt.Nel];
	double2int(iB, dB, opt.Nsides,opt.Nel);


	/* Create matrices for the return arguments */
	XYZ_OUT = mxCreateDoubleMatrix( opt.Nal, 3,   mxREAL );
	VXYZ_OUT = mxCreateDoubleMatrix( opt.Nal, 3,   mxREAL );
	FLAG_OUT = mxCreateDoubleMatrix( 1, 1,   mxREAL );

	/*  create a C pointer to a copy of the output matrix */
    xyz = mxGetPr(XYZ_OUT);
    vxyz = mxGetPr(VXYZ_OUT);
    exitflag = mxGetPr(FLAG_OUT);

    //std::cout << std::setiosflags(std::ios::fixed) << std::setprecision(4);
    //std::cout << sp[0] << " " << sp[1] << " " << sp[2] << std::endl;
    //std::cout << XY[ind(37,1,opt.Np)] << " " << XY[ind(37,2,opt.Np)] << std::endl;
    //std::cout << Z[ind(opt.Np,1,opt.Np)] << " " << Z[ind(opt.Np,3,opt.Np)] << std::endl;
    //std::cout << iMSH[ind(1,1,opt.Nel)] << " " << iMSH[ind(1,2,opt.Nel)] << " " << iMSH[ind(1,3,opt.Nel)] << std::endl;
    //std::cout << iB[ind(1,10,opt.Nsides)] << " " << iB[ind(2,10,opt.Nsides)] << " " << iB[ind(3,10,opt.Nsides)] << std::endl;
    //std::cout << H[ind(opt.Np,1,opt.Np)] << " " << H[ind(opt.Np,3,opt.Np)] << std::endl;
    //std::cout << Kx[ind(opt.Np,1,opt.Nel)] << " " << Kx[ind(opt.Np,3,opt.Nel)] << std::endl;
    //std::cout << Ky[0] << std::endl;
    //std::cout << Kz[ind(opt.Np,1,opt.Nel)] << " " << Kz[ind(opt.Np,3,opt.Nel)] << std::endl;
    //std::cout << por[0] << std::endl;

    int eflag = particle_Tracking_main(xyz, vxyz, sp, XY, Z, iMSH, iB, H, Kx, Ky, Kz , por, opt);


    exitflag[0] = eflag;
    //std::cout << "Exitflag " << exitflag[0] << std::endl;
    

    delete [] iB;
	delete [] iMSH;
}