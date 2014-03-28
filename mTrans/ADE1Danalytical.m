function C=ADE1Danalytical(x,t,v,cf,aL,Dm,lambda,R)
% C=ADE1Danalytical(x, t, v, cf, aL, Dm, lambda, R)
% Returns a concentration profile for each point in x as function of time t 
%
% Input
% x      : points in 1D domain where we want to compute the breakthrough curve
% t      : times where the concentration will be computed 
% v      : pore velocity i.e. v=V/porosity
% cf     : Input concentration
% aL     : Longitudinal dispersion coefficient
% Dm     : Molecular diffusion
% lambda : Decay constant
% R      : Retardation factor
%
% Output:
% C [NtxNp] matrix where Nt is the number of time steps and Np is the points
% where we want to compute the breakthrough
%
% Example:
% Dm=1e-7;
% R=1;
% aL=1000;
% cf=1;
% lambda=0;
% x=1:100:10000;
% t=[0:200]*365;
% v=0.3;
% C=ADE1Danalytical(x,t,v,cf,aL,Dm,lambda,R)
%
% Version : 1.0
% Author : George Kourakos
% email: giorgk@gmail.com
% web : http://groundwater.ucdavis.edu/msim
% Date 18-Dec_2012
% Department of Land Air and Water
% University of California Davis
%

x=x(:);
t=t(:);
D=aL*v+Dm;
Nt=length(t);
Np=length(x);
C=zeros(Nt,Np);
if Nt>Np
    for i=1:Np
        if lambda==0
            C(:,i)=cf*(0.5*erfc((R*x(i)-v*t)./(2*sqrt(D*R*t)))+sqrt(v^2*t/(pi*D*R)).*exp(-(R*x(i)-v*t).^2./(4*D*R*t))- ...
                      0.5*(1+v*x(i)/D+v^2.*t/(D*R)).*exp(v*x(i)/D).*erfc((R*x(i)+v*t)./(2*sqrt(D*R*t))));
        else
            U=sqrt(v^2+4*D*R*lambda);
            C(:,i)=cf*(v/(v+U)*exp(x(i)*(v-U)/(2*D))*erfc((R*x(i)-U*t)./(2*sqrt(D*R*t)))+ ...
                       v/(v-U)*exp(x(i)*(v+U)/(2*D))*erfc((R*x(i)+U*t)./(2*sqrt(D*R*t)))+ ...
                       v^2/(2*D*R*lambda)*exp(v*x(i)/D-lambda*t).*erfc((R*x(i)+v*t)./(2*sqrt(D*R*t))));
        end
    end
else
    for i=1:Nt
        if lambda==0
            C(i,:)=cf*(0.5*erfc((R*x-v*t(i))./(2*sqrt(D*R*t(i))))+sqrt(v^2*t(i)./(pi*D*R)).*exp(-(R*x-v*t(i)).^2./(4*D*R*t(i)))- ...
                      0.5*(1+v*x/D+v^2.*t(i)/(D*R)).*exp(v*x/D).*erfc((R*x+v*t(i))./(2*sqrt(D*R*t(i)))));
        else
            U=sqrt(v^2+4*D*R*lambda);
            C(i,:)=cf*(v/(v+U)*exp(x*(v-U)/(2*D))*erfc((R*x-U*t(i))/(2*sqrt(D*R*t(i))))+ ...
                       v/(v-U)*exp(x*(v+U)/(2*D))*erfc((R*x+U*t(i))/(2*sqrt(D*R*t(i))))+ ...
                       v^2/(2*D*R*lambda)*exp(v*x/D-lambda*t(i))*erfc((R*x+v*t)/(2*sqrt(D*R*t(i)))));
        end
    end
end
