function [XYZ, V, exitflag]=ParticleTracking_prism_par(Init,XY,Z,MSH,B,H,Kx,Ky,Kz,por,opt)
%
% THIS FUNCTION SHOULD NOT BE CALLED DIRECTLY.
%USE THE ParticleTracking_main INSTEAD.
%
% This function was just an attempt to write a vectorized particle tracking
% function. Although it works in most cases I have encounter examples where
% this function runs either very slow or seems to have stuck maybe because few of the particles
% are moving or in areas with very very slow field.
% 
% While this function gives nice live graphical output of particle tracking
% I highly recommend to avoid the vect options and use the cpp.


global exitflag;

Npart=size(Init,1);

% exitflag: -8 Initial position of particle is outside of the domain
%         : -1 Particle has stucked 
%         :  2 Particle exits from the side. 
%         :  1 Particle exits normally from the top surface
%         : -9 Particle exits from the bottom
%
% opt.ploton 0, 1 or any positive number turns on and off plotting
%    .Nal Allocation size 
%    .search : depth search it is used to find the initial id of the
%    element for each point
%    .bed_corr : true or false. If true it will assume that the bottom of
%    the aquifer is bedrock and no particles are allowed to exit 
if opt.ploton > 0 
    figure(10);clf
    hold on
    plotel_list=[0 0];
end

%Initialize the matrices that will hold the particle coordinates and the
%velocities
XX=zeros(Npart,opt.Nal);YY=zeros(Npart,opt.Nal);ZZ=zeros(Npart,opt.Nal);
VX=zeros(Npart,opt.Nal);VY=zeros(Npart,opt.Nal);VZ=zeros(Npart,opt.Nal);
exitflag=zeros(Npart,1);

point=initialize_point(Npart,Init,opt);

point=find_element(point,XY,Z,MSH,B,opt);
%time1=toc

point=checkpointstatus(point);
point=delete_points(point,point.exitflag~=0);
exitflag(exitflag==-9)=-8;

if isempty(point.ActiveID)
    XYZ=[];V=[];
    return
end

point=compute_max_step(point,XY,Z,MSH,opt);
%for the points inside the aquifer compute the initial velocity
point=compute_velocity_outer(point,XY,Z,MSH,H,Kx,Ky,Kz,por,opt);

XX(point.ActiveID,1)=point.coord(:,1);YY(point.ActiveID,1)=point.coord(:,2);ZZ(point.ActiveID,1)=point.coord(:,3);
VX(point.ActiveID,1)=point.vel(:,1);VY(point.ActiveID,1)=point.vel(:,2);VZ(point.ActiveID,1)=point.vel(:,3);
Xmn=XX(:,1);Xmx=XX(:,1);
Ymn=YY(:,1);Ymx=YY(:,1);
Zmn=ZZ(:,1);Zmx=ZZ(:,1);

if opt.ploton
    if opt.ploton > 1
        for i=1:size(point.idel,1)
            if isempty(find(plotel_list(:,1)==point.idel(i) & plotel_list(:,2)==point.lay(i), 1))
                plot3(XY(MSH(point.idel(i),[1 2 3 1]),1),XY(MSH(point.idel(i),[1 2 3 1]),2),Z(MSH(point.idel(i),[1 2 3 1]),point.lay(i)),':')
                plot3(XY(MSH(point.idel(i),[1 2 3 1]),1),XY(MSH(point.idel(i),[1 2 3 1]),2),Z(MSH(point.idel(i),[1 2 3 1]),point.lay(i)+1),':')
                plot3(XY(MSH(point.idel(i),[1 1]),1),XY(MSH(point.idel(i),[1 1]),2),Z(MSH(point.idel(i),1),[ point.lay(i) point.lay(i)+1]),':')
                plot3(XY(MSH(point.idel(i),[2 2]),1),XY(MSH(point.idel(i),[2 2]),2),Z(MSH(point.idel(i),2),[ point.lay(i) point.lay(i)+1]),':')
                plot3(XY(MSH(point.idel(i),[3 3]),1),XY(MSH(point.idel(i),[3 3]),2),Z(MSH(point.idel(i),3),[ point.lay(i) point.lay(i)+1]),':')
                plotel_list=[plotel_list;point.idel(i) point.lay(i)];
            end
        end
    end
    plot3(Init(:,1),Init(:,2),Init(:,3),'or')
end

