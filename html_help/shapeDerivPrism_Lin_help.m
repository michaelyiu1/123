%% shapeDerivPrism_Lin
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%
%
% Computes the shape function derivatives and the determinant of the 
% jacobian matrix for linear prism elements.
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
% [B Jdet] = shapeDerivPrism_Lin(p, TRI, n)
%
%% Input
% _*p*_: [Np x 3] Coodrinates of nodes [x1 y1 z1; x2 y2 z2;...xn yn zn],
% where _Np_ is the number of nodes
%
% _*TRI*_: [Nel x Np_el] id of elements. Each row correspond to an element.
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
% N1 = (1-xi-eta)*(1-zta)/2;
%
% N2 = xi*(1-zta)/2;
%
% N3 = eta*(1-zta)/2;
%
% N4 = (1-xi-eta)*(1+zta)/2;
%
% N5 = xi*(1+zta)/2;
%
% N6 = eta*(1+zta)/2;
%
%% Derivatives of shape functions
% wrt. ksi:
%
% dN1 = 1/2 - zta/2;
%
% dN2 = 0;
%
% dN3 = zta/2 - 1/2;
%
% dN4 = zta/2 + 1/2;
%
% dN5 = 0;
%
% dN6 = - zta/2 - 1/2;
%
%
% wrt. eta:
%
% dN7 = 0;
%
% dN8 = 1/2 - zta/2;
%
% dN9 = zta/2 - 1/2;
%
% dN10 = 0;
%
% dN11 = zta/2 + 1/2;
%
% dN12 = - zta/2 - 1/2;
%
%
% wrt. zeta:
%
% dN13 = -xi/2;
%
% dN14 = -eta/2;
%
% dN15 = eta/2 + xi/2 - 1/2;
%
% dN16 = xi/2;
%
% dN17 = eta/2;
%
% dN18 = 1/2 - xi/2 - eta/2;
%
%%
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%