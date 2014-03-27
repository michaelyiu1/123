%% ParticleTracking_main
%
% This is the main particle tracking function. This is only a wrapper
% function for the various implementations of the particle tracking
% routine. Currently particle tracking is available only for linear prism
% elements, and the adaptive Runge-Kutta 45 time stepping scheme is the only option.
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
% [XYZ Vxyz exitflag] = ParticleTracking_main(sp, XY, Z, MSH, B, H, K, por, opt)
%
%% Input:
%
% _*sp*_ : [n_part x 3] starting positions of the particles
%
% _*XY*_ : [Np x 2] the x-y coordinates of the mesh nodes. It is assumed
% that the nodes on every layer have the same x-y coordinates and different
% Z coordinates.
%
% _*Z*_ : [Np x Nlay] are the z coordinates of the mesh nodes. Each column
% has the coordinates for a different layer. Column 1 has the elevations of
% the top layer and the last column the elevations of the bottom layer.
%
% _*MSH*_ : [Nel xN pel] is the 2D mesh, where Nel is
% the number of 2D elements and Npel is the number of dof per element
%
% _*B*_ : is the element connectivity of the 2D Mesh. This is generated
% using the Build2Dmeshinfocpp function.
%
% _*H*_ : [Np x Nlay] is the head distribution formatted in a similar
% manner as the elevation matrix _*Z*_.
%
% _*K*_ : is a cell array with 3 rows at most. Each row is a [Np or Nel x Nlay]
% matrix. If 3 rows are given Kx = K{1,1}, Ky = K{2,1}, Kz = K{3,1}
% If 2 rows are given Kx = Ky = K{1,1}, Kz = K{2,1}
% If 2 row is given Kx = Ky = Kz = K{1,1}. Each array is formatted in a
% similar to elevation matrix _*Z*_. If the number of rows is equal to Np
% the it is assumed that hydraulic conductivity is defined on nodes. If the
% number of rows is equal to Nel it is assumed that the hydraulic
% conductivity is defined on elements.
%
% _*por*_ : is porosity and it is either a scalar or a matrix [Np or Nel x Nlay] 
%
% _*opt*_ : is an option structure. For details see <part_options_help.html
% |part_options|>.
%
%% Output:
% _*XYZ*_ : is a cell array with rows equal to number of starting position
% particles. Each cell contains the coordinates of a streamline. You can
% plot the streamlines all toghether using the 
% <http://www.mathworks.com/help/matlab/ref/streamline.html streamline>
% function e.g. streamline(XYZ)
%
% _*Vxyz*_ : is a cell array with same format as the XYZ. This array
% contains the velocities at each position of the streamline.
%
% _*exitflag*_ : gives the reason for terminating the particle tracking.
% For example : -8 Initial position of particle is outside of the
% domain; -1 the Particle has stucked in the flow field (Yes that can happend!!);
% 2 Particle exits from the side That's can be ok unless the side is no 
% flow boundary. (Unfortunatelyl that can happend too); 1 Particle exits 
% normally from the top surface; -9 Particle exits from the bottom; That's
% not ok if the bottom is no flow boundary. To avoid this set the option 
% _*bed_corr*_ to true (see <part_options_help.html
% |part_options|>).
%
%