times_no_expand=zeros(length(point.ActiveID),1);
iter=0;%tic;
%--------------  MAIN LOOP -----------------%
while 1
    iter=iter+1;
    %fflush(stdout);
    point=find_next_point(point,XY,Z,MSH,B,H,Kx,Ky,Kz,por,opt);
    if isempty(point)
        break
    end
    test=point.Iter>=opt.Nal;
    point.exitflag(test)=-1;
    exitflag(point.ActiveID(test))=-1;
    point=checkpointstatus(point);
    point=delete_points(point,point.exitflag~=0);
    if isempty(point.ActiveID)
        break
    end
    point=compute_max_step(point,XY,Z,MSH,opt);
    point=compute_velocity_outer(point,XY,Z,MSH,H,Kx,Ky,Kz,por,opt);
     
    lin_ind=point.ActiveID+Npart*(point.Iter-1);
    lin_ind_prev=point.ActiveID+Npart*(point.Iter-2);
    XX(lin_ind)=point.coord(:,1);YY(lin_ind)=point.coord(:,2);ZZ(lin_ind)=point.coord(:,3);
    VX(lin_ind)=point.vel(:,1);VY(lin_ind)=point.vel(:,2);VZ(lin_ind)=point.vel(:,3);

    
    
    expand=false(length(point.ActiveID),1);
    expand(point.coord(:,1)>Xmx(point.ActiveID) | point.coord(:,2)>Ymx(point.ActiveID) | point.coord(:,3)>Zmx(point.ActiveID) | ...
           point.coord(:,1)<Xmn(point.ActiveID) | point.coord(:,2)>Ymn(point.ActiveID) | point.coord(:,3)>Zmn(point.ActiveID))=true;
    times_no_expand(point.ActiveID(expand),1)=0;
    times_no_expand(point.ActiveID(~expand),1)=times_no_expand(point.ActiveID(~expand),1)+1;
    id_no_expand= times_no_expand>opt.stall_times;
    point.exitflag(id_no_expand)=-1;
   
    if all(point.Iter>2)
        ang=anglevel([VX(lin_ind) VY(lin_ind) VZ(lin_ind)],...
            [VX(lin_ind_prev) VY(lin_ind_prev) VZ(lin_ind_prev)]);
        test=ang>170;
        point.exitflag(test)=-1;
        exitflag(point.ActiveID(test))=-1;
    end
    
    
    
    if opt.ploton
        if opt.ploton > 1
            for i=1:size(point.idel,1)
                if isempty(find(plotel_list(:,1)==point.idel(i) & plotel_list(:,2)==point.lay(i), 1))
                    plot3(XY(MSH(point.idel(i),[1 2 3 1]),1),XY(MSH(point.idel(i),[1 2 3 1]),2),Z(MSH(point.idel(i),[1 2 3 1]),point.lay(i)),':')
                    plot3(XY(MSH(point.idel(i),[1 2 3 1]),1),XY(MSH(point.idel(i),[1 2 3 1]),2),Z(MSH(point.idel(i),[1 2 3 1]),point.lay(i)+1),':')
                    plot3(XY(MSH(point.idel(i),[1 1]),1),XY(MSH(point.idel(i),[1 1]),2),Z(MSH(point.idel(i),1),[ point.lay(i) point.lay(i)+1]),':')
                    plot3(XY(MSH(point.idel(i),[2 2]),1),XY(MSH(point.idel(i),[2 2]),2),Z(MSH(point.idel(i),2),[ point.lay(i) point.lay(i)+1]),':')
                    plot3(XY(MSH(point.idel(i),[3 3]),1),XY(MSH(point.idel(i),[3 3]),2),Z(MSH(point.idel(i),3),[ point.lay(i) point.lay(i)+1]),':')
                    plotel_list=[plotel_list;point.idel(i) point.lay(i)];
                end
            end
        end
        plot3([XX(lin_ind) XX(lin_ind_prev)]',...
              [YY(lin_ind) YY(lin_ind_prev)]',...
              [ZZ(lin_ind) ZZ(lin_ind_prev)]','.-')
          drawnow
    end
    if mod(iter,opt.freqplot)==0
        plot3(XX(lin_ind),YY(lin_ind),ZZ(lin_ind),'.')
        drawnow
        %fprintf('completed %.2f in %f sec\n',100*(1-size(point.coord,1)/Npart), toc)
        
        %fprintf('completed %.2f\n',100*(1-size(point.coord,1)/Npart))
    end
end
%time2=toc
%gather data into a structure
%XYZ=time1;V=time2;
for i=1:Npart
    ind=find(XX(i,:)==0,1,'first');
    XYZ{i,1}=[XX(i,1:ind-1)' YY(i,1:ind-1)' ZZ(i,1:ind-1)'];
    V{i,1}=[VX(i,1:ind-1)' VY(i,1:ind-1)' VZ(i,1:ind-1)'];
end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               SUBFUNCTIONS                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function newpoint=find_next_point(point,XY,Z,MSH,B,H,Kx,Ky,Kz,por,opt)

switch opt.method
    case {'RK45',4}
        newpoint=newp_rk45(point,XY,Z,MSH,B,H,Kx,Ky,Kz,por,opt);
end


function newpoint=newp_rk45(point,XY,Z,MSH,B,H,Kx,Ky,Kz,por,opt)
newpoint=[];
%Compute the step in time units
%point.h=point.step./sqrt(sum((point.vel.^2),2));

%find one point in this direction
K2=point;
    temp_t=point.step./sqrt(sum((point.vel.^2),2));%
    K2.coord=point.coord+bsxfun(@times,(-point.vel),(temp_t/4));%compute K2
    K2=find_element(K2,XY,Z,MSH,B,opt);%find the element of the new points
    K2=checkpointstatus(K2);%check their status
    point=delete_points(point,K2.exitflag~=0);%delete any point outside of the domain from the point struct
    K2=delete_points(K2,K2.exitflag~=0); %delete those points from the intermediate point structure
    if isempty(K2.coord);
        newpoint=[];
        return;
    end
    K2=compute_velocity_outer(K2,XY,Z,MSH,H,Kx,Ky,Kz,por,opt);
    
K3=K2;
    av_vel=(-((3/32)*point.vel+(9/32)*K2.vel));
    temp_t=point.step./sqrt(sum((av_vel.^2),2));
    K3.coord=point.coord+bsxfun(@times,av_vel,(3*temp_t/8));
    K3=find_element(K3,XY,Z,MSH,B,opt);
    K3=checkpointstatus(K3);
    point=delete_points(point,K3.exitflag~=0);
    K2=delete_points(K2,K3.exitflag~=0);
    K3=delete_points(K3,K3.exitflag~=0);
    if isempty(K3.coord);
        newpoint=[];
        return;
    end
    K3=compute_velocity_outer(K3,XY,Z,MSH,H,Kx,Ky,Kz,por,opt);
    
K4=K3;
    av_vel=(-((1932/2197)*point.vel-(7200/2197)*K2.vel+(7296/2197)*K3.vel));
    temp_t=point.step./sqrt(sum((av_vel.^2),2));
    K4.coord=point.coord+bsxfun(@times,av_vel,(12*temp_t/13));
    K4=find_element(K4,XY,Z,MSH,B,opt);
    K4=checkpointstatus(K4);
    point=delete_points(point,K4.exitflag~=0);
    K2=delete_points(K2,K4.exitflag~=0);
    K3=delete_points(K3,K4.exitflag~=0);
    K4=delete_points(K4,K4.exitflag~=0);
    if isempty(K4.coord);
        newpoint=[];
        return;
    end
    K4=compute_velocity_outer(K4,XY,Z,MSH,H,Kx,Ky,Kz,por,opt);
  
K5=K4;
    av_vel=(-((439/216)*point.vel-(8)*K2.vel+(3680/513)*K3.vel-(845/4104)*K4.vel));
    temp_t=point.step./sqrt(sum((av_vel.^2),2));
    K5.coord=point.coord+bsxfun(@times,av_vel,(temp_t));
    K5=find_element(K5,XY,Z,MSH,B,opt);
    K5=checkpointstatus(K5);
    point=delete_points(point,K5.exitflag~=0);
    K2=delete_points(K2,K5.exitflag~=0);
    K3=delete_points(K3,K5.exitflag~=0);
    K4=delete_points(K4,K5.exitflag~=0);
    K5=delete_points(K5,K5.exitflag~=0);
    if isempty(K5.coord);
        newpoint=[];
        return;
    end
    K5=compute_velocity_outer(K5,XY,Z,MSH,H,Kx,Ky,Kz,por,opt);
    
K6=K5;
    av_vel=(-(-(8/27)*point.vel+(2)*K2.vel-(3544/2565)*K3.vel+(1859/4104)*K4.vel-(11/40)*K5.vel));
    temp_t=point.step./sqrt(sum((av_vel.^2),2));
    K6.coord=point.coord+bsxfun(@times,av_vel,(temp_t/2));
    K6=find_element(K6,XY,Z,MSH,B,opt);
    K6=checkpointstatus(K6);
    point=delete_points(point,K6.exitflag~=0);
    K2=delete_points(K2,K6.exitflag~=0);
    K3=delete_points(K3,K6.exitflag~=0);
    K4=delete_points(K4,K6.exitflag~=0);
    K5=delete_points(K5,K6.exitflag~=0);
    K6=delete_points(K6,K6.exitflag~=0);
    if isempty(K6.coord);
        newpoint=[];
        return;
    end
    K6=compute_velocity_outer(K6,XY,Z,MSH,H,Kx,Ky,Kz,por,opt);

%Calculate two points based on two different combinations of the above
%velocities
av_vel=(-((25/216)*point.vel+(1408/2565)*K3.vel+(2197/4104)*K4.vel-(1/5)*K5.vel));
temp_t=point.step./sqrt(sum((av_vel.^2),2));
y=point.coord+bsxfun(@times,av_vel,temp_t);
av_vel=(-((16/135)*point.vel+(6656/12825)*K3.vel+(28561/56430)*K4.vel-(9/50)*K5.vel+(2/55)*K6.vel));
temp_t=point.step./sqrt(sum((av_vel.^2),2));
z=point.coord+bsxfun(@times,av_vel,temp_t);
%check the error
err=abs(sqrt(sum((z-y).^2,2)));

newpoint=point;
test= err<opt.errmin; % for the points with error less than the minimum double the step
newpoint.coord(test,:)=y(test,:);
newpoint.step(test,:)=min(point.step(test,:)*1.2,point.maxstep(test,:));
newpoint.Iter(test,:)=newpoint.Iter(test,:)+1;

test=err>opt.errmax & point.step > opt.minstep; %if the error is greater that the maximum error and if the step size is greater than the minimum
%then decrease the step and recompute in the next iteration
newpoint.coord(test,:)=point.coord(test,:);
newpoint.step(test)=point.step(test)/2;

test=err>opt.errmax & point.step < 2*opt.minstep; % if the step is already very small accept the new point despite the error
newpoint.coord(test,:)=y(test,:);
newpoint.Iter(test,:)=newpoint.Iter(test,:)+1;

test= err>=opt.errmin & err<=opt.errmax;
newpoint.coord(test,:)=y(test,:);
newpoint.step(test)=point.step(test);
newpoint.Iter(test,:)=newpoint.Iter(test,:)+1;

newpoint=find_element(newpoint,XY,Z,MSH,B,opt);

    

function p=compute_velocity_outer(p,XY,Z,MSH,H,Kx,Ky,Kz,por,opt)
%read element properties
[Ht, Hb, kxt, kxb, kyt, kyb, kzt, kzb, Xtb, Ytb, Zt, Zb,prt,prb]=get_elem_prop(p.idel,p.lay,XY,Z,MSH,H,Kx,Ky,Kz,por,opt);
%Compute shape function derivatives 
dH=CalcShapeDeriv_prism_par(p.t(:,1),p.t(:,2),p.u,Xtb,Ytb,Zt,Zb);
%compute velocity
[vpx, vpy, vpz]=calcvel_H(p.t,p.u,Ht,Hb,kxt,kxb,kyt,kyb,kzt,kzb,dH,prt,prb,opt,(1:length(p.u))');

if opt.bed_corr %if the bottom layer is bedrock then do not allow the particles to go beyond a specific elevation of the last layer
    ind = find(p.lay==size(H,2)-1 & vpz>0); %find the particles that have positive velocity and they are located to the last layer
    if ~isempty(ind)
        N_corr=length(ind);%get how many there are
        fix_id=Hb(ind,:)>Ht(ind,:); %find which nodes of the element have higher head at the bottom nodes( these cause the particles to go to down)
        Hb(ind(fix_id(:,1)),1)=Ht(ind(fix_id(:,1)),1); %set the elevations temporarily equal to zero the positive gradient
        Hb(ind(fix_id(:,2)),2)=Ht(ind(fix_id(:,2)),2);
        Hb(ind(fix_id(:,3)),3)=Ht(ind(fix_id(:,3)),3);
        %Find new velocities for those particles
        [~, ~, vpz1]=calcvel_H(p.t, p.u, Ht, Hb, kxt, kxb, kyt, kyb, kzt, kzb, dH, prt, prb, opt, ind);
        u=ScaleValues([p.u(ind) -0.5*ones(N_corr,1) ones(N_corr,1)],0,1);u=max(u(:,1),0);%scale the parametric values of those points
        vpz(ind)=vpz(ind).*u+vpz1.*(1-u);%assign a linear combination of the two velocities as final velocity
        %p.step(ind)=max(p.step(ind)/2,opt.minstep);%reduce the step
    end
end

p.vel=[vpx vpy vpz];


function [vpx vpy vpz]=calcvel_H(t,u,Ht,Hb,kxt,kxb,kyt,kyb,kzt,kzb,B,prt,prb,opt,id)

dhx=B(id,1).*Hb(id,1)+B(id,2).*Hb(id,2)+B(id,3).*Hb(id,3)+B(id,4).*Ht(id,1)+B(id,5).*Ht(id,2)+B(id,6).*Ht(id,3);
dhy=B(id,7).*Hb(id,1)+B(id,8).*Hb(id,2)+B(id,9).*Hb(id,3)+B(id,10).*Ht(id,1)+B(id,11).*Ht(id,2)+B(id,12).*Ht(id,3);
dhz=B(id,13).*Hb(id,1)+B(id,14).*Hb(id,2)+B(id,15).*Hb(id,3)+B(id,16).*Ht(id,1)+B(id,17).*Ht(id,2)+B(id,18).*Ht(id,3);

if opt.Knodes
    %interpolate hydraulic conductivity from nodes
    N1=t(id,1).*(1-u(id))/2; N2=t(id,2).*(1-u(id))/2; N3=t(id,3).*(1-u(id))/2;
    N4=t(id,1).*(1+u(id))/2; N5=t(id,2).*(1+u(id))/2; N6=t(id,3).*(1+u(id))/2;
    Kx=N1.*kxb(id,1)+N2.*kxb(id,2)+N3.*kxb(id,3)+N4.*kxt(id,1)+N5.*kxt(id,2)+N6.*kxt(id,3);
    Ky=N1.*kyb(id,1)+N2.*kyb(id,2)+N3.*kyb(id,3)+N4.*kyt(id,1)+N5.*kyt(id,2)+N6.*kyt(id,3);
    Kz=N1.*kzb(id,1)+N2.*kzb(id,2)+N3.*kzb(id,3)+N4.*kzt(id,1)+N5.*kzt(id,2)+N6.*kzt(id,3);
else
    Kx=kxt(id);
    Ky=kyt(id);
    Kz=kzt(id);
end
if length(prt)~=1
    if opt.pornodes
            N1=t(id,1).*(1-u(id))/2; N2=t(id,2).*(1-u(id))/2; N3=t(:,3).*(1-u(id))/2;
            N4=t(id,1).*(1+u(id))/2; N5=t(id,2).*(1+u(id))/2; N6=t(:,3).*(1+u(id))/2;
            POR=N1.*prb(id,1)+N2.*prb(id,2)+N3.*prb(id,3)+N4.*prt(id,1)+N5.*prt(id,2)+N6.*prt(id,3);
    else
        POR=prt(id);
    end
else
    POR=prt;
end

vpx=-Kx.*dhx./POR;
vpy=-Ky.*dhy./POR;
vpz=-Kz.*dhz./POR;







function [Ht, Hb, kxt, kxb, kyt, kyb, kzt, kzb, Xtb, Ytb, Zt, Zb, prt, prb]=get_elem_prop(idel,lay,XY,Z,MSH,H,Kx,Ky,Kz,por,opt)
ind1t=sub2ind(size(H),MSH(idel,1),lay);ind2t=sub2ind(size(H),MSH(idel,2),lay);ind3t=sub2ind(size(H),MSH(idel,3),lay);
ind1b=sub2ind(size(H),MSH(idel,1),lay+1);ind2b=sub2ind(size(H),MSH(idel,2),lay+1);ind3b=sub2ind(size(H),MSH(idel,3),lay+1);

Ht=[H(ind1t) H(ind2t) H(ind3t)];
Hb=[H(ind1b) H(ind2b) H(ind3b)];

Zt=[Z(ind1t) Z(ind2t) Z(ind3t)];
Zb=[Z(ind1b) Z(ind2b) Z(ind3b)];

Xtb=[XY(MSH(idel,1),1) XY(MSH(idel,2),1) XY(MSH(idel,3),1)];
Ytb=[XY(MSH(idel,1),2) XY(MSH(idel,2),2) XY(MSH(idel,3),2)];

if opt.Knodes==1 % Conductivity is defined on nodes
    kxt=[Kx(ind1t) Kx(ind2t) Kx(ind3t)];
    kxb=[Kx(ind1b) Kx(ind2b) Kx(ind3b)];
    if Ky == -1 %Ky == Kx
        kyt=kxt;
        kyb=kxb;
    else
        kyt=[Ky(ind1t) Ky(ind2t) Ky(ind3t)];
        kyb=[Ky(ind1b) Ky(ind2b) Ky(ind3b)];
    end
    if Kz == -1 %Kz == Kx
        kzt=kxt;
        kzb=kxt;
    else
        kzt=[Kz(ind1t) Kz(ind2t) Kz(ind3t)];
        kzb=[Kz(ind1b) Kz(ind2b) Kz(ind3b)];
    end
else % Conductivity is defined on elements
    ind_el=sub2ind(size(Kx), idel, lay);
    
    kxt=Kx(ind_el);kxb=[];kyb=[];kzb=[];
    if Ky == -1 %Ky == Kx
        kyt=kxt;
    else
        kyt=Ky(ind_el);
    end
    if Kz == -1 %Kz == Kx
        kzt=kxt;
    else
        kzt=Kz(ind_el);
    end
    
end

if length(por)==1
    prt=por;prb=[];
else
    if opt.pornodes==1
        prt=[por(ind1t) por(ind2t) por(ind3t)];
        prb=[por(ind1b) por(ind2b) por(ind3b)];
    else
        prt=por(ind_el);prb=[];
    end
end
    

function B=CalcShapeDeriv_prism_par(ksi,eta,zta,XX,YY,Zt,Zb)
gn1=1/2 - zta/2; gn2=0;           gn3=zta/2 - 1/2;          gn4=zta/2 + 1/2; gn5=0;            gn6=- zta/2 - 1/2;
gn7=0;           gn8=1/2 - zta/2; gn9=zta/2 - 1/2;          gn10=0;          gn11=zta/2 + 1/2; gn12=- zta/2 - 1/2;
gn13=-ksi/2;     gn14=-eta/2;     gn15=eta/2 + ksi/2 - 1/2; gn16=ksi/2;      gn17=eta/2;       gn18=1/2 - ksi/2 - eta/2;
x1=XX(:,1);x2=XX(:,2);x3=XX(:,3);x4=XX(:,1);x5=XX(:,2);x6=XX(:,3);
y1=YY(:,1);y2=YY(:,2);y3=YY(:,3);y4=YY(:,1);y5=YY(:,2);y6=YY(:,3);
z1=Zb(:,1);z2=Zb(:,2);z3=Zb(:,3);z4=Zt(:,1);z5=Zt(:,2);z6=Zt(:,3);

j1=gn1.*x1 + gn2.*x2 + gn3.*x3 + gn4.*x4 + gn5.*x5 + gn6.*x6;
j2=gn1.*y1 + gn2.*y2 + gn3.*y3 + gn4.*y4 + gn5.*y5 + gn6.*y6;
j3=gn1.*z1 + gn2.*z2 + gn3.*z3 + gn4.*z4 + gn5.*z5 + gn6.*z6;
j4=gn7.*x1 + gn8.*x2 + gn9.*x3 + gn10.*x4 + gn11.*x5 + gn12.*x6;
j5=gn7.*y1 + gn8.*y2 + gn9.*y3 + gn10.*y4 + gn11.*y5 + gn12.*y6;
j6=gn7.*z1 + gn8.*z2 + gn9.*z3 + gn10.*z4 + gn11.*z5 + gn12.*z6;
j7=gn13.*x1 + gn14.*x2 + gn15.*x3 + gn16.*x4 + gn17.*x5 + gn18.*x6;
j8=gn13.*y1 + gn14.*y2 + gn15.*y3 + gn16.*y4 + gn17.*y5 + gn18.*y6;
j9=gn13.*z1 + gn14.*z2 + gn15.*z3 + gn16.*z4 + gn17.*z5 + gn18.*z6;

 Jdet=(j1.*j5.*j9 - j1.*j6.*j8 - j2.*j4.*j9 + j2.*j6.*j7 + j3.*j4.*j8 - j3.*j5.*j7);
 
 jinv1=(j5.*j9 - j6.*j8)./Jdet;
jinv2=-(j2.*j9 - j3.*j8)./Jdet;
jinv3=(j2.*j6 - j3.*j5)./Jdet; 
jinv4= -(j4.*j9 - j6.*j7)./Jdet;
jinv5= (j1.*j9 - j3.*j7)./Jdet;
jinv6= -(j1.*j6 - j3.*j4)./Jdet;
jinv7= (j4.*j8 - j5.*j7)./Jdet;
jinv8= -(j1.*j8 - j2.*j7)./Jdet;
jinv9=(j1.*j5 - j2.*j4)./Jdet;
 
 B=[ gn1.*jinv1 + gn13.*jinv3 + gn7.*jinv2, gn14.*jinv3 + gn2.*jinv1 + gn8.*jinv2, gn15.*jinv3 + gn3.*jinv1 + gn3.*jinv2, gn10.*jinv2 + gn16.*jinv3 + gn4.*jinv1, gn11.*jinv2 + gn17.*jinv3 + gn5.*jinv1, gn12.*jinv2 + gn18.*jinv3 + gn6.*jinv1,...
    gn1.*jinv4 + gn13.*jinv6 + gn7.*jinv5, gn14.*jinv6 + gn2.*jinv4 + gn8.*jinv5, gn15.*jinv6 + gn3.*jinv4 + gn3.*jinv5, gn10.*jinv5 + gn16.*jinv6 + gn4.*jinv4, gn11.*jinv5 + gn17.*jinv6 + gn5.*jinv4, gn12.*jinv5 + gn18.*jinv6 + gn6.*jinv4,...
    gn1.*jinv7 + gn13.*jinv9 + gn7.*jinv8, gn14.*jinv9 + gn2.*jinv7 + gn8.*jinv8, gn15.*jinv9 + gn3.*jinv7 + gn3.*jinv8, gn10.*jinv8 + gn16.*jinv9 + gn4.*jinv7, gn11.*jinv8 + gn17.*jinv9 + gn5.*jinv7, gn12.*jinv8 + gn18.*jinv9 + gn6.*jinv7];
 


function p=find_element(p,XY,Z,MSH,B,opt)
Npart=size(p.coord,1);
Nlay=size(Z,2);
ind=(1:Npart)';
idel=zeros(Npart,1);t=zeros(Npart,3);lay=nan(Npart,1);u=zeros(Npart,1);

if (all(p.idel==0))
    cc=[(XY(MSH(:,1),1)+XY(MSH(:,2),1)+XY(MSH(:,3),1))/3 (XY(MSH(:,1),2)+XY(MSH(:,2),2)+XY(MSH(:,3),2))/3];
    [lst,~]=knnsearch(cc,p.coord(:,1:2),'K',opt.search);
    %lst = knnsearch_my(p.coord(:,1:2), cc, opt.search);
else
    t_temp=parametric_XY(XY,MSH,p.coord(ind,1:2),p.idel);
    test=logical(t_temp(:,1)>=0 & t_temp(:,1)<=1 & ...
                 t_temp(:,2)>=0 & t_temp(:,2)<=1 & ...
                 t_temp(:,3)>=0 & t_temp(:,3)<=1);
    if all(test)
        idel=p.idel;
        t=t_temp;
        lst=[];
    else
        idel(test)=p.idel(test);
        t(test,:)=t_temp(test,:);
        ind=find(~test);
        lst=zeros(Npart,1000);
        for i=1:length(ind)
%             disp(i);fflush(stdout);
%             lst1=zeros(1,1000);lst1(1)=p.idel(ind(i));
%             temp=ListNeighborElemcpp_v2(B,lst1,opt.Ngen-1);
            temp=ListNeighborElem(B,p.idel(ind(i)),opt.Ngen)';
            lst(ind(i),1:length(temp))=temp;
        end
    end
    
end
%disp(2);fflush(stdout);
for i=1:size(lst,2)
    ind(lst(ind,i)==0,:)=[];% remove the points with zero ids in element list
    t_temp=parametric_XY(XY,MSH,p.coord(ind,1:2),lst(ind,i)); % find the parametric values wrt the elements 
                                                              % in the first column of lst
    test=logical(t_temp(:,1)>=0 & t_temp(:,1)<=1 & ...
                 t_temp(:,2)>=0 & t_temp(:,2)<=1 & ...
                 t_temp(:,3)>=0 & t_temp(:,3)<=1); % find the points that lay inside the those elements
    idel(ind(test),1)=lst(ind(test),i);% assign the element ids for those with positive test
    t(ind(test),:)=t_temp(test,:);% assign also their parametric values to variable t
    if all(idel~=0)% all the points have a non zero element id then exit for loop
        break
    end
    ind(test,:)=[];% otherwise delete from the ind list those points that we 
                   % have found element id and continue searching on the next column of lst
end
%so far we have found the element id of the 2D MSH,
%Now we need to find the layer
ind=(1:Npart)';
ind(idel==0,:)=[]; % we dont need to find anything for the points without element id

for i=1:Nlay-1
    
    u_temp=parametric_Z(Z,MSH,p.coord(ind,3),idel(ind),t(ind,:),i); %find the parametric value of elevation wrt ti i layer
    test=logical(u_temp>=-1 & u_temp<=1); % if the parametric is within [-1 1] then thats the layer it belongs to
    u(ind(test))=u_temp(test); %set the u parametric value equal to u_temp for those that belong to that layer
    lay(ind(test))=i;%set the layer
    if i==1 % if there are particles with u>1 for i==1 these particles have actually exit from the top
        test1=logical(u_temp>1);
        lay(ind(test1))=0;% we set them as layer 0
    elseif i==Nlay-1 % if there are particles with u<-1 for the last layer the these have exit from the bottom of the aquifer
        test1=logical(u_temp<-1);
        lay(ind(test1))=-99;
    else
        test1=false(size(u_temp,1),1);
    end
    ind(test1 | test,:)=[];%remove the indices of the particles we have found their layers
    if all(~isnan(lay));
        break;
    end
    
end
p.idel=idel;
p.t=t;
p.lay=lay;
p.u=u;


function point=initialize_point(n,Init,opt)
point.coord=Init;% point coordinates
point.idel=zeros(n,1);% id of the element in 2D mesh
point.lay=-8*ones(n,1);%layer 
point.t=-8*ones(n,3); %parametric coordinates of the XY location
point.u=-8*ones(n,1); %parametric coordinate of Z
point.vel=-8*ones(n,3);%velocities
point.oldvel=-8*ones(n,3);%velocity of the previous point
if size(opt.step,1)==n
    point.step=opt.step;% step size in m
else
    point.step=opt.step*ones(n,1);
end
point.exitflag=zeros(n,1); 
point.Iter=ones(n,1);%this holds the column id where the point should be writen
point.ActiveID=(1:n)';


function t=parametric_XY(XY,MSH,p,idel)
%Converts the coordinates of points p to the barycentric coordinates of
%elements idel
x1=XY(MSH(idel,1),1);y1=XY(MSH(idel,1),2);
x2=XY(MSH(idel,2),1);y2=XY(MSH(idel,2),2);
x3=XY(MSH(idel,3),1);y3=XY(MSH(idel,3),2);
D=1./((x2.*y3-x3.*y2)+x1.*(y2-y3)+y1.*(x3-x2));
DCT=bsxfun(@times, D,[x2.*y3-x3.*y2  y2-y3  x3-x2 ...
                      x3.*y1-x1.*y3  y3-y1  x1-x3 ...
                      x1.*y2-x2.*y1  y1-y2  x2-x1]);
t=[DCT(:,1)+bsxfun(@times,DCT(:,2),p(:,1))+bsxfun(@times,DCT(:,3),p(:,2))...
   DCT(:,4)+bsxfun(@times,DCT(:,5),p(:,1))+bsxfun(@times,DCT(:,6),p(:,2))... 
   DCT(:,7)+bsxfun(@times,DCT(:,8),p(:,1))+bsxfun(@times,DCT(:,9),p(:,2))];


function u=parametric_Z(Z,TRI,pz,idel,t,lay)
%interpolates the elevation of the top layer and the bottom layer and
%rescales the value to [-1 1], which is the parametric space for z in prism
%elements
z1=Z(TRI(idel,1),lay).*t(:,1)+Z(TRI(idel,2),lay).*t(:,2)+Z(TRI(idel,3),lay).*t(:,3);
z2=Z(TRI(idel,1),lay+1).*t(:,1)+Z(TRI(idel,2),lay+1).*t(:,2)+Z(TRI(idel,3),lay+1).*t(:,3);
u=(2.*(pz-z2)./(z1-z2)-1);% scale sz between -1 and 1

function p=checkpointstatus(p)
global exitflag

test=p.idel==0;
p.exitflag(test)=2;
exitflag(p.ActiveID(test))=2;
test=p.lay==0;
p.exitflag(test)=1;
exitflag(p.ActiveID(test))=1;
test=p.lay==-99;
p.exitflag(test)=-9;
exitflag(p.ActiveID(test))=-9;

function [point]=delete_points(point,test)
%exitflag(ind(test))=point.exitflag(test);
%test=point.exitflag~=0;
if all(test==0)
    return
end
if isfield(point,'coord');point.coord(test,:)=[];end
if isfield(point,'idel');point.idel(test,:)=[];end
if isfield(point,'lay');point.lay(test,:)=[];end
if isfield(point,'t');point.t(test,:)=[];end
if isfield(point,'u');point.u(test,:)=[];end
if isfield(point,'vel');point.vel(test,:)=[];end
if isfield(point,'oldvel');point.oldvel(test,:)=[];end
if isfield(point,'step');point.step(test,:)=[];end
if isfield(point,'exitflag');point.exitflag(test,:)=[];end
if isfield(point,'Iter');point.Iter(test,:)=[];end
if isfield(point,'h');point.h(test,:)=[];end 
if isfield(point,'ActiveID');point.ActiveID(test,:)=[];end
if isfield(point,'maxstep');point.maxstep(test,:)=[];end

% function [point ind exitflag]=delete_points(point,ind,exitflag)
% test=find(point.exitflag~=0);
% exitflag(ind(test))=point.exitflag(test);
% point.coord(test,:)=[];
% point.idel(test,:)=[];
% point.lay(test,:)=[];
% point.t(test,:)=[];
% point.u(test,:)=[];
% point.vel(test,:)=[];
% point.oldvel(test,:)=[];
% point.step(test,:)=[];
% point.exitflag(test,:)=[];
% point.Iter(test,:)=[];
% ind(test,:)=[];

function lst=ListNeighborElem(B,lst,nGen)
%lst=[lst zeros(length(lst),1000)];
istr=1;iend=1;
igen=1;
while igen<nGen
    [lst istr iend]=listtemp(B,lst,istr,iend);
    igen=igen+1;
end

function [lst istr iend]=listtemp(B,lst,istr,iend)
cnt=1;
dontuse=false;
for ii=istr:iend
    for i=1:3
        if B(i,lst(ii))~=0
            for k=1:iend+cnt-1
                if lst(k)==B(i,lst(ii))
                    dontuse=true;
                    break
                end
            end
            if dontuse
                dontuse=false;
            else
                lst(iend+cnt,1)=B(i,lst(ii));
                cnt=cnt+1;
            end
        end
    end
end
istr=iend+1;
iend=cnt+iend-1;

function lst=ListNeighborElem_v2(B,id,ngen)
lst=zeros(1000,1);
lst(1:3)=B(:,id);
strt_id=1;end_id=3;
for ii=1:ngen
    temp=lst(strt_id:end_id);
    temp(temp==0,:)=[];
    temp2=B(:,temp);
    temp2=reshape(temp2,1,3*size(temp2,2))';
    [b m n]=unique([lst(strt_id:end_id);temp2],'stable');
    temp2=b(end_id+1:end);
    strt_id=end_id+1;
    end_id=length(temp2)+strt_id-1;
    lst(strt_id:end_id)=temp2;
end
    

function ang=anglevel(v1,v2)
if any(abs(sqrt(sum(v1.^2,2)).*sqrt(sum(v2.^2,2)))<1e-7)
    check=true;
end
ang=(180/pi).*acos(sum((v1.*v2),2)./(sqrt(sum(v1.^2,2)).*sqrt(sum(v2.^2,2))));

function p=compute_max_step(p,XY,Z,MSH,opt)
x=[XY(MSH(p.idel,1),1) XY(MSH(p.idel,2),1) XY(MSH(p.idel,3),1)];
y=[XY(MSH(p.idel,1),2) XY(MSH(p.idel,2),2) XY(MSH(p.idel,3),2)];

try 
    ind1t=sub2ind(size(Z),MSH(p.idel,1),p.lay);ind2t=sub2ind(size(Z),MSH(p.idel,2),p.lay);ind3t=sub2ind(size(Z),MSH(p.idel,3),p.lay);
    ind1b=sub2ind(size(Z),MSH(p.idel,1),p.lay+1);ind2b=sub2ind(size(Z),MSH(p.idel,2),p.lay+1);ind3b=sub2ind(size(Z),MSH(p.idel,3),p.lay+1);
catch
    wtf=true
end
    
zt=[Z(ind1t) Z(ind2t) Z(ind3t)];
zb=[Z(ind1b) Z(ind2b) Z(ind3b)];

xmin=min(x,[],2);xmax=max(x,[],2);
ymin=min(y,[],2);ymax=max(y,[],2);
zmin=min([zt zb],[],2);zmax=max([zt zb],[],2);

dst=sqrt((xmax-xmin).^2+(ymax-ymin).^2+(zmax-zmin).^2);
p.maxstep=dst*opt.maxstep;

