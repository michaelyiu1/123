function [B Jdet]=shapeDerivHex_quad_27(p,MSH,n)
% [B Jdet] = shapeDerivHex_quad_27(p, MSH, n)
%
% Computes the shape function derivatives and the determinant of the 
% jacobian matrix for hexahedral quadratic elements (complete).
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
% Version : 1.0
% Author : George Kourakos
% email: giorgk@gmail.com
% web : http://groundwater.ucdavis.edu/msim
% Date 18-Dec_2012
% Department of Land Air and Water
% University of California Davis
%
% Shape functions of 27 node hexahedral element
% N(1) = (eta*xi*zta*(eta - 1)*(xi - 1)*(zta - 1))/8;
% N(2) = (eta*xi*zta*(eta - 1)*(xi + 1)*(zta - 1))/8;
% N(3) = (eta*xi*zta*(eta + 1)*(xi + 1)*(zta - 1))/8;
% N(4) = (eta*xi*zta*(eta + 1)*(xi - 1)*(zta - 1))/8;
% N(5) = (eta*xi*zta*(eta - 1)*(xi - 1)*(zta + 1))/8;
% N(6) = (eta*xi*zta*(eta - 1)*(xi + 1)*(zta + 1))/8;
% N(7) = (eta*xi*zta*(eta + 1)*(xi + 1)*(zta + 1))/8;
% N(8) = (eta*xi*zta*(eta + 1)*(xi - 1)*(zta + 1))/8;
% N(9) = -(eta*zta*(xi^2 - 1)*(eta - 1)*(zta - 1))/4;
% N(10) = -(xi*zta*(eta^2 - 1)*(xi + 1)*(zta - 1))/4;
% N(11) = -(eta*zta*(xi^2 - 1)*(eta + 1)*(zta - 1))/4;
% N(12) = -(xi*zta*(eta^2 - 1)*(xi - 1)*(zta - 1))/4;
% N(13) = -(eta*zta*(xi^2 - 1)*(eta - 1)*(zta + 1))/4;
% N(14) = -(xi*zta*(eta^2 - 1)*(xi + 1)*(zta + 1))/4;
% N(15) = -(eta*zta*(xi^2 - 1)*(eta + 1)*(zta + 1))/4;
% N(16) = -(xi*zta*(eta^2 - 1)*(xi - 1)*(zta + 1))/4;
% N(17) = -(eta*xi*(zta^2 - 1)*(eta - 1)*(xi - 1))/4;
% N(18) = -(eta*xi*(zta^2 - 1)*(eta - 1)*(xi + 1))/4;
% N(19) = -(eta*xi*(zta^2 - 1)*(eta + 1)*(xi + 1))/4;
% N(20) = -(eta*xi*(zta^2 - 1)*(eta + 1)*(xi - 1))/4;
% N(21) = (eta*(xi^2 - 1)*(zta^2 - 1)*(eta - 1))/2;
% N(22) = (xi*(eta^2 - 1)*(zta^2 - 1)*(xi + 1))/2;
% N(23) = (eta*(xi^2 - 1)*(zta^2 - 1)*(eta + 1))/2;
% N(24) = (xi*(eta^2 - 1)*(zta^2 - 1)*(xi - 1))/2;
% N(25) = (zta*(eta^2 - 1)*(xi^2 - 1)*(zta - 1))/2;
% N(26) = (zta*(eta^2 - 1)*(xi^2 - 1)*(zta + 1))/2;
% N(27) = -(eta^2 - 1)*(xi^2 - 1)*(zta^2 - 1);
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
x19=p(MSH(:,19),1);y19=p(MSH(:,19),2);z19=p(MSH(:,19),3);
x20=p(MSH(:,20),1);y20=p(MSH(:,20),2);z20=p(MSH(:,20),3);
x21=p(MSH(:,21),1);y21=p(MSH(:,21),2);z21=p(MSH(:,21),3);
x22=p(MSH(:,22),1);y22=p(MSH(:,22),2);z22=p(MSH(:,22),3);
x23=p(MSH(:,23),1);y23=p(MSH(:,23),2);z23=p(MSH(:,23),3);
x24=p(MSH(:,24),1);y24=p(MSH(:,24),2);z24=p(MSH(:,24),3);
x25=p(MSH(:,25),1);y25=p(MSH(:,25),2);z25=p(MSH(:,25),3);
x26=p(MSH(:,26),1);y26=p(MSH(:,26),2);z26=p(MSH(:,26),3);
x27=p(MSH(:,27),1);y27=p(MSH(:,27),2);z27=p(MSH(:,27),3);

