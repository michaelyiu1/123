%% calcNDBline_Lin
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%
% Computes the product N x v x B for 1D linear elements in vectorized manner
% This is used internally from <calcNvB_help.html calcNvB>.
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
% NvB = calcNDBline_Lin(N, v, B, ii)
%
%% Input
% _*N*_: shape functions
%
% _*v*_: velocity
%
% _*B*_: shape function derivatives
%
% _*ii*_: in case of nested calculation this defines which loop well be
% calculated. (Currently this is not used)
%
%% Output
% _*NvB*_: the product N x v x B computed in vectorized manner
%
%% How to compute
% In mSim we avoid by hand computations at all costs, therefore we used the symbolic 
% toolbox to perform the vectorized computations. The following code show 
% how we computed the products.
syms n1 n2 b1 b2 vx
N=[n1; n2];
V=vx;
B=[b1 b2];
N*V*B
%%
%
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%