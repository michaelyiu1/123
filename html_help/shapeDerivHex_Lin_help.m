%% shapeDerivHex_Lin
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%
%
% Computes the shape function derivatives and the determinant of the 
% jacobian matrix for hexahedral linear elements.
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
% [B Jdet]=shapeDerivHex_Lin(p, MSH, n)
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
% %% Shape functions
% N1 = 0.125*(1-ksi)*(1-eta)*(1-zta); 
% 
% N2=0.125*(1+ksi)*(1-eta)*(1-zta);
% 
% N3 = 0.125*(1+ksi)*(1+eta)*(1-zta); 
% 
% N4 = 0.125*(1-ksi)*(1+eta)*(1-zta);
% 
% N5 = 0.125*(1-ksi)*(1-eta)*(1+zta); 
% 
% N6 = 0.125*(1+ksi)*(1-eta)*(1+zta);
% 
% N7 = 0.125*(1+ksi)*(1+eta)*(1+zta); 
% 
% N8 = 0.125*(1-ksi)*(1+eta)*(1+zta);
%
%% Derivatives of shape functions
% wrt. ksi:
%
% dN1 = -((eta - 1)*(zta - 1))/8;  
% 
% dN2 = ((eta - 1)*(zta - 1))/8; 
% 
% dN3 = -((eta + 1)*(zta - 1))/8; 
% 
% dN4 = ((eta + 1)*(zta - 1))/8; 
% 
% dN5 = ((eta - 1)*(zta + 1))/8; 
% 
% dN6 = -((eta - 1)*(zta + 1))/8; 
% 
% dN7 = ((eta + 1)*(zta + 1))/8; 
% 
% dN8 = -((eta + 1)*(zta + 1))/8;
%
%
% wrt. eta:
%
% dN9 = -((ksi - 1)*(zta - 1))/8;  
% 
% dN10 = ((ksi + 1)*(zta - 1))/8; 
% 
% dN11 = -((ksi + 1)*(zta - 1))/8; 
% 
% dN12 = ((ksi - 1)*(zta - 1))/8;
% 
% dN13 = ((ksi - 1)*(zta + 1))/8; 
% 
% dN14 = -((ksi + 1)*(zta + 1))/8; 
% 
% dN15 = ((ksi + 1)*(zta + 1))/8; 
% 
% dN16 = -((ksi - 1)*(zta + 1))/8;
%
%
% wrt. zeta:
%
% dN17 = -((eta - 1)*(ksi - 1))/8; 
% 
% dN18 = ((eta - 1)*(ksi + 1))/8; 
% 
% dN19 = -((eta + 1)*(ksi + 1))/8; 
% 
% dN20 = ((eta + 1)*(ksi - 1))/8;
% 
% dN21 = ((eta - 1)*(ksi - 1))/8; 
% 
% dN22 = -((eta - 1)*(ksi + 1))/8; 
% 
% dN23 = ((eta + 1)*(ksi + 1))/8; 
% 
% dN24 = -((eta + 1)*(ksi - 1))/8;
%
%%
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%