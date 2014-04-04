%% shapeDerivPrism_quad
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%
%
% Computes the shape function derivatives and the determinant of the 
% jacobian matrix for quadratic prism elements.
% This function is used internally from <shapeDerivatives_help.html shapeDerivatives>.
% 
%
% Version : 1.0
%
% Author : George Kourakos
%
% email: giorgk@gmail.com
%
% web : http://groundwater.ucdavis.edu/msim
%
% Date 18-Mar-2014
%
% Department of Land Air and Water
%
% University of California Davis
%
%% Usage
% [B Jdet]=shapeDerivPrism_quad(p, MSH, n)
%
%% Input
% _*p*_: [Np x 3] Coodrinates of nodes [x1 y1 z1; x2 y2 z2;...xn yn zn],
% where _Np_ is the number of nodes
%
% _*MSH*_: [Nel x Np_el] id of elements. Each row correspond to an element.
% _Nel_ is the number of elements and _Np_el_ is the number of nodes to define the element
%
% _*n*_: the integration point where the derivatives will be evaluated. 
%
%% Output
% _*B*_: Shape function derivatives
%
% _*Jdet*_: The determinant of the Jacobian Matrix 
%
%% Shape functions
% N(1) = (xi*zta*(2*xi - 1)*(zta - 1))/2;
%
% N(2) = (eta*zta*(2*eta - 1)*(zta - 1))/2;
%
% N(3) = (zta*(zta - 1)*(eta + xi - 1)*(2*eta + 2*xi - 1))/2;
%
% N(4) = (xi*zta*(2*xi - 1)*(zta + 1))/2;
%
% N(5) = (eta*zta*(2*eta - 1)*(zta + 1))/2;
%
% N(6) = (zta*(zta + 1)*(eta + xi - 1)*(2*eta + 2*xi - 1))/2;
%
% N(7) = 2*eta*xi*zta*(zta - 1);
%
% N(8) = -2*eta*zta*(zta - 1)*(eta + xi - 1);
%
% N(9) = -(xi*zta*(zta - 1)*(4*eta + 4*xi - 4))/2;
%
% N(10) = 2*eta*xi*zta*(zta + 1);
%
% N(11) = -2*eta*zta*(zta + 1)*(eta + xi - 1);
%
% N(12) = -(xi*zta*(zta + 1)*(4*eta + 4*xi - 4))/2;
%
% N(13) = -xi*(2*xi - 1)*(zta^2 - 1);
%
% N(14) = -eta*(2*eta - 1)*(zta^2 - 1);
%
% N(15) = -(zta^2 - 1)*(eta + xi - 1)*(2*eta + 2*xi - 1);
%
% N(16) = -4*eta*xi*(zta^2 - 1);
%
% N(17) = 4*eta*(zta^2 - 1)*(eta + xi - 1);
%
% N(18) = xi*(zta^2 - 1)*(4*eta + 4*xi - 4);
%
%% Derivatives of shape functions
% wrt. ksi:
%
% dN1 = xi*zta*(zta - 1) + (zta*(2*xi - 1)*(zta - 1))/2;
% 
% dN2 = 0;
% 
% dN3 = (zta*(zta - 1)*(2*eta + 2*xi - 1))/2 + zta*(zta - 1)*(eta + xi - 1);
% 
% dN4 = xi*zta*(zta + 1) + (zta*(2*xi - 1)*(zta + 1))/2;
% 
% dN5 = 0;
% 
% dN6 = (zta*(zta + 1)*(2*eta + 2*xi - 1))/2 + zta*(zta + 1)*(eta + xi - 1);
% 
% dN7 = 2*eta*zta*(zta - 1);
% 
% dN8 = -2*eta*zta*(zta - 1);
% 
% dN9 = - 2*xi*zta*(zta - 1) - (zta*(zta - 1)*(4*eta + 4*xi - 4))/2;
% 
% dN10 = 2*eta*zta*(zta + 1);
% 
% dN11 = -2*eta*zta*(zta + 1);
% 
% dN12 = - 2*xi*zta*(zta + 1) - (zta*(zta + 1)*(4*eta + 4*xi - 4))/2;
% 
% dN13 = - 2*xi*(zta^2 - 1) - (2*xi - 1)*(zta^2 - 1);
% 
% dN14 = 0;
% 
% dN15 = - (zta^2 - 1)*(2*eta + 2*xi - 1) - 2*(zta^2 - 1)*(eta + xi - 1);
% 
% dN16 = -4*eta*(zta^2 - 1);
% 
% dN17 = 4*eta*(zta^2 - 1);
% 
% dN18 = 4*xi*(zta^2 - 1) + (zta^2 - 1)*(4*eta + 4*xi - 4);
%
%
% wrt. eta:
%
% dN19 = 0;
% 
% dN20 = eta*zta*(zta - 1) + (zta*(2*eta - 1)*(zta - 1))/2;
% 
% dN21 = (zta*(zta - 1)*(2*eta + 2*xi - 1))/2 + zta*(zta - 1)*(eta + xi - 1);
% 
% dN22 = 0;
% 
% dN23 = eta*zta*(zta + 1) + (zta*(2*eta - 1)*(zta + 1))/2;
% 
% dN24 = (zta*(zta + 1)*(2*eta + 2*xi - 1))/2 + zta*(zta + 1)*(eta + xi - 1);
% 
% dN25 = 2*xi*zta*(zta - 1);
% 
% dN26 = - 2*eta*zta*(zta - 1) - 2*zta*(zta - 1)*(eta + xi - 1);
% 
% dN27 = -2*xi*zta*(zta - 1);
% 
% dN28 = 2*xi*zta*(zta + 1);
% 
% dN29 = - 2*eta*zta*(zta + 1) - 2*zta*(zta + 1)*(eta + xi - 1);
% 
% dN30 = -2*xi*zta*(zta + 1);
% 
% dN31 = 0;
% 
% dN32 = - (2*eta - 1)*(zta^2 - 1) - 2*eta*(zta^2 - 1);
% 
% dN33 = - (zta^2 - 1)*(2*eta + 2*xi - 1) - 2*(zta^2 - 1)*(eta + xi - 1);
% 
% dN34 = -4*xi*(zta^2 - 1);
% 
% dN35 = 4*(zta^2 - 1)*(eta + xi - 1) + 4*eta*(zta^2 - 1);
% 
% dN36 = 4*xi*(zta^2 - 1);
%
%
% wrt. zeta:
%
% dN37 = (xi*zta*(2*xi - 1))/2 + (xi*(2*xi - 1)*(zta - 1))/2;
% 
% dN38 = (eta*zta*(2*eta - 1))/2 + (eta*(2*eta - 1)*(zta - 1))/2;
% 
% dN39 = (zta*(eta + xi - 1)*(2*eta + 2*xi - 1))/2 + ((zta - 1)*(eta + xi - 1)*(2*eta + 2*xi - 1))/2;
% 
% dN40 = (xi*zta*(2*xi - 1))/2 + (xi*(2*xi - 1)*(zta + 1))/2;
% 
% dN41 = (eta*zta*(2*eta - 1))/2 + (eta*(2*eta - 1)*(zta + 1))/2;
% 
% dN42 = (zta*(eta + xi - 1)*(2*eta + 2*xi - 1))/2 + ((zta + 1)*(eta + xi - 1)*(2*eta + 2*xi - 1))/2;
% 
% dN43 = 2*eta*xi*(zta - 1) + 2*eta*xi*zta;
% 
% dN44 = - 2*eta*zta*(eta + xi - 1) - 2*eta*(zta - 1)*(eta + xi - 1);
% 
% dN45 = - (xi*zta*(4*eta + 4*xi - 4))/2 - (xi*(zta - 1)*(4*eta + 4*xi - 4))/2;
% 
% dN46 = 2*eta*xi*(zta + 1) + 2*eta*xi*zta;
% 
% dN47 = - 2*eta*zta*(eta + xi - 1) - 2*eta*(zta + 1)*(eta + xi - 1);
% 
% dN48 = - (xi*zta*(4*eta + 4*xi - 4))/2 - (xi*(zta + 1)*(4*eta + 4*xi - 4))/2;
% 
% dN49 = -2*xi*zta*(2*xi - 1);
% 
% dN50 = -2*eta*zta*(2*eta - 1);
% 
% dN51 = -2*zta*(eta + xi - 1)*(2*eta + 2*xi - 1);
% 
% dN52 = -8*eta*xi*zta;
% 
% dN53 = 8*eta*zta*(eta + xi - 1);
% 
% dN54 = 2*xi*zta*(4*eta + 4*xi - 4);
%
%%
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%