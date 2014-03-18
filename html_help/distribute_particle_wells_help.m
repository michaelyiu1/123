%% distribute_particle_wells
%
% Distributes uniformly the particles around the well screens.
% Well screens are assumed to be vertical lines defined by x, y,
% top and bottom elevation of the well screen.
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
% [xp, yp, zp, id_well] = distribute_particle_wells(wells, opt)
%
%% Input:
%
% _*wells*_  is a structure with the following fields
%
%   X: x coordinate
%
%   Y: y coordinate
%
%   zt: top elevation of the well screen
%
%   zb: bottom elevation of the well screen
%
% _*opt*_  is a structure that passes various options with the following fields
%
%   radius: distance between the released particle and the x,y location of the well
%
%   Nl: number of layers
%
%   Nppl: Number of particles per layer
% 
%% Output:
% _*xp, yp, zp*_ Coordinates of the initial particle positions
