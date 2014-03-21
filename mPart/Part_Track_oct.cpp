#include <octave/oct.h>
#include <octave/ov.h>
#include <octave/ov-struct.h>

#include <iomanip>
#include <iostream>
#include <math.h>
#include <vector>
#include <algorithm>

#include "include/pTrack_definitions.h"
#include "include/pTrack_options_oct.h"
#include "include/findelem.h"
#include "include/velocity_computations.h"
#include "include/find_next_point.h"
#include "include/main_loop.h"

/*//#include "find_next_point.h"

//--------------------------------------------------------
//-----------Main function-------------------------------
//--------------------------------------------------------
int particle_Tracking_main(double XYZ[], double Vxyz[], double sp[], double XY[],
	double Z[], int* MSH, int* B, double H[], double Kx[], double Ky[],
	double Kz[], double por[], partoptions opt ){
	std::cout << std::setiosflags(std::ios::fixed) << std::setprecision(4);
	int exitflag=0;
	int iter=0;//count iterations
	int cnt_stall_times=0; // count number of times the particle has stucked
	particle_point pnt;
	pnt.initialize(opt.step);
	pnt.setcoord(sp);
	//pnt.show();
	double sV[6]; // stream volume. This is used to check if the particle has stuck
	sV[0]=sp[0];sV[1]=sp[0];sV[2]=sp[1];sV[3]=sp[1];sV[4]=sp[2];sV[5]=sp[2];
	double angle;
	
	int prnt=130;
	int hyst=5;
	for (int i=1;i<=opt.Nal;i++){
		for (int j=1;j<=3;j++){
			XYZ[ind(i,j,opt.Nal)]=0;
			Vxyz[ind(i,j,opt.Nal)]=0;
		}
	}
		

	
	
	while (exitflag==0){
		iter++;
		if (iter>prnt-hyst){
		std::cout << "\n";
		std::cout << "------------------------------------------------\n";
		std::cout << "iter " << iter << "\n";}
		pnt=FindElement(pnt, XY, Z, MSH, B, opt);
		exitflag = pnt.checkpoint();
		if (iter>prnt-hyst){std::cout << "exitflag " << exitflag << "\n";}
		if (exitflag !=0)
            break;
		
		// if the point is still within the domain compute its velocity 
		// and find the next point
		pnt=compute_point_velocity(pnt,XY,Z,MSH,B,H,Kx,Ky,Kz,por,opt);
		if (iter>prnt-hyst){pnt.show();}
		if (iter>1){
			angle=check_velAngle(pnt);
			if (iter>prnt-hyst){std::cout << "angle " << angle << "\n";}
			if (angle > 170)
				break;
		}
		
		
		XYZ[ind(iter,1,opt.Nal)]=pnt.coord[0];
		XYZ[ind(iter,2,opt.Nal)]=pnt.coord[1];
		XYZ[ind(iter,3,opt.Nal)]=pnt.coord[2];
		Vxyz[ind(iter,1,opt.Nal)]=pnt.vel[0];
		Vxyz[ind(iter,2,opt.Nal)]=pnt.vel[1];
		Vxyz[ind(iter,3,opt.Nal)]=pnt.vel[2];
		if (iter>prnt-hyst){
			for(int i=1;i<=3;i++){ std::cout << "p:" << XYZ[ind(iter,i,opt.Nal)] << " ";}
			std::cout << "\n";
			for(int i=1;i<=3;i++){ std::cout << "v:" << Vxyz[ind(iter,i,opt.Nal)] << " ";}
			std::cout << "\n";
		}
		//if (iter>prnt-hyst){std::cout << "ishere01\n";}
		pnt=find_next_point(pnt,XY,Z,MSH,B,H,Kx,Ky,Kz,por,opt);
		//if (iter>prnt-hyst){std::cout << "ishere11\n";}
		check_sVolume(cnt_stall_times, sV, pnt);
		//if (iter>prnt-hyst){std::cout << "ishere12\n";}
          
		if (iter>prnt)
			exitflag=11;
		
	}
	return exitflag;
}*/

void double2int(int*& iA, Matrix A, int nr, int nc){
	for (int i=1;i<=nr;i++){
		for (int j=1;j<=nc;j++){
			iA[ind(i,j,nr)]=(int)A(i-1,j-1);
		}
	}
}

