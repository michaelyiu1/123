%% mSim
% *A Matlab Toolbox for the simulation of non-point source pollution*
% (and not only...)

%% Introduction
% The mSim is a collection of matlab functions which solve the
% groundwater flow equation and contaminant transport. The code was primarily 
% written for the simulation of Non-Point Source (NPS) contamination in
% large groundwater basins, however the equations that mSim solves are
% general. For the theoretical documentation of the model see 
% <http://subsurface.gr/index.php/cv/publications/journals/88-pub-2012a (Kourakos et al., 2012)>
% while the description and real world application see 
% <http://subsurface.gr/index.php/cv/publications/journals/92-pub-2014a (Kourakos and Harter 2014)>

%% Overview
% The mSim functions are organized into folders. The current version contains 
% the following folders:
%
% * mFlow :
% Contains functions related to the simulation of groundwater flow.
% * mTrans : 
% Contains functions related to the simulation of Contaminant transport.
% * mPart : 
% Contains functions related to the Particle tracking.
% * mUtil : 
% Contains various utility functions. 
% * mNPSAT : 
% Contains functions related to the Non Point Source Assessment Toolbox.
%

%% Pre/Post Processing
% The mSim is a finite element based model and relies on two external
% softwares for the mesh generation and complex data visualization.
% Gmsh is a free, open source, powerful mesh generator with its
% own scripting language. The mSim functions assist in creating the
% nessecary input files for Gmsh. Note that Gmsh can be executed within
% Matlab.
% 
% For data visualization we recommend the Paraview code. This is also an
% open source code based on the vtk libraries. Again mSim functions convert
% the results of the simulation into appropriate vtk legacy format for 
% direct input to Paraview

%% Limitations - future improvements
% The current version 1.0 has the following limitations:
%
% * Supports only steady state flow simulation
% * Support only 1D steady state transport simulation
% * Particle tracking is based on the head gradient
% * The Gmsh input files created by mSim do not provide great flexibility
% compared to the options offered by Gmsh
% * The output files for displaying with paraview are written in ascii
% format which is rather slow when reading large data sets
%
% The following is the list of features we intent to improve:
%
% # Improve particle tracking algorithm
% # Support of transient state flow
% # Extend the transport simulations to higher dimensions
% # Support transient transport simulation
%





