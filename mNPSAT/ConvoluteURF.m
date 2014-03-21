function BTC = ConvoluteURF(URF,LF,mode)
% BTC = ConvoluteURF(URF,LF,mode)
%
% This function convolutes the unit response function with loading
% functions. 
%
% Input data
% URF: are the unit response functions [Ns x Nt] where Ns is the number of
%      streamlines or in general the number of independent URFs and Nt is
%      the number of discretization steps of the URF.
% LF:  are the loading functions [Ns x Nt_lf] where Ns is the number of
%      indepedent loading functions and Nt_lf are the number of steps that
%      the loading functions are discretized. 
%      If size(LF,1) == 1 then the same loading function will be convoluted with all URF
%      IMPORTANT NOTE: 
%      The step size in URF and LF must be the same otherwise the results
%      will be wrong.
% mode: The recomended mode is the 'cpp'. However if mex or oct are not available
%       the 'vect' option can be used. There is also the 'serial' option for
%       debuging only!
%    
%
% Output data 
% BTC: The Breakthrough curve that coresponds to convolution of the i URF
%      with the i loading function 
%
%
%
% Version : 1.0
% Author : George Kourakos
% email: giorgk@gmail.com
% web : http://groundwater.ucdavis.edu/msim
% Date 2-Apr-2012
% Department of Land Air and Water
% University of California Davis


Ns = size(URF,1);
if Ns ~= size(LF)
    if size(LF,1) == 1
	LF=repmat(LF,Ns,1);
    else
        error('The number of URFs must be equal to number of loading functions')
    end
end
Nt_lf = size(LF,2);
% allocate space for the output

URF(URF<0) = 0;

switch mode
    case 'cpp'
        if exist('OCTAVE_VERSION')
            BTC = calcbtc_oct(URF,LF);
        else
            BTC = calcbtc_mat(URF,LF);
        end
        
    case 'vect'
        shift=0;
        BTC=zeros(Ns,Nt_lf);
        for i=1:Nt_lf
            temp=[zeros(Ns,shift) bsxfun(@times,URF,LF(:,i))];
            BTC = BTC + temp(:,1:Nt_lf);
            shift=shift+1;
        end
    case 'serial'
        % For debuging only !!! Dont USE!!!
        shift=1;
        BTC=zeros(Ns,Nt_lf);
        for i = 1:Nt_lf
            for j = 1:Ns
                for k = shift:Nt_lf
                    BTC(j,k) = BTC(j,k) + URF(j,k-shift+1)*LF(j,i);
                end
            end
            shift = shift + 1;
        end
end
