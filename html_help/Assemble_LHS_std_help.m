%% Assemble_LHS_std
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%
%
% Assembles the global advection-dispersion and sorption matrix of the
% advection dispersion equation for steady state flow field.
%
% Version : 1.0
%
% Author : George Kourakos
%
% email: giorgk@gmail.com
%
% web : http://groundwater.ucdavis.edu/msim
%
% Date 28-Mar-2014
%
% Department of Land Air and Water
%
% University of California Davis
%
%% Usage
% [Dglo Mglo c]= Assemble_LHS_std(p, MSH, A, V, rho_b, K_d, lambda, theta, Dm, CC, opt)
%
%% Input
% _*p*_: coordinates of the Mesh nodes
%
% _*MSH*_: Mesh structure
%
% _*A*_: dispertivity [aL, aTH, aTV].
%
% _*V*_: velocity
%
% _*rho_b*_: bulk density
%
% _*K_d*_: equilibrium distribution coefficient
%
% _*lambda*_: decay constant
%
% _*theta*_: porosity
%
% _*Dm*_: Molecular diffusion coefficient
%
% _*CC*_: Dirichlet boundary conditions
%
% _*opt*_: option structure with the following fields :
% _assemblemode_ : 'vect' for vectorize or 'nested' (just dont used the
%                       latter)
% _capacmode_ : 'lumped' or 'consistent'
% _int_ord_ : Gaussian intergration order. If the field does not exist a
% default value will be used according to element order
% and the dimension of the problem
% _el_order_ : 'linear' Currently this is the only option for
% transport
% _dim_ : Dimension of the problem.
% _el_type_ : this is the element type.  
%% Output
% _*Dglo*_: Global advection dispersion matrix
% _*Mglo*_: Global sorption matrix
% _*c*_: The unkown concentration vector with nan values for unknown nodes 
% scalar values for the dirichlet nodes
%%
%
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%