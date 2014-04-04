function [B Jdet]=shapeDerivTriang_quad(p,MSH,n,proj)
% [B Jdet]=shapeDerivQuad_Lin(p, MSH, n, proj)
%
% Computes the shape function derivatives and the determinant of the 
% jacobian matrix for quadratic triangle elements.
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
% shape functions of quadratic triangles
% N1=ksi*(2*ksi-1); N2=eta*(2*eta-1); N3=(1-ksi-eta)*(2*(1-ksi-eta)-1);
% N4=4*ksi*eta; N5=4*eta*(1-ksi-eta); N6=4*(1-ksi-eta)*ksi; 
%
% see also shapeDerivatives

ksi=n(1,1);
eta=n(1,2);

px=[p(MSH(:,1),1) p(MSH(:,2),1) p(MSH(:,3),1) p(MSH(:,4),1) p(MSH(:,5),1) p(MSH(:,6),1)];
py=[p(MSH(:,1),2) p(MSH(:,2),2) p(MSH(:,3),2) p(MSH(:,4),2) p(MSH(:,5),2) p(MSH(:,6),2)];
pz=[p(MSH(:,1),3) p(MSH(:,2),3) p(MSH(:,3),3) p(MSH(:,4),3) p(MSH(:,5),3) p(MSH(:,6),3)];

if proj==0
    x1=p(MSH(:,1),1);y1=p(MSH(:,1),2);
    x2=p(MSH(:,2),1);y2=p(MSH(:,2),2);
    x3=p(MSH(:,3),1);y3=p(MSH(:,3),2);
    x4=p(MSH(:,4),1);y4=p(MSH(:,4),2);
    x5=p(MSH(:,5),1);y5=p(MSH(:,5),2);
    x6=p(MSH(:,6),1);y6=p(MSH(:,6),2);
else
    [pxt pyt pzt]=mapElemto2D(px(:,1:3),py(:,1:3),pz(:,1:3));
    x1=pxt(:,1);y1=pyt(:,1);
    x2=pxt(:,2);y2=pyt(:,2);
    x3=pxt(:,3);y3=pyt(:,3);
    x4=(x1+x2)/2;y4=(y1+y2)/2;
    x5=(x2+x3)/2;y5=(y2+y3)/2;
    x6=(x3+x1)/2;y6=(y3+y1)/2;
end


%Derivatives of shape functions wrt parametric variables ksi and eta
gn1=4*ksi - 1; gn2=0; gn3=4*eta + 4*ksi - 3; gn4=4*eta; gn5=-4*eta; gn6=4 - 8*ksi - 4*eta;
gn7=0; gn8=4*eta - 1; gn9=4*eta + 4*ksi - 3; gn10=4*ksi; gn11=4 - 4*ksi - 8*eta; gn12=-4*ksi;


%Multiply the derivatives with element coordinates to obtain the elements 
%of Jacobian Matrix

j1=gn1.*x1 + gn2.*x2 + gn3.*x3 + gn4.*x4 + gn5.*x5 + gn6.*x6;
j2=gn1.*y1 + gn2.*y2 + gn3.*y3 + gn4.*y4 + gn5.*y5 + gn6.*y6;
j3=gn7.*x1 + gn8.*x2 + gn9.*x3 + gn10.*x4 + gn11.*x5 + gn12.*x6;
j4=gn7.*y1 + gn8.*y2 + gn9.*y3 + gn10.*y4 + gn11.*y5 + gn12.*y6;
 
Jdet=j1.*j4-j2.*j3;
if any(Jdet<0)
    warning('Some of the quadratic triangular Elements have negative Determinant')
end

jinv1 =  j4./Jdet;
jinv2 = -j2./Jdet;
jinv3 = -j3./Jdet;
jinv4 =  j1./Jdet;

B=[gn1.*jinv1 + gn7.*jinv2, gn2.*jinv1 + gn8.*jinv2, gn3.*jinv1 + gn9.*jinv2, gn4.*jinv1 + gn10.*jinv2, gn5.*jinv1 + gn11.*jinv2, gn6.*jinv1 + gn12.*jinv2,...
   gn1.*jinv3 + gn7.*jinv4, gn2.*jinv3 + gn8.*jinv4, gn3.*jinv3 + gn9.*jinv4, gn4.*jinv3 + gn10.*jinv4, gn5.*jinv3 + gn11.*jinv4, gn6.*jinv3 + gn12.*jinv4];
 
Jdet=Jdet/2; 