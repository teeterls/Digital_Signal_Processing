function [Yn] = Diezmador(M,Xn)
Yn = zeros(1,length(round(Xn/M)));
index = 1:M:length(Xn);
Yn = Xn(index);
end

