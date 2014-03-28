function F= Assemble_RHS(Ndof,p, MSH, FLUX)
% F = Assemble_RHS(Ndof, p, MSH, FLUX)
%
% Assembles the right hand side of the groundwater flow for flows defined
% on elements
%
% Ndof: Number of degrees of freedom
% p   : [Np x 3] Coodrinates of nodes [x1 y1 z1; x2 y2 z2;...xn yn zn]
%       Np : Number of points
%
% MSH : [Nel x Np_el] id of elements. Each row correspond to an element
%       Nel : Number of elements
%       Np_el : dimension of elements
%
% FLUX: A structure with the following fields
%       id: The id of the elements where the flux conditions are applied.
%       val: the flux values. the size of _val_ must be equal to _id_
%       dim: The structural dimension of the elements. For example in 3D flow
%            the groundwater recharge is applied to 2D elements while the well pumping
%            can be applied to 3D elements. See also the tutorials
%       el_type: the element type such as 'line', triangle','quad','prism','hex' etc.
%       el_order: the element order
%       id_el: This is the index of MSH.elem row. This is commonly 1. On case
%               that this is different is the following example. Lets suppose that the
%               problem is 3D, discretized in prism elements and the variable MSH containts 
%               the mesh info. MSH is a structure where the 2D elements will be on the
%               3rd row.
%               MSH(3,1) will have a field _elem_. Each row of MSH(3,1).elem  corresponds
%               to the mesh of different type of elements. There will be one row for the
%               triangular faces, and one row for the quadrilateral faces. _id_el_ must
%               to point to the correct row in MESH(x,1).elem(_id_el_,1).id. See also the
%               3D examples with prism elements.
%       assemblemode: choose the assemble mode 'vect' or 'nested' (use always vect)
%
% Output
% F     : The assembled right hand side
%
% Version : 1.0
% Author : George Kourakos
% email: giorgk@gmail.com
% web : http://groundwater.ucdavis.edu/msim
% Date 18-Dec-2012
% Department of Land Air and Water
% University of California Davis
%
% see also Assemble_LHS, solve_system
%

F=sparse(Ndof,1);

for k=1:length(FLUX)
    if ~isfield(FLUX(k,1),'assemblemode')
        FLUX(k,1).assemblemode='vect';
    else
        if isempty(  FLUX(k,1).assemblemode )
            FLUX(k,1).assemblemode='vect';
        end
    end
    
    switch FLUX(k,1).assemblemode
        case 'vect'
            F=assemble_full(F,p,MSH,FLUX(k,1),Ndof);
        case 'nested'
            F=assemble_nested(F,p,MSH,FLUX(k,1),Ndof);
    end
end



function F=assemble_full(F,p,MSH,FLUX,Ndof)
if ~isfield(FLUX,'project');FLUX.project=0;end
if isfield(FLUX,'project');if isempty(FLUX.project);FLUX.project=0;end;end
if ~isfield(FLUX,'int_ord');
    temp_opt=struct('dim',FLUX.dim,'el_type',FLUX.el_type,'el_order',FLUX.el_order,'project',FLUX.project);
else
    temp_opt=struct('dim',FLUX.dim,'el_type',FLUX.el_type,...
                'int_ord',FLUX.int_ord,'el_order',FLUX.el_order,'project',FLUX.project);
end

FEM=initialize_FEM(size(MSH(FLUX.dim+1,1).elem(FLUX.id_el,1).id(FLUX.id,:),1),temp_opt);
pint=integr_order(temp_opt);
Npint=size(pint,2);
for ii=1:size(pint,1)
    [dummy, Jdet]=shapeDerivatives(p, MSH(FLUX.dim+1,1).elem(FLUX.id_el,1).id(FLUX.id,:),...
                               pint(ii,1:Npint-1),temp_opt);
    N=shapefunctions(pint(ii,1:Npint-1),temp_opt);
    %element flux*(Shape functions*Jacobian)*Gauss weight
    FEM=FEM+bsxfun(@times,FLUX.val,bsxfun(@times,N,Jdet)).*pint(ii,Npint);
