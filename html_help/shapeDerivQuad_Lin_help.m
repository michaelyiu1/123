%% shapeDerivQuad_Lin
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%
%
% Computes the shape function derivatives and the determinant of the 
% jacobian matrix for quadrilateral linear elements.
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
% [B Jdet] = shapeDerivQuad_Lin(p, MSH, n, proj)
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
% _*proj*_ : if proj is true then the elements will be projected on the 2D
% plane before computing the determinant usign <mapElemto2D_help.html mapElemto2D>
%% Output
% _*B*_: Shape function derivatives
%
% _*Jdet*_: The determinant of the Jacobian Matrix 
%
%% Shape functions
% N1=0.25*(1-ksi)*(1-eta)
%
% N2=0.25*(1+ksi)*(1-eta)
%
% N3=0.25*(1+ksi)*(1+eta)
%
% N4=0.25*(1-ksi)*(1+eta)
%
%% Derivatives of shape functions
% dN1=eta/4 - 1/4; dN2=1/4 - eta/4;  dN3=eta/4 + 1/4; dN4=- eta/4 - 1/4; (wrt. ksi)
%
% dN5=ksi/4 - 1/4; dN6=- ksi/4 - 1/4; dN7=ksi/4 + 1/4; dN8=1/4 - ksi/4; (wrt. eta)
%
%%
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%