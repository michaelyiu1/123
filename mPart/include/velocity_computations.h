void read_elem_prop_lin_prism(double Ht[], double Hb[], double Kxt[], double Kxb[], 
				   double Kyt[], double Kyb[], double Kzt[], double Kzb[], double Prt[], double Prb[],
                   double Xtb[], double Ytb[], double Zb[], double Zt[], particle_point pnt, 
                   double H[], double Kx[], double Ky[], double Kz[], double por[], partoptions opt,
                   int ids[], double XY[], double Z[]){
					   
	
	
	for (int i=1;i<=3;i++){
		
		//---------Head-------------
		Ht[i-1]=H[ind(ids[i-1],pnt.lay,opt.Np)];   
		Hb[i-1]=H[ind(ids[i-1],pnt.lay+1,opt.Np)];
	
		//---------elevation-------------
		Zt[i-1]=Z[ind(ids[i-1],pnt.lay,opt.Np)];   
		Zb[i-1]=Z[ind(ids[i-1],pnt.lay+1,opt.Np)];
		
		//-----coordinates--------
		Xtb[i-1]=XY[ind(ids[i-1],1,opt.Np)];
		Ytb[i-1]=XY[ind(ids[i-1],2,opt.Np)];
	
		//-----Kx----------------
		if (opt.Knodes == -1){ // if it is uniform
			Kxt[i-1]=Kx[0];
			Kxb[i-1]=Kx[0];
		}
		else if (opt.Knodes == 1){ // If it is defined on nodes
			Kxt[i-1]=Kx[ind(ids[i-1],pnt.lay,opt.Np)];   
			Kxb[i-1]=Kx[ind(ids[i-1],pnt.lay+1,opt.Np)];
		}
		else if (opt.Knodes == 0){ //if it is defined on the elements
			Kxt[i-1]=Kx[ind(pnt.idel,pnt.lay,opt.Nel)];
			Kxb[i-1]=Kxt[i-1];
		}
	
		//-----Ky--------------- 
		if (Ky[0] < 0.0){ // if Ky = Kx
			Kyt[i-1]=Kxt[i-1];
			Kyb[i-1]=Kxb[i-1];
		}
		else{
			if (opt.Knodes == -1){
				Kyt[i-1]=Ky[0];
				Kyb[i-1]=Ky[0];
			}
			else if (opt.Knodes == 1){
				Kyt[i-1]=Ky[ind(ids[i-1],pnt.lay,opt.Np)];   
				Kyb[i-1]=Ky[ind(ids[i-1],pnt.lay+1,opt.Np)];
			}
			else if (opt.Knodes == 0){
				Kyt[i-1]=Ky[ind(pnt.idel,pnt.lay,opt.Nel)];
				Kyb[i-1]=Kyt[i-1];
			}
		}
	
		//-----Kz--------------- 
		if (Kz[0] < 0.0){
			Kzt[i-1]=Kxt[i-1];
			Kzb[i-1]=Kxb[i-1];
		}
		else{
			if (opt.Knodes == -1){
				Kzt[i-1]=Ky[0];
				Kzb[i-1]=Ky[0];
			}
			else if (opt.Knodes == 1){
				Kzt[i-1]=Kz[ind(ids[i-1],pnt.lay,opt.Np)];   
				Kzb[i-1]=Kz[ind(ids[i-1],pnt.lay+1,opt.Np)];
			}
			else if (opt.Knodes == 0){
				Kzt[i-1]=Kz[ind(pnt.idel,pnt.lay,opt.Nel)];
				Kzb[i-1]=Kzt[i-1];
			}
		}
	
	//-----por--------------- 
		if (opt.pornodes == -1){
			Prt[i-1]=por[0];
			Prb[i-1]=por[0];
		}
		else if (opt.pornodes == 1){
			Prt[i-1]=por[ind(ids[i-1],pnt.lay,opt.Np)];   
			Prb[i-1]=por[ind(ids[i-1],pnt.lay+1,opt.Np)];
		}
		else if (opt.pornodes == 0){
			Prt[i-1]=por[ind(pnt.idel,pnt.lay,opt.Nel)];
			Prb[i-1]=Prt[i-1];
		}
	}				   
}

