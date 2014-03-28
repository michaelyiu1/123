%% Calc_Barycenters
% 
% <msim_help_main.html | main>   <Tutorials | msim_help_demos.html> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%
% Computes the barycenters of mesh elements in a
% vectorized fashion. It works for all element size and types and
% dimensions.
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
% cc = Calc_Barycenters(p, MSH)
%
%% Input:
% _*p*_ : [Np x 2] coordinates
%
% _*MSH*_ : [Nel, Nsh] Mesh element ids. Nel is the number of elements and
% Nsh is the number of shapefunctions. The ids correspond to the row of the
% array _*p*_
%
%% Output
% _*cc*_  : [Nel x dim] coordinates of the element barycenters
%
%% Example
%
% Create a hypothetical mesh
p = 10 * rand(10,2);
MSH = delaunay(p(:,1), p(:,2));
%%%
% Calculate the barycenter of each element and plot
cc = Calc_Barycenters(p,MSH);
triplot(MSH, p(:,1), p(:,2))
hold on
plot(cc(:,1), cc(:,2),'or')
%%
% 
% <msim_help_main.html | main>   <Tutorials | msim_help_demos.html> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%