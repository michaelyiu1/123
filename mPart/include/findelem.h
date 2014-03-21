void calc_barycenters(double*& CC, double XY[], int* MSH, partoptions opt){
	CC = new double [2*opt.Nel];
	
	//std::cout << "MSH1: " << MSH[ind(1,1,opt.Nel)] << " " << MSH[ind(1,2,opt.Nel)] << " " << MSH[ind(1,3,opt.Nel)] << "\n";
	
	for (int i=1;i<=opt.Nel;i++){
		CC[ind(i,1,opt.Nel)]=(XY[ind(MSH[ind(i,1,opt.Nel)],1,opt.Np)] +
                                 XY[ind(MSH[ind(i,2,opt.Nel)],1,opt.Np)] +
                                 XY[ind(MSH[ind(i,3,opt.Nel)],1,opt.Np)])/3.0;
        CC[ind(i,2,opt.Nel)]=(XY[ind(MSH[ind(i,1,opt.Nel)],2,opt.Np)] +
                                 XY[ind(MSH[ind(i,2,opt.Nel)],2,opt.Np)] +
                                 XY[ind(MSH[ind(i,3,opt.Nel)],2,opt.Np)])/3.0;
		
	}
}

particle_point parametric_XY(particle_point pnt, int id, double XY[], int* MSH, partoptions opt){
	double x1, x2, x3, y1, y2, y3, D;
	double CT[9];
	x1=XY[ind(MSH[ind(id,1,opt.Nel)],1,opt.Np)]; y1=XY[ind(MSH[ind(id,1,opt.Nel)],2,opt.Np)];
	x2=XY[ind(MSH[ind(id,2,opt.Nel)],1,opt.Np)]; y2=XY[ind(MSH[ind(id,2,opt.Nel)],2,opt.Np)];
	x3=XY[ind(MSH[ind(id,3,opt.Nel)],1,opt.Np)]; y3=XY[ind(MSH[ind(id,3,opt.Nel)],2,opt.Np)];

	D=1/((x2*y3-x3*y2)+x1*(y2-y3)+y1*(x3-x2));

	CT[0]=D*(x2*y3-x3*y2); CT[1]=D*(y2-y3); CT[2]=D*(x3-x2);
	CT[3]=D*(x3*y1-x1*y3); CT[4]=D*(y3-y1); CT[5]=D*(x1-x3);
	CT[6]=D*(x1*y2-x2*y1); CT[7]=D*(y1-y2); CT[8]=D*(x2-x1);
	pnt.t[0]=CT[0]*1+CT[1]*pnt.coord[0]+CT[2]*pnt.coord[1];
	pnt.t[1]=CT[3]*1+CT[4]*pnt.coord[0]+CT[5]*pnt.coord[1];
	pnt.t[2]=CT[6]*1+CT[7]*pnt.coord[0]+CT[8]*pnt.coord[1];
	return pnt;
}

particle_point parametric_Z(particle_point pnt, int ilay, double Z[], int* MSH, partoptions opt){
	double z1, z2;
	z1=Z[ind(MSH[ind(pnt.idel,1,opt.Nel)],ilay,opt.Np)]*pnt.t[0]+
	   Z[ind(MSH[ind(pnt.idel,2,opt.Nel)],ilay,opt.Np)]*pnt.t[1]+
	   Z[ind(MSH[ind(pnt.idel,3,opt.Nel)],ilay,opt.Np)]*pnt.t[2];
	z2=Z[ind(MSH[ind(pnt.idel,1,opt.Nel)],ilay+1,opt.Np)]*pnt.t[0]+
	   Z[ind(MSH[ind(pnt.idel,2,opt.Nel)],ilay+1,opt.Np)]*pnt.t[1]+
	   Z[ind(MSH[ind(pnt.idel,3,opt.Nel)],ilay+1,opt.Np)]*pnt.t[2];
	pnt.u=(2*(pnt.coord[2]-z2)/(z1-z2)-1);// scale between [-1 1]
	return pnt;
}

void listneibors(int lst[], int* B, int inds[]){
	int cnt=1;
	int istr;
	int iend;
	istr=inds[0];
	iend=inds[1];
	bool dontuse=false;
	int ii, i, k;
	for(ii=istr-1;ii<iend;ii++){
		for (i=1;i<=3;i++){
			if (B[ind(i,lst[ii],3)]!=0){
				//octave_stdout << (int)B[i+3*((int)lst[ii]-1)] << "\n";
				for (k=0;k<iend+cnt-1;k++){
					if (lst[k]==B[ind(i,lst[ii],3)]){
						dontuse=true;
						break;
					}
				}
				if (dontuse==true)
					dontuse=false;
				else{
					lst[iend+cnt-1]=B[ind(i,lst[ii],3)];
					cnt++;
					if (iend+cnt-1 > 999)
						return;
				}
			}
		}
	}
	istr=iend+1;
    iend=cnt+iend-1;
    inds[0]=istr;
    inds[1]=iend;
}

