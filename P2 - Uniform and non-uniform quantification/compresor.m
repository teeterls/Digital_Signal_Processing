function [Fa] = compresor(A,x)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
Fa = zeros(1,length(x));
% �ndices correspondientes al primer segmento de amplitud
indices_1 = find(abs(x) < 1/A);
% �ndices correspondientes al segundo segmento de amplitud
indices_2 = find(abs(x) >= 1/A);
% Factor de correcci�n de la amplitud en el primer segmento
Fa(indices_1) = sign(x(indices_1)) .* (A*abs(x(indices_1)))./(1+log(A));
% Factor de correcci�n de la amplitud en el segundo segmento
Fa(indices_2)= sign(x(indices_2)) .* (1 + log(A*abs(x(indices_2))))./(1 + log(A));
end

