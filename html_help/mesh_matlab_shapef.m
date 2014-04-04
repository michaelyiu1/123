%% Mesh Generation from Shapefiles using Matlab only
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%
% To create mesh from ArcGIS shapefiles you will need mapping toolbox
% license. However if you dont have the license you can still follow this
% tutorial as we have converted the data from shapefile to matlab variables.
%

%%
% The hypothetical domain is shown in the following figure. The domain
% consist of a polygon shapefile describing the domain, a polygon shapefile
% describing the properties of different landuses, a line shapefile that
% discribes the streams and a point shapefile for the wells.
% 
% <<domain2D.png>>
% 
% The shapefile data are under the mSim/html_help/DATA directory
%
% We assume that you have the mapping toolbox license. If you are not sure
% you can check the outcome of the license function.
license('test','map_toolbox')

%%
% If you have mapping toolbox license then reading shapefiles is
% straightforward.
% First we will read the domain: (note that you need to change the
% msim_root path)
msim_root='/home/giorgos/Documents/mSim_code/msim/';
dom = shaperead([msim_root 'html_help/DATA/domain.shp'])

%%
% The dom variable is actually a struct with several fields. The important
% fields for mSim are the "Geometry" and the "X" and "Y" which containts
% the coordinates of the polygon.

%%
% Next we will read the landuse:

landuse = shaperead([msim_root 'html_help/DATA/landuses.shp'])

%%
% In addition to the standard fields we see that this shapefile
% contains information about the recharge. The field "Q_rch" is the
% groundwater rechagre in m/day and the "Q_m3_day" is the total recharge in
% m^3/day from each field.

%%
% In similar way we can read the streams and the wells. Each shapefile has 
% a flow rate field. However this example is about creating a mesh from 
% shapefiles so we will not make use of them.  
streams = shaperead([msim_root 'html_help/DATA/streams.shp'])

%%
wells = shaperead([msim_root 'html_help/DATA/wells.shp'])
%%
% *If the mapping toolbox is not available, we have saved all these variables
% and can be loaded with
% load([msim_root 'html_help/DATA/shapefile_data.mat'])*

%%
% Typically we expect steep hydraulic head gradient near the streams and 
% wells, therefore we want to instruct Gmsh to refine the mesh around these
% features. To do so we have to add 4 fields to these shapefiles. The
% description of the fields can be found in <http://geuz.org/gmsh/doc/texinfo/gmsh.html#t10_002egeo |t10.geo|>
% example. (If the link is broken search for the tutorial 10 in Gmsh
% documentation). In short here we request the minimum element length to be
% ~30 m near the feature and a linear increase up to 100 m element lenght after 250 m distance. 

for i = 1:size(streams,1)
    streams(i,1).DistMin = 30;
    streams(i,1).DistMax = 250;
    streams(i,1).LcMin = 30;
    streams(i,1).LcMax = 200;
end

%% 
% Similarly for the wells, although we now request finer mesh around the
% wells compared to the streams.

for i = 1:size(wells,1)
    wells(i,1).DistMin = 5;
    wells(i,1).DistMax = 250;
    wells(i,1).LcMin = 5;
    wells(i,1).LcMax = 200;
end

%%
% Now the workflow is similar to the <mesh_matlab_only.html previous example>. First we create a
% constructive solid geometry (CSG) object from the shapefiles. Next we write the
% Gmsh input file. Then we run Gmsh and finally we read the mesh.

%%
% To create the CSG object we call the constructor CSGobj_v2 ( The choice of the
% parameters is not important. They are used to allocate matrices. However
% if the actual matrices are larger than the allocated ones then the dynamic allocation will make
% the function significantly slower).
aquif = CSGobj_v2(2,20,200,500,1) % Dim, Npoly, Nline, Npoints, usertol

%%
% The _aquif_ object is empty. We have just allocated space for it. 
% Next we will add data to it. We always read first the domain outline.
aquif = aquif.readshapefile(dom);

%%
% Using the same method we read all shapefiles.
% To choose the order in which the features need
% to be read you should keep in mind the following: The points of the last feature
% which are closer than the user tolerance to points already existing  from
% previous features will be snapped and as a result the geometry of the last 
% feature will be slightly altered.
aquif = aquif.readshapefile(landuse);
aquif = aquif.readshapefile(streams);
aquif = aquif.readshapefile(wells);

%%
% Anytime we can plot the CSG object
aquif.plotCSGobj;
axis equal

%% 
% Next we define the general mesh options. The function
% <msim_mesh_options_help.html msim_mesh_options>
% returns a struct with the default options. We will change here the
% following fields. If we want quadratic elements we can change the el_order field to 2; 
meshopt=msim_mesh_options;
meshopt.lc_gen = 300;
meshopt.embed_points = 1;
meshopt.embed_lines = 1;

%%
% The next step is to create the Gmsh input file using the method *.writegeo*.
% This will create a xxxxx.geo file.
aquif.writegeo('triangle_linear',meshopt);

%%
% The following figure shows the first lines of the triangle_linear.geo
% file. The file is written in sections and the first section always contain 
% the options about the mesh size. For example the parameter lc_gen is set
% equal to 300 and then there are two groups of the 4 parameters we set above 
% which correspond to the wells (b1* group) and the streams (b2* group). Note that the order
% which these group are listed is random. If one wants to change the
% parameters do not need to recreate the file from Matlab but can change
% the values directly in the *.geo file. This is very handy in very
% complex domains where writing the *geo file is time consuming and in
% cases where someone wants to create interactively many meshes for the same geometry.
%
% <<triangl_linear.png>>
%

%%
% Finally to generate the mesh we call the method *.runGmsh*
gmsh_path='/usr/bin/gmsh';
aquif.runGmsh('triangle_linear',gmsh_path,[])

%% 
% The last command created a triangle_linear.msh file. We can read the mesh
% using the function read_2D_Gmsh
[p MSH]=read_2D_Gmsh('triangle_linear');

%%
% Since the mesh consist of linear triangles and it is relatively small, we 
% can visualize it with Matlab functions
clf
triplot(MSH(3,1).elem(1,1).id, p(:,1), p(:,2))
axis equal
%%
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%


    


