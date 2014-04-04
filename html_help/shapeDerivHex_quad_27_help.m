%% shapeDerivHex_quad_27
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%
%
% Computes the shape function derivatives and the determinant of the 
% jacobian matrix for hexahedral quadratic elements (complete).
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
% [B Jdet] = shapeDerivHex_quad_27(p, MSH, n)
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
% N1 = (eta*xi*zta*(eta - 1)*(xi - 1)*(zta - 1))/8;
% 
% N2 = (eta*xi*zta*(eta - 1)*(xi + 1)*(zta - 1))/8;
% 
% N3 = (eta*xi*zta*(eta + 1)*(xi + 1)*(zta - 1))/8;
% 
% N4 = (eta*xi*zta*(eta + 1)*(xi - 1)*(zta - 1))/8;
% 
% N5 = (eta*xi*zta*(eta - 1)*(xi - 1)*(zta + 1))/8;
% 
% N6 = (eta*xi*zta*(eta - 1)*(xi + 1)*(zta + 1))/8;
% 
% N7 = (eta*xi*zta*(eta + 1)*(xi + 1)*(zta + 1))/8;
% 
% N8 = (eta*xi*zta*(eta + 1)*(xi - 1)*(zta + 1))/8;
% 
% N9 = -(eta*zta*(xi^2 - 1)*(eta - 1)*(zta - 1))/4;
% 
% N10 = -(xi*zta*(eta^2 - 1)*(xi + 1)*(zta - 1))/4;
% 
% N11 = -(eta*zta*(xi^2 - 1)*(eta + 1)*(zta - 1))/4;
% 
% N12 = -(xi*zta*(eta^2 - 1)*(xi - 1)*(zta - 1))/4;
% 
% N13 = -(eta*zta*(xi^2 - 1)*(eta - 1)*(zta + 1))/4;
% 
% N14 = -(xi*zta*(eta^2 - 1)*(xi + 1)*(zta + 1))/4;
% 
% N15 = -(eta*zta*(xi^2 - 1)*(eta + 1)*(zta + 1))/4;
% 
% N16 = -(xi*zta*(eta^2 - 1)*(xi - 1)*(zta + 1))/4;
% 
% N17 = -(eta*xi*(zta^2 - 1)*(eta - 1)*(xi - 1))/4;
% 
% N18 = -(eta*xi*(zta^2 - 1)*(eta - 1)*(xi + 1))/4;
% 
% N19 = -(eta*xi*(zta^2 - 1)*(eta + 1)*(xi + 1))/4;
% 
% N20 = -(eta*xi*(zta^2 - 1)*(eta + 1)*(xi - 1))/4;
% 
% N21 = (eta*(xi^2 - 1)*(zta^2 - 1)*(eta - 1))/2;
% 
% N22 = (xi*(eta^2 - 1)*(zta^2 - 1)*(xi + 1))/2;
% 
% N23 = (eta*(xi^2 - 1)*(zta^2 - 1)*(eta + 1))/2;
% 
% N24 = (xi*(eta^2 - 1)*(zta^2 - 1)*(xi - 1))/2;
% 
% N25 = (zta*(eta^2 - 1)*(xi^2 - 1)*(zta - 1))/2;
% 
% N26 = (zta*(eta^2 - 1)*(xi^2 - 1)*(zta + 1))/2;
% 
% N27 = -(eta^2 - 1)*(xi^2 - 1)*(zta^2 - 1);
%
%% Derivatives of shape functions
% wrt. ksi:
%
% dN1 = (eta*xi*zta*(eta - 1)*(zta - 1))/8 + (eta*zta*(eta - 1)*(xi - 1)*(zta - 1))/8;
% 
% dN2 = (eta*xi*zta*(eta - 1)*(zta - 1))/8 + (eta*zta*(eta - 1)*(xi + 1)*(zta - 1))/8;
% 
% dN3 = (eta*xi*zta*(eta + 1)*(zta - 1))/8 + (eta*zta*(eta + 1)*(xi + 1)*(zta - 1))/8;
% 
% dN4 = (eta*xi*zta*(eta + 1)*(zta - 1))/8 + (eta*zta*(eta + 1)*(xi - 1)*(zta - 1))/8;
% 
% dN5 = (eta*xi*zta*(eta - 1)*(zta + 1))/8 + (eta*zta*(eta - 1)*(xi - 1)*(zta + 1))/8;
% 
% dN6 = (eta*xi*zta*(eta - 1)*(zta + 1))/8 + (eta*zta*(eta - 1)*(xi + 1)*(zta + 1))/8;
% 
% dN7 = (eta*xi*zta*(eta + 1)*(zta + 1))/8 + (eta*zta*(eta + 1)*(xi + 1)*(zta + 1))/8;
% 
% dN8 = (eta*xi*zta*(eta + 1)*(zta + 1))/8 + (eta*zta*(eta + 1)*(xi - 1)*(zta + 1))/8;
% 
% dN9 = -(eta*xi*zta*(eta - 1)*(zta - 1))/2;
% 
% dN10 = - (xi*zta*(eta^2 - 1)*(zta - 1))/4 - (zta*(eta^2 - 1)*(xi + 1)*(zta - 1))/4;
% 
% dN11 = -(eta*xi*zta*(eta + 1)*(zta - 1))/2;
% 
% dN12 = - (xi*zta*(eta^2 - 1)*(zta - 1))/4 - (zta*(eta^2 - 1)*(xi - 1)*(zta - 1))/4;
% 
% dN13 = -(eta*xi*zta*(eta - 1)*(zta + 1))/2;
% 
% dN14 = - (xi*zta*(eta^2 - 1)*(zta + 1))/4 - (zta*(eta^2 - 1)*(xi + 1)*(zta + 1))/4;
% 
% dN15 = -(eta*xi*zta*(eta + 1)*(zta + 1))/2;
% 
% dN16 = - (xi*zta*(eta^2 - 1)*(zta + 1))/4 - (zta*(eta^2 - 1)*(xi - 1)*(zta + 1))/4;
% 
% dN17 = - (eta*xi*(zta^2 - 1)*(eta - 1))/4 - (eta*(zta^2 - 1)*(eta - 1)*(xi - 1))/4;
% 
% dN18 = - (eta*xi*(zta^2 - 1)*(eta - 1))/4 - (eta*(zta^2 - 1)*(eta - 1)*(xi + 1))/4;
% 
% dN19 = - (eta*xi*(zta^2 - 1)*(eta + 1))/4 - (eta*(zta^2 - 1)*(eta + 1)*(xi + 1))/4;
% 
% dN20 = - (eta*xi*(zta^2 - 1)*(eta + 1))/4 - (eta*(zta^2 - 1)*(eta + 1)*(xi - 1))/4;
% 
% dN21 = eta*xi*(zta^2 - 1)*(eta - 1);
% 
% dN22 = (xi*(eta^2 - 1)*(zta^2 - 1))/2 + ((eta^2 - 1)*(zta^2 - 1)*(xi + 1))/2;
% 
% dN23 = eta*xi*(zta^2 - 1)*(eta + 1);
% 
% dN24 = (xi*(eta^2 - 1)*(zta^2 - 1))/2 + ((eta^2 - 1)*(zta^2 - 1)*(xi - 1))/2;
% 
% dN25 = xi*zta*(eta^2 - 1)*(zta - 1);
% 
% dN26 = xi*zta*(eta^2 - 1)*(zta + 1);
% 
% dN27 = -2*xi*(eta^2 - 1)*(zta^2 - 1);
%
%
% wrt. eta:
%
% dN28 = (eta*xi*zta*(xi - 1)*(zta - 1))/8 + (xi*zta*(eta - 1)*(xi - 1)*(zta - 1))/8;
% 
% dN29 = (eta*xi*zta*(xi + 1)*(zta - 1))/8 + (xi*zta*(eta - 1)*(xi + 1)*(zta - 1))/8;
% 
% dN30 = (eta*xi*zta*(xi + 1)*(zta - 1))/8 + (xi*zta*(eta + 1)*(xi + 1)*(zta - 1))/8;
% 
% dN31 = (eta*xi*zta*(xi - 1)*(zta - 1))/8 + (xi*zta*(eta + 1)*(xi - 1)*(zta - 1))/8;
% 
% dN32 = (eta*xi*zta*(xi - 1)*(zta + 1))/8 + (xi*zta*(eta - 1)*(xi - 1)*(zta + 1))/8;
% 
% dN33 = (eta*xi*zta*(xi + 1)*(zta + 1))/8 + (xi*zta*(eta - 1)*(xi + 1)*(zta + 1))/8;
% 
% dN34 = (eta*xi*zta*(xi + 1)*(zta + 1))/8 + (xi*zta*(eta + 1)*(xi + 1)*(zta + 1))/8;
% 
% dN35 = (eta*xi*zta*(xi - 1)*(zta + 1))/8 + (xi*zta*(eta + 1)*(xi - 1)*(zta + 1))/8;
% 
% dN36 = - (eta*zta*(xi^2 - 1)*(zta - 1))/4 - (zta*(xi^2 - 1)*(eta - 1)*(zta - 1))/4;
% 
% dN37 = -(eta*xi*zta*(xi + 1)*(zta - 1))/2;
% 
% dN38 = - (eta*zta*(xi^2 - 1)*(zta - 1))/4 - (zta*(xi^2 - 1)*(eta + 1)*(zta - 1))/4;
% 
% dN39 = -(eta*xi*zta*(xi - 1)*(zta - 1))/2;
% 
% dN40 = - (eta*zta*(xi^2 - 1)*(zta + 1))/4 - (zta*(xi^2 - 1)*(eta - 1)*(zta + 1))/4;
% 
% dN41 = -(eta*xi*zta*(xi + 1)*(zta + 1))/2;
% 
% dN42 = - (eta*zta*(xi^2 - 1)*(zta + 1))/4 - (zta*(xi^2 - 1)*(eta + 1)*(zta + 1))/4;
% 
% dN43 = -(eta*xi*zta*(xi - 1)*(zta + 1))/2;
% 
% dN44 = - (eta*xi*(zta^2 - 1)*(xi - 1))/4 - (xi*(zta^2 - 1)*(eta - 1)*(xi - 1))/4;
% 
% dN45 = - (eta*xi*(zta^2 - 1)*(xi + 1))/4 - (xi*(zta^2 - 1)*(eta - 1)*(xi + 1))/4;
% 
% dN46 = - (eta*xi*(zta^2 - 1)*(xi + 1))/4 - (xi*(zta^2 - 1)*(eta + 1)*(xi + 1))/4;
% 
% dN47 = - (eta*xi*(zta^2 - 1)*(xi - 1))/4 - (xi*(zta^2 - 1)*(eta + 1)*(xi - 1))/4;
% 
% dN48 = (eta*(xi^2 - 1)*(zta^2 - 1))/2 + ((xi^2 - 1)*(zta^2 - 1)*(eta - 1))/2;
% 
% dN49 = eta*xi*(zta^2 - 1)*(xi + 1);
% 
% dN50 = (eta*(xi^2 - 1)*(zta^2 - 1))/2 + ((xi^2 - 1)*(zta^2 - 1)*(eta + 1))/2;
% 
% dN51 = eta*xi*(zta^2 - 1)*(xi - 1);
% 
% dN52 = eta*zta*(xi^2 - 1)*(zta - 1);
% 
% dN53 = eta*zta*(xi^2 - 1)*(zta + 1);
% 
% dN54 = -2*eta*(xi^2 - 1)*(zta^2 - 1);
%
%
% wrt. zeta:
%
% dN55 = (eta*xi*zta*(eta - 1)*(xi - 1))/8 + (eta*xi*(eta - 1)*(xi - 1)*(zta - 1))/8;
% 
% dN56 = (eta*xi*zta*(eta - 1)*(xi + 1))/8 + (eta*xi*(eta - 1)*(xi + 1)*(zta - 1))/8;
% 
% dN57 = (eta*xi*zta*(eta + 1)*(xi + 1))/8 + (eta*xi*(eta + 1)*(xi + 1)*(zta - 1))/8;
% 
% dN58 = (eta*xi*zta*(eta + 1)*(xi - 1))/8 + (eta*xi*(eta + 1)*(xi - 1)*(zta - 1))/8;
% 
% dN59 = (eta*xi*zta*(eta - 1)*(xi - 1))/8 + (eta*xi*(eta - 1)*(xi - 1)*(zta + 1))/8;
% 
% dN60 = (eta*xi*zta*(eta - 1)*(xi + 1))/8 + (eta*xi*(eta - 1)*(xi + 1)*(zta + 1))/8;
% 
% dN61 = (eta*xi*zta*(eta + 1)*(xi + 1))/8 + (eta*xi*(eta + 1)*(xi + 1)*(zta + 1))/8;
% 
% dN62 = (eta*xi*zta*(eta + 1)*(xi - 1))/8 + (eta*xi*(eta + 1)*(xi - 1)*(zta + 1))/8;
% 
% dN63 = - (eta*zta*(xi^2 - 1)*(eta - 1))/4 - (eta*(xi^2 - 1)*(eta - 1)*(zta - 1))/4;
% 
% dN64 = - (xi*zta*(eta^2 - 1)*(xi + 1))/4 - (xi*(eta^2 - 1)*(xi + 1)*(zta - 1))/4;
% 
% dN65 = - (eta*zta*(xi^2 - 1)*(eta + 1))/4 - (eta*(xi^2 - 1)*(eta + 1)*(zta - 1))/4;
% 
% dN66 = - (xi*zta*(eta^2 - 1)*(xi - 1))/4 - (xi*(eta^2 - 1)*(xi - 1)*(zta - 1))/4;
% 
% dN67 = - (eta*zta*(xi^2 - 1)*(eta - 1))/4 - (eta*(xi^2 - 1)*(eta - 1)*(zta + 1))/4;
% 
% dN68 = - (xi*zta*(eta^2 - 1)*(xi + 1))/4 - (xi*(eta^2 - 1)*(xi + 1)*(zta + 1))/4;
% 
% dN69 = - (eta*zta*(xi^2 - 1)*(eta + 1))/4 - (eta*(xi^2 - 1)*(eta + 1)*(zta + 1))/4;
% 
% dN70 = - (xi*zta*(eta^2 - 1)*(xi - 1))/4 - (xi*(eta^2 - 1)*(xi - 1)*(zta + 1))/4;
% 
% dN71 = -(eta*xi*zta*(eta - 1)*(xi - 1))/2;
% 
% dN72 = -(eta*xi*zta*(eta - 1)*(xi + 1))/2;
% 
% dN73 = -(eta*xi*zta*(eta + 1)*(xi + 1))/2;
% 
% dN74 = -(eta*xi*zta*(eta + 1)*(xi - 1))/2;
% 
% dN75 = eta*zta*(xi^2 - 1)*(eta - 1);
% 
% dN76 = xi*zta*(eta^2 - 1)*(xi + 1);
% 
% dN77 = eta*zta*(xi^2 - 1)*(eta + 1);
% 
% dN78 = xi*zta*(eta^2 - 1)*(xi - 1);
% 
% dN79 = (zta*(eta^2 - 1)*(xi^2 - 1))/2 + ((eta^2 - 1)*(xi^2 - 1)*(zta - 1))/2;
% 
% dN80 = (zta*(eta^2 - 1)*(xi^2 - 1))/2 + ((eta^2 - 1)*(xi^2 - 1)*(zta + 1))/2;
% 
% dN81 = -2*zta*(eta^2 - 1)*(xi^2 - 1);
%
%%
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%