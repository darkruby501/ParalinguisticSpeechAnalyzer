function c = customconv(a, b)

% a is speech vector
% b is kernel

% Want same as length a
len = length(a);
lenb = length(b);

zp = length(b)-1;

a = [zeros(zp,1);a;zeros(zp,1)];


for i = zp+1:length(a)
    
    sum(a(i-lenb-1:i)*


%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


end

