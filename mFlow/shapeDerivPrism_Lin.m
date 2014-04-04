function [B Jdet]=shapeDerivPrism_Lin(p,TRI,n)
% [B Jdet] = shapeDerivPrism_Lin(p, TRI, n)
%
% Computes the shape function derivatives and the determinant of the 
% jacobian matrix for linear prism elements.
% This function is used internally from shapeDerivatives.
% 
% Input
% p   : [Np x 3] Coodrinates of nodes [x1 y1 z1; x2 y2 z2;...xn yn zn]
%        Np : Number of nodes
%
% TRI : [Nel x Np_el] id of elements. Each row correspond to an element
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
% Date 18-Dec_2012
% Department of Land Air and Water
% University of California Davis
%
% N1=(1-xi-eta)*(1-zta)/2;
% N2=xi*(1-zta)/2;
% N3=eta*(1-zta)/2;
% N4=(1-xi-eta)*(1+zta)/2;
% N5=xi*(1+zta)/2;
% N6=eta*(1+zta)/2;
%
% B(:,1:6) are the derivative of shape function wtr to x, 
% B(:,7:12) are the derivative of shape function wrt to y
% B(:,13:18) are the derivative of shape function wrt to z
%
% Jdet is the determinant of the Jacobian of isoparametric transformation.
% Jdet is also the volume of each element
%
% shape functions of prisms
% N1=ksi*(1-zta)/2; N2=eta*(1-zta)/2; N3=(1-ksi-eta)*(1-zta)/2;
% N4=ksi*(1+zta)/2; N5=eta*(1+zta)/2; N6=(1-ksi-eta)*(1+zta)/2;
%
% see also shapeDerivatives

xi=n(1,1);
eta=n(1,2);
zta=n(1,3);
x1=p(TRI(:,1),1);y1=p(TRI(:,1),2);z1=p(TRI(:,1),3);
x2=p(TRI(:,2),1);y2=p(TRI(:,2),2);z2=p(TRI(:,2),3);
x3=p(TRI(:,3),1);y3=p(TRI(:,3),2);z3=p(TRI(:,3),3);
x4=p(TRI(:,4),1);y4=p(TRI(:,4),2);z4=p(TRI(:,4),3);
x5=p(TRI(:,5),1);y5=p(TRI(:,5),2);z5=p(TRI(:,5),3);
x6=p(TRI(:,6),1);y6=p(TRI(:,6),2);z6=p(TRI(:,6),3);

%Derivatives of shape functions with respect the parametric variables ksi,
%eta and zta
gn1 = 1/2 - zta/2;
gn2 = 0;
gn3 = zta/2 - 1/2;
gn4 = zta/2 + 1/2;
gn5 = 0;
gn6 = - zta/2 - 1/2;

gn7 = 0;
gn8 = 1/2 - zta/2;
gn9 = zta/2 - 1/2;
gn10 = 0;
gn11 = zta/2 + 1/2;
gn12 = - zta/2 - 1/2;

gn13 = -xi/2;
gn14 = -eta/2;
gn15 = eta/2 + xi/2 - 1/2;
gn16 = xi/2;
gn17 = eta/2;
gn18 = 1/2 - xi/2 - eta/2;

%Multiply the derivatives with element coordinates to obtain the elements 
%of Jacobian Matrix
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
if any(Jdet<0)
    warning('Some of the linear Prism Elements have negative Determinant')
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

B=[ gn1.*jinv1 + gn13.*jinv3 + gn7.*jinv2, gn14.*jinv3 + gn2.*jinv1 + gn8.*jinv2, gn15.*jinv3 + gn3.*jinv1 + gn3.*jinv2, gn10.*jinv2 + gn16.*jinv3 + gn4.*jinv1, gn11.*jinv2 + gn17.*jinv3 + gn5.*jinv1, gn12.*jinv2 + gn18.*jinv3 + gn6.*jinv1,...
    gn1.*jinv4 + gn13.*jinv6 + gn7.*jinv5, gn14.*jinv6 + gn2.*jinv4 + gn8.*jinv5, gn15.*jinv6 + gn3.*jinv4 + gn3.*jinv5, gn10.*jinv5 + gn16.*jinv6 + gn4.*jinv4, gn11.*jinv5 + gn17.*jinv6 + gn5.*jinv4, gn12.*jinv5 + gn18.*jinv6 + gn6.*jinv4,...
    gn1.*jinv7 + gn13.*jinv9 + gn7.*jinv8, gn14.*jinv9 + gn2.*jinv7 + gn8.*jinv8, gn15.*jinv9 + gn3.*jinv7 + gn3.*jinv8, gn10.*jinv8 + gn16.*jinv9 + gn4.*jinv7, gn11.*jinv8 + gn17.*jinv9 + gn5.*jinv7, gn12.*jinv8 + gn18.*jinv9 + gn6.*jinv7];



% syms xi eta zta
% N(1)=xi*(1-zta)/2;
% N(2)=eta*(1-zta)/2;
% N(3)=(1-xi-eta)*(1-zta)/2;
% N(4)=xi*(1+zta)/2;
% N(5)=eta*(1+zta)/2;
% N(6)=(1-xi-eta)*(1+zta)/2;
% 
% 
% 
% for i=1:6
%     B(i,1)=diff(N(i),xi);
%     B(i+6,1)=diff(N(i),eta);
%     B(i+2*6,1)=diff(N(i),zta);
% end
% 
% for i=1:18
%     fprintf(['gn' num2str(i) ' = ' char(B(i)) ';\n'])
% end
% % copy the text from the command window and paste it above
