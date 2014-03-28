%% SteadyFlowTransport
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%
% Solves the Advection dispersion equation for steady state flow
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
% C = SteadyFlowTransport(Mglo, Dglo, F, Cinit, T, c, theta)
%
%% Input
% Most of the inputs of this function are outputs of <Assemble_LHS_std_help.html
% Assemble_LHS_std>
%
% _*Mglo*_: Sorption global Matrix
%
% _*Dglo*_: Avection dispersion global Matrix
%
% _*F*_: Right hand side vector
%
% _*Cinit*_: Initial concentration
%
% _*T*_: time steps
%
% _*c*_     : Dirichlet boundary conditions (see Assemble_LHS_std)
%
% _*theta*_ : defines the time differentiation scheme. e.g 0.5 -> Crank–Nicolson
% 0 -> Forward Euler, 1-> Backward Euler
%
%% Output
% _*C*_: Distribution of solution
%
%%
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%