%Derivatives of shape functions wrt xi eta and zta
gn1 = (eta*xi*zta*(eta - 1)*(zta - 1))/8 + (eta*zta*(eta - 1)*(xi - 1)*(zta - 1))/8;
gn2 = (eta*xi*zta*(eta - 1)*(zta - 1))/8 + (eta*zta*(eta - 1)*(xi + 1)*(zta - 1))/8;
gn3 = (eta*xi*zta*(eta + 1)*(zta - 1))/8 + (eta*zta*(eta + 1)*(xi + 1)*(zta - 1))/8;
gn4 = (eta*xi*zta*(eta + 1)*(zta - 1))/8 + (eta*zta*(eta + 1)*(xi - 1)*(zta - 1))/8;
gn5 = (eta*xi*zta*(eta - 1)*(zta + 1))/8 + (eta*zta*(eta - 1)*(xi - 1)*(zta + 1))/8;
gn6 = (eta*xi*zta*(eta - 1)*(zta + 1))/8 + (eta*zta*(eta - 1)*(xi + 1)*(zta + 1))/8;
gn7 = (eta*xi*zta*(eta + 1)*(zta + 1))/8 + (eta*zta*(eta + 1)*(xi + 1)*(zta + 1))/8;
gn8 = (eta*xi*zta*(eta + 1)*(zta + 1))/8 + (eta*zta*(eta + 1)*(xi - 1)*(zta + 1))/8;
gn9 = -(eta*xi*zta*(eta - 1)*(zta - 1))/2;
gn10 = - (xi*zta*(eta^2 - 1)*(zta - 1))/4 - (zta*(eta^2 - 1)*(xi + 1)*(zta - 1))/4;
gn11 = -(eta*xi*zta*(eta + 1)*(zta - 1))/2;
gn12 = - (xi*zta*(eta^2 - 1)*(zta - 1))/4 - (zta*(eta^2 - 1)*(xi - 1)*(zta - 1))/4;
gn13 = -(eta*xi*zta*(eta - 1)*(zta + 1))/2;
gn14 = - (xi*zta*(eta^2 - 1)*(zta + 1))/4 - (zta*(eta^2 - 1)*(xi + 1)*(zta + 1))/4;
gn15 = -(eta*xi*zta*(eta + 1)*(zta + 1))/2;
gn16 = - (xi*zta*(eta^2 - 1)*(zta + 1))/4 - (zta*(eta^2 - 1)*(xi - 1)*(zta + 1))/4;
gn17 = - (eta*xi*(zta^2 - 1)*(eta - 1))/4 - (eta*(zta^2 - 1)*(eta - 1)*(xi - 1))/4;
gn18 = - (eta*xi*(zta^2 - 1)*(eta - 1))/4 - (eta*(zta^2 - 1)*(eta - 1)*(xi + 1))/4;
gn19 = - (eta*xi*(zta^2 - 1)*(eta + 1))/4 - (eta*(zta^2 - 1)*(eta + 1)*(xi + 1))/4;
gn20 = - (eta*xi*(zta^2 - 1)*(eta + 1))/4 - (eta*(zta^2 - 1)*(eta + 1)*(xi - 1))/4;
gn21 = eta*xi*(zta^2 - 1)*(eta - 1);
gn22 = (xi*(eta^2 - 1)*(zta^2 - 1))/2 + ((eta^2 - 1)*(zta^2 - 1)*(xi + 1))/2;
gn23 = eta*xi*(zta^2 - 1)*(eta + 1);
gn24 = (xi*(eta^2 - 1)*(zta^2 - 1))/2 + ((eta^2 - 1)*(zta^2 - 1)*(xi - 1))/2;
gn25 = xi*zta*(eta^2 - 1)*(zta - 1);
gn26 = xi*zta*(eta^2 - 1)*(zta + 1);
gn27 = -2*xi*(eta^2 - 1)*(zta^2 - 1);
gn28 = (eta*xi*zta*(xi - 1)*(zta - 1))/8 + (xi*zta*(eta - 1)*(xi - 1)*(zta - 1))/8;
gn29 = (eta*xi*zta*(xi + 1)*(zta - 1))/8 + (xi*zta*(eta - 1)*(xi + 1)*(zta - 1))/8;
gn30 = (eta*xi*zta*(xi + 1)*(zta - 1))/8 + (xi*zta*(eta + 1)*(xi + 1)*(zta - 1))/8;
gn31 = (eta*xi*zta*(xi - 1)*(zta - 1))/8 + (xi*zta*(eta + 1)*(xi - 1)*(zta - 1))/8;
gn32 = (eta*xi*zta*(xi - 1)*(zta + 1))/8 + (xi*zta*(eta - 1)*(xi - 1)*(zta + 1))/8;
gn33 = (eta*xi*zta*(xi + 1)*(zta + 1))/8 + (xi*zta*(eta - 1)*(xi + 1)*(zta + 1))/8;
gn34 = (eta*xi*zta*(xi + 1)*(zta + 1))/8 + (xi*zta*(eta + 1)*(xi + 1)*(zta + 1))/8;
gn35 = (eta*xi*zta*(xi - 1)*(zta + 1))/8 + (xi*zta*(eta + 1)*(xi - 1)*(zta + 1))/8;
gn36 = - (eta*zta*(xi^2 - 1)*(zta - 1))/4 - (zta*(xi^2 - 1)*(eta - 1)*(zta - 1))/4;
gn37 = -(eta*xi*zta*(xi + 1)*(zta - 1))/2;
gn38 = - (eta*zta*(xi^2 - 1)*(zta - 1))/4 - (zta*(xi^2 - 1)*(eta + 1)*(zta - 1))/4;
gn39 = -(eta*xi*zta*(xi - 1)*(zta - 1))/2;
gn40 = - (eta*zta*(xi^2 - 1)*(zta + 1))/4 - (zta*(xi^2 - 1)*(eta - 1)*(zta + 1))/4;
gn41 = -(eta*xi*zta*(xi + 1)*(zta + 1))/2;
gn42 = - (eta*zta*(xi^2 - 1)*(zta + 1))/4 - (zta*(xi^2 - 1)*(eta + 1)*(zta + 1))/4;
gn43 = -(eta*xi*zta*(xi - 1)*(zta + 1))/2;
gn44 = - (eta*xi*(zta^2 - 1)*(xi - 1))/4 - (xi*(zta^2 - 1)*(eta - 1)*(xi - 1))/4;
gn45 = - (eta*xi*(zta^2 - 1)*(xi + 1))/4 - (xi*(zta^2 - 1)*(eta - 1)*(xi + 1))/4;
gn46 = - (eta*xi*(zta^2 - 1)*(xi + 1))/4 - (xi*(zta^2 - 1)*(eta + 1)*(xi + 1))/4;
gn47 = - (eta*xi*(zta^2 - 1)*(xi - 1))/4 - (xi*(zta^2 - 1)*(eta + 1)*(xi - 1))/4;
gn48 = (eta*(xi^2 - 1)*(zta^2 - 1))/2 + ((xi^2 - 1)*(zta^2 - 1)*(eta - 1))/2;
gn49 = eta*xi*(zta^2 - 1)*(xi + 1);
gn50 = (eta*(xi^2 - 1)*(zta^2 - 1))/2 + ((xi^2 - 1)*(zta^2 - 1)*(eta + 1))/2;
gn51 = eta*xi*(zta^2 - 1)*(xi - 1);
gn52 = eta*zta*(xi^2 - 1)*(zta - 1);
gn53 = eta*zta*(xi^2 - 1)*(zta + 1);
gn54 = -2*eta*(xi^2 - 1)*(zta^2 - 1);
gn55 = (eta*xi*zta*(eta - 1)*(xi - 1))/8 + (eta*xi*(eta - 1)*(xi - 1)*(zta - 1))/8;
gn56 = (eta*xi*zta*(eta - 1)*(xi + 1))/8 + (eta*xi*(eta - 1)*(xi + 1)*(zta - 1))/8;
gn57 = (eta*xi*zta*(eta + 1)*(xi + 1))/8 + (eta*xi*(eta + 1)*(xi + 1)*(zta - 1))/8;
gn58 = (eta*xi*zta*(eta + 1)*(xi - 1))/8 + (eta*xi*(eta + 1)*(xi - 1)*(zta - 1))/8;
gn59 = (eta*xi*zta*(eta - 1)*(xi - 1))/8 + (eta*xi*(eta - 1)*(xi - 1)*(zta + 1))/8;
gn60 = (eta*xi*zta*(eta - 1)*(xi + 1))/8 + (eta*xi*(eta - 1)*(xi + 1)*(zta + 1))/8;
gn61 = (eta*xi*zta*(eta + 1)*(xi + 1))/8 + (eta*xi*(eta + 1)*(xi + 1)*(zta + 1))/8;
gn62 = (eta*xi*zta*(eta + 1)*(xi - 1))/8 + (eta*xi*(eta + 1)*(xi - 1)*(zta + 1))/8;
gn63 = - (eta*zta*(xi^2 - 1)*(eta - 1))/4 - (eta*(xi^2 - 1)*(eta - 1)*(zta - 1))/4;
gn64 = - (xi*zta*(eta^2 - 1)*(xi + 1))/4 - (xi*(eta^2 - 1)*(xi + 1)*(zta - 1))/4;
gn65 = - (eta*zta*(xi^2 - 1)*(eta + 1))/4 - (eta*(xi^2 - 1)*(eta + 1)*(zta - 1))/4;
gn66 = - (xi*zta*(eta^2 - 1)*(xi - 1))/4 - (xi*(eta^2 - 1)*(xi - 1)*(zta - 1))/4;
gn67 = - (eta*zta*(xi^2 - 1)*(eta - 1))/4 - (eta*(xi^2 - 1)*(eta - 1)*(zta + 1))/4;
gn68 = - (xi*zta*(eta^2 - 1)*(xi + 1))/4 - (xi*(eta^2 - 1)*(xi + 1)*(zta + 1))/4;
gn69 = - (eta*zta*(xi^2 - 1)*(eta + 1))/4 - (eta*(xi^2 - 1)*(eta + 1)*(zta + 1))/4;
gn70 = - (xi*zta*(eta^2 - 1)*(xi - 1))/4 - (xi*(eta^2 - 1)*(xi - 1)*(zta + 1))/4;
gn71 = -(eta*xi*zta*(eta - 1)*(xi - 1))/2;
gn72 = -(eta*xi*zta*(eta - 1)*(xi + 1))/2;
gn73 = -(eta*xi*zta*(eta + 1)*(xi + 1))/2;
gn74 = -(eta*xi*zta*(eta + 1)*(xi - 1))/2;
gn75 = eta*zta*(xi^2 - 1)*(eta - 1);
gn76 = xi*zta*(eta^2 - 1)*(xi + 1);
gn77 = eta*zta*(xi^2 - 1)*(eta + 1);
gn78 = xi*zta*(eta^2 - 1)*(xi - 1);
gn79 = (zta*(eta^2 - 1)*(xi^2 - 1))/2 + ((eta^2 - 1)*(xi^2 - 1)*(zta - 1))/2;
gn80 = (zta*(eta^2 - 1)*(xi^2 - 1))/2 + ((eta^2 - 1)*(xi^2 - 1)*(zta + 1))/2;
gn81 = -2*zta*(eta^2 - 1)*(xi^2 - 1);%I have tested those derivatives with the vtk code from
%http://fossies.org/dox/vtk-5.10.1/vtkTriQuadraticHexahedron_8cxx_source.html#l00519

