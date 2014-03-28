function [Kglo H]= Assemble_LHS(p, MSH, K, CH, GHB, opt)
% [Kglo H]= Assemble_LHS(p, MSH, K, CH, GHB,opt)
% Assembles the conductance matrix
%
%
% Input
% p   : [Np x 3] Coodrinates of nodes [x1 y1 z1; x2 y2 z2;...xn yn zn]
%        Np : Number of nodes
%
% MSH : [Nel x Np_el] id of elements. Each row correspond to an element
%        Nel : Number of elements
%        Np_el : Number of nodes to define the element
%
% K   : Hydraulic Conductivity defined on nodes or elements
%       if size(K,1)==Np then K is defined on nodes
%       if size(K,1)=Nel then K is defined on elements
%       if size(K,2)==1 then aquifer is isotropic Kx=Ky=Kz
%       if size(K,2)==2 then aquifer is anisotropic Kx=Ky~=Kz,
%       if size(K,2)==3 then aquifer is anisotropic Kx~=Ky~=Kz
%
% CH  : [nx2] the first column contains the id of the nodes with constant
%       head boundary conditions. The second contains the values
%
% GHB : [nx3] : id of node connected with a GHB, head, conductance
%
% opt : Simulation options. Valid fields
%      dim : Dimension of the problem : 1, 2 or 3.
%      el_type : type of element e.g. triangle, prism etc... 
%      el_order order of the element: linear or quadratic 
%      assemblemode : 'vect', 'nested','serial'(Use always vect) 
%
%
% Output
%
% Kglo : Conductance matrix (sparse)
% H : vector with nan values for the unknowns and scalar for the
%     dirichlet nodes
%
% Version : 1.0
% Author : George Kourakos
% email: giorgk@gmail.com
% web : http://groundwater.ucdavis.edu/msim
% Date 18-Dec-2012
% Department of Land Air and Water
% University of California Davis
%
% see also Assemble_RHS, solve_system

Np=size(p,1); % number of discretization nodes
if ~isempty(GHB)
    Nghb=size(GHB,1); 
else
    Nghb=0;
end

if ~isfield(opt,'assemblemode')
    opt.assemblemode='vect';
end

switch opt.assemblemode
    case 'vect'
        Kglo=assemble_vect(p,MSH,K,opt,Nghb);
    case 'nested'
        Kglo=assemble_nested_v2(p,MSH,K,opt,Nghb);
    case 'serial'
        Kglo=assemble_serial(p,MSH,K,opt,Nghb);
end

java.lang.Runtime.getRuntime.gc
    
%assign constant head boundary conditions (i.e. Dirichlet )
if isempty(CH) && isempty(GHB) 
    warning('WarnTests:convertTest','System will be singular!! (specify boundary conditions')
end

%Allocate for the unkown vector H
H=nan(Np+Nghb,1);

%Assign Constant heads boundary conditions
if ~isempty(CH)
    H(CH(:,1))=CH(:,2);
end


%Assign generalized head boundary conditions
if ~isempty(GHB)
    id_ghb=(Np+1:Nghb+Np)';
    TRI1D=[id_ghb GHB(:,1)];
    BBEM=[1 -1 -1 1];
    for ii=1:4
        [kj ki]=ind2sub([2 2],ii);
        Kglo=Kglo+sparse(TRI1D(:,ki),TRI1D(:,kj),GHB(:,3)*BBEM(ii),Np+Nghb,Np+Nghb);
    end
    H(id_ghb,:)=GHB(:,2);
end



%search for unknowns without connections into the mesh
DG=diag(Kglo);
if ~isempty(find(DG==0, 1))
    warning('WarnTests:convertTest',...
        ['Conductance matrix contains nodes with zero diagonal elements \n',...
        'Probably there are points in the mesh without any connections \n'...
        'run find(diag(Kglo)==0) to obtain their ids'])
end
if ~isempty(find(DG>=10^6, 1))
    warning('WarnTests:convertTest',...
        ['Conductance matrix contains elements with values greater than 10^6 \n',...
        'Probably there are ill shaped shapes in the mesh \n'])
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%            SUBFUNCTIONS                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Vectorized
function Kglo=assemble_vect(p,MSH,K,opt,Nghb)
Nel=size(MSH,1); % number elements
Np=size(p,1);
pint=integr_order(opt);
Npint=size(pint,2);

