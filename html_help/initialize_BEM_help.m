%% initialize_BEM
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%
% Initialize the matrix that will hold the shape functions derivatives
% values. This is used internaly during the assemble of glabal conductance matrix 
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
% BEM = initialize_BEM(Nel, opt)
%
%% Inputs
% _*Nel*_: Number of elements
%
% _*opt*_ : structure with the following fields:
%
% _dim_ : dimension of the problem
%
% _el_type_ : element type (e.g. triangle, quad, prism, hex)
%
% _el_order_ : element order, linear or quadratic
%
%% Output: 
% BEM [Nel x N_sh^2], where N_sh is the number of shape functions per element
%
%%
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%