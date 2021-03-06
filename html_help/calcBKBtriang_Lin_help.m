%% calcBKBtriang_Lin
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%
% Computes the product B' x K x B for 21D linear triangle elements in vectorized manner
% This is used internally from <calcBKB_help.html calcBKB>.
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
% BKB = calcBKBtriang_Lin(B, K, ii)
%% Input
% _*B*_: [Nel x N_sh^2] contains the contributions of each element to the final
%      conductance matrix
%
% _*K*_ : [Nel x Nanis] Hydraulic conductiviy element values. The number of columns 
%     is defined by the anisotropy. Maximum number is 3.
%
% _*ii*_ : In case of nested assembly this indicates the iteration. In
%       vectorized assembly this is not used 
%
%% Output
% _*BKB*_: the product B'*K*B
%% How to compute
% In mSim we avoid by hand computations at all costs, therefore we used the symbolic 
% toolbox to perform the vectorized computations. The following code show 
% how we computed the products.
syms b1 b2 b3
syms b4 b5 b6
syms kx ky
B=[b1 b2 b3; b4 b5 b6];
BT = [b1 b4;b2 b5; b3 b6];
BKB = BT*[kx 0; 0 ky]*B
%%
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%