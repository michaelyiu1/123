%% Transport simulation in 1D
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%
% In this example we show how to use msim functions to solve 1D ADE. This
% is very important in streamline modeling that msim was developed for.
% Besides showing the msim function we perform a small analysis on the
% parameters of the ADE.
%% Problem Description
% The domain of the problem is a line 5 km long.
L = 5000;
%%
% We will discretize the domain into 50 m linear line elements. 
% Therefore the coordinates of the points are
p = ( 0:50:L )';
Np = size(p, 1);
%%
% Next we define the 1D mesh. To generate a uniform 1D mesh we do not need 
% any special software, however we need to create a structure variable to 
% hold the mesh information, similar to the one we use in more complex 
% meshes. The first 2 lines of code are not used and descibe the 0 
% dimension elements e.g. boundary points. (We could set MSH(1,1) = []; instead)
MSH(1,1).elem(1,1).type = 'Bndpnt';
MSH(1,1).elem(1,1).id = [1;Np];
MSH(2,1).elem(1,1).type = 'line';
MSH(2,1).elem(1,1).id = [(1:Np-1)' (2:Np)'];
Nel = size(MSH(2,1).elem(1,1).id,1);
%%
% For initial conditions we will use a constant concentration of of 50 mg/L
% on the first node with id 1
CC = [1 50];
%%
% The initial distribution of the concentration will be zero
Cinit = zeros(Np, 1);
%%
% and we will run the simulation for 150 years with yearly step
T = (0:150)'*365;
%%
% Since we do not have any input/output flows we set a vector of zeros
F = sparse(Np,1);
%%
% and we will use the crank Niclolson scheme
wmega = 0.5;
%%
% Last we will define the few simulation options
opt.dim=1; % This is the dimension of the problem
opt.el_type='line'; %the element type
opt.el_order='linear';% the element order (linear is the only valid option)
opt.assemblemode='vect';% theis is the mode. (use always vectorized option)
opt.capacmode='consistent';% option regarding the capacitance matrix (other option is 'lumped')
%% Constant transport parameters, no decay, no retardation
% First we will show the most simple transport case where all transport 
% properties constant. In addition we will assume no retardation and decay.
aL = 500; %[m] longitudinal dispersivity
v = 0.15; %[m/day] velocity
lambda = 0; %[1/day] radioactive decay
K_d = 0; %[m^3/Kg] equilibrium distribution coefficient
rho_b = 1;% bulk density
Dm = 1.1578e-004;%[m^2/day] Molecular diffusion coefficient
theta = ones(Nel,1);
%%
% To assemble the mass and dispersivity matrix we call the function
[Dglo, Mglo, c]= Assemble_LHS_std(p, MSH(2,1).elem(1,1).id,...
    aL, v, rho_b, K_d, lambda, theta, Dm, CC, opt);
%%
% ... and we are ready to solve the transport equation
C1 = SteadyFlowTransport(Mglo, Dglo, F, Cinit, T, c, wmega);
%%
% Plotting concentration profiles and the breakthrough curve at the outlet in matlab is easy
figure('Position',[100 100 660 220])
subplot(1,2,1);
surf(p/1000,T(2:end)/365,C1,'edgecolor','none')
view(0,90)
axis([0 5 0 150])
xlabel('Distance [km]')
ylabel('Time [years]')
colorbar
subplot(1,2,2)
plot(T(2:end)/365,C1(:,end))
xlabel('Time [years]')
ylabel('Concentration at the outlet [mg/L]')
%%
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%