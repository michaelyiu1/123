%% System Requirments
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%
% To run mSim you need the basic Matlab toolboxes or Octave.
% However the classes have been written in the new Matlab style which is
% currently (2013) not supported by Octave. The majority of the code 
% is written as functions, and only a small number of preprocessing tasks 
% are written in an object oriented programming style.
%%% 
% mSim is expected to run in any computer that can run either Matlab or
% Octave. The code has been tested on several Linux and Windows OS. 
%%%
% The mSim is a collection of m-files organized in folders. Therefore to
% obtain access to all available function you need to add the mSim path by
% typing
addpath(genpath('msim_root'));
%%%
% where msim_root is the top level directory of mSim
%%%
% Optionally you can add the above line in the
% <http://www.mathworks.com/help/matlab/ref/startup.html startup file>
%%%
% In addition we have writen few functions in C/C++ which have to be
% compiled. On the top level directory of mSim run
msim_compile;
%%%
% To compile all the C/C++ functions
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%