%% part_options
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%
% Returns a structure with fields the required options for
% particle tracking
%
% Version : 1.0
%
% Author : George Kourakos
%
% email: giorgk@gmail.com
%
% web : http://groundwater.ucdavis.edu/msim
%
% Date 09-May_2013
%
% Department of Land Air and Water
%
% University of California Davis
%
%% Usage
% opt=part_options
%
%% Input:
% No input arguments
%
%% Output:
% _*opt*_: A structure with the following fields
%
% (Default values are in parentheses)
%
% Knodes (1) :       flag 0-> K values defined on elements, 1-> Kvalues defined of nodes -1 K is one uniform value
%
% Nal (1000) :       Allocation size for the particles
%
% search (50) :      This parameter is used only once in the simulation. 
%                   To identify the element id we compute the minimum distance of the
%                   particle and the barycenter of search elements
%
% bed_corr (false) : This flag impose that no particles should exit from the bottom
%                   Note: that when true value is used, the local velocity field
%                   artificially changes so that particles do not exit from the bottom
%
% ploton (0) :       For debuging only. 0: no plotting, 1: plots the particle positions only 2: plots also the elements
%
% step (5) :         initial step
%
% minstep (5) :      minimum allowable step
%
% errmin (0.01) :    if the error is smaller the step doubles (Used only in  RK45)
%
% errmax (0.1) :     if the error is larger half the step or use minimum step
%
% method (RK45) :    So far its the only option
%
% pornodes (-1) :    0-> porosity defined on elements 1-> porosity defined of nodes -1-> porosity is one uniform value
%
% Ngen (15) :        when exiting on element how many neibor element shoud search to find the id of the current element
%
% maxstep (0.5) :    times the maximum diagonal of the current element
%
% stall_times (100) : If the streamline has not expanded after stall_times steps then quit
%
% freqplot (10) :    This will allow plotting every freqplot steps. 
%
% mode (vect)  :     other options are 'cpp' and 'serial'
%
% el_type (1) :      1-> trianlge, 2-> quadrilateral
%%
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%