BEM=initialize_BEM(Nel,opt);
Kel=zeros(Nel,size(K,2));
for ii=1:size(pint,1)
    [B Jdet]=shapeDerivatives(p, MSH, pint(ii,1:Npint-1),opt);
    N=shapefunctions(pint(ii,1:Npint-1),opt);
    if size(K,1)==Np %if the dimension of K is equal to nodes then interpolate
                      %the parametric point value from the nodes
        for jj=1:size(K,2)
            Kel(:,jj)=interp_with_shapefnc(N,K(:,jj),MSH,opt);
        end
    else
        Kel=K;
    end
    BEM=BEM+bsxfun(@times,calcBKB(B,Kel,opt,[]),Jdet).*pint(ii,Npint);
end

%fprintf('Assembling Conductance ... x out of %.0f\n',size(BEM,2))
%fprintf('Assembling Conductance ...\n')
Kglo=sparse(Np+Nghb,Np+Nghb);
Nsh=size(MSH,2);
for ii=1:Nsh
    for jj=1:Nsh
        i_lin=sub2ind([Nsh Nsh],jj,ii);
        %fprintf('                    %.0f\n',i_lin)
        Kglo=Kglo+sparse(MSH(:,ii),MSH(:,jj),BEM(:,i_lin),Np+Nghb,Np+Nghb);
    end
end

%%% Nested
function Kglo=assemble_nested_v2(p,MSH,K,opt,Nghb)

Nel=size(MSH,1);
Np=size(p,1);
pint=integr_order(opt);
Npint=size(pint,2);
Kel=zeros(Nel,size(K,2));
Nsh=size(MSH,2);
Kglo=sparse(Np+Nghb,Np+Nghb);

for i_nsh=1:Nsh
    for j_nsh=1:Nsh
        [i_nsh j_nsh]
        BEM=zeros(Nel,1);
        i_lin=sub2ind([Nsh Nsh],j_nsh,i_nsh);
        for ii=1:size(pint,1)
            [B Jdet]=shapeDerivatives(p, MSH, pint(ii,1:Npint-1),opt);
            N=shapefunctions(pint(ii,1:Npint-1),opt);
            if size(K,1)==Np %if the dimension of K is equal to nodes then interpolate
                      %the parametric point value from the nodes
                for jj=1:size(K,2)
                    Kel(:,jj)=interp_with_shapefnc(N,K(:,jj),MSH,opt);
                end
            else
                Kel=K;
            end
            BEM=BEM+bsxfun(@times,calcBKB(B,Kel,opt,i_lin),Jdet).*pint(ii,Npint);
        end
        Kglo=Kglo+sparse(MSH(:,i_nsh),MSH(:,j_nsh),BEM,Np+Nghb,Np+Nghb);
    end
end

%%% Serial
function Kglo=assemble_serial(p,MSH,K,opt,Nghb)
Nel=size(MSH,1);
Np=size(p,1);
pint=integr_order(opt);
Npint=size(pint,2);
Kel=zeros(1,size(K,2));
Nsh=size(MSH,2);
Kglo=sparse(Np+Nghb,Np+Nghb);


for i=1:Nel
    BEM=initialize_BEM(1,opt);
    for ii=1:size(pint,1)
        [B Jdet]=shapeDerivatives(p, MSH(i,:), pint(ii,1:Npint-1),opt);
        N=shapefunctions(pint(ii,1:Npint-1),opt);
        if size(K,1)==Np %if the dimension of K is equal to nodes then interpolate
                      %the parametric point value from the nodes
            for jj=1:size(K,2)
                Kel(1,jj)=interp_with_shapefnc(N,K(:,jj),MSH(i,:),opt);
            end
        else
            Kel=K(i,:);
        end
        BEM=BEM+bsxfun(@times,calcBKB(B,Kel,opt,[]),Jdet).*pint(ii,Npint);
    end
    I=repmat(MSH(i,:),Nsh,1);
    J=repmat(MSH(i,:)',1,Nsh);
    Kglo=Kglo+sparse(I,J,BEM,Np+Nghb,Np+Nghb);
end



    
