function [B Jdet]=shapeDerivPrism_quad(p,MSH,n)
% [B Jdet]=shapeDerivPrism_quad(p, MSH, n)
%
% Computes the shape function derivatives and the determinant of the 
% jacobian matrix for quadratic prism elements.
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
% N(1) = (xi*zta*(2*xi - 1)*(zta - 1))/2;
% N(2) = (eta*zta*(2*eta - 1)*(zta - 1))/2;
% N(3) = (zta*(zta - 1)*(eta + xi - 1)*(2*eta + 2*xi - 1))/2;
% N(4) = (xi*zta*(2*xi - 1)*(zta + 1))/2;
% N(5) = (eta*zta*(2*eta - 1)*(zta + 1))/2;
% N(6) = (zta*(zta + 1)*(eta + xi - 1)*(2*eta + 2*xi - 1))/2;
% N(7) = 2*eta*xi*zta*(zta - 1);
% N(8) = -2*eta*zta*(zta - 1)*(eta + xi - 1);
% N(9) = -(xi*zta*(zta - 1)*(4*eta + 4*xi - 4))/2;
% N(10) = 2*eta*xi*zta*(zta + 1);
% N(11) = -2*eta*zta*(zta + 1)*(eta + xi - 1);
% N(12) = -(xi*zta*(zta + 1)*(4*eta + 4*xi - 4))/2;
% N(13) = -xi*(2*xi - 1)*(zta^2 - 1);
% N(14) = -eta*(2*eta - 1)*(zta^2 - 1);
% N(15) = -(zta^2 - 1)*(eta + xi - 1)*(2*eta + 2*xi - 1);
% N(16) = -4*eta*xi*(zta^2 - 1);
% N(17) = 4*eta*(zta^2 - 1)*(eta + xi - 1);
% N(18) = xi*(zta^2 - 1)*(4*eta + 4*xi - 4);
%
% see also shapeDerivatives

xi=n(1,1);
eta=n(1,2);
zta=n(1,3);

x1 =p(MSH(:,1),1); y1 =p(MSH(:,1),2); z1 =p(MSH(:,1),3);
x2 =p(MSH(:,2),1); y2 =p(MSH(:,2),2); z2 =p(MSH(:,2),3);
x3 =p(MSH(:,3),1); y3 =p(MSH(:,3),2); z3 =p(MSH(:,3),3);
x4 =p(MSH(:,4),1); y4 =p(MSH(:,4),2); z4 =p(MSH(:,4),3);
x5 =p(MSH(:,5),1); y5 =p(MSH(:,5),2); z5 =p(MSH(:,5),3);
x6 =p(MSH(:,6),1); y6 =p(MSH(:,6),2); z6 =p(MSH(:,6),3);
x7 =p(MSH(:,7),1); y7 =p(MSH(:,7),2); z7 =p(MSH(:,7),3);
x8 =p(MSH(:,8),1); y8 =p(MSH(:,8),2); z8 =p(MSH(:,8),3);
x9 =p(MSH(:,9),1); y9 =p(MSH(:,9),2); z9 =p(MSH(:,9),3);
x10=p(MSH(:,10),1);y10=p(MSH(:,10),2);z10=p(MSH(:,10),3);
x11=p(MSH(:,11),1);y11=p(MSH(:,11),2);z11=p(MSH(:,11),3);
x12=p(MSH(:,12),1);y12=p(MSH(:,12),2);z12=p(MSH(:,12),3);
x13=p(MSH(:,13),1);y13=p(MSH(:,13),2);z13=p(MSH(:,13),3);
x14=p(MSH(:,14),1);y14=p(MSH(:,14),2);z14=p(MSH(:,14),3);
x15=p(MSH(:,15),1);y15=p(MSH(:,15),2);z15=p(MSH(:,15),3);
x16=p(MSH(:,16),1);y16=p(MSH(:,16),2);z16=p(MSH(:,16),3);
x17=p(MSH(:,17),1);y17=p(MSH(:,17),2);z17=p(MSH(:,17),3);
x18=p(MSH(:,18),1);y18=p(MSH(:,18),2);z18=p(MSH(:,18),3);

