function cc = Calc_Barycenters(p,MSH)
% cc = Calc_Barycenters(p,MSH)
%
% Computes the barycenters of mesh elements in a
% vectorized fashion. It works for all element size and types and
% dimensions.
%
% Input 
% p   :  matrix [Np x dim] with the coordinates of the elements
% MSH :  matrix [Nel x Nsh] with the indices of the elements. Nsh are the
%        number of control points for each element
%
% Output
% cc  : [Nel x dim] coordinates of the element barycenters
%
%
% Version : 1.0
% Author : George Kourakos
% email: giorgk@gmail.com
% web : http://groundwater.ucdavis.edu/msim
% Date 4-Apr_2013 
% Department of Land Air and Water
% University of California Davis

dim = size(p,2);
[Nel Nsh] = size(MSH);

cc = zeros(Nel, dim);
for ii = 1:dim
    for j = 1:Nsh
        cc(:,ii) = cc(:,ii) + p(MSH(:,j),ii);
    end
    cc(:,ii) = cc(:,ii)/Nsh;
end