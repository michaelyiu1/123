%% integr_order
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%
%
% Returns the gaussian integration points and weights for a given type of
% elements.
%
% *NOTE: Need to go through this function again*
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
% pint = integr_order(opt)
%
%% Input
% _*opt*_: a structure with the following fields:
%
% _dim_ : dimension of elements 1, 2, 3
%
% _el_type_: element type e.g. 'triangle','quad','prism','hex'
%
% _int_ord_: THis defines the number of gaussing quadrature. (*The input
% values are quite weird now and need to be fixed*)
%% Output:
% pint : [np x ndim+1] Martix that contains the integration points
% in local coordinates
% np is the number of gaussian quadrature points
% ndim is the dimension of the problem plus the integration weights
%% Example
% Set the options for 2D triangles
opt.dim = 2;
opt.el_type = 'triangle';
%%
% For linear triange elements set
opt.int_ord = 3; 
pint = integr_order(opt)
%%
% For quadratic triangle elements set
opt.int_ord = 6; 
pint = integr_order(opt)
%%
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%