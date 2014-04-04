%% iscw
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%
% Checks if the elements of the mesh are in clockwise orientation. Although
% Matlab has a similar built in function  
% <http://www.mathworks.com/help/map/ref/ispolycw.html ispolycw>
% this function is vectorized for 2D meshes
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
% tf = iscw(p, MSH)
%
% Input
% _*p*_ : Mesh node coordinates [ np x 2]
% _*MSH*_ : Mesh [Nel x Nsh]
%
%% Output
% _tf*_: true if the polygon orientation is clockwise
%
%% Example
% Create a hypothetical mesh
p = 10*rand(10,2);
MSH = delaunay(p(:,1), p(:,2));
%%%
% Check the all element mesh orientation without looping through each element
tf=iscw(p,MSH)
%%
% Lets reverse the orientation
MSH = [MSH(:,1) MSH(:,3) MSH(:,2)];
tf=iscw(p,MSH)
%%
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%