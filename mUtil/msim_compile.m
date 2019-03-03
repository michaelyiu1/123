function msim_compile()
% msim_compile
%
% This will compile all the C/C++ mSim functions.
% Make sure that you call this function on the mSim root folder
% Next will go into various folders and compile the c/c++ functions
%
% Version : 1.0
% Author : George Kourakos
% email: giorgk@gmail.com
% web : http://groundwater.ucdavis.edu/msim
% Date 5-Sep_2014 
% Department of Land Air and Water
% University of California Davis

msim_root = cd;
if exist('OCTAVE_VERSION')
    cd([msim_root '/mPart/'])
    mkoctfile Part_Track_oct.cpp
    
    cd([msim_root '/mNPSAT/'])
    mkoctfile calcbtc_oct.cpp
    
else
    cd([msim_root '/mPart/'])
    mex Part_Track_mat.cpp
    
    cd([msim_root '/mNPSAT/'])
    mex calcbtc_mat.cpp
    
    cd([msim_root '/mUtil/'])
    mex Build2Dmeshinfocpp.cpp
    mex read_2D_mesh_cpp.cpp
    
    
end
cd(msim_root);
