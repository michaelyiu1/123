function [xp, yp, zp, id_well] = distribute_particle_wells(wells, opt)
% [xp, yp, zp, id_well] = distribute_particle_wells(wells, opt)
%
% Distributes uniformly the particles around the well screens.
% Well screens are assumed to be vertical lines defined by x, y,
% top and bottom elevation of the well screen.
%
%
% Input Data
% wells is a structure with the following fields
%   X: x coordinate
%   Y: y coordinate
%   zt: top elevation of the well screen
%   zb: bottom elevation of the well screen
%
% opt is a structure that passes various options with the following fields
%	radius : distance between the released particle and the x,y location of the well
%	Nl : number of layers
%	Nppl: Number of particles per layer
% 
% Output data:
% xp, yp, zp Coordinates of the initial particle positions
%
% Version : 1.0
% Author : George Kourakos
% email: giorgk@gmail.com
% web : http://groundwater.ucdavis.edu/msim
% Date 07-Mar_2013 (Tsiknopempti)
% Department of Land Air and Water
% University of California Davis


if isempty(opt)
    opt.radius = 10;
    opt.Nl = 25;
    opt.Nppl = 4;
end

rads = 2*pi/opt.Nppl;
rads1 = linspace(0,2*pi,opt.Nl);
radpos = nan(opt.Nl, opt.Nppl);
for i = 1:opt.Nl
    radpos(i,:) = linspace(0+rads/2+rads1(1,i),...
                            2*pi - rads/2 + rads1(1,i), opt.Nppl);
end

xp = nan(opt.Nl*opt.Nppl*size(wells,1),1);
yp = nan(opt.Nl*opt.Nppl*size(wells,1),1);
zp = nan(opt.Nl*opt.Nppl*size(wells,1),1);
id_well = nan(opt.Nl*opt.Nppl*size(wells,1),1);
cnt = 1; incr = opt.Nl*opt.Nppl;
for i = 1:size(wells,1)
    zval = linspace(wells(i,1).zb, wells(i,1).zt, opt.Nl);
    xp_i = cos(radpos)*opt.radius + wells(i,1).X;
    yp_i = sin(radpos)*opt.radius + wells(i,1).Y;
    zp_i = repmat(zval', 1, opt.Nppl);
    xp(cnt:cnt+incr-1) = reshape(xp_i, opt.Nl*opt.Nppl, 1);
    yp(cnt:cnt+incr-1) = reshape(yp_i, opt.Nl*opt.Nppl, 1);
    zp(cnt:cnt+incr-1) = reshape(zp_i, opt.Nl*opt.Nppl, 1);
    id_well(cnt:cnt+incr-1) = i;
    cnt=cnt+incr;
end
