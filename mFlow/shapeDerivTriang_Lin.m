function [B Jdet]=shapeDerivTriang_Lin(p,MSH,n,proj)
% [B Jdet]=shapeDerivTriang_Lin(p, MSH, n, proj)
%
% Computes the shape function derivatives and the determinant of the 
% jacobian matrix for linear triangle elements.
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
% N1=ksi;
% N2=eta;
% N3=1-ksi-eta
%
% see also shapeDerivatives, mapElemto2D

ksi=n(1,1);
eta=n(1,2);

px=[p(MSH(:,1),1) p(MSH(:,2),1) p(MSH(:,3),1)];
py=[p(MSH(:,1),2) p(MSH(:,2),2) p(MSH(:,3),2)];
pz=[p(MSH(:,1),3) p(MSH(:,2),3) p(MSH(:,3),3)];
if proj==0
    x1=p(MSH(:,1),1);y1=p(MSH(:,1),2);
    x2=p(MSH(:,2),1);y2=p(MSH(:,2),2);
    x3=p(MSH(:,3),1);y3=p(MSH(:,3),2);
else
    [pxt pyt pzt]=mapElemto2D(px,py,pz);
    x1=pxt(:,1);y1=pyt(:,1);
    x2=pxt(:,2);y2=pyt(:,2);
    x3=pxt(:,3);y3=pyt(:,3);
end

%Derivatives of shape functions with respect the parametric variables ksi
%and eta
gn1=1; gn2=0; gn3=-1;
gn4=0; gn5=1; gn6=-1;

%Multiply the derivatives with element coordinates to obtain the elements 
%of Jacobian Matrix
j1 = gn1.*x1 + gn2.*x2 + gn3.*x3;
j2 = gn1.*y1 + gn2.*y2 + gn3.*y3;
j3 = gn4.*x1 + gn5.*x2 + gn6.*x3;
j4 = gn4.*y1 + gn5.*y2 + gn6.*y3;

Jdet=(j1.*j4-j2.*j3);
if any(Jdet<0)
    warning('Some of the linear triangular Elements have negative Determinant')
end

%for triangles the area of the canonical element is 1/2

% jinv1 =  j4./Jdet;
% jinv2 = -j2./Jdet;
% jinv3 = -j3./Jdet;
% jinv4 =  j1./Jdet;

%Multiply the inverse Jacobian with the shapw function derivatives

% B=[gn1.*jinv1 + gn4.*jinv2, gn2.*jinv1 + gn5.*jinv2, gn3.*jinv1 + gn6.*jinv2 ...
%    gn1.*jinv3 + gn4.*jinv4, gn2.*jinv3 + gn5.*jinv4, gn3.*jinv3 + gn6.*jinv4];
 
% for linear triangular elements we can use the real coordinates
B=[(y2-y3)./Jdet (y3-y1)./Jdet (y1-y2)./Jdet ...
    (x3-x2)./Jdet (x1-x3)./Jdet (x2-x1)./Jdet];

%for triangular elements we have to multiply not with the jacobian but the
%area of the triangle which is Jdet/2
Jdet=Jdet/2; 



