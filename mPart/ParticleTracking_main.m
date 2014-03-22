function [XYZ Vxyz exitflag]=ParticleTracking_main(sp,XY,Z,MSH,B,H,K,por,opt)
% [XYZ, Vxyz, exitflag]=ParticleTracking_main(sp,XY,Z,MSH,B,H,K,por,opt)
%
% This is the main particle tracking function. This is only a wrapper
% function for the various implementations of the particle tracking
% routine. Currently particle tracking is available only for linear prism
% elements, and the adaptive Rubge-Kutta 45 time stepping scheme is the only option.
%
% INPUTS:
% sp : [n_partx3] starting positions of the particles
%
% XY : [Np x 2] the x-y coordinates of the mesh nodes. It is assumed
%       that the nodes on every layer have the same x-y coordinates and different
%       Z coordinates.
%
% Z : [Np x Nlay] are the z coordinates of the mesh nodes. Each column
%       has the coordinates for a different layer. Column 1 has the elevations of
%       the top layer and the last column the elevations of the bottom layer.
%
% MSH : [NelxNpel] is the 2D mesh, where Nel is
%       the number of 2D elements and Npel is the number of dof per element
%
% B :   is the element connectivity of the 2D Mesh. This is generated
%       using the Build2Dmeshinfocpp function.
%
% H : [Np x Nlay] is the head distribution formatted in a similar
%       manner as the elevation matrix Z.
%
% K : is a cell array with 3 rows at most. Each row is a [Np or Nel x Nlay]
%       matrix. 
%       If 3 rows are given Kx = K{1,1}, Ky = K{2,1}, Kz = K{3,1}
%       If 2 rows are given Kx = Ky = K{1,1}, Kz = K{2,1}
%       If 2 row is given Kx = Ky = Kz = K{1,1}. 
%       Each array is formatted in a similar to elevation matrix _*Z*_.
%       If the number of rows is equal to Np
%       the it is assumed that hydraulic conductivity is defined on nodes. If the
%       number of rows is equal to Nel it is assumed that the hydraulic
%       conductivity is defined on elements.
%
% por : is porosity and it is either a scalar or a matrix [Np or Nel x Nlay] 
%
% opt : is an option structure. For details see part_options function
%
% Output
% XYZ : is a cell array with rows equal to number of starting position
%       particles. Each cell contains the coordinates of a streamline. You can
%       plot the streamlines all toghether using the  streamline function e.g. streamline(XYZ)
%
% Vxyz : is a cell array with same format as the XYZ. This array
%       contains the velocities at each position of the streamline.
%
% exitflag : gives the reason for terminating the particle tracking.
%         -8 -> Initial position of particle is outside of the
%         -1 -> the Particle has stucked in the flow field (Yes that can happend!!);
%          2 -> Particle exits from the side That's can be ok unless the side is no 
%               flow boundary. (Unfortunatelyl that can happend too); 
%          1 -> Particle exits  normally from the top surface; 
%         -9 -> Particle exits from the bottom; That's % not ok if the 
%               bottom is no flow boundary. To avoid this set the option 
%               bed_corr to true (see part_options).
%
% Version : 1.0
% Author : George Kourakos
% email: giorgk@gmail.com
% web : http://groundwater.ucdavis.edu/msim
% Date 09-May_2013
% Department of Land Air and Water
% University of California Davis


Npoints=size(XY,1);
Nelem=size(MSH,1);
if size(K,1)==1;
	Kx=K{1,1};Ky=-1;Kz=-1;
elseif size(K,1)==2
	Kx=K{1,1};Kz=K{2,1};Ky=-1;
elseif size(K,1)==3
	Kx=K{1,1};Ky=K{2,1};Kz=K{3,1};
end

if size(por,1)==Npoints
	opt.porenodes=1;
    opt.porinterp = 1;
elseif size(por,1)==Nelem
	opt.pornodes=0;
    opt.porinterp = 0;
elseif size(por,1)==1
	opt.pornodes=-1;
    opt.porinterp = 0;
end

opt.Nel=Nelem;
opt.Np=Npoints;
if opt.el_type==1
	opt.Nsides=3;
    if size(MSH,2) == 3
        opt.el_order = 1;
    elseif size(MSH,2) == 6
        opt.el_order = 2;
    end
        
elseif opt.el_type==2
	opt.Nsides=4;
    if size(MSH,2) == 4
        opt.el_order = 1;
    elseif size(MSH,2) == 9
        opt.el_order = 2;
    end
end
opt.Nsh=size(MSH,2);
opt.Nlay=size(H,2);

if strcmp(opt.method, 'RK45'); opt.method = 4;end
if strcmp(opt.method, 'euler'); opt.method = 1;end
if strcmp(opt.method, 'RK2'); opt.method = 2;end
if strcmp(opt.method, 'RK4'); opt.method = 3;end
opt.valid = false;
if ~isfield(opt,'ploton');ploton = 1;end
	
newopt = order_structure(opt);
XYZ{size(sp,1),1}=[];
Vxyz{size(sp,1),1}=[];
exitflag = nan(size(sp,1),1);
switch opt.mode
	case 'cpp'
        if exist('OCTAVE_VERSION')
            for i = 1:size(sp,1)
                if opt.ploton
                    fprintf('%3d\n',i);
                end
                [tXYZ tVxyz texitflag]=Part_Track_oct(sp(i,:),XY,Z,MSH,B,H,Kx,Ky,Kz,por,newopt);
                id_zr=find(tXYZ(:,1)==0,1,'first');
                tXYZ(id_zr:end,:)=[];
                tVxyz(id_zr:end,:)=[];
                XYZ{i,1} = tXYZ;
                Vxyz{i,1} = tVxyz;
                exitflag(i,1) = texitflag;
            end
        else
            for i = 1:size(sp,1)
                if opt.ploton
                    fprintf('%3d\n',i);
                end
                [tXYZ tVxyz texitflag]=Part_Track_mat(sp(i,:),XY,Z,MSH,B,H,Kx,Ky,Kz,por,newopt);
                id_zr=find(tXYZ(:,1)==0,1,'first');
                tXYZ(id_zr:end,:)=[];
                tVxyz(id_zr:end,:)=[];
                XYZ{i,1} = tXYZ;
                Vxyz{i,1} = tVxyz;
                exitflag(i,1) = texitflag;
            end
        end
    case 'vect'
        if newopt.el_type == 1
            [XYZ, Vxyz, exitflag]=ParticleTracking_prism_par(sp,XY,Z,MSH,B,H,Kx,Ky,Kz,por,opt);
        end
    case 'serial'
        for i = 1:size(sp,1)
            if opt.ploton
                fprintf('%3d\n',i);
            end
            [tXYZ tVxyz texitflag]=ParticleTracking_prism_par(sp(i,:),XY,Z,MSH,B,H,Kx,Ky,Kz,por,opt);
            XYZ{i,1} = tXYZ;
            Vxyz{i,1} = tVxyz;
            exitflag(i,1) = texitflag;
        end
        
        
        
end


function newopt = order_structure(opt)
fieldnames = {'Nal','search','bed_corr','Knodes','step','minstep','errmin',...
    'errmax','method','pornodes','porinterp','Ngen','maxstep',...
    'stall_times','el_type','el_order','valid','Nel','Np','Nsides','Nsh','Nlay'};
for i = 1 :length(fieldnames)
    eval([ 'newopt.' fieldnames{i} ' = opt.' fieldnames{i} ';']);
end