void CalcShapeDeriv_lin_prism(double dH[], double ksi, double eta , double zta , double x[], double y[], double zt[], double zb[]){
    double gn[18];
    double j[9];
    double jinv[9];
    double Jdet;
    //cout << "ksi:" << ksi << "\n";
    //cout << "eta:" << eta << "\n";
    //cout << "zta:" << zta << "\n";

    // shape functions derivatives
    gn[0]=0.5 - zta/2; gn[1]=0;           gn[2]=zta/2 - 0.5;          gn[3]=zta/2 + 0.5; gn[4]=0;            gn[5]=- zta/2 - 0.5;
    gn[6]=0;           gn[7]=0.5 - zta/2; gn[8]=zta/2 - 0.5;          gn[9]=0;          gn[10]=zta/2 + 0.5; gn[11]=- zta/2 - 0.5;
    gn[12]=-ksi/2;     gn[13]=-eta/2;     gn[14]=eta/2 + ksi/2 - 0.5; gn[15]=ksi/2;      gn[16]=eta/2;       gn[17]=0.5 - ksi/2 - eta/2;

    //for (int i=0;i<18;i++)
    //    cout << "gn" << i << ":" << gn[i] << "\n";

    j[0]=gn[0]  *  x[0] + gn[1]  *  x[1] + gn[2]  *  x[2] + gn[3]  *  x[0] + gn[4]  *  x[1] + gn[5]  *  x[2];
    j[1]=gn[0]  *  y[0] + gn[1]  *  y[1] + gn[2]  *  y[2] + gn[3]  *  y[0] + gn[4]  *  y[1] + gn[5]  *  y[2];
    j[2]=gn[0]  * zb[0] + gn[1]  * zb[1] + gn[2]  * zb[2] + gn[3]  * zt[0] + gn[4]  * zt[1] + gn[5]  * zt[2];
    j[3]=gn[6]  *  x[0] + gn[7]  *  x[1] + gn[8]  *  x[2] + gn[9]  *  x[0] + gn[10] *  x[1] + gn[11] *  x[2];
    j[4]=gn[6]  *  y[0] + gn[7]  *  y[1] + gn[8]  *  y[2] + gn[9]  *  y[0] + gn[10] *  y[1] + gn[11] *  y[2];
    j[5]=gn[6]  * zb[0] + gn[7]  * zb[1] + gn[8]  * zb[2] + gn[9]  * zt[0] + gn[10] * zt[1] + gn[11] * zt[2];
    j[6]=gn[12] *  x[0] + gn[13] *  x[1] + gn[14] *  x[2] + gn[15] *  x[0] + gn[16] *  x[1] + gn[17] *  x[2];
    j[7]=gn[12] *  y[0] + gn[13] *  y[1] + gn[14] *  y[2] + gn[15] *  y[0] + gn[16] *  y[1] + gn[17] *  y[2];
    j[8]=gn[12] * zb[0] + gn[13] * zb[1] + gn[14] * zb[2] + gn[15] * zt[0] + gn[16] * zt[1] + gn[17] * zt[2];

    //for (int i=0;i<9;i++)
    //    cout << "j" << i << ":" << j[i] << "\n";

    Jdet=(j[0]*j[4]*j[8] - j[0]*j[5]*j[7] - j[1]*j[3]*j[8] + j[1]*j[5]*j[6] + j[2]*j[3]*j[7] - j[2]*j[4]*j[6]);

    //cout << "Jdet:" << Jdet << "\n";

    jinv[0] =  (j[4] * j[8] - j[5] * j[7])/Jdet;
    jinv[1] = -(j[1] * j[8] - j[2] * j[7])/Jdet;
    jinv[2] =  (j[1] * j[5] - j[2] * j[4])/Jdet;
    jinv[3] = -(j[3] * j[8] - j[5] * j[6])/Jdet;
    jinv[4] =  (j[0] * j[8] - j[2] * j[6])/Jdet;
    jinv[5] = -(j[0] * j[5] - j[2] * j[3])/Jdet;
    jinv[6] =  (j[3] * j[7] - j[4] * j[6])/Jdet;
    jinv[7] = -(j[0] * j[7] - j[1] * j[6])/Jdet;
    jinv[8] =  (j[0] * j[4] - j[1] * j[3])/Jdet;

    //for (int i=0;i<9;i++)
    //    cout << "jinv" << i << ":" << jinv[i] << "\n";

    dH[0] = gn[0] * jinv[0] + gn[12] * jinv[2] + gn[6] * jinv[1];
    dH[1] = gn[13] * jinv[2] + gn[1] * jinv[0] + gn[7] * jinv[1];
    dH[2] = gn[14] * jinv[2] + gn[2] * jinv[0] + gn[2] * jinv[1];
    dH[3] = gn[9] * jinv[1] + gn[15] * jinv[2] + gn[3] * jinv[0];
    dH[4] = gn[10]* jinv[1] + gn[16] * jinv[2] + gn[4] * jinv[0];
    dH[5] = gn[11] * jinv[1] + gn[17] * jinv[2] + gn[5] * jinv[0];
    dH[6] = gn[0] * jinv[3] + gn[12] * jinv[5] + gn[6] * jinv[4];
    dH[7] = gn[13] * jinv[5] + gn[1] * jinv[3] + gn[7] * jinv[4];
    dH[8] = gn[14] * jinv[5] + gn[2] * jinv[3] + gn[2] * jinv[4];
    dH[9] = gn[9] * jinv[4] + gn[15] * jinv[5] + gn[3] * jinv[3];
    dH[10]= gn[10] * jinv[4] + gn[16] * jinv[5] + gn[4] * jinv[3];
    dH[11]= gn[11] * jinv[4] + gn[17] * jinv[5] + gn[5] * jinv[3];
    dH[12]= gn[0] * jinv[6] + gn[12] * jinv[8] + gn[6] * jinv[7];
    dH[13]= gn[13] * jinv[8] + gn[1] * jinv[6] + gn[7] * jinv[7];
    dH[14]= gn[14] * jinv[8] + gn[2] * jinv[6] + gn[2] * jinv[7];
    dH[15]= gn[9] * jinv[7] + gn[15] * jinv[8] + gn[3] * jinv[6];
    dH[16]= gn[10] * jinv[7] + gn[16] * jinv[8] + gn[4] * jinv[6];
    dH[17]= gn[11] * jinv[7] + gn[17] * jinv[8] + gn[5] * jinv[6];

    //for (int i=0;i<18;i++)
    //    cout << "dH" << i << ":" << dH[i] << "\n";

}

