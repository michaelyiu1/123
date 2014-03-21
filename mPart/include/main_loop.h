int particle_Tracking_main(double XYZ[], double Vxyz[], double sp[], double XY[],
	double Z[], int* MSH, int* B, double H[], double Kx[], double Ky[],
	double Kz[], double por[], partoptions opt ){

	std::cout << std::setiosflags(std::ios::fixed) << std::setprecision(4);
	int exitflag = 0;
	int iter=0;//count iterations
	int cnt_stall_times=0; // count number of times the particle has stucked
	particle_point pnt;
	pnt.initialize(opt.step);

	pnt.setcoord(sp);

	
	double sV[6]; // stream volume. This is used to check if the particle has stuck
	sV[0]=sp[0];sV[1]=sp[0];sV[2]=sp[1];sV[3]=sp[1];sV[4]=sp[2];sV[5]=sp[2];
	double angle;
	int prnt=opt.Nal-1; // I use these variables for debuggin only
	int hyst=5;         // to print information for the last hyst iterations

	//initialize the output variables
	for (int i=1;i<=opt.Nal;i++){
		for (int j=1;j<=3;j++){
			XYZ[ind(i,j,opt.Nal)]=0;
			Vxyz[ind(i,j,opt.Nal)]=0;
		}
	}

	/* Start main Loop */
	while (exitflag==0) {
		iter++;
		if (iter>prnt-hyst){
			//std::cout << "\n";
			//std::cout << "------------------------------------------------\n";
			//std::cout << "iter " << iter << "\n";
		}
		pnt=FindElement(pnt, XY, Z, MSH, B, opt);
		exitflag = pnt.checkpoint();
		//if (iter>prnt-hyst){std::cout << "exitflag " << exitflag << "\n";}
		if (exitflag !=0)
            break;
        
        // if the point is still within the domain compute its velocity 
		// and find the next point
		pnt=compute_max_step(pnt, XY, Z, MSH, opt);
		pnt=compute_point_velocity(pnt,XY,Z,MSH,B,H,Kx,Ky,Kz,por,opt);
		//if (iter>prnt-hyst){pnt.show();}
		if (iter>1){
			angle=check_velAngle(pnt);
			//if (iter>prnt-hyst){std::cout << "angle " << angle << "\n";}
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
			//for(int i=1;i<=3;i++){ std::cout << "p:" << XYZ[ind(iter,i,opt.Nal)] << " ";}
			//std::cout << "\n";
			//for(int i=1;i<=3;i++){ std::cout << "v:" << Vxyz[ind(iter,i,opt.Nal)] << " ";}
			//std::cout << "\n";
		}
		pnt=find_next_point(pnt,XY,Z,MSH,B,H,Kx,Ky,Kz,por,opt);
		exitflag = pnt.checkpoint();
		if (exitflag !=0)
        	break;
		check_sVolume(cnt_stall_times, sV, pnt);

		if (iter>prnt)
			exitflag=11;

	}



	return exitflag;
}