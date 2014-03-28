%% CSGobj_v2
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%
% This is a class which stores the geometric features of the
% domain. The primary purpose of this class is to read shapefiles or
% structures that are similar to matlab's shapefiles and create a
% constructive geometry object.
%%
% The typical flow for creating a mesh with mSim is the following:
%%
%
% # Create an empty object using the constructor *CSGobj_v2* of this class.
% # Read the shapefiles using *readshapefile* or *readShapefiles_withArc*
% method. After this it make sense to use *plotCSGobj* method to display the
% content of CSG.
% # Next write the *.geo file using *writegeo* method.
% # Generate the mesh by running the *runGmsh* method
%
%% CSG = CSGobj_v2(Dim, Npoly, Nline, Npoints, usertol)
% 
% To create a *CSGobj_v2* object the following input arguments are
% required:
%
% _*Dim*_: This is the dimension of the geometry. (Currently only 2D is
% suported)
%
% _*Npoly*_: The number of polygons which expected to be in the object.
% _Note_: This is used only to allocate space for the polygons and is not very
% important. However a wrong estimation might slow dow the code
% considerably.
%
% _*Nline*_: Number of lines which expected to be in the CSG object. See
% also the note on _*Npoly*_ input argument
%
% _*Npoints*_: Number of points which is expected to be in the object. See
% also the note on _*Npoly*_ input argument.
%
% _*usertol*_: This sets the tolerance. Two points closer than _*usertol*_ 
% will be treated as identical.
%
%% plotCSGobj(CSG,ln_cl,pnt_cl,lnw)
% This method is used to plot the current content of the CSG object.
% 
% It can be used without arguments, however optionaly one can define the
% following arguments for more customized plots
%
% _*ln_cl*_: line color (default: blue). Similar rules to 
% <http://www.mathworks.com/help/matlab/ref/colorspec.html color specifications>
% apply here.
%
% _*pnt_cl*_ : point color (default red)
%
% _*lnw*_: line weight. (default 1.5)
%
%% CSG=readShapefiles_withArc(CSG, nonpointlist, pointlist, tempname)
% This method is used to read the shapefile using ArcGIS. This is recommended 
% when the geometries are very complex and the number of features (lines, polygons, points) is 
% greater than 10,000. However because it requires ArcGIS license we have
% tested this method only on one machine.
%
% This methods requires a
% slightly complicated configuration because what happens is that matlab
% will pass the input arguments to a python script which in turn will
% execute a sequence of ArcGIS commands. As for the time of writing the
% documentation
% Matlab does not provide a script to call python. Yet it provides a perl
% script. In mSim we copied and renamed the 
% <http://www.mathworks.com/help/matlab/ref/perl.html?searchHighlight=perl perl.m> to 
% <msim_python_help.html msim_python.m> In
% msim_python.m function you need to provide the arc python directory.
%
% _*nonpointlist*_: a list of polygons and/or polyline shapefiles. This
% should be an array of cells.
%
% _*pointlist*_: a list of point shapefiles. THis should be an array of
% cells.
%
% _*tempname*_: The arcGis commands create several intermediate files. However 
% when a shapefile already exists in a directory ArcGIS returns an error. To avoid this
% we append the prefix given by the _*tempname*_ to all intermediate files.
% Before we start the script the method will delete all files  starting
% with _*tempname*_. So it is important to give something uncommon for the
% working direcotry.
%
%% CSG=readshapefile(CSG,SH)
% This method appends the given shapefile to the CSG object.
%
% _*SH*_: is a matlab structure for shape files. The required fields here
% are the Geometry, X, Y. It is always assumed that the first shapefile
% which is passed to an empty CSG object describes the domain.
% 
%% runGmsh(CSG,filename, gmsh_exe, Nsub)
% Executes the gmsh program, which generates the mesh. The program is
% executed in batch mode and the output of gmsh is printed on matlab
% command window.
% 
% _*filename*_: is the *.geo input file for gmsh. The filename must be given
% without the extension *.geo. The results will be written to a file with
% the same filename and extension *.msh
%
% _*gmsh_exe*_: is the full path of the executable.
%
%% showGmsh(CSG,filename,gmsh_exe,type)
% Starts the Gmsh GUI which loads the model described in filename. This
% function is usefull because one cal visualize the mesh without reading it
% into matlab workspace. WHile Gmsh GUI is open matlab will appear as busy.
%
% _*filename*_: is the  input file
%
% _*gmsh_exe*_: is the full path of the executable.
%
% _*type*_: is either 'geo' or 'msh'. In geo case gmsh loads the geometry
% file and in 'msh' case loads the mesh file.
%
%% writegeo(CSG,filename,opt)
% Writes the data of CSG object to *.geo format.
%
% _*filename*_: is the .geo input file for gmsh. This will create or modify the file
% _*filename*_.geo.
%
% _*opt*_: a structure with mesh options. 
% <msim_mesh_options_help.html msim_mesh_options> for details
%%
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%