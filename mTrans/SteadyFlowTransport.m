function C=SteadyFlowTransport(Mglo,Dglo,F,Cinit,T,c,theta)
% C = SteadyFlowTransport(Mglo, Dglo, F, Cinit, T, c, theta)
%
% Solves the Advection dispersion equation for steady state flow.
%
% Input
% Most of the inputs of this function are outputs of <Assemble_LHS_std
% Mglo  : Sorption global Matrix
% Dglo  : Avection dispersion global Matrix
% F     : Right hand side vector
% Cinit : Initial concentration
% T     : time steps
% c     : Dirichlet boundary conditions (see Assemble_LHS_std)
% theta : defines the time differentiation scheme. e.g 0.5 -> Crank–Nicolson
%        0 -> Forward Euler, 1-> Backward Euler
%
% Output
% C     : Distribution of solution
%
% see also Assemble_LHS_std
%
% Version : 1.0
% Author : George Kourakos
% email: giorgk@gmail.com
% web : http://groundwater.ucdavis.edu/msim
% Date 28-Mar-2014
% Department of Land Air and Water
% University of California Davis
%
c=c(:);
Dt=diff(T);
C=zeros(length(Dt),length(c));
ldnans=find(isnan(c));
cnstHD=find(~isnan(c));

for it=1:length(Dt)
    Aglo=Mglo+theta*Dt(it)*Dglo;
    Bglo=(Mglo-(1-theta)*Dt(it)*Dglo)*Cinit+Dt(it)*((1-theta)*F+theta*F);
    
    KK=Aglo(ldnans,ldnans);
    GG=Aglo(ldnans,cnstHD);
    dd=c(cnstHD);
    c(ldnans)=KK\(Bglo(ldnans)-GG*dd);
    Cinit=c;
    C(it,:)=c';
end