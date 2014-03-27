function WriteVtkMesh(filename,MSH,p,propND,propCL,eltype)
%WriteVtkMesh(filename,MSH,p,propND,propCL,eltype)
%
% Writes Data to Vtk format for visualization with ParaView
%Inputs: 
%1)filename (without the suffix .vtk)
%2)MSH, Mesh connectivity [Nel x Nsh]
%   Nel # of elements 
%   Nsh # Number of shape functions needed for each element
%3)p Coordinates [Npx3], Np: # of points
%4)propND :Node Properties
%5)propCL :Cell Properties. use [] if there are no properties
%Each row is a struct variable with 3 fields:
%name, val, type: 
%   name : Name of the property
%   val  : Value of the property [Np x 1] (for propND) or [Nel x 1](propCL)
%   type : scalar or vector, In case of vector then val must be a matrix
%          with dimensions  [Np x 3] or [Nel x 3]
%6)eltype: element type :'triangle', 'quad', 'hex', 'prism'
%
% Example for propND and propCL
% propND(1,1).name='heads';
% propND(1,1).val=Hf;
% propND(1,1).type='scalars';
% propND(2,1).name='Velocity';
% propND(2,1).val=[full(Vx) full(Vy) full(Vz)];
% propND(2,1).type='vectors';
% propND(3,1).name='HorizCond';
% propND(3,1).val=Knd;
% propND(3,1).type='scalars';
% propND(4,1).name='VertCond';
% propND(4,1).val=Lnd;
% propND(4,1).type='scalars';
%
% Version : 1.0
% Author : George Kourakos
% email: giorgk@gmail.com
% web : http://groundwater.ucdavis.edu/msim
% Date 18-Dec_2012
% Department of Land Air and Water
% University of California Davis
%
% Descriptions of the vtk file formats can be found here: 
% www.vtk.org/VTK/img/file-formats.pdf
% or 
% http://www.vtk.org/doc/nightly/html/vtkCellType_8h.html (for complete list)

if size(p,2)==2
    p=[p zeros(size(p,1),1)];
