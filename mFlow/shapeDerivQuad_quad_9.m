function [B Jdet]=shapeDerivQuad_quad_9(p,MSH,n,proj)
% [B Jdet] = shapeDerivQuad_quad_9(p, MSH, n, proj)
%
% Computes the shape function derivatives and the determinant of the 
% jacobian matrix for quadratic quadrilateral elements.
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
% shape functions for 9 node quadratic quadrilaterals
% N1=0.25*(xi-1)*(eta-1)*xi*eta; N2=0.25*(xi+1)*(eta-1)*xi*eta;
% N3=0.25*(xi+1)*(eta+1)*xi*eta; N4=0.25*(xi-1)*(eta+1)*xi*eta;
% N5=-0.5*(xi^2-1)*(eta-1)*eta;  N6=-0.5*(xi+1)*(eta^2-1)*xi;
% N7=-0.5*(xi^2-1)*(eta+1)*eta;  N8=-0.5*(xi-1)*(eta^2-1)*xi;
% N9=(xi^2-1)*(eta^2-1);
%
% see also shapeDerivatives, mapElemto2D

xi=n(1,1);
eta=n(1,2);

px=[p(MSH(:,1),1) p(MSH(:,2),1) p(MSH(:,3),1) p(MSH(:,4),1) p(MSH(:,5),1)...
    p(MSH(:,6),1) p(MSH(:,7),1) p(MSH(:,8),1) p(MSH(:,9),1)];
py=[p(MSH(:,1),2) p(MSH(:,2),2) p(MSH(:,3),2) p(MSH(:,4),2) p(MSH(:,5),2) ...
    p(MSH(:,6),2) p(MSH(:,7),2) p(MSH(:,8),2) p(MSH(:,9),2)];
pz=[p(MSH(:,1),3) p(MSH(:,2),3) p(MSH(:,3),3) p(MSH(:,4),3) p(MSH(:,5),3) ...
    p(MSH(:,6),3) p(MSH(:,7),3) p(MSH(:,8),3) p(MSH(:,9),3)];
if proj==0
    x1=px(:,1);y1=py(:,1);
    x2=px(:,2);y2=py(:,2);
    x3=px(:,3);y3=py(:,3);
    x4=px(:,4);y4=py(:,4);
    x5=px(:,5);y5=py(:,5);
    x6=px(:,6);y6=py(:,6);
    x7=px(:,7);y7=py(:,7);
    x8=px(:,8);y8=py(:,8);
    x9=px(:,9);y9=py(:,9);
else
    [pxt pyt pzt]=mapElemto2D(px(:,1:4),py(:,1:4),pz(:,1:4));
    x1=pxt(:,1);y1=pyt(:,1);
    x2=pxt(:,2);y2=pyt(:,2);
    x3=pxt(:,3);y3=pyt(:,3);
    x4=pxt(:,4);y4=pyt(:,4);
    x5=(x1+x2)/2;y5=(y1+y2)/2;
    x6=(x2+x3)/2;y6=(y2+y3)/2;
    x7=(x3+x4)/2;y7=(y3+y4)/2;
    x8=(x4+x1)/2;y8=(y4+y1)/2;
    x9=(x5+x7)/2;y9=(y5+y7)/2;
end
    

% x1=p(MSH(:,1),1);y1=p(MSH(:,1),2);
% x2=p(MSH(:,2),1);y2=p(MSH(:,2),2);
% x3=p(MSH(:,3),1);y3=p(MSH(:,3),2);
% x4=p(MSH(:,4),1);y4=p(MSH(:,4),2);
% x5=p(MSH(:,5),1);y5=p(MSH(:,5),2);
% x6=p(MSH(:,6),1);y6=p(MSH(:,6),2);
% x7=p(MSH(:,7),1);y7=p(MSH(:,7),2);
% x8=p(MSH(:,8),1);y8=p(MSH(:,8),2);
% x9=p(MSH(:,9),1);y9=p(MSH(:,9),2);

%Derivatives of shape functions wrt parametric variables xi and eta
gn1=(eta*(2*xi - 1)*(eta - 1))/4;  gn2=(eta*(2*xi + 1)*(eta - 1))/4;  gn3=(eta*(2*xi + 1)*(eta + 1))/4;
gn4=(eta*(2*xi - 1)*(eta + 1))/4;  gn5=-eta*xi*(eta - 1);             gn6=-((eta^2 - 1)*(2*xi + 1))/2;
gn7=-eta*xi*(eta + 1);             gn8=-((eta^2 - 1)*(2*xi - 1))/2;   gn9=2*xi*(eta^2 - 1);
gn10=(xi*(2*eta - 1)*(xi - 1))/4;  gn11=(xi*(2*eta - 1)*(xi + 1))/4;  gn12=(xi*(2*eta + 1)*(xi + 1))/4;
gn13=(xi*(2*eta + 1)*(xi - 1))/4;  gn14=-((2*eta - 1)*(xi^2 - 1))/2;  gn15=-eta*xi*(xi + 1);
gn16=-((2*eta + 1)*(xi^2 - 1))/2;  gn17=-eta*xi*(xi - 1);             gn18=2*eta*(xi^2 - 1);

j1=gn1.*x1 + gn2.*x2 + gn3.*x3 + gn4.*x4 + gn5.*x5 + gn6.*x6 + gn7.*x7 + gn8.*x8 + gn9.*x9;
j2=gn1.*y1 + gn2.*y2 + gn3.*y3 + gn4.*y4 + gn5.*y5 + gn6.*y6 + gn7.*y7 + gn8.*y8 + gn9.*y9;
j3=gn10.*x1 + gn11.*x2 + gn12.*x3 + gn13.*x4 + gn14.*x5 + gn15.*x6 + gn16.*x7 + gn17.*x8 + gn18.*x9;
j4=gn10.*y1 + gn11.*y2 + gn12.*y3 + gn13.*y4 + gn14.*y5 + gn15.*y6 + gn16.*y7 + gn17.*y8 + gn18.*y9;

Jdet=j1.*j4-j2.*j3;
if any(Jdet<0)
    warning('Some of the quadratic Quadrilateral Elements have negative Determinant')
end

jinv1 =  j4./Jdet;
jinv2 = -j2./Jdet;
jinv3 = -j3./Jdet;
jinv4 =  j1./Jdet;

B=[gn1.*jinv1 + gn10.*jinv2, gn2.*jinv1 + gn11.*jinv2, gn3.*jinv1 + gn12.*jinv2, gn4.*jinv1 + gn13.*jinv2, gn5.*jinv1 + gn14.*jinv2, gn6.*jinv1 + gn15.*jinv2, gn7.*jinv1 + gn16.*jinv2, gn8.*jinv1 + gn17.*jinv2, gn9.*jinv1 + gn18.*jinv2,...
   gn1.*jinv3 + gn10.*jinv4, gn2.*jinv3 + gn11.*jinv4, gn3.*jinv3 + gn12.*jinv4, gn4.*jinv3 + gn13.*jinv4, gn5.*jinv3 + gn14.*jinv4, gn6.*jinv3 + gn15.*jinv4, gn7.*jinv3 + gn16.*jinv4, gn8.*jinv3 + gn17.*jinv4, gn9.*jinv3 + gn18.*jinv4];
 

 

