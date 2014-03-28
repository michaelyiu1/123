function NLN=calcNLN(N,L)
% NLN = calcNLN(N, L)
% Computes the product N' x L x N for 1D linear elements in vectorized manner
% This is used internally. Currently the computations are performed within
% this function. However in the future this will be used as wraper wich
% will call the appropriate function depending the element type and order.
% 
% Documentation to be completed

Nsh=length(N);
Nel=size(L,1);
NLN=zeros(Nel,Nsh^2);
for ii=1:Nsh
    for jj=1:Nsh
        i_lin=sub2ind([Nsh Nsh],jj,ii);
        NLN(:,i_lin)=N(ii).*L.*N(jj);
    end
end
