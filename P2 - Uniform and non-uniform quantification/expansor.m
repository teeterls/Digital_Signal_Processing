function [Fa_inv] = expansor(A,y)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
Fa_inv = zeros(1,length(y));
% Índices correspondientes al primer segmento de amplitud
indices_1 = find(abs(y) < 1/(1 + log(A)));
% Índices correspondientes al segundo segmento de amplitud
indices_2 = find(abs(y) >= 1/(1 + log(A)));
% Factor de corrección de la amplitud en el primer segmento
Fa_inv(indices_1) = sign(y(indices_1)) .* (abs(y(indices_1))*(1+log(A)))/A;
% Factor de corrección de la amplitud en el segundo segmento
Fa_inv(indices_2) = sign(y(indices_2)) .* (exp(abs(y(indices_2))*(1+log(A))-1))/A; 
end