particle_point find_new_elem(particle_point pnt, double XY[], int* MSH, int* B, partoptions opt){
	bool tf;
	int lst[1000];
	for (int i=0;i<1000;i++)
		lst[i]=0;
	int inds[2];
	inds[0]=1;inds[1]=1;
	// make a list of the neibor elements
	lst[0]=pnt.idel;
	pnt.idel=0;
	//std::cout << ".......................\n";
	//std::cout << ".......................\n";
	//std::cout << "starting point" << lst[0] << "\n";
	
	for (int i=0;i<opt.Ngen;i++){
		//std::cout << inds[0] << " " << inds[1] << "\n";
		listneibors(lst,B,inds);
		if (lst[999]!=0)
			break;
	}
	/*
	for (int i=0;i<50;i++){
		std::cout << i << " " << lst[i] << "\n";
	}
	*/
	//std::cout << ". . . . . . . . . . . .\n";
	// Find which element in the list contains the point
	for (int i=1;i<1000;i++){
		//std::cout << i << " " << lst[i] << "\n";
		if (i ==1000)
			break;
		if (lst[i]==0)
			break;
		pnt = parametric_XY(pnt, lst[i], XY, MSH, opt);
		tf = pnt.isPntinElem(opt.el_type);
		if (tf == true){
			pnt.idel = lst[i];
			break;
		}
	}
	return pnt;
}


particle_point compute_max_step(particle_point pnt, double XY[], double Z[], int* MSH, partoptions opt){
	double x[3];
	double y[3];
	double zt[3];
	double zb[3];
	double xmin, xmax, ymin, ymax, zmin, zmax;
	xmin=1000000000; xmax=-1000000000;
	ymin=1000000000; ymax=-1000000000;
	zmin=1000000000; zmax=-1000000000;
	
	for (int i=1;i<=3;i++){
		x[i-1]=XY[ind(MSH[ind(pnt.idel,i,opt.Nel)],1,opt.Np)];
		y[i-1]=XY[ind(MSH[ind(pnt.idel,i,opt.Nel)],2,opt.Np)];
		zt[i-1]=Z[ind(MSH[ind(pnt.idel,i,opt.Nel)],pnt.lay,opt.Np)];
		zb[i-1]=Z[ind(MSH[ind(pnt.idel,i,opt.Nel)],pnt.lay+1,opt.Np)];
		
		if (x[i-1] > xmax) xmax = x[i-1];
		if (x[i-1] < xmin) xmin = x[i-1];
		if (y[i-1] > ymax) ymax = y[i-1];
		if (y[i-1] < ymin) ymin = y[i-1];
		if (zt[i-1] > zmax) zmax = zt[i-1];
		if (zb[i-1] < zmin) zmin = zb[i-1];
	}
	pnt.maxstep=opt.maxstep*sqrt(pow(xmax-xmin,2)+pow(ymax-ymin,2)+pow(zmax-zmin,2));
	
	return pnt;
}

particle_point FindElement(particle_point pnt, double XY[], double Z[], int* MSH, int* B, partoptions opt){
	bool tf = false;
	// First find the id of the element in the 2D Mesh structure
	if (pnt.idel==-88){
		double* CC;
		calc_barycenters(CC, XY, MSH, opt);
		//std::cout << "t: " << CC[0] << " " << CC[1] << " " << CC[2] << "\n";
		//define a vector of the class my_comp and store the distances and element indices
		
        std::vector<my_comp>cmpr(opt.Nel);
        for (int i=1;i<=opt.Nel;i++){
            cmpr[i-1].num=sqrt(pow(CC[ind(i,1,opt.Nel)]-pnt.coord[0],2)+
                               pow(CC[ind(i,2,opt.Nel)]-pnt.coord[1],2));
			cmpr[i-1].ind=i;
        }
        // sort the first "search_depth" elements
        std::partial_sort(cmpr.begin(),cmpr.begin() + opt.search,cmpr.end(),comp_func);
        for (int i=1;i<=opt.search;i++){
			pnt = parametric_XY(pnt, cmpr[i-1].ind, XY, MSH, opt);
            //pnt.parametric_XY(cmpr[i-1].ind, XY, M, SimOpt);
            tf = pnt.isPntinElem(opt.el_type);
            if (tf == true){
                pnt.idel = cmpr[i-1].ind;
                break;
			}
		}
	delete [] CC;  
	}
	else{
		pnt = parametric_XY(pnt, pnt.idel, XY, MSH, opt); // find the paramentric coordinates
		tf = pnt.isPntinElem(opt.el_type); // check if the point is in the current element
		if (tf == false){
			pnt=find_new_elem(pnt, XY, MSH, B, opt);
		}
	}
	if (pnt.idel<=0)
		return pnt;
        
    // Next find the layer 
    for (int i=1;i<opt.Nlay;i++){
		pnt = parametric_Z(pnt,i,Z,MSH,opt);
		//std::cout << "u" << pnt.u << "\n";
		if (i == 1 && pnt.u > 1){
			pnt.lay=0;
			break;
		}
		else if (i==opt.Nlay-1 && pnt.u < -1){
			pnt.lay=-9;
			break;
		}
		else {
			if (pnt.u >= -1 && pnt.u <= 1){
				pnt.lay = i;
				break;
			}
		}
	}
	
	if (pnt.lay>0 && pnt.lay <opt.Nlay)
		pnt = compute_max_step(pnt, XY, Z, MSH, opt);
	
	return pnt;
}
	
