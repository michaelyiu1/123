%% shapeDerivQuad_quad_9
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%
%
% Computes the shape function derivatives and the determinant of the 
% jacobian matrix for quadratic quadrilateral elements.
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
% [B Jdet] = shapeDerivQuad_quad_9(p, MSH, n, proj)
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
% N1=0.25*(xi-1)*(eta-1)*xi*eta; N2=0.25*(xi+1)*(eta-1)*xi*eta;
%
% N3=0.25*(xi+1)*(eta+1)*xi*eta; N4=0.25*(xi-1)*(eta+1)*xi*eta;
%
% N5=-0.5*(xi^2-1)*(eta-1)*eta;  N6=-0.5*(xi+1)*(eta^2-1)*xi;
%
% N7=-0.5*(xi^2-1)*(eta+1)*eta;  N8=-0.5*(xi-1)*(eta^2-1)*xi;
%
% N9=(xi^2-1)*(eta^2-1);
%
%% Derivatives of shape functions
% dN1 = (eta*(2*xi - 1)*(eta - 1))/4;  dN2 = (eta*(2*xi + 1)*(eta - 1))/4;  dN3 = (eta*(2*xi + 1)*(eta + 1))/4;
%
% dN4 = (eta*(2*xi - 1)*(eta + 1))/4;  dN5 = -eta*xi*(eta - 1);             dN6 = -((eta^2 - 1)*(2*xi + 1))/2;
%
% dN7 = -eta*xi*(eta + 1);             dN8 = -((eta^2 - 1)*(2*xi - 1))/2;   dN9 = 2*xi*(eta^2 - 1);              (wrt. ksi)
%
%
% dN10 = (xi*(2*eta - 1)*(xi - 1))/4;  dN11 = (xi*(2*eta - 1)*(xi + 1))/4;  dN12 = (xi*(2*eta + 1)*(xi + 1))/4;
%
% dN13 = (xi*(2*eta + 1)*(xi - 1))/4;  dN14 = -((2*eta - 1)*(xi^2 - 1))/2;  dN15 = -eta*xi*(xi + 1);
%
% dN16 = -((2*eta + 1)*(xi^2 - 1))/2;  dN17 = -eta*xi*(xi - 1);             dN18 = 2*eta*(xi^2 - 1);              (wrt. eta)
%
%%
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%