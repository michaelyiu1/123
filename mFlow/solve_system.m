function H = solve_system(Kglo,H,F)
% H = solve_system(Kglo, H, F)
%
% This function solves the linear system of equations Kglo*H = F using default matlab
% methods. Note that this function takes care of the boundary conditions.
%
% Input
% Kglo : System matrix 
% H    : Solution vector. This function will have scalar values on the
%        nodes associated with dirichlet boundary conditions and nan on the
%        unknown dofs
% F    : The right hand side
%
% Output
% H    : The solution of the system
%
% Version : 1.0
% Author : George Kourakos
% email: giorgk@gmail.com
% web : http://groundwater.ucdavis.edu/msim
% Date : 14-Jan-2013
% Department of Land Air and Water
% University of California Davis
%
% see also Assemble_LHS, Assemble_RHS

%find wich nodes are constant and shich variable
id_cnst=find(~isnan(H)); 
id_var=find(isnan(H));
%partition the system
KK=Kglo(id_var,id_var);
GG=Kglo(id_var,id_cnst);
DD=H(id_cnst);
B=F(id_var)-GG*DD;

%solution
x=KK\B;
%x=LISs(KK,B,zeros(length(B),1),'bicgstab',[]);

H(id_var,1)=x;
