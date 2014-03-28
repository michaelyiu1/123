%% ConvoluteURF
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%
% This function convolutes the unit response function with loading
% functions. 
%
% Version : 1.0
%
% Author : George Kourakos
%
% email: giorgk@gmail.com
%
% web : http://groundwater.ucdavis.edu/msim
%
% Date 2-Apr-2012
%
% Department of Land Air and Water
%
% University of California Davis
%
%% Usage
% BTC = ConvoluteURF(URF, LF, mode)
%
%% Input:
% _*URF*_: are the unit response functions [Ns x Nt] where Ns is the number of
% streamlines or in general the number of independent URFs and Nt is
% the number of discretization steps of the URF.
%
% _*LF*_: are the loading functions [Ns x Nt_lf] where Ns is the number of
%    indepedent loading functions and Nt_lf are the number of steps that
%    the loading functions are discretized. 
%
% If size(LF,1) == 1 then the same loading function will be convoluted with all URF
%
% _IMPORTANT NOTE:_ 
% The step size in URF and LF must be the same otherwise the results
%  will be wrong.
%
% _*mode*_: The recomended mode is the 'cpp'. However if mex or oct are not available
%     the 'vect' option can be used. There is also the 'serial' option for
%     debuging only!
%    
%
%% Output data 
% _*BTC*_: The Breakthrough curve that coresponds to convolution of the i URF
% with the i loading function 
%%
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%