function [Yn] = Interpolador(L,Xn)
Yn = zeros(length(Xn)*L,1);
index = 1:length(Xn);
Yn(index.*L) = Xn(index);
end

