%% Create mesh using ARCGIS and Gmsh
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%
% In the <mesh_matlab_shapef.html  previous example> we explained how to create the Gmsh input file using
% the mSim Matlab class CGSobj_v2. However the methods of this class perform
% many checks every time a new line or point is added to the 
% geometry. For problems with features on the order of several thousands
% the class CGSobj_v2 is quite fast. However for very
% complex problems it becomes very inefficient and time consuming.
% Because we have dealt with this situation, where the class CGSobj_v2
% takes very long to create the CGS object, we use ARCGIS to overcome this.
% Assuming that the complex domain is descibed by shapefiiles (this was
% our case) we use the functions of ARCGIS to create quite fast a CSG object. 
% ARCGIS has its own GUI, nevertheless all its functionalities
% can be scripted in several languages (python, C++, VBA etc..).
%%
% To use the ARCGIS we have written a small python script that executes a
% series of ARCGIS commands. Note that the script is called from Matlab. 
% (There is no need to launch ARCGIS GUI).
%%
% In the folder mUtil there is a function named <msim_python_help msim_python>.
% This function is used to execute python scripts from Matlab. To be able
% to run Arcpy commands one has to define inside the script the executable
% of Arcpy. In our example this was the folder 'c:\Python27\ArcGIS10.2\'.
% Therefore you need to edit the msim_python.m file ans specify the path:
arcpy_path = 'c:\Python27\ArcGIS10.2\';
%%
% In this example we will generate a mesh for following domain:
%
%%
% 
% <<domain2D.png>>
% 
%%
% The data for the domain are in the folder 
msim_root = 'e:\mSim_code\';
data_path = [msim_root 'html_help\DATA\'];
%%
% You need of course to change the msim_root with your mSim path.
%%
% In this folder there are 4 shapefile , which a are self explainatory
%%
% 
% # domain.shp 
% # landuses.shp
% # streams.shp
% # wells.shp
%
%%
% If we want to instruct gmsh to refine the mesh around the features we
% have to define 4 fields for each feature in the same manner as it was done in a
% <mesh_matlab_shapef.html  previous example>.
%%
% To do so we need to read the shapefiles, add the required fields, and write the
% shapefiles. We want to define a refinement for the streams and wells. As
% in the <mesh_matlab_shapef.html  previous example> we will define a minimum
% size element around the wells/streams equal to 5/30 m and linear increase to 200/200 m
% after 250/250 m distance respectively.
%%
% Read the  shapefiles 
streams = shaperead([data_path 'streams']);
wells = shaperead([data_path 'wells']);
%%
% Add the required fileds
for i = 1:size(streams,1)
    streams(i,1).DistMin = 30;
    streams(i,1).DistMax = 250;
    streams(i,1).LcMin = 30;
    streams(i,1).LcMax = 200;
end
for i = 1:size(wells,1)
    wells(i,1).DistMin = 20;
    wells(i,1).DistMax = 250;
    wells(i,1).LcMin = 20;
    wells(i,1).LcMax = 200;
end
%%
% and write the shapefiles:
shapewrite(streams, [data_path 'streams_flds'])
shapewrite(wells, [data_path 'wells_flds'])
%%
% Next we create a list of the non point feature shapefiles (e.g. polygons, and
% lines features). *We have to make sure that the shapefile that describes
% the domain is the first in the list*.
%%
non_point_shapelist{1,1}=[data_path 'domain'];
non_point_shapelist{2,1}=[data_path 'landuses'];
non_point_shapelist{3,1}=[data_path 'streams_flds'];
%% 
% and a list of the point shapefiles. Here we have only one
point_shapelist{1,1}=[data_path 'wells_flds'];
%%
% *Note that we omitted the suffix *.shp*
%% 
% Next comes the initialization of the CSG object. Since this is expected
% to be used for complex geometries we should provide a resonable estimation
% for allocating space for the various features. A small value will result 
% in frequent allocations and will slow down the processes
test_arc=CSGobj_v2(2,20,200,500,1); %Dim, Npoly, Nline, Npoints, usertol
%%
% Next we call the method *.readShapefiles_withArc*. This methods takes 3 arguments:
% i) a list of non point shapefiles, ii) a list of point shapefiles and iii)
% a temporary name. 
%%
% *In all three cases we must provide the full paths*
%%
% Otherwise python generates an error.
% The process generates intermediate shapefiles. In general ARCGIS does not 
% overides existing shapefiles and produce an error if the shapefile
% already exists. Therefore before we execute the python command we delete all
% files starting with the temporary filename. 
%%
% *If there are other files starting
% with the same prefix they will be deleted too!!* 
%%
% Therefore make sure you
% give a temporary name that does not exist in the working folder.
% It is also very important to define the temporary file with its full
% path.
%%
% First you will notice a warning message stating that this has not been
% thoroughly tested. This is due to the fact that we do
% not use the method *.readShapefiles_withArc* very often. (If you find bugs let us know)
%%
% following by  a question dialog, which is the last chance to avoid
% deleting any usefull files starting with the tempname
%%
% 
% <<qstn_dlg.png>>
% 
%
%% 
tempname = [data_path 'qwertyu'];
test_arc = test_arc.readShapefiles_withArc(non_point_shapelist, point_shapelist, tempname);

%%
% There is also the output from the python command. If something goes wrong
% during the python execution it will be displayed here.
%%
% The output is a standard CSG object and we can plot the contained
% geometry using the method *.plotCSGobj*
test_arc.plotCSGobj
axis equal
%%
% After we describde the domain as CSG object we can use the same methods as in the previous tutorials to
% generate the gmsh input file and run gmsh.
%%
% First we define the mesh options:
meshopt=msim_mesh_options;
meshopt.lc_gen = 300;
meshopt.embed_points = 1;
meshopt.embed_lines = 1;
%%
% ... write the input file
test_arc.writegeo('triangle_linear_arc',meshopt);
%%
% ... run Gmsh
gmsh_path='E:\downloads\gmsh-2.6.1-Windows\gmsh.exe';
test_arc.runGmsh('triangle_linear_arc',gmsh_path,[]);
%%
% ... and finaly read the mesh into  Matlab workspace and plot.
[p MSH]=read_2D_Gmsh('triangle_linear_arc');
triplot(MSH(3,1).elem.id, p(:,1), p(:,2));
axis equal
%%
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%
%%
% ___________END OF Tutorial______________________
%
% (Just to keep my folders clean of garbage files I delete the shapefiles with the fields and the intermediate ones)
 delete([data_path 'streams_flds*'])
 delete([data_path 'wells_flds*'])
 delete([tempname '*'])
