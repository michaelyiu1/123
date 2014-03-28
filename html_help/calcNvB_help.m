%% calcNvB
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%
% 
% Computes the product N x v x B in vectorized manner, where N are the
% shape function values, v is the velocity and B the shape function
% derivatives. This function is used internally. Based on the options
% selects the appropriate function to perform the vectorized computations
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
% NvB = calcNvB(N, v, B, opt, ii)
%
%% Input
% _*N*_: shape functions
%
% _*v*_: velocity
%
% _*B*_: shape function derivatives
%
% _*opt*_: option structure. for details see <Assemble_LHS_std_help.html
% Assemble_LHS_std>
%
% _*ii*_: in case of nested calculation this defines which loop well be
% calculated. (Currently this is not used)
%
%% Output
% _*NvB*_: the product N x v x B computed in vectorized manner
%
%%
%
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%