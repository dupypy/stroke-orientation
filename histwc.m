% HISTWC  Weighted histogram count given number of bins
%
% This function generates a vector of cumulative weights for data
% histogram. Equal number of bins will be considered using minimum and 
% maximum values of the data. Weights will be summed in the given bin.
%
% Usage: [histw, vinterval] = histwc(vv, ww, nbins, bound)
%
% Arguments:
%       vv    - values as a vector
%       ww    - weights as a vector
%       nbins - number of bins, default nbins is 30 when setting nbins 0 or
%               nargin is equal to 2
%       bound - 2 elements array, specify the lower and upper limits of the
%               bin
%
% Returns:
%       histw     - weighted histogram
%       vinterval - intervals used
%       
%
%
% See also: HISTC, HISTWCV

% Author:
% mehmet.suzen physics org
% BSD License
% July 2013

function [histw, intervals] = histwc(vv, ww, nbins, bound)
 
  if nargin == 2 || nbins == 0
      nbins = 30;
  end
  
  if nargin <= 3
      bound = [min(vv) max(vv)];      
  end
  
  intervals = linspace(bound(1), bound(2), nbins+1);
  intervals = intervals(1:nbins);
  histw = zeros(nbins, 1);
  for i=1:length(vv)
    ind = find(intervals <= vv(i), 1, 'last');
    if ~isempty(ind)
      histw(ind) = histw(ind) + ww(i);
    end
  end
end