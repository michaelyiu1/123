/* Matlab Include */
#include "mex.h"
#include "matrix.h"

/* C++ includes */
#include <iostream>
#include <fstream>
#include <string.h>
#include <sstream>



/* Output Arguments */
#define	P_OUT plhs[0]
#define	MSH_OUT plhs[1]

//ind takes i,j and number of rows and returns the linear index
#define ind(i,j,ni)(i-1+ni*(j-1))


using namespace std;
void mexFunction(int nlhs, mxArray *plhs[], int	nrhs, const mxArray	*prhs[])
{
	/*
	cout << "__________________________________\n";
	cout << "....Read 2D Mesh file from GMSH...\n";
	cout << "__________________________________\n";
	cout << "__________George Kourakos_________\n";
	cout << "_________giorgk@gmail.com_________\n";
	cout << "__________________________________\n";
	*/
	 cout << mxGetNumberOfElements(prhs[0]) << endl;
	char *namefile;
	mwSize namefile_length;
	namefile_length = mxGetNumberOfElements(prhs[0]) + 1;
	namefile = new char[namefile_length];
	mxGetString(prhs[0], namefile, namefile_length);

	//namefile = mxCalloc(namefile_length, sizeof(char));
	cout << " The file name is " << namefile << endl;

	//ttt = mxGetPr(prhs[0]);


	//char namefile[] = "/media/giorgos/Win7/UCDAVIS_BIG/TLBmodel_V2/CVHMsim/cvhm_coarse.msh";
	char buffer[256];
	char test[80];

	int Np, Nel;
	double *p; // pointer for coordinates
	double *msh;
	int index, type, n_tags, temp;


	ifstream* Gmeshfile = new ifstream(namefile);
	if (!Gmeshfile->good()){
		cout << "Can't open" << namefile << std::endl;
	}

	for (int i = 0; i < 10; i++){
		Gmeshfile->getline(buffer,256); // put the first line into buffer
		//cout << "buffer" << buffer << "#" << endl;
		istringstream inp(buffer);
		inp.getline(test,80);
		//cout << "$"<< test << "$" << endl;
//		if (strcmp (test," ")==0 | strcmp (test,"")==0)
//			continue;



		// code for reading the node coordinates
		if (strcmp (test,"$Nodes")==0){
			//start reading nodes
			cout << "Reading nodes..." << endl;
			// Now read the total number of nodes
			Gmeshfile->getline(buffer,256);
			istringstream inp(buffer);
			inp >> Np;
			cout << "Np = " << Np << endl;
			
			P_OUT = mxCreateDoubleMatrix( Np, 3,   mxREAL );
			p = mxGetPr(P_OUT);
			//p = new double [3*Np];
			for (int j = 0; j < Np; j++){
				//cout << j << endl;
				Gmeshfile->getline(buffer,256);
				istringstream inp(buffer);
				inp >> index;
				inp >> p[ind(index, 1, Np)];
				inp >> p[ind(index, 2, Np)];
				inp >> p[ind(index, 3, Np)];
			}
		}

		//code for reading elements
		if (strcmp (test,"$Elements")==0){
			cout << "Reading Elements..." << endl;
			// Now read the total number of elements
			Gmeshfile->getline(buffer,256);
			istringstream inp(buffer);
			inp >> Nel;
			cout << "Nel = " << Nel << endl;

			MSH_OUT = mxCreateDoubleMatrix( Nel, 11,   mxREAL );
			msh = mxGetPr(MSH_OUT);

			for (int j = 0; j < Nel; j++){
				Gmeshfile->getline(buffer,256);
				istringstream inp(buffer);
				inp >> index;
				msh[ind(index, 1, Nel)] = index;
				inp >> type;
				msh[ind(index, 2, Nel)] = type;
				inp >> n_tags;
				for (int k = 0; k < n_tags; k++){
					inp >> temp;
				}

				if (type == 15){ // point
					inp >> msh[ind(index, 3, Nel)];
				}
				if(type == 1){ // 2-node line
					inp >> msh[ind(index, 3, Nel)];
					inp >> msh[ind(index, 4, Nel)];
				}
				if (type == 2){ //3-node triangle
					inp >> msh[ind(index, 3, Nel)];
					inp >> msh[ind(index, 4, Nel)];
					inp >> msh[ind(index, 5, Nel)];
				}
				if (type == 3){ //4-node quadrangle
					inp >> msh[ind(index, 3, Nel)];
					inp >> msh[ind(index, 4, Nel)];
					inp >> msh[ind(index, 5, Nel)];
				}
				if (type == 8){ //3-node second order line (2 nodes associated with the vertices and 1 with the edge)
					inp >> msh[ind(index, 3, Nel)];
					inp >> msh[ind(index, 4, Nel)];
					inp >> msh[ind(index, 5, Nel)];
				}
				if (type == 9){ //6-node second order triangle (3 nodes associated with the vertices and 3 with the edges)
					inp >> msh[ind(index, 3, Nel)]; inp >> msh[ind(index, 4, Nel)];
					inp >> msh[ind(index, 5, Nel)]; inp >> msh[ind(index, 6, Nel)];
					inp >> msh[ind(index, 7, Nel)]; inp >> msh[ind(index, 8, Nel)];
				}
				if (type == 10){ //9-node second order quadrangle (4 nodes associated with the vertices, 4 with the edges and 1 with the face)
					inp >> msh[ind(index, 3, Nel)]; inp >> msh[ind(index, 4, Nel)]; inp >> msh[ind(index, 5, Nel)];
					inp >> msh[ind(index, 6, Nel)]; inp >> msh[ind(index, 7, Nel)]; inp >> msh[ind(index, 8, Nel)];
					inp >> msh[ind(index, 9, Nel)]; inp >> msh[ind(index, 10, Nel)]; inp >> msh[ind(index, 11, Nel)];
				}
				if (type == 16){ //8-node second order quadrangle (4 nodes associated with the vertices and 4 with the edges)
					inp >> msh[ind(index, 3, Nel)]; inp >> msh[ind(index, 4, Nel)];
					inp >> msh[ind(index, 5, Nel)]; inp >> msh[ind(index, 6, Nel)];
					inp >> msh[ind(index, 7, Nel)]; inp >> msh[ind(index, 8, Nel)];
					inp >> msh[ind(index, 9, Nel)]; inp >> msh[ind(index, 10, Nel)];
				}
			}
			break;
		}

	}



	





}