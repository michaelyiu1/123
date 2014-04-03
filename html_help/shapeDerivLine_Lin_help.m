%% shapeDerivLine_Lin
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%
%
% Computes the shape function derivatives and the determinant for
% of 1D linear isoparametric elements.
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
% [B Jdet]=shapeDerivLine_Lin(p, MSH, n)
%
%% Input
% _*p*_: [Np x 3] Coodrinates of nodes [x1 y1 z1; x2 y2 z2;...xn yn zn],
% where _Np_ is the number of nodes
%
% _*MSH*_: [Nel x Np_el] id of elements. Each row correspond to an element.
% _Nel_ is the number of elements and _Np_el_ is the number of nodes to define the element
%
% _*n*_: the integration point where the derivatives will be evaluated. For
% linear line elements this is empty because the derivative is constant.
%        
%% Output
% _*B*_: Shape function derivatives
%
% _*Jdet*_: The determinant of the Jacobian Matrix 
%
%% Shape functions
% N1 = 0.5 * (1 - xi)
%
% N2 = 0.5 * (1 + xi)
%
%% Derivatives of shape functions
% dN1 = -1/2;
%
% dN2 =  1/2;
%
%%
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%
%