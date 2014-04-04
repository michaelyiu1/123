%% solve_system
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%
%
% Computes the shape functions for a given parametric point and element
% type.
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
% H = solve_system(Kglo, H, F)
%
%% Input
% _*Kglo*_: System matrix 
%
% _*H*_: Solution vector. This function will have scalar values on the
% nodes associated with dirichlet boundary conditions and nan on the
% unknown dofs
%
% _*F*_: The right hand side
%
%% Output
% _*H*_: The solution of the system
%
%%
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%