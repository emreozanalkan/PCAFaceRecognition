%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
function [A,b] = GetAB(F, Fp)
%     AB = zeros(3,2);
    AB = pinv([F, [1;1;1;1;1]]) * Fp;
    A = AB(1:2,:);
    A = A';
    B = AB(3,:);
    b = B';
end