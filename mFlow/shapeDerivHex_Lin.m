function [B Jdet]=shapeDerivHex_Lin(p,MSH,n)
% [B Jdet]=shapeDerivHex_Lin(p, MSH, n)
%
% Computes the shape function derivatives and the determinant of the 
% jacobian matrix for hexahedral linear elements.
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
%
% Shape functions of 8 node hexahedral element
% N1=0.125*(1-ksi)*(1-eta)*(1-zta); N2=0.125*(1+ksi)*(1-eta)*(1-zta);
% N3=0.125*(1+ksi)*(1+eta)*(1-zta); N4=0.125*(1-ksi)*(1+eta)*(1-zta);
% N5=0.125*(1-ksi)*(1-eta)*(1+zta); N6=0.125*(1+ksi)*(1-eta)*(1+zta);
% N7=0.125*(1+ksi)*(1+eta)*(1+zta); N8=0.125*(1-ksi)*(1+eta)*(1+zta);
%
% see also shapeDerivatives

ksi=n(1,1);
eta=n(1,2);
zta=n(1,3);
x1=p(MSH(:,1),1);y1=p(MSH(:,1),2);z1=p(MSH(:,1),3);
x2=p(MSH(:,2),1);y2=p(MSH(:,2),2);z2=p(MSH(:,2),3);
x3=p(MSH(:,3),1);y3=p(MSH(:,3),2);z3=p(MSH(:,3),3);
x4=p(MSH(:,4),1);y4=p(MSH(:,4),2);z4=p(MSH(:,4),3);
x5=p(MSH(:,5),1);y5=p(MSH(:,5),2);z5=p(MSH(:,5),3);
x6=p(MSH(:,6),1);y6=p(MSH(:,6),2);z6=p(MSH(:,6),3);
x7=p(MSH(:,7),1);y7=p(MSH(:,7),2);z7=p(MSH(:,7),3);
x8=p(MSH(:,8),1);y8=p(MSH(:,8),2);z8=p(MSH(:,8),3);

%Derivatives of shape functions wrt ksi eta and zta
gn1=-((eta - 1)*(zta - 1))/8;  gn2=((eta - 1)*(zta - 1))/8; gn3=-((eta + 1)*(zta - 1))/8; gn4=((eta + 1)*(zta - 1))/8; 
gn5=((eta - 1)*(zta + 1))/8; gn6=-((eta - 1)*(zta + 1))/8; gn7=((eta + 1)*(zta + 1))/8; gn8=-((eta + 1)*(zta + 1))/8;
gn9=-((ksi - 1)*(zta - 1))/8;  gn10=((ksi + 1)*(zta - 1))/8; gn11=-((ksi + 1)*(zta - 1))/8; gn12=((ksi - 1)*(zta - 1))/8;
gn13=((ksi - 1)*(zta + 1))/8; gn14=-((ksi + 1)*(zta + 1))/8; gn15=((ksi + 1)*(zta + 1))/8; gn16=-((ksi - 1)*(zta + 1))/8;
gn17=-((eta - 1)*(ksi - 1))/8; gn18=((eta - 1)*(ksi + 1))/8; gn19=-((eta + 1)*(ksi + 1))/8; gn20=((eta + 1)*(ksi - 1))/8;
gn21=((eta - 1)*(ksi - 1))/8; gn22=-((eta - 1)*(ksi + 1))/8; gn23=((eta + 1)*(ksi + 1))/8; gn24=-((eta + 1)*(ksi - 1))/8;