gn1 = xi*zta*(zta - 1) + (zta*(2*xi - 1)*(zta - 1))/2;
gn2 = 0;
gn3 = (zta*(zta - 1)*(2*eta + 2*xi - 1))/2 + zta*(zta - 1)*(eta + xi - 1);
gn4 = xi*zta*(zta + 1) + (zta*(2*xi - 1)*(zta + 1))/2;
gn5 = 0;
gn6 = (zta*(zta + 1)*(2*eta + 2*xi - 1))/2 + zta*(zta + 1)*(eta + xi - 1);
gn7 = 2*eta*zta*(zta - 1);
gn8 = -2*eta*zta*(zta - 1);
gn9 = - 2*xi*zta*(zta - 1) - (zta*(zta - 1)*(4*eta + 4*xi - 4))/2;
gn10 = 2*eta*zta*(zta + 1);
gn11 = -2*eta*zta*(zta + 1);
gn12 = - 2*xi*zta*(zta + 1) - (zta*(zta + 1)*(4*eta + 4*xi - 4))/2;
gn13 = - 2*xi*(zta^2 - 1) - (2*xi - 1)*(zta^2 - 1);
gn14 = 0;
gn15 = - (zta^2 - 1)*(2*eta + 2*xi - 1) - 2*(zta^2 - 1)*(eta + xi - 1);
gn16 = -4*eta*(zta^2 - 1);
gn17 = 4*eta*(zta^2 - 1);
gn18 = 4*xi*(zta^2 - 1) + (zta^2 - 1)*(4*eta + 4*xi - 4);
gn19 = 0;
gn20 = eta*zta*(zta - 1) + (zta*(2*eta - 1)*(zta - 1))/2;
gn21 = (zta*(zta - 1)*(2*eta + 2*xi - 1))/2 + zta*(zta - 1)*(eta + xi - 1);
gn22 = 0;
gn23 = eta*zta*(zta + 1) + (zta*(2*eta - 1)*(zta + 1))/2;
gn24 = (zta*(zta + 1)*(2*eta + 2*xi - 1))/2 + zta*(zta + 1)*(eta + xi - 1);
gn25 = 2*xi*zta*(zta - 1);
gn26 = - 2*eta*zta*(zta - 1) - 2*zta*(zta - 1)*(eta + xi - 1);
gn27 = -2*xi*zta*(zta - 1);
gn28 = 2*xi*zta*(zta + 1);
gn29 = - 2*eta*zta*(zta + 1) - 2*zta*(zta + 1)*(eta + xi - 1);
gn30 = -2*xi*zta*(zta + 1);
gn31 = 0;
gn32 = - (2*eta - 1)*(zta^2 - 1) - 2*eta*(zta^2 - 1);
gn33 = - (zta^2 - 1)*(2*eta + 2*xi - 1) - 2*(zta^2 - 1)*(eta + xi - 1);
gn34 = -4*xi*(zta^2 - 1);
gn35 = 4*(zta^2 - 1)*(eta + xi - 1) + 4*eta*(zta^2 - 1);
gn36 = 4*xi*(zta^2 - 1);
gn37 = (xi*zta*(2*xi - 1))/2 + (xi*(2*xi - 1)*(zta - 1))/2;
gn38 = (eta*zta*(2*eta - 1))/2 + (eta*(2*eta - 1)*(zta - 1))/2;
gn39 = (zta*(eta + xi - 1)*(2*eta + 2*xi - 1))/2 + ((zta - 1)*(eta + xi - 1)*(2*eta + 2*xi - 1))/2;
gn40 = (xi*zta*(2*xi - 1))/2 + (xi*(2*xi - 1)*(zta + 1))/2;
gn41 = (eta*zta*(2*eta - 1))/2 + (eta*(2*eta - 1)*(zta + 1))/2;
gn42 = (zta*(eta + xi - 1)*(2*eta + 2*xi - 1))/2 + ((zta + 1)*(eta + xi - 1)*(2*eta + 2*xi - 1))/2;
gn43 = 2*eta*xi*(zta - 1) + 2*eta*xi*zta;
gn44 = - 2*eta*zta*(eta + xi - 1) - 2*eta*(zta - 1)*(eta + xi - 1);
gn45 = - (xi*zta*(4*eta + 4*xi - 4))/2 - (xi*(zta - 1)*(4*eta + 4*xi - 4))/2;
gn46 = 2*eta*xi*(zta + 1) + 2*eta*xi*zta;
gn47 = - 2*eta*zta*(eta + xi - 1) - 2*eta*(zta + 1)*(eta + xi - 1);
gn48 = - (xi*zta*(4*eta + 4*xi - 4))/2 - (xi*(zta + 1)*(4*eta + 4*xi - 4))/2;
gn49 = -2*xi*zta*(2*xi - 1);
gn50 = -2*eta*zta*(2*eta - 1);
gn51 = -2*zta*(eta + xi - 1)*(2*eta + 2*xi - 1);
gn52 = -8*eta*xi*zta;
gn53 = 8*eta*zta*(eta + xi - 1);
gn54 = 2*xi*zta*(4*eta + 4*xi - 4);


%Multiply the derivatives with element coordinates to obtain the elements 
%of Jacobian Matrix
j1= gn1*x1 + gn2*x2 + gn3*x3 + gn4*x4 + gn5*x5 + gn6*x6 + gn7*x7 + gn8*x8 + gn9*x9 + gn10*x10 + gn11*x11 + gn12*x12 + gn13*x13 + gn14*x14 + gn15*x15 + gn16*x16 + gn17*x17 + gn18*x18;
j2= gn1*y1 + gn2*y2 + gn3*y3 + gn4*y4 + gn5*y5 + gn6*y6 + gn7*y7 + gn8*y8 + gn9*y9 + gn10*y10 + gn11*y11 + gn12*y12 + gn13*y13 + gn14*y14 + gn15*y15 + gn16*y16 + gn17*y17 + gn18*y18;
j3= gn1*z1 + gn2*z2 + gn3*z3 + gn4*z4 + gn5*z5 + gn6*z6 + gn7*z7 + gn8*z8 + gn9*z9 + gn10*z10 + gn11*z11 + gn12*z12 + gn13*z13 + gn14*z14 + gn15*z15 + gn16*z16 + gn17*z17 + gn18*z18;
j4= gn19*x1 + gn20*x2 + gn21*x3 + gn22*x4 + gn23*x5 + gn24*x6 + gn25*x7 + gn26*x8 + gn27*x9 + gn28*x10 + gn29*x11 + gn30*x12 + gn31*x13 + gn32*x14 + gn33*x15 + gn34*x16 + gn35*x17 + gn36*x18;
j5= gn19*y1 + gn20*y2 + gn21*y3 + gn22*y4 + gn23*y5 + gn24*y6 + gn25*y7 + gn26*y8 + gn27*y9 + gn28*y10 + gn29*y11 + gn30*y12 + gn31*y13 + gn32*y14 + gn33*y15 + gn34*y16 + gn35*y17 + gn36*y18;
j6= gn19*z1 + gn20*z2 + gn21*z3 + gn22*z4 + gn23*z5 + gn24*z6 + gn25*z7 + gn26*z8 + gn27*z9 + gn28*z10 + gn29*z11 + gn30*z12 + gn31*z13 + gn32*z14 + gn33*z15 + gn34*z16 + gn35*z17 + gn36*z18;
j7= gn37*x1 + gn38*x2 + gn39*x3 + gn40*x4 + gn41*x5 + gn42*x6 + gn43*x7 + gn44*x8 + gn45*x9 + gn46*x10 + gn47*x11 + gn48*x12 + gn49*x13 + gn50*x14 + gn51*x15 + gn52*x16 + gn53*x17 + gn54*x18;
j8= gn37*y1 + gn38*y2 + gn39*y3 + gn40*y4 + gn41*y5 + gn42*y6 + gn43*y7 + gn44*y8 + gn45*y9 + gn46*y10 + gn47*y11 + gn48*y12 + gn49*y13 + gn50*y14 + gn51*y15 + gn52*y16 + gn53*y17 + gn54*y18;
j9= gn37*z1 + gn38*z2 + gn39*z3 + gn40*z4 + gn41*z5 + gn42*z6 + gn43*z7 + gn44*z8 + gn45*z9 + gn46*z10 + gn47*z11 + gn48*z12 + gn49*z13 + gn50*z14 + gn51*z15 + gn52*z16 + gn53*z17 + gn54*z18;
 
Jdet=(j1.*j5.*j9 - j1.*j6.*j8 - j2.*j4.*j9 + j2.*j6.*j7 + j3.*j4.*j8 - j3.*j5.*j7);
if any(Jdet<0)
    warning('Some of the quadratic Hexahedral Elements have negative Determinant')
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

B=[gn1*jinv1 + gn19*jinv2 + gn37*jinv3, gn2*jinv1 + gn20*jinv2 + gn38*jinv3, gn3*jinv1 + gn21*jinv2 + gn39*jinv3, gn4*jinv1 + gn22*jinv2 + gn40*jinv3, gn5*jinv1 + gn23*jinv2 + gn41*jinv3, gn6*jinv1 + gn24*jinv2 + gn42*jinv3, gn7*jinv1 + gn25*jinv2 + gn43*jinv3, gn8*jinv1 + gn26*jinv2 + gn44*jinv3, gn9*jinv1 + gn27*jinv2 + gn45*jinv3, gn10*jinv1 + gn28*jinv2 + gn46*jinv3, gn11*jinv1 + gn29*jinv2 + gn47*jinv3, gn12*jinv1 + gn30*jinv2 + gn48*jinv3, gn13*jinv1 + gn31*jinv2 + gn49*jinv3, gn14*jinv1 + gn32*jinv2 + gn50*jinv3, gn15*jinv1 + gn33*jinv2 + gn51*jinv3, gn16*jinv1 + gn34*jinv2 + gn52*jinv3, gn17*jinv1 + gn35*jinv2 + gn53*jinv3, gn18*jinv1 + gn36*jinv2 + gn54*jinv3,...
   gn1*jinv4 + gn19*jinv5 + gn37*jinv6, gn2*jinv4 + gn20*jinv5 + gn38*jinv6, gn3*jinv4 + gn21*jinv5 + gn39*jinv6, gn4*jinv4 + gn22*jinv5 + gn40*jinv6, gn5*jinv4 + gn23*jinv5 + gn41*jinv6, gn6*jinv4 + gn24*jinv5 + gn42*jinv6, gn7*jinv4 + gn25*jinv5 + gn43*jinv6, gn8*jinv4 + gn26*jinv5 + gn44*jinv6, gn9*jinv4 + gn27*jinv5 + gn45*jinv6, gn10*jinv4 + gn28*jinv5 + gn46*jinv6, gn11*jinv4 + gn29*jinv5 + gn47*jinv6, gn12*jinv4 + gn30*jinv5 + gn48*jinv6, gn13*jinv4 + gn31*jinv5 + gn49*jinv6, gn14*jinv4 + gn32*jinv5 + gn50*jinv6, gn15*jinv4 + gn33*jinv5 + gn51*jinv6, gn16*jinv4 + gn34*jinv5 + gn52*jinv6, gn17*jinv4 + gn35*jinv5 + gn53*jinv6, gn18*jinv4 + gn36*jinv5 + gn54*jinv6,...
   gn1*jinv7 + gn19*jinv8 + gn37*jinv9, gn2*jinv7 + gn20*jinv8 + gn38*jinv9, gn3*jinv7 + gn21*jinv8 + gn39*jinv9, gn4*jinv7 + gn22*jinv8 + gn40*jinv9, gn5*jinv7 + gn23*jinv8 + gn41*jinv9, gn6*jinv7 + gn24*jinv8 + gn42*jinv9, gn7*jinv7 + gn25*jinv8 + gn43*jinv9, gn8*jinv7 + gn26*jinv8 + gn44*jinv9, gn9*jinv7 + gn27*jinv8 + gn45*jinv9, gn10*jinv7 + gn28*jinv8 + gn46*jinv9, gn11*jinv7 + gn29*jinv8 + gn47*jinv9, gn12*jinv7 + gn30*jinv8 + gn48*jinv9, gn13*jinv7 + gn31*jinv8 + gn49*jinv9, gn14*jinv7 + gn32*jinv8 + gn50*jinv9, gn15*jinv7 + gn33*jinv8 + gn51*jinv9, gn16*jinv7 + gn34*jinv8 + gn52*jinv9, gn17*jinv7 + gn35*jinv8 + gn53*jinv9, gn18*jinv7 + gn36*jinv8 + gn54*jinv9];
 
%How to compute the above expressions
% % syms xi eta zta
% % N1t=xi*(2*xi-1);
% % N2t=eta*(2*eta-1);
% % N3t=(1-xi-eta)*(2*(1-xi-eta)-1);
% % N4t=4*xi*eta;
% % N5t=4*eta*(1-xi-eta);
% % N6t=4*(1-xi-eta)*xi;
% % N1z=0.5*zta*(zta-1);
% % N2z=0.5*zta*(zta+1);
% % N3z=1-zta^2;
% % 
% % N(1)=N1t*N1z;
% % N(2)=N2t*N1z;
% % N(3)=N3t*N1z;
% % N(4)=N1t*N2z;
% % N(5)=N2t*N2z;
% % N(6)=N3t*N2z;
% % 
% % N(7)=N4t*N1z;
% % N(8)=N5t*N1z;
% % N(9)=N6t*N1z;
% % N(10)=N4t*N2z;
% % N(11)=N5t*N2z;
% % N(12)=N6t*N2z;
% % 
% % N(13)=N1t*N3z;
% % N(14)=N2t*N3z;
% % N(15)=N3t*N3z;
% % 
% % N(16)=N4t*N3z;
% % N(17)=N5t*N3z;
% % N(18)=N6t*N3z;
% % 
% % for i=1:18
% %     fprintf(['N(' num2str(i) ') = ' char(N(i)) ';\n'])
% % end
% % %copy these shape functions to shapefunctions.m file
% % 
% % for i=1:18
% %     B(i,1)=diff(N(i),xi);
% %     B(i+18,1)=diff(N(i),eta);
% %     B(i+2*18,1)=diff(N(i),zta);
% % end
% % 
% % for i=1:54
% %     fprintf(['gn' num2str(i) ' = ' char(B(i)) ';\n'])
% % end
% % 
% % % % copy the text from the command window and paste it above
% % 
% % syms gn1 gn2 gn3 gn4 gn5 gn6 gn7 gn8 gn9 gn10 gn11 gn12 gn13 gn14 gn15 gn16 gn17 gn18
% % syms gn19 gn20 gn21 gn22 gn23 gn24 gn25 gn26 gn27 gn28 gn29 gn30 gn31 gn32 gn33 gn34 gn35 gn36
% % syms gn37 gn38 gn39 gn40 gn41 gn42 gn43 gn44 gn45 gn46 gn47 gn48 gn49 gn50 gn51 gn52 gn53 gn54
% % 
% % syms x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 x13 x14 x15 x16 x17 x18
% % syms y1 y2 y3 y4 y5 y6 y7 y8 y9 y10 y11 y12 y13 y14 y15 y16 y17 y18
% % syms z1 z2 z3 z4 z5 z6 z7 z8 z9 z10 z11 z12 z13 z14 z15 z16 z17 z18
% % dN=[gn1 gn2 gn3 gn4 gn5 gn6 gn7 gn8 gn9 gn10 gn11 gn12 gn13 gn14 gn15 gn16 gn17 gn18;...
% %     gn19 gn20 gn21 gn22 gn23 gn24 gn25 gn26 gn27 gn28 gn29 gn30 gn31 gn32 gn33 gn34 gn35 gn36;...
% %     gn37 gn38 gn39 gn40 gn41 gn42 gn43 gn44 gn45 gn46 gn47 gn48 gn49 gn50 gn51 gn52 gn53 gn54];
% % 
% % XYZ=[x1 y1 z1; x2 y2 z2; x3 y3 z3; x4 y4 z4; x5 y5 z5; x6 y6 z6; x7 y7 z7; x8 y8 z8; x9 y9 z9;...
% %      x10 y10 z10; x11 y11 z11; x12 y12 z12; x13 y13 z13; x14 y14 z14; x15 y15 z15; x16 y16 z16; x17 y17 z17; x18 y18 z18];
% % % the elements ji are obtain by mulitply dN*XYZ
% % 
% % syms jinv1 jinv2 jinv3 jinv4 jinv5 jinv6 jinv7 jinv8 jinv9
% % JINV=[jinv1 jinv2 jinv3; jinv4 jinv5 jinv6; jinv7 jinv8 jinv9];
% % 
% % % the derivatives are computed by JINV*dN
