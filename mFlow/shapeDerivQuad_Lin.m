function [B Jdet]=shapeDerivQuad_Lin(p,MSH,n,proj)
% [B Jdet] = shapeDerivQuad_Lin(p, MSH, n, proj)
%
% Computes the shape function derivatives and the determinant of the 
% jacobian matrix for quadrilateral linear elements.
% This function is used internally from shapeDerivatives.
% 
% Input
% p   : [Np x 3] Coodrinates of nodes [x1 y1 z1; x2 y2 z2;...xn yn zn]
%        Np : Number of nodes
%
% MSH : [Nel x Np_el] id of elements. Each row correspond to an element
%        Nel : Number of elements
%        Np_el : Number of nodes to define the element
% n   : the intergration point where the derivatives will be evaluated
%
% proj : if proj is true then the elements will be projected on the 2D
%         plane before computing the determinant 
%
% Output
% B    : Shape function derivatives
% Jdet : The determinant of the Jacobian Matrix 
%
% Version : 1.0
% Author : George Kourakos
% email: giorgk@gmail.com
% web : http://groundwater.ucdavis.edu/msim
% Date : 18-Dec_2012
% Department of Land Air and Water
% University of California Davis
%
% shape functions
% N1=0.25*(1-ksi)*(1-eta)
% N2=0.25*(1+ksi)*(1-eta)
% N3=0.25*(1+ksi)*(1+eta)
% N4=0.25*(1-ksi)*(1+eta)
%
% see also shapeDerivatives, mapElemto2D

ksi=n(1,1);
eta=n(1,2);
px=[p(MSH(:,1),1) p(MSH(:,2),1) p(MSH(:,3),1) p(MSH(:,4),1)];
py=[p(MSH(:,1),2) p(MSH(:,2),2) p(MSH(:,3),2) p(MSH(:,4),2)];
pz=[p(MSH(:,1),3) p(MSH(:,2),3) p(MSH(:,3),3) p(MSH(:,4),3)];

if proj==0
    x1=px(:,1);y1=py(:,1);
    x2=px(:,2);y2=py(:,2);
    x3=px(:,3);y3=py(:,3);
    x4=px(:,4);y4=py(:,4);
else
    [pxt pyt pzt]=mapElemto2D(px,py,pz);
    x1=pxt(:,1);y1=pyt(:,1);
    x2=pxt(:,2);y2=pyt(:,2);
    x3=pxt(:,3);y3=pyt(:,3);
    x4=pxt(:,4);y4=pyt(:,4);
end

% 
% x1=p(MSH(:,1),1);y1=p(MSH(:,1),2);
% x2=p(MSH(:,2),1);y2=p(MSH(:,2),2);
% x3=p(MSH(:,3),1);y3=p(MSH(:,3),2);
% x4=p(MSH(:,4),1);y4=p(MSH(:,4),2);

%Derivatives of shape functions wrt parametric variables ksi and eta
gn1=eta/4 - 1/4; gn2=1/4 - eta/4;  gn3=eta/4 + 1/4; gn4=- eta/4 - 1/4;
gn5=ksi/4 - 1/4; gn6=- ksi/4 - 1/4; gn7=ksi/4 + 1/4; gn8=1/4 - ksi/4;


%Multiply the derivatives with element coordinates to obtain the elements 
%of Jacobian Matrix

j1=gn1.*x1 + gn2.*x2 + gn3.*x3 + gn4.*x4;
j2=gn1.*y1 + gn2.*y2 + gn3.*y3 + gn4.*y4;
j3=gn5.*x1 + gn6.*x2 + gn7.*x3 + gn8.*x4;
j4=gn5.*y1 + gn6.*y2 + gn7.*y3 + gn8.*y4;

Jdet=j1.*j4-j2.*j3;
if any(Jdet<0)
    warning('Some of the quadratic Linear Elements have negative Determinant')
end

jinv1 =  j4./Jdet;
jinv2 = -j2./Jdet;
jinv3 = -j3./Jdet;
jinv4 =  j1./Jdet;

%Multiply the inverse Jacobian with the shape function derivatives

B=[gn1.*jinv1 + gn5.*jinv2, gn2.*jinv1 + gn6.*jinv2, gn3.*jinv1 + gn7.*jinv2, gn4.*jinv1 + gn8.*jinv2 ...
   gn1.*jinv3 + gn5.*jinv4, gn2.*jinv3 + gn6.*jinv4, gn3.*jinv3 + gn7.*jinv4, gn4.*jinv3 + gn8.*jinv4];
 
