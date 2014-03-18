%% mSim Toolbox
%
% *A Matlab Toolbox for the simulation of Non-Point Source Pollution*
% (and not only...)
%
%
%
% mSim toolbox is a suite of Matlab functions which are primarily used to 
% simulate non-point source pollution in groundwater aquifers using  
% finite element methods. The current version of mSim solves the following 
% equations:
%
%%%
% 
% # Groundwater flow equation (steady state.
% # Particle Tracking (using Runge Kutta 45).
% # 1D Advection dispersion equation.
% # 1D Convolution 
% 
%%%
%
% In addition mSim provides a number of functions which assist with the 
% pre/post-processing tasks, which are involved in a finite element simulation as well 
% as functions which are used for the simulation of non-point source pollution such as 
% convolution functions etc. 
%%%
%
% mSim uses the finite element method. For the mesh generation we rely on 
% <http://geuz.org/gmsh Gmsh>, and for advanced visualizations we used <http://www.paraview.org/ Paraview>.

%% 
% The software is written almost entirely in Matlab and the majority of the
% functions are portable to <http://www.gnu.org/software/octave/ Octave> 
% without modifications. However there are very few functions which are 
% written in the new style of Matlab classes which are not supported by Octave.
%%%
% We have also writen few functions in C/C++ which are called by other 
% Matlab/Octave functions Therefore and the users do not directly interact
% with the C/C++ code.