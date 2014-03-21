/*
particle_point newp_euler(particle_point pnt, double XY[], double Z[],
						int* MSH, int* B, double H[], double Kx[], double Ky[],
						double Kz[], double por[], partoptions opt){
	


		
}
*/
particle_point newp_RK45(particle_point pnt, double XY[], double Z[], 
				int* MSH, int* B, double H[], double Kx[] ,double Ky[], 
				double Kz[], double por[], partoptions opt){
	double t, err;
	double av_vel[3];
	int exitflag1, i;
	double y[3];
	double z[3];
	particle_point newpnt;
	
	//------- K2
	//std::cout << "K2\n";
	particle_point K2;
	K2.initialize(opt.step);
	
	for (i=0;i<3;i++) { av_vel[i]=(-((1.0/4.0)*pnt.vel[i]));}
	//std::cout << "av:" << av_vel[0] << " " << av_vel[1] << " " << av_vel[2] << std::endl;
	t=(pnt.step/sqrt(pow(av_vel[0],2)+pow(av_vel[1],2)+pow(av_vel[2],2)))*(1.0/4.0);
	//std::cout << "t:" << t << "\n"
	for (i=0;i<3;i++) { K2.coord[i]=pnt.coord[i]+av_vel[i]*t;}
	K2.idel=pnt.idel;
	//std::cout << "K2here1\n";
	K2=FindElement(K2, XY, Z, MSH, B, opt);
	//std::cout << "K2here2\n";
	exitflag1 = K2.checkpoint();
	//std::cout << "K2here3\n";
	if (exitflag1 !=0){
		return K2;
	}
	//std::cout << "K2here4\n";
	//K2.show();
	K2=compute_point_velocity(K2,XY,Z,MSH,B,H,Kx,Ky,Kz,por,opt);
	//std::cout << "K2here5\n";
	//K2.show();
	
	//--------K3
	//std::cout << "K3\n";
	particle_point K3;
	K3.initialize(opt.step);
	for (i=0;i<3;i++) { av_vel[i]=(-((3.0/32.0)*pnt.vel[i]+(9.0/32.0)*K2.vel[i]));}
	t=(pnt.step/sqrt(pow(av_vel[0],2)+pow(av_vel[1],2)+pow(av_vel[2],2)))*(3.0/8.0);
	for (i=0;i<3;i++) { K3.coord[i]=pnt.coord[i]+av_vel[i]*t;}
	K3.idel=K2.idel;
	K3=FindElement(K3, XY, Z, MSH, B, opt);
	exitflag1 = K3.checkpoint();
	if (exitflag1 !=0){
		return K3;
	}
	K3=compute_point_velocity(K3,XY,Z,MSH,B,H,Kx,Ky,Kz,por,opt);
	//K3.show();
	
	//---------K4
	//std::cout << "K4\n";
	particle_point K4;
	K4.initialize(opt.step);
	for (i=0;i<3;i++) { av_vel[i]=(-((1932.0/2197.0)*pnt.vel[i]-(7200.0/2197.0)*K2.vel[i]+(7296.0/2197.0)*K3.vel[i]));}
	t=(pnt.step/sqrt(pow(av_vel[0],2)+pow(av_vel[1],2)+pow(av_vel[2],2)))*(12.0/13.0);
	for (i=0;i<3;i++) { K4.coord[i]=pnt.coord[i]+av_vel[i]*t;}
	K4.idel=K3.idel;
	K4=FindElement(K4, XY, Z, MSH, B, opt);
	exitflag1 = K4.checkpoint();
	if (exitflag1 !=0){
		return K4;
	}
	K4=compute_point_velocity(K4,XY,Z,MSH,B,H,Kx,Ky,Kz,por,opt);
	//K4.show();
	
	//----------K5
	//std::cout << "K5\n";
	particle_point K5;
	K5.initialize(opt.step);
	for (i=0;i<3;i++) { av_vel[i]=(-((439.0/216.0)*pnt.vel[i]-(8.0)*K2.vel[i]+(3680.0/513.0)*K3.vel[i]-(845.0/4104.0)*K4.vel[i]));}
	t=(pnt.step/sqrt(pow(av_vel[0],2)+pow(av_vel[1],2)+pow(av_vel[2],2)));
	for (i=0;i<3;i++) { K5.coord[i]=pnt.coord[i]+av_vel[i]*t;}
	K5.idel=K4.idel;
	K5=FindElement(K5, XY, Z, MSH, B, opt);
	exitflag1 = K5.checkpoint();
	if (exitflag1 !=0){
		return K5;
	}
	K5=compute_point_velocity(K5,XY,Z,MSH,B,H,Kx,Ky,Kz,por,opt);
	//K5.show();
	
	//---------K6
	//std::cout << "K5\n";
	particle_point K6;
	K6.initialize(opt.step);
	for (i=0;i<3;i++) { av_vel[i]=(-(-(8.0/27.0)*pnt.vel[i]+(2)*K2.vel[i]-(3544.0/2565.0)*K3.vel[i]+(1859.0/4104.0)*K4.vel[i]-(11.0/40.0)*K5.vel[i]));}
	t=(pnt.step/sqrt(pow(av_vel[0],2)+pow(av_vel[1],2)+pow(av_vel[2],2)))*(1.0/2.0);
	for (i=0;i<3;i++) { K6.coord[i]=pnt.coord[i]+av_vel[i]*t;}
	K6.idel=K5.idel;
	K6=FindElement(K6, XY, Z, MSH, B, opt);
	exitflag1 = K6.checkpoint();
	if (exitflag1 !=0){
		return K6;
	}
	K6=compute_point_velocity(K6,XY,Z,MSH,B,H,Kx,Ky,Kz,por,opt);
	//K6.show();
	
	
	for (i=0;i<3;i++) { av_vel[i]=(-((25.0/216.0)*pnt.vel[i]+(1408.0/2565.0)*K3.vel[i]+(2197.0/4104.0)*K4.vel[i]-(1.0/5.0)*K5.vel[i]));}
	t=(pnt.step/sqrt(pow(av_vel[0],2)+pow(av_vel[1],2)+pow(av_vel[2],2)));
	for (i=0;i<3;i++) { y[i]=pnt.coord[i]+av_vel[i]*t;}
	
	for (i=0;i<3;i++) { av_vel[i]=(-((16.0/135.0)*pnt.vel[i]+(6656.0/12825.0)*K3.vel[i]+(28561.0/56430.0)*K4.vel[i]-(9.0/50.0)*K5.vel[i]+(2.0/55.0)*K6.vel[i]));}
	t=(pnt.step/sqrt(pow(av_vel[0],2)+pow(av_vel[1],2)+pow(av_vel[2],2)));
	for (i=0;i<3;i++) { z[i]=pnt.coord[i]+av_vel[i]*t;}
	
	err=sqrt(pow(y[0]-z[0],2)+pow(y[1]-z[1],2)+pow(y[2]-z[2],2));
	//std::cout << "err" << err << "\n";
	
	if (err < opt.errmin){
		double temp_step=pnt.step*1.2;
		if (temp_step > pnt.maxstep)
			temp_step=pnt.maxstep;
		newpnt.initialize(temp_step);
		newpnt.setcoord(y);
		newpnt.setoldvel(pnt.vel);
		newpnt.idel=K6.idel;
	}
	else if (err > opt.errmax){
		if (pnt.step < 2*opt.minstep){
			//std::cout << "ishere2\n";
			newpnt.initialize(pnt.step);
			newpnt.setcoord(y);
			newpnt.setoldvel(pnt.vel);
			newpnt.idel=K6.idel;
		}
		else {
			pnt.step=pnt.step/2;
			newpnt = newp_RK45(pnt, XY, Z, MSH, B, H, Kx , Ky, Kz, por, opt);
		}
	}
	else {
		newpnt.initialize(pnt.step);
		newpnt.setcoord(y);
		newpnt.setoldvel(pnt.vel);
		newpnt.idel=K6.idel;
	}
	
	return newpnt;
}

particle_point find_next_point(particle_point pnt, double XY[], double Z[], 
				int* MSH, int* B, double H[], double Kx[] ,double Ky[], 
				double Kz[], double por[], partoptions opt){
	/*
	if (opt.method == 1){
		pnt = newp_euler(pnt, XY, Z, MSH, B, H, Kx, Ky, Kz, por, opt);
	}
	*/
	if (opt.method == 4){
		pnt = newp_RK45(pnt, XY, Z, MSH, B, H, Kx, Ky, Kz, por, opt);
	}
	
	return pnt;
}

