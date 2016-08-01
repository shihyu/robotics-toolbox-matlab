%CTRAJ Cartesian trajectory between two poses
%
% TC = CTRAJ(T0, T1, N) is a Cartesian trajectory (4x4xN) from pose T0 to T1
% with N points that follow a trapezoidal velocity profile along the path.
% The Cartesian trajectory is a homogeneous transform sequence and the last 
% subscript being the point index, that is, T(:,:,i) is the i'th point along
% the path.
%
% TC = CTRAJ(T0, T1, S) as above but the elements of S (Nx1) specify the 
% fractional distance  along the path, and these values are in the range [0 1].
% The i'th point corresponds to a distance S(i) along the path.
%
% Notes::
% - If T0 or T1 is equal to [] it is taken to be the identity matrix.
% - In the second case S could be generated by a scalar trajectory generator
%   such as TPOLY or LSPB (default).
%
% Reference::
% Robotics, Vision & Control, Sec 3.1.5,
% Peter Corke, Springer 2011
%
% See also LSPB, MSTRAJ, TRINTERP, Quaternion.interp, TRANSL.



% Copyright (C) 1993-2015, by Peter I. Corke
%
% This file is part of The Robotics Toolbox for MATLAB (RTB).
% 
% RTB is free software: you can redistribute it and/or modify
% it under the terms of the GNU Lesser General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
% RTB is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU Lesser General Public License for more details.
% 
% You should have received a copy of the GNU Leser General Public License
% along with RTB.  If not, see <http://www.gnu.org/licenses/>.
%
% http://www.petercorke.com

function traj = ctraj(T0, T1, t)

    T0 = SE3.check(T0);
    T1 = SE3.check(T1);
    
    % distance along path is a smooth function of time
    if isscalar(t)
        s = lspb(0, 1, t);
    else
        s = t(:);
    end


    for i=1:length(s)
        
        traj(i) = trinterp(T0, T1, s(i));
    end

    
