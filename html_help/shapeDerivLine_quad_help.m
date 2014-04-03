%% shapeDerivLine_quad
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%
%
% Computes the shape function derivatives and the determinant of the 
% jacobian matrix for 1D quadratic line elements.
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
% [B Jdet] = shapeDerivLine_quad(p, MSH, xi)
%
%% Input
% _*p*_: [Np x 3] Coodrinates of nodes [x1 y1 z1; x2 y2 z2;...xn yn zn],
% where _Np_ is the number of nodes
%
% _*MSH*_: [Nel x Np_el] id of elements. Each row correspond to an element.
% _Nel_ is the number of elements and _Np_el_ is the number of nodes to define the element
%
% _*xi*_: the integration point where the derivatives will be evaluated. 
%        
%% Output
% _*B*_: Shape function derivatives
%
% _*Jdet*_: The determinant of the Jacobian Matrix 
%
%% Shape functions
% N1 = 0.5 * ksi * (ksi - 1)
%
% N2 = 0.5 * ksi * (ksi + 1)
%
% N3 = 1 - ksi^2
%
%% Derivatives of shape functions
% dN1 = ksi - 1/2;
%
% dN2 = ksi + 1/2;
%
% dN3 = -2*ksi;
%
%%
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%