%% calcBKB
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%
% Computes the product B'*K*B in a vectorized fashion, where B are the
% shape function derivatives. This is used internally by <Assemble_LHS_help
% Assemble_LHS>
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
% Date 28-Mar-2014
%
% Department of Land Air and Water
%
% University of California Davis
%
%% Usage
% BKB = calcBKB(B, K, opt, ii)
% 
%% Input
% _*B*_: [Nel x N_sh^2] contains the contributions of each element to the final
%      conductance matrix
%
% _*K*_ : [Nel x Nanis] Hydraulic conductiviy element values. The number of columns 
%     is defined by the anisotropy. Maximum number is 3.
%
% _*opt*_ : Structure variable with the following fields
%
% _dim_ : dimension of the elements
%
% _el_type_ : the element type
%
% _el_order_ : the element order
%
% _*ii*_ : In case of nested assembly this indicates the iteration. In
%       vectorized assembly this is not used 
%
%% Output
% _*BKB*_: the product B'*K*B
%%
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%