%Multiply the derivatives with element coordinates to obtain the elements 
%of Jacobian Matrix
j1=gn1*x1 + gn2*x2 + gn3*x3 + gn4*x4 + gn5*x5 + gn6*x6 + gn7*x7 + gn8*x8;
j2=gn1*y1 + gn2*y2 + gn3*y3 + gn4*y4 + gn5*y5 + gn6*y6 + gn7*y7 + gn8*y8;
j3=gn1*z1 + gn2*z2 + gn3*z3 + gn4*z4 + gn5*z5 + gn6*z6 + gn7*z7 + gn8*z8;
j4=gn9*x1 + gn10*x2 + gn11*x3 + gn12*x4 + gn13*x5 + gn14*x6 + gn15*x7 + gn16*x8;
j5=gn9*y1 + gn10*y2 + gn11*y3 + gn12*y4 + gn13*y5 + gn14*y6 + gn15*y7 + gn16*y8;
j6=gn9*z1 + gn10*z2 + gn11*z3 + gn12*z4 + gn13*z5 + gn14*z6 + gn15*z7 + gn16*z8;
j7=gn17*x1 + gn18*x2 + gn19*x3 + gn20*x4 + gn21*x5 + gn22*x6 + gn23*x7 + gn24*x8;
j8=gn17*y1 + gn18*y2 + gn19*y3 + gn20*y4 + gn21*y5 + gn22*y6 + gn23*y7 + gn24*y8;
j9=gn17*z1 + gn18*z2 + gn19*z3 + gn20*z4 + gn21*z5 + gn22*z6 + gn23*z7 + gn24*z8;

Jdet=(j1.*j5.*j9 - j1.*j6.*j8 - j2.*j4.*j9 + j2.*j6.*j7 + j3.*j4.*j8 - j3.*j5.*j7);
if any(Jdet<0)
    warning('Some of the linear Hexahedral elements have negative Determinant')
end

jinv1=(j5.*j9 - j6.*j8)./Jdet;
jinv2=-(j2.*j9 - j3.*j8)./Jdet;
jinv3=(j2.*j6 - j3.*j5)./Jdet; 
jinv4= -(j4.*j9 - j6.*j7)./Jdet;
jinv5= (j1.*j9 - j3.*j7)./Jdet;
jinv6= -(j1.*j6 - j3.*j4)./Jdet;
jinv7= (j4.*j8 - j5.*j7)./Jdet;
jinv8= -(j1.*j8 - j2.*j7)./Jdet;
jinv9=(j1.*j5 - j2.*j4)./Jdet;

B=[gn1*jinv1 + gn9*jinv2 + gn17*jinv3, gn2*jinv1 + gn10*jinv2 + gn18*jinv3, gn3*jinv1 + gn11*jinv2 + gn19*jinv3, gn4*jinv1 + gn12*jinv2 + gn20*jinv3, gn5*jinv1 + gn13*jinv2 + gn21*jinv3, gn6*jinv1 + gn14*jinv2 + gn22*jinv3, gn7*jinv1 + gn15*jinv2 + gn23*jinv3, gn8*jinv1 + gn16*jinv2 + gn24*jinv3 ...
   gn1*jinv4 + gn9*jinv5 + gn17*jinv6, gn2*jinv4 + gn10*jinv5 + gn18*jinv6, gn3*jinv4 + gn11*jinv5 + gn19*jinv6, gn4*jinv4 + gn12*jinv5 + gn20*jinv6, gn5*jinv4 + gn13*jinv5 + gn21*jinv6, gn6*jinv4 + gn14*jinv5 + gn22*jinv6, gn7*jinv4 + gn15*jinv5 + gn23*jinv6, gn8*jinv4 + gn16*jinv5 + gn24*jinv6 ...
   gn1*jinv7 + gn9*jinv8 + gn17*jinv9, gn2*jinv7 + gn10*jinv8 + gn18*jinv9, gn3*jinv7 + gn11*jinv8 + gn19*jinv9, gn4*jinv7 + gn12*jinv8 + gn20*jinv9, gn5*jinv7 + gn13*jinv8 + gn21*jinv9, gn6*jinv7 + gn14*jinv8 + gn22*jinv9, gn7*jinv7 + gn15*jinv8 + gn23*jinv9, gn8*jinv7 + gn16*jinv8 + gn24*jinv9];
 
 