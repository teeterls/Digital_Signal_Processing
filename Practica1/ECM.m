function [error] = ECM(og,cuant)
N = length(og);
acum = 0;
for i=1:N
    acum = acum + (abs(og(i) - cuant(i)))^2;
end
error = (1/N)*acum;
end