void calcvel_lin_prism(double Vel[], double Ht[], double Hb[], double Kxt[], double Kxb[],
                   double Kyt[], double Kyb[], double Kzt[], double Kzb[], 
                   double Prt[], double Prb[], double dH[], particle_point pnt){
    double dhx, dhy, dhz;
    double N[6];
    double Kx, Ky, Kz, Pr;
    dhx=dH[0]*Hb[0]+dH[1]*Hb[1]+dH[2]*Hb[2]+dH[3]*Ht[0]+dH[4]*Ht[1]+dH[5]*Ht[2];
    dhy=dH[6]*Hb[0]+dH[7]*Hb[1]+dH[8]*Hb[2]+dH[9]*Ht[0]+dH[10]*Ht[1]+dH[11]*Ht[2];
    dhz=dH[12]*Hb[0]+dH[13]*Hb[1]+dH[14]*Hb[2]+dH[15]*Ht[0]+dH[16]*Ht[1]+dH[17]*Ht[2];

    //std::cout << "dhx" << dhx << std::endl;
    //std::cout << "dhy" << dhy << std::endl;
    //std::cout << "dhz" << dhz << std::endl;

    N[0]=pnt.t[0]*(1-pnt.u)/2; N[1]=pnt.t[1]*(1-pnt.u)/2; N[2]=pnt.t[2]*(1-pnt.u)/2;
    N[3]=pnt.t[0]*(1+pnt.u)/2; N[4]=pnt.t[1]*(1+pnt.u)/2; N[5]=pnt.t[2]*(1+pnt.u)/2;
    //for (int i=0;i<6;i++) {std::cout << "N[" << i << "] " << N[i] << std::endl;}

    Kx=N[0]*Kxb[0]+N[1]*Kxb[1]+N[2]*Kxb[2]+N[3]*Kxt[0]+N[4]*Kxt[1]+N[5]*Kxt[2];
    Ky=N[0]*Kyb[0]+N[1]*Kyb[1]+N[2]*Kyb[2]+N[3]*Kyt[0]+N[4]*Kyt[1]+N[5]*Kyt[2];
    Kz=N[0]*Kzb[0]+N[1]*Kzb[1]+N[2]*Kzb[2]+N[3]*Kzt[0]+N[4]*Kzt[1]+N[5]*Kzt[2];
    Pr=N[0]*Prb[0]+N[1]*Prb[1]+N[2]*Prb[2]+N[3]*Prt[0]+N[4]*Prt[1]+N[5]*Prt[2];

    //std::cout << "Kx " << Kx << std::endl;
    //std::cout << "Ky " << Ky << std::endl;
    //std::cout << "Kz " << Kz << std::endl;

    Vel[0]=-Kx*dhx/Pr;
    Vel[1]=-Ky*dhy/Pr;
    Vel[2]=-Kz*dhz/Pr;
}


