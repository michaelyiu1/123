%% DispCoeff
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%
% Calculates the dispersion coefficients for given longitudinal and
% transverse coefficient, velocity vectors and molecular diffusion
% coefficient
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
% D = DispCoeff(A,V,Dm)
% 
%% Input
% _*A*_:[aL aTH aTV] an array with the longitudinal and transverse
% coefficients
%
% _*V*_: [n x dim] velocity vectors. The code will assume the dimension of
% the problem by the number of columns of velocity. For example if
% two columns are given then two columns are expected for the A array
% as well.
%
% _*Dm*_: Molecular diffusion coefficient
%
%% Output
% _*D*_: Dispersivity coefficients.
%%
%
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%