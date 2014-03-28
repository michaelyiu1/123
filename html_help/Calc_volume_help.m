%% Calc_volume
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%
% Computes the volume of 3D elements in a vectorized manner
% Currently only hexahedrals are supported.
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
% V=Calc_volume(p, MSH)
%
%% Input
% _*p*_ : [Np x 3] coordinates
%
% _*MSH*_ : [Nel, Nsh] Mesh element ids. Nel is the number of elements and
% Nsh is the number of shapefunctions. The ids correspond to the row of the
% array _*p*_
%
%% Output
% _*V*_ : [Nel x 1] The volume of each element
%%
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%