end
Np=size(p,1);
Nel=size(MSH,1);
fid=fopen([filename '.vtk'],'w');
fprintf(fid,'# vtk DataFile Version 3.0\n');
fprintf(fid,'write mesh on file\n');
fprintf(fid,'ASCII\n');
fprintf(fid,'DATASET UNSTRUCTURED_GRID\n');
fprintf(fid,'POINTS %i double\n', Np);
display('Writing Nodes coord...')
fprintf(fid,'%f %f %f\n',p(:,1:3)');


display('Writing Elements...')

switch eltype
    case 'triangle'
        if size(MSH,2)==3
            %linear
            fprintf(fid,'CELLS %i %i\n',[Nel Nel*(1+3)]);
            fprintf(fid,'%i %i %i %i\n',[3*ones(Nel,1) MSH(:,1)-1 MSH(:,2)-1 MSH(:,3)-1]');
            fprintf(fid,'CELL_TYPES %i\n',Nel);
            fprintf(fid,'%i\n',5*ones(Nel,1));
        end
        if size(MSH,2)==6
            %quadratic
            fprintf(fid,'CELLS %i %i\n',[Nel Nel*(1+6)]);
            fprintf(fid,'%i %i %i %i %i %i %i\n',[6*ones(Nel,1) MSH(:,1)-1 MSH(:,2)-1 MSH(:,3)-1 MSH(:,4)-1 MSH(:,5)-1 MSH(:,6)-1]');
            fprintf(fid,'CELL_TYPES %i\n',Nel);
            fprintf(fid,'%i\n',22*ones(Nel,1));
        end
    case 'quad'
        if size(MSH,2)==4
            %linear
            fprintf(fid,'CELLS %i %i\n',[Nel Nel*(1+4)]);
            fprintf(fid,'%i %i %i %i %i\n',[4*ones(Nel,1) MSH(:,1)-1 MSH(:,2)-1 MSH(:,3)-1 MSH(:,4)-1]');
            fprintf(fid,'CELL_TYPES %i\n',Nel);
            fprintf(fid,'%i\n',9*ones(Nel,1));
        end
        if size(MSH,2)==9
            %Biquadratic quad (9 node)
                        fprintf(fid,'CELLS %i %i\n',[Nel Nel*(1+9)]);
            fprintf(fid,'%i %i %i %i %i\n',[9*ones(Nel,1) MSH(:,1)-1 MSH(:,2)-1 MSH(:,3)-1 MSH(:,4)-1 MSH(:,5)-1 MSH(:,6)-1 MSH(:,7)-1 MSH(:,8)-1 MSH(:,9)-1]');
            fprintf(fid,'CELL_TYPES %i\n',Nel);
            fprintf(fid,'%i\n',28*ones(Nel,1));
        end
    case 'hex'
        if size(MSH,2)==8;
            %hexahedron
            fprintf(fid,'CELLS %i %i\n',[Nel Nel*(1+8)]);
            fprintf(fid,'%i %i %i %i %i %i %i %i %i\n',[8*ones(Nel,1) MSH(:,1)-1 MSH(:,2)-1 MSH(:,3)-1 MSH(:,4)-1 MSH(:,5)-1 MSH(:,6)-1 MSH(:,7)-1 MSH(:,8)-1]');
            fprintf(fid,'CELL_TYPES %i\n',Nel);
            fprintf(fid,'%i\n',12*ones(Nel,1));
        end
        if size(MSH,2)==27;
            %hexahedron
            fprintf(fid,'CELLS %i %i\n',[Nel Nel*(1+27)]);
            fprintf(fid,'%i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i\n',...
                [27*ones(Nel,1) MSH(:,1)-1 MSH(:,2)-1 MSH(:,3)-1 MSH(:,4)-1 MSH(:,5)-1 MSH(:,6)-1 MSH(:,7)-1 MSH(:,8)-1 ...
                MSH(:,9)-1 MSH(:,10)-1 MSH(:,11)-1 MSH(:,12)-1 MSH(:,13)-1 MSH(:,14)-1 MSH(:,15)-1 MSH(:,16)-1 ...
                MSH(:,17)-1 MSH(:,18)-1 MSH(:,19)-1 MSH(:,20)-1 MSH(:,24)-1 MSH(:,22)-1 MSH(:,21)-1 MSH(:,23)-1 ...
                MSH(:,25)-1 MSH(:,26)-1 MSH(:,27)-1]');
            fprintf(fid,'CELL_TYPES %i\n',Nel);
            fprintf(fid,'%i\n',29*ones(Nel,1));
        end
    case 'prism'
        if size(MSH,2)==6;
            fprintf(fid,'CELLS %i %i\n',[Nel Nel*(1+6)]);
            fprintf(fid,'%i %i %i %i %i %i %i\n',[6*ones(Nel,1) MSH(:,1)-1 MSH(:,2)-1 MSH(:,3)-1 MSH(:,4)-1 MSH(:,5)-1 MSH(:,6)-1]');
            fprintf(fid,'CELL_TYPES %i\n',Nel);
            fprintf(fid,'%i\n',13*ones(Nel,1));
        elseif size(MSH,2)==18;
            fprintf(fid,'CELLS %i %i\n',[Nel Nel*(1+18)]);
            fprintf(fid,'%i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i\n',...
                [18*ones(Nel,1) MSH(:,1)-1 MSH(:,2)-1 MSH(:,3)-1 MSH(:,4)-1 MSH(:,5)-1 MSH(:,6)-1 ...
                MSH(:,7)-1 MSH(:,8)-1 MSH(:,9)-1 MSH(:,10)-1 MSH(:,11)-1 MSH(:,12)-1 ...
                MSH(:,13)-1 MSH(:,14)-1 MSH(:,15)-1 MSH(:,16)-1 MSH(:,17)-1 MSH(:,18)-1]');
            fprintf(fid,'CELL_TYPES %i\n',Nel);
            fprintf(fid,'%i\n',32*ones(Nel,1));
        end
end




%
if ~isempty(propND)
    fprintf(fid,'POINT_DATA %i\n', Np);
    for iprop=1:size(propND,1)
        if strcmp(propND(iprop,1).type,'scalars')
            display(['Writing ' propND(iprop,1).name '...'])
            fprintf(fid,'SCALARS %s double 1\n', propND(iprop,1).name);
            fprintf(fid,'LOOKUP_TABLE default\n');
            fprintf(fid,'%f\n',propND(iprop,1).val');
        end
        if strcmp(propND(iprop,1).type,'vectors')
            display(['Writing ' propND(iprop,1).name '...'])
            fprintf(fid,'VECTORS %s double\n', propND(iprop,1).name);
            fprintf(fid,'%f %f %f\n',propND(iprop,1).val');
        end
    end
end
if ~isempty(propCL)
    fprintf(fid,'CELL_DATA %i\n', Nel);
    for iprop=1:size(propCL,1)
        if strcmp(propCL(iprop,1).type,'scalars')
            display(['Writing ' propCL(iprop,1).name '...'])
            fprintf(fid,'SCALARS %s double 1\n', propCL(iprop,1).name);
            fprintf(fid,'LOOKUP_TABLE default\n');
            fprintf(fid,'%f\n',propCL(iprop,1).val');
        end
        if strcmp(propCL(iprop,1).type,'vectors')
            display(['Writing ' propCL(iprop,1).name '...'])
            fprintf(fid,'VECTORS %s double\n', propCL(iprop,1).name);
            fprintf(fid,'%f %f %f\n',propCL(iprop,1).val');
        end
    end
end
%}
%{
%Write data as Field data

if ~isempty(propND)
    %fprintf(fid,'POINT_DATA %i\n', Np);
    fprintf(fid,'FIELD FieldData %i\n', size(propND,1));
    for iprop=1:size(propND,1)
        fprintf(fid,'%s ', propND(iprop,1).name );
        display(['Writing ' propND(iprop,1).name '...'])
        NComp=size(propND(iprop,1).val,2);
        fprintf(fid,'%i %i double\n',[NComp Np]);
        strfrmt='%f';
        for k=1:NComp-1; strfrmt=[strfrmt ' %f'];end
        strfrmt=[strfrmt '\n'];
        for i=1:Np
            fprintf(fid,strfrmt,propND(iprop,1).val(i,:));
        end
    end
end
if ~isempty(propCL)
    fprintf(fid,'CELL_DATA %i\n', Ntri);
    for iprop=1:size(propCL,1)
        if strcmp(propCL(iprop,1).type,'scalars')
            display(['Writing ' propCL(iprop,1).name '...'])
            fprintf(fid,'SCALARS %s double 1\n', propCL(iprop,1).name);
            fprintf(fid,'LOOKUP_TABLE default\n');
            for i=1:Ntri
                fprintf(fid,'%f\n',propCL(iprop,1).val(i,1));
            end
        end
        if strcmp(propCL(iprop,1).type,'vectors')
            display(['Writing ' propCL(iprop,1).name '...'])
            fprintf(fid,'VECTORS %s double\n', propCL(iprop,1).name);
            for i=1:Ntri
                fprintf(fid,'%f %f %f\n',propCL(iprop,1).val(i,:));
            end
        end
    end
end
%}
fclose(fid);