particle_point linear_prism_velocity(particle_point pnt, double XY[] , double Z[],
				int* MSH,int* B, double H[], double Kx[], double Ky[], double Kz[],
				double por[], partoptions opt){
					
	double Ht[3]; // hydraulic head of the top nodes
    double Hb [3]; // hydraulic head of the bottom nodes
    double Kxt [3]; //Hydraulic conductivity
    double Kxb [3];
    double Kyt [3];
    double Kyb [3];
    double Kzt [3];
    double Kzb [3];
    double Prt [3];
    double Prb [3];
    double Xtb [3]; //coordinates
    double Ytb [3];
    double Zt [3]; // elevation of top nodes
    double Zb [3]; // elevation of bottom nodes
    double dH [18]; //derivatives of hydraulic head
    double Vel [3];
    
    int ids[3]; // ids of the nodes
    ids[0]=MSH[ind(pnt.idel,1,opt.Nel)];
    ids[1]=MSH[ind(pnt.idel,2,opt.Nel)];
    ids[2]=MSH[ind(pnt.idel,3,opt.Nel)];
    
	read_elem_prop_lin_prism(Ht, Hb, Kxt, Kxb, Kyt, Kyb, Kzt, Kzb, Prt, Prb,
                   Xtb, Ytb, Zb, Zt, pnt, H, Kx, Ky, Kz, por, opt, ids, XY, Z);


	//std::cout << "Ht ";for (int i=0;i<3;i++) {std::cout << Ht[i] << " ";} std::cout << std::endl;
	//std::cout << "Hb ";for (int i=0;i<3;i++) {std::cout << Hb[i] << " ";} std::cout << std::endl;
	//std::cout << "Kxt ";for (int i=0;i<3;i++) {std::cout << Kxt[i] << " ";} std::cout << std::endl;
	//std::cout << "Kyt ";for (int i=0;i<3;i++) {std::cout << Kyt[i] << " ";} std::cout << std::endl;
	//std::cout << "Kzt ";for (int i=0;i<3;i++) {std::cout << Kzt[i] << " ";} std::cout << std::endl;
	//std::cout << "Xtb ";for (int i=0;i<3;i++) {std::cout << Xtb[i] << " ";} std::cout << std::endl;
	//std::cout << "Ytb ";for (int i=0;i<3;i++) {std::cout << Ytb[i] << " ";} std::cout << std::endl;
	//std::cout << "Zt ";for (int i=0;i<3;i++) {std::cout << Zt[i] << " ";} std::cout << std::endl;
	//std::cout << "Zb ";for (int i=0;i<3;i++) {std::cout << Zb[i] << " ";} std::cout << std::endl;


	
	CalcShapeDeriv_lin_prism(dH, pnt.t[0], pnt.t[1], pnt.u, Xtb, Ytb, Zt, Zb);
	//for (int i=0;i<18;i++) {std::cout << "dH[" << i << "] " << dH[i] << std::endl;}


	
	calcvel_lin_prism(Vel, Ht, Hb, Kxt, Kxb, Kyt, Kyb, Kzt, Kzb, Prt, Prb, dH, pnt);
	
	if (opt.bed_corr == 1){
		/*if the bottom layer is bedrock then do not allow the particles 
		to go beyond a specific elevation of the bottom layer.*/
		if (pnt.lay == opt.Nlay-1 && Vel[2]>0){
			double tempvel[3];
			/* If the particle is within the bottom layer and 
			the vertical velocity points downward, tweak the heads.
			The final velocity is a linear combination of the actual velocity
			and the tweaked velocity. As we moved towards the bottom the weight of the 
			tweaked velocity is increased.  */
			for (int i=0;i<opt.Nsh;i++){
				if (Hb[i]>Ht[i])
					Hb[i]=Ht[i];
			}
			calcvel_lin_prism(tempvel, Ht, Hb, Kxt, Kxb, Kyt, Kyb, Kzt, Kzb, Prt, Prb, dH, pnt);
			//std::cout << "tempvel "  << tempvel[2]*100000000 << "\n";
			double xmin = -0.5;
			double Xrange = 1.5;
			double Yrange = 1;
			double uu;
			uu=(pnt.u-xmin)/(Xrange/Yrange);
			if (uu<0){uu=0;}
			//std::cout << "u "  << uu << "\n";
			//std::cout << "vel1 "  << Vel[2]*100000000 << "\n";
			Vel[2]=Vel[2]*uu+tempvel[2]*(1-uu);
			//std::cout << "vel2 " << Vel[2]*100000000 << "\n";
		}
	}
	pnt.vel[0]=Vel[0];pnt.vel[1]=Vel[1];pnt.vel[2]=Vel[2];
	return pnt;
}

particle_point compute_point_velocity(particle_point pnt, double XY[], double Z[], 
				int* MSH, int* B, double H[], double Kx[], double Ky[], double Kz[], 
				double por[], partoptions opt){
	if (opt.el_type == 1){
		if (opt.el_order = 1){
			// compute velocity for linear prism elements
			pnt = linear_prism_velocity(pnt, XY, Z, MSH, B, H, Kx, Ky, Kz, por, opt);
			
		}
	}
	return pnt;
}
