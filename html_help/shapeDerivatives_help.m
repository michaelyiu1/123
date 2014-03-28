%% shapeDerivatives
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%
%
% Computes the shape function derivatives and the determinant of the
% Jacobian matrix
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
%% Usage
% [B Jdet]=shapeDerivatives(p, MSH, n, opt)
%
%% Input
% _*p*_: [Np x 3] Coodrinates of nodes [x1 y1 z1; x2 y2 z2;...xn yn zn], 
% Np is the number of nodes
%
% _*MSH*_ : [Nel x Np_el] id of elements. Each row correspond to an
% element.
% Nel is the number of elements.
% Np_el is the number of nodes to define the element.
%
% _*n*_: the intergration point where the derivatives will be evaluated
%
% _*opt*_ : Structure with the following fields
%
% _dim_: Dimension of the problem : 1, 2 or 3.
%
% _el_type_: type of element e.g. triangle, prism etc... 
%
% _el_order_: order of the element: linear or quadratic 
% 
%% Output
% _*B*_    : Shape function derivatives
%
% _*Jdet*_ : The determinant of the Jacobian Matrix 
%%
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%
%