end
for ii=1:size(FEM,2)
    F=F+sparse(MSH(FLUX.dim+1,1).elem(FLUX.id_el,1).id(FLUX.id,ii),1,FEM(:,ii),Ndof,1);
end



function F=assemble_nested(F,p,MSH,FLUX,Ndof)
temp_opt=struct('dim',FLUX.dim,'el_type',FLUX.el_type,...
                'int_ord',FLUX.int_ord,'el_order',FLUX.el_order);
pint=integr_order(temp_opt);
Npint=size(pint,2);
for ii=1:size(pint,1)
    [dummy, Jdet]=shapeDerivatives(p, MSH(FLUX.dim+1,1).elem(FLUX.id_el,1).id(FLUX.id,:),...
                               pint(ii,1:Npint-1),temp_opt);
    N=shapefunctions(pint(ii,1:Npint-1),temp_opt);
    %element flux*(Shape functions*Jacobian)*Gauss weight
    for i_ord=1:size(MSH(FLUX.dim+1,1).elem(FLUX.id_el,1).id,2)
        FEM=bsxfun(@times,FLUX.val,bsxfun(@times,N(i_ord),Jdet)).*pint(ii,Npint);
        F=F+sparse(MSH(FLUX.dim+1,1).elem(FLUX.id_el,1).id(FLUX.id,i_ord),1,FEM,Ndof,1);
    end
end
    



function FEM=initialize_FEM(Nel,opt)
%BEM [NelxN_sh], where N_sh is the number of shape functions per element
if opt.dim==1
    switch opt.el_order
        case 'linear'
            FEM=zeros(Nel,2);
        case 'quadratic'
            FEM=zeros(Nel,3);
    end
elseif opt.dim==2
    switch opt.el_type
        case 'triangle'
            switch opt.el_order
                case 'linear'
                    FEM=zeros(Nel,3);
                case 'quadratic'
                    FEM=zeros(Nel,6);
            end
        case 'quad'
            switch opt.el_order
                case 'linear'
                    FEM=zeros(Nel,4);
                case 'quadratic_9'
                    FEM=zeros(Nel,9);
            end
    end
elseif opt.dim==3
    switch opt.el_type
        case 'prism'
            switch opt.el_order
                case 'linear'
                    FEM=zeros(Nel,6);
            end
        case 'hex'
            switch opt.el_order
                case 'linear'
                    FEM=zeros(Nel,8);
            end
    end
end


% % temp_opt=struct('dim',FLUX(k,1).dim,'el_type',FLUX(k,1).el_type,...
% %                     'int_ord',FLUX(k,1).int_ord,'el_order',FLUX(k,1).el_order);
% % FEM=initialize_FEM(size(MSH(FLUX(k,1).dim+1,1).elem(FLUX(k,1).id_el,1).id(FLUX(k,1).id,:),1),temp_opt);
% % pint=integr_order(temp_opt);
% % Npint=size(pint,2);
% % for ii=1:size(pint,1)
% %     [~, Jdet]=shapeDerivatives(p, MSH(FLUX(k,1).dim+1,1).elem(FLUX(k,1).id_el,1).id(FLUX(k,1).id,:),...
% %                                pint(ii,1:Npint-1),temp_opt);
% %     N=shapefunctions(pint(ii,1:Npint-1),temp_opt);
% %     %element flux*(Shape functions*Jacobian)*Gauss weight
% %     %Q_el*N*J(
% %     FEM=FEM+bsxfun(@times,FLUX(k,1).val,bsxfun(@times,N,Jdet)).*pint(ii,Npint);
% % end
% % for ii=1:size(FEM,2)
% %     F=F+sparse(MSH(FLUX(k,1).dim+1,1).elem(FLUX(k,1).id_el,1).id(FLUX(k,1).id,ii),1,FEM(:,ii),Ndof,1);
% % end
        
    



    
