function [xp yp zp id_stream] = distribute_particle_streams(streams, opt)
% [xp yp zp id_stream] = distribute_particle_streams(streams, opt)
%
% Distributes particles around a stream as shown: 
%             Stream
%          .    o    . <-particles
%           . . . . .
%
% Input Data
% streams is a structure with the following fields
%   X: x coordinate
%   Y: y coordinate
%   Z: z coordinate
%
% opt is an option structure with hte following fields:
%   Npsec: Number of particles per section. One section is illustrated
%           above.
%   Dxsec: Distance between sections
%   radius : distance between the particle and the stream
%
% Output Data
% xp yp, zp : coordinates of initial particle positions
% id_stream : the id of the stream each particle is associated
%
% Version : 1.0
% Author : George Kourakos
% email: giorgk@gmail.com
% web : http://groundwater.ucdavis.edu/msim
% Date 09-May_2013
% Department of Land Air and Water
% University of California Davis


if isempty(opt)
    opt.Npsec = 4;
    opt.Dxsec = 20;
    opt.radius = 20;
end


xp = nan(100000,1);
yp = nan(100000,1);
zp = nan(100000,1);
id_stream = nan(100000,1);
cnt = 1;


for i = 1:size(streams,1)
    for j = 1:length(streams(i,1).X) - 1
        if isnan(streams(i,1).X(j)) || isnan(streams(i,1).X(j+1))
            continue
        end
        p1 = [streams(i,1).X(j) streams(i,1).Y(j) streams(i,1).Z(j)];
        p2 = [streams(i,1).X(j+1) streams(i,1).Y(j+1) streams(i,1).Z(j+1)];
        if p1(1)>p2(1) 
            p2 = [streams(i,1).X(j) streams(i,1).Y(j) streams(i,1).Z(j)];
            p1 = [streams(i,1).X(j+1) streams(i,1).Y(j+1) streams(i,1).Z(j+1)];
        end

        %  I keep the plotting code for debug purposes
        % clf
        % plot3([p1(1) p2(1)], [p1(2) p2(2)], [p1(3) p2(3)],'.-r')
        % hold on
        % plot3(p1(1),p1(2),p1(3),'o')
        % view(0,90)
        % drawnow
        
        L = sqrt( (p1(1) - p2(1))^2 + (p1(2) - p2(2))^2 + (p1(3) - p2(3))^2);
        Nlay = round(L/opt.Dxsec);
        Nppl = 2*opt.Npsec + 2;
        
        [xtemp ytemp ztemp] = helix_axis(p1, p2, Nlay, Nppl, opt.radius);
        
        [A B C D] = calc_line_plane(p1, p2);
        % clf
        % plot3(xtemp, ytemp, ztemp, '.-')
        % hold on
        % plot3([p1(1) p2(1)], [p1(2) p2(2)], [p1(3) p2(3)],'.-r')
        % plot3(xtemp,ytemp,(-A.*xtemp - B.*ytemp - D)/C,'.g')
        test = (-A.*xtemp - B.*ytemp - D)/C < ztemp+1;
        xtemp(test,:)=[];
        ytemp(test,:)=[];
        ztemp(test,:)=[];
        % plot3(xtemp, ytemp, ztemp, 'or')
        % drawnow
        
        
        
        ntemp = length(xtemp);
        xp(cnt:cnt+ntemp-1,1) = xtemp;
        yp(cnt:cnt+ntemp-1,1) = ytemp;
        zp(cnt:cnt+ntemp-1,1) = ztemp;
        id_stream(cnt:cnt+ntemp-1,1) = i;
        cnt = cnt+ntemp;
    end
end
xp(cnt:end,:) = [];
yp(cnt:end,:) = [];
zp(cnt:end,:) = [];
id_stream(cnt:end,:) = [];

function [A B C D] = calc_line_plane(p1, p2)
% line equation of the x-y projection of the line
if abs(p2(1) - p1(1)) < 1e-3
    p3(1) = p1(1)+100;
    p3(2) = p1(2);
    p3(3) = p1(3);
elseif abs(p2(2) - p1(2)) < 1e-3
    p3(1) = p1(1);
    p3(2) = p1(2)+100;
    p3(3) = p1(3);
else
    m = (p2(2) - p1(2))/(p2(1) - p1(1));
    b = p1(2) - m*p1(1);
    %The slope of the perpendicular line is
    m = -1/m;
    % find the x,y coordinates of a point along this line
    p3(1) = p1(1)+100;
    p3(2) = m*p3(1) + b;
    p3(3) = p1(3);
end


% find the plane equation defined by p1, p2, p3
A = (p2(2) - p1(2))*(p3(3) - p1(3)) - (p3(2) - p1(2))*(p2(3) - p1(3));
B = (p2(3) - p1(3))*(p3(1) - p1(1)) - (p3(3) - p1(3))*(p2(1) - p1(1));
C = (p2(1) - p1(1))*(p3(2) - p1(2)) - (p3(1) - p1(1))*(p2(2) - p1(2));
D = -(A*p1(1) + B*p1(2) + C*p1(3));








