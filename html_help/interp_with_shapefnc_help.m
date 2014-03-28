%% interp_with_shapefnc
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%
% Interpolate value P defined on nodes using the shape functions N
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
% P_interp = interp_with_shapefnc(N, P, MSH, opt)
%
%% Input
% _*N*_: [1 x N_sh] Shape functions values. This is the outcome of the functions shapefunctions.m
%
% _*P*_ : [Np x 1] The property for interpolation defined on the nodes. Np is
% the number of nodes in the mesh
%
% _*opt*_ : a structure variable with fields:
%
% _dim_: dimension of the elements e.g. 1, 2 or 3
%
% _el_type_: type of elements
%
% _el_order_: order of elements
%
%% Output
% _*P_interp*_: interpolated values on the points defined by the
% shape function values
%
%%
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%