%Multiply the derivatives with element coordinates to obtain the elements 
%of Jacobian Matrix
j1= gn1*x1 + gn2*x2 + gn3*x3 + gn4*x4 + gn5*x5 + gn6*x6 + gn7*x7 + gn8*x8 + gn9*x9 + gn10*x10 + gn11*x11 + gn12*x12 + gn13*x13 + gn14*x14 + gn15*x15 + gn16*x16 + gn17*x17 + gn18*x18 + gn19*x19 + gn20*x20 + gn21*x21 + gn22*x22 + gn23*x23 + gn24*x24 + gn25*x25 + gn26*x26 + gn27*x27;
j2= gn1*y1 + gn2*y2 + gn3*y3 + gn4*y4 + gn5*y5 + gn6*y6 + gn7*y7 + gn8*y8 + gn9*y9 + gn10*y10 + gn11*y11 + gn12*y12 + gn13*y13 + gn14*y14 + gn15*y15 + gn16*y16 + gn17*y17 + gn18*y18 + gn19*y19 + gn20*y20 + gn21*y21 + gn22*y22 + gn23*y23 + gn24*y24 + gn25*y25 + gn26*y26 + gn27*y27;
j3= gn1*z1 + gn2*z2 + gn3*z3 + gn4*z4 + gn5*z5 + gn6*z6 + gn7*z7 + gn8*z8 + gn9*z9 + gn10*z10 + gn11*z11 + gn12*z12 + gn13*z13 + gn14*z14 + gn15*z15 + gn16*z16 + gn17*z17 + gn18*z18 + gn19*z19 + gn20*z20 + gn21*z21 + gn22*z22 + gn23*z23 + gn24*z24 + gn25*z25 + gn26*z26 + gn27*z27;
j4= gn28*x1 + gn29*x2 + gn30*x3 + gn31*x4 + gn32*x5 + gn33*x6 + gn34*x7 + gn35*x8 + gn36*x9 + gn37*x10 + gn38*x11 + gn39*x12 + gn40*x13 + gn41*x14 + gn42*x15 + gn43*x16 + gn44*x17 + gn45*x18 + gn46*x19 + gn47*x20 + gn48*x21 + gn49*x22 + gn50*x23 + gn51*x24 + gn52*x25 + gn53*x26 + gn54*x27;
j5= gn28*y1 + gn29*y2 + gn30*y3 + gn31*y4 + gn32*y5 + gn33*y6 + gn34*y7 + gn35*y8 + gn36*y9 + gn37*y10 + gn38*y11 + gn39*y12 + gn40*y13 + gn41*y14 + gn42*y15 + gn43*y16 + gn44*y17 + gn45*y18 + gn46*y19 + gn47*y20 + gn48*y21 + gn49*y22 + gn50*y23 + gn51*y24 + gn52*y25 + gn53*y26 + gn54*y27;
j6= gn28*z1 + gn29*z2 + gn30*z3 + gn31*z4 + gn32*z5 + gn33*z6 + gn34*z7 + gn35*z8 + gn36*z9 + gn37*z10 + gn38*z11 + gn39*z12 + gn40*z13 + gn41*z14 + gn42*z15 + gn43*z16 + gn44*z17 + gn45*z18 + gn46*z19 + gn47*z20 + gn48*z21 + gn49*z22 + gn50*z23 + gn51*z24 + gn52*z25 + gn53*z26 + gn54*z27;
j7= gn55*x1 + gn56*x2 + gn57*x3 + gn58*x4 + gn59*x5 + gn60*x6 + gn61*x7 + gn62*x8 + gn63*x9 + gn64*x10 + gn65*x11 + gn66*x12 + gn67*x13 + gn68*x14 + gn69*x15 + gn70*x16 + gn71*x17 + gn72*x18 + gn73*x19 + gn74*x20 + gn75*x21 + gn76*x22 + gn77*x23 + gn78*x24 + gn79*x25 + gn80*x26 + gn81*x27;
j8= gn55*y1 + gn56*y2 + gn57*y3 + gn58*y4 + gn59*y5 + gn60*y6 + gn61*y7 + gn62*y8 + gn63*y9 + gn64*y10 + gn65*y11 + gn66*y12 + gn67*y13 + gn68*y14 + gn69*y15 + gn70*y16 + gn71*y17 + gn72*y18 + gn73*y19 + gn74*y20 + gn75*y21 + gn76*y22 + gn77*y23 + gn78*y24 + gn79*y25 + gn80*y26 + gn81*y27;
j9= gn55*z1 + gn56*z2 + gn57*z3 + gn58*z4 + gn59*z5 + gn60*z6 + gn61*z7 + gn62*z8 + gn63*z9 + gn64*z10 + gn65*z11 + gn66*z12 + gn67*z13 + gn68*z14 + gn69*z15 + gn70*z16 + gn71*z17 + gn72*z18 + gn73*z19 + gn74*z20 + gn75*z21 + gn76*z22 + gn77*z23 + gn78*z24 + gn79*z25 + gn80*z26 + gn81*z27;

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

B=[gn1*jinv1 + gn28*jinv2 + gn55*jinv3, gn2*jinv1 + gn29*jinv2 + gn56*jinv3, gn3*jinv1 + gn30*jinv2 + gn57*jinv3, gn4*jinv1 + gn31*jinv2 + gn58*jinv3, gn5*jinv1 + gn32*jinv2 + gn59*jinv3, gn6*jinv1 + gn33*jinv2 + gn60*jinv3, gn7*jinv1 + gn34*jinv2 + gn61*jinv3, gn8*jinv1 + gn35*jinv2 + gn62*jinv3, gn9*jinv1 + gn36*jinv2 + gn63*jinv3, gn10*jinv1 + gn37*jinv2 + gn64*jinv3, gn11*jinv1 + gn38*jinv2 + gn65*jinv3, gn12*jinv1 + gn39*jinv2 + gn66*jinv3, gn13*jinv1 + gn40*jinv2 + gn67*jinv3, gn14*jinv1 + gn41*jinv2 + gn68*jinv3, gn15*jinv1 + gn42*jinv2 + gn69*jinv3, gn16*jinv1 + gn43*jinv2 + gn70*jinv3, gn17*jinv1 + gn44*jinv2 + gn71*jinv3, gn18*jinv1 + gn45*jinv2 + gn72*jinv3, gn19*jinv1 + gn46*jinv2 + gn73*jinv3, gn20*jinv1 + gn47*jinv2 + gn74*jinv3, gn21*jinv1 + gn48*jinv2 + gn75*jinv3, gn22*jinv1 + gn49*jinv2 + gn76*jinv3, gn23*jinv1 + gn50*jinv2 + gn77*jinv3, gn24*jinv1 + gn51*jinv2 + gn78*jinv3, gn25*jinv1 + gn52*jinv2 + gn79*jinv3, gn26*jinv1 + gn53*jinv2 + gn80*jinv3, gn27*jinv1 + gn54*jinv2 + gn81*jinv3 ...
   gn1*jinv4 + gn28*jinv5 + gn55*jinv6, gn2*jinv4 + gn29*jinv5 + gn56*jinv6, gn3*jinv4 + gn30*jinv5 + gn57*jinv6, gn4*jinv4 + gn31*jinv5 + gn58*jinv6, gn5*jinv4 + gn32*jinv5 + gn59*jinv6, gn6*jinv4 + gn33*jinv5 + gn60*jinv6, gn7*jinv4 + gn34*jinv5 + gn61*jinv6, gn8*jinv4 + gn35*jinv5 + gn62*jinv6, gn9*jinv4 + gn36*jinv5 + gn63*jinv6, gn10*jinv4 + gn37*jinv5 + gn64*jinv6, gn11*jinv4 + gn38*jinv5 + gn65*jinv6, gn12*jinv4 + gn39*jinv5 + gn66*jinv6, gn13*jinv4 + gn40*jinv5 + gn67*jinv6, gn14*jinv4 + gn41*jinv5 + gn68*jinv6, gn15*jinv4 + gn42*jinv5 + gn69*jinv6, gn16*jinv4 + gn43*jinv5 + gn70*jinv6, gn17*jinv4 + gn44*jinv5 + gn71*jinv6, gn18*jinv4 + gn45*jinv5 + gn72*jinv6, gn19*jinv4 + gn46*jinv5 + gn73*jinv6, gn20*jinv4 + gn47*jinv5 + gn74*jinv6, gn21*jinv4 + gn48*jinv5 + gn75*jinv6, gn22*jinv4 + gn49*jinv5 + gn76*jinv6, gn23*jinv4 + gn50*jinv5 + gn77*jinv6, gn24*jinv4 + gn51*jinv5 + gn78*jinv6, gn25*jinv4 + gn52*jinv5 + gn79*jinv6, gn26*jinv4 + gn53*jinv5 + gn80*jinv6, gn27*jinv4 + gn54*jinv5 + gn81*jinv6 ...
   gn1*jinv7 + gn28*jinv8 + gn55*jinv9, gn2*jinv7 + gn29*jinv8 + gn56*jinv9, gn3*jinv7 + gn30*jinv8 + gn57*jinv9, gn4*jinv7 + gn31*jinv8 + gn58*jinv9, gn5*jinv7 + gn32*jinv8 + gn59*jinv9, gn6*jinv7 + gn33*jinv8 + gn60*jinv9, gn7*jinv7 + gn34*jinv8 + gn61*jinv9, gn8*jinv7 + gn35*jinv8 + gn62*jinv9, gn9*jinv7 + gn36*jinv8 + gn63*jinv9, gn10*jinv7 + gn37*jinv8 + gn64*jinv9, gn11*jinv7 + gn38*jinv8 + gn65*jinv9, gn12*jinv7 + gn39*jinv8 + gn66*jinv9, gn13*jinv7 + gn40*jinv8 + gn67*jinv9, gn14*jinv7 + gn41*jinv8 + gn68*jinv9, gn15*jinv7 + gn42*jinv8 + gn69*jinv9, gn16*jinv7 + gn43*jinv8 + gn70*jinv9, gn17*jinv7 + gn44*jinv8 + gn71*jinv9, gn18*jinv7 + gn45*jinv8 + gn72*jinv9, gn19*jinv7 + gn46*jinv8 + gn73*jinv9, gn20*jinv7 + gn47*jinv8 + gn74*jinv9, gn21*jinv7 + gn48*jinv8 + gn75*jinv9, gn22*jinv7 + gn49*jinv8 + gn76*jinv9, gn23*jinv7 + gn50*jinv8 + gn77*jinv9, gn24*jinv7 + gn51*jinv8 + gn78*jinv9, gn25*jinv7 + gn52*jinv8 + gn79*jinv9, gn26*jinv7 + gn53*jinv8 + gn80*jinv9, gn27*jinv7 + gn54*jinv8 + gn81*jinv9];
 
% Using symbolic toolbox to compute the above expressions
% % syms xi eta zta
% % N1x=0.5*xi*(xi-1)
% % N1e=0.5*eta*(eta-1)
% % N1z=0.5*zta*(zta-1)
% % N2x=0.5*xi*(xi+1)
% % N2e=0.5*eta*(eta+1)
% % N2z=0.5*zta*(zta+1)
% % N3x=1-xi^2
% % N3e=1-eta^2
% % N3z=1-zta^2
% % 
% % N(1)=N1x*N1e*N1z
% % N(2)=N2x*N1e*N1z
% % N(3)=N2x*N2e*N1z
% % N(4)=N1x*N2e*N1z
% % N(5)=N1x*N1e*N2z
% % N(6)=N2x*N1e*N2z
% % N(7)=N2x*N2e*N2z
% % N(8)=N1x*N2e*N2z
% % 
% % N(9)=N3x*N1e*N1z
% % N(10)=N2x*N3e*N1z
% % N(11)=N3x*N2e*N1z
% % N(12)=N1x*N3e*N1z
% % N(13)=N3x*N1e*N2z
% % N(14)=N2x*N3e*N2z
% % N(15)=N3x*N2e*N2z
% % N(16)=N1x*N3e*N2z
% % 
% % N(17)=N1x*N1e*N3z
% % N(18)=N2x*N1e*N3z
% % N(19)=N2x*N2e*N3z
% % N(20)=N1x*N2e*N3z
% % 
% % N(21)=N3x*N1e*N3z
% % N(22)=N2x*N3e*N3z
% % N(23)=N3x*N2e*N3z
% % N(24)=N1x*N3e*N3z
% % 
% % N(25)=N3x*N3e*N1z
% % N(26)=N3x*N3e*N2z
% % N(27)=N3x*N3e*N3z
% % 
% % for i=1:27
% %     fprintf(['N(' num2str(i) ') = ' char(N(i)) ';\n'])
% % end
%copy these shape functions to shapefunctions.m file

% % 
% % for i=1:27
% %     B(i,1)=diff(N(i),xi);
% %     B(i+27,1)=diff(N(i),eta);
% %     B(i+2*27,1)=diff(N(i),zta);
% % end
% % 
% % for i=1:81
% %     fprintf(['gn' num2str(i) ' = ' char(B(i)) ';\n'])
% % end
% % copy the text from the command window and paste it above