//--------------------------------------------------------
//-----DEFUN_DLD function-This takes inputs from octave and 
//------converts them to c++------------------------------
//--------------------------------------------------------
DEFUN_DLD (Part_Track_oct, args, nargout , "[XYZ Vxyz exitflag]=Part_Track_oct(sp,XY,Z,MSH,B,H,Kx,Ky,Kz,por,opt) \n \n"){
	std::cout << "|______________________________|\n";
	std::cout << "|______________________________|\n";
	std::cout << "|______________________________|\n";
	std::cout << "|                              |\n";
	std::cout << "|      Particle Tracking       |\n";
	std::cout << "|______________________________|\n";
	std::cout << "|______________________________|\n";
	std::cout << "|________George Kourakos_______|\n";
	std::cout << "|_______giorgk@gmail.com_______|\n";
	std::cout << "|______________________________|\n";
	
	
	octave_value_list retval;
	retval.resize (3);
	//-----Inputs------//
	int nargin = args.length ();
	if (nargin != 11){
		std::cout << "Wrong number of inputs" << std::endl;
		print_usage ();
		retval(0)=0;
		return retval;
	}
	
	Matrix sp;  //  1 initial point
	Matrix XY;  //  2 XY coordinates of the mesh
	Matrix Z;   //  3 Z coodrinates of the mesh in [np x nlay] format
	Matrix MSH; //  4 mesh numbering
	Matrix B;   //  5 connectivity of elements 
	Matrix H;   //  6 Hydraulic heads in [np x nlay] format
	Matrix Kx;  //  7 Horizontal Hydraulic conductivity along x in [np or Nel x nlay] format
	Matrix Ky;  //  8 Horizontal Hydraulic conductivity along y in [np or Nel x nlay] format
	Matrix Kz;  //  9 Vertical Hydraulic conductivity along z in [np or Nel x nlay] format
	Matrix por; //  10 porosity
	octave_scalar_map oct_opt; // 11 options
	
	//Validate option structure
	oct_opt = args(10).scalar_map_value();
	partoptions opt = validate_options(oct_opt);
	if (opt.valid == false){
		return octave_value (nargin);
	}
	
	//assign input arguments to matrices
	sp  =  args(0).matrix_value();
	XY  =  args(1).matrix_value();
	Z   =  args(2).matrix_value();
	MSH =  args(3).matrix_value();
	B   =  args(4).matrix_value();
	H	=  args(5).matrix_value();
	Kx	=  args(6).matrix_value();
	Ky	=  args(7).matrix_value();
	Kz	=  args(8).matrix_value();
	por	=  args(9).matrix_value();
	int* iMSH;
	int* iB;
	
	//XY,Z,MSH,B.H,Kx,Ky,Kz,por
	
	//--------Outputs----------//
	
	if (nargout !=3){
		std::cout << "Wrong number of outputs" << std::endl;
		print_usage ();
		retval(0)=0;
		return retval;
	}
	Matrix mXYZ(opt.Nal,3);
	Matrix mVxyz(opt.Nal,3);
	Matrix mexitflag(1,1);
	//double* XYZ;
	//double* Vxyz;
	//XYZ = new double [3 * opt.Nal];
	//Vxyz = new double [3 * opt.Nal];
	iMSH = new int [opt.Nsh * opt.Nel];
	iB = new int [opt.Nsides * opt.Nel];
	double2int(iB, B, opt.Nsides,opt.Nel);
	//std::cout << opt.Nsh << std::endl;
	double2int(iMSH, MSH, opt.Nel, opt.Nsh);
	int exitflag=100;
	
	//std::cout << "opt.Nal" << opt.Nal << std::endl;
	//std::cout << "opt.search" << opt.search << std::endl;
	//std::cout << "opt.bed_corr" << opt.bed_corr << std::endl;
	//std::cout << "opt.Knodes" << opt.Knodes << std::endl;
	//std::cout << "opt.step" << opt.step << std::endl;
	//std::cout << "opt.minstep" << opt.minstep << std::endl;
	//std::cout << "opt.errmin" << opt.errmin << std::endl;
	//std::cout << "opt.errmax" << opt.errmax << std::endl;
	//std::cout << "opt.method" << opt.method << std::endl;
	//std::cout << "opt.pornodes" << opt.pornodes << std::endl;
	//std::cout << "opt.porinterp" << opt.porinterp << std::endl;
	//std::cout << "opt.Ngen" << opt.Ngen << std::endl;
	//std::cout << "opt.maxstep" << opt.maxstep << std::endl;
	//std::cout << "opt.stall_times" << opt.stall_times << std::endl;
	//std::cout << "opt.el_type" << opt.el_type << std::endl;
	//std::cout << "opt.el_order" << opt.el_order << std::endl;
	//std::cout << "opt.valid" << opt.valid << std::endl;
	//std::cout << "opt.Nel" << opt.Nel << std::endl;
	//std::cout << "opt.Np" << opt.Np << std::endl;
	//std::cout << "opt.Nsides" << opt.Nsides << std::endl;
	//std::cout << "opt.Nsh" << opt.Nsh << std::endl;
	//std::cout << "opt.Nlay" << opt.Nlay << std::endl;

	
	// ---------Call outer particle tracking function--------//
	 exitflag=particle_Tracking_main(mXYZ.fortran_vec(),mVxyz.fortran_vec(),
	 		 sp.fortran_vec(),XY.fortran_vec(),
	 		 Z.fortran_vec(),iMSH,iB,H.fortran_vec(), Kx.fortran_vec(),
	 		 Ky.fortran_vec(),Kz.fortran_vec(),por.fortran_vec(), opt);

	mexitflag(0)=exitflag;
	retval(0)=mXYZ;//;
	retval(1)=mVxyz;//;
	retval(2)=mexitflag;//;
	
	delete [] iB;
	delete [] iMSH;
	//delete [] XYZ;
	//delete [] Vxyz;
  return octave_value_list(retval);
}
