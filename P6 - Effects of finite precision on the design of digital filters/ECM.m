function [error] = ECM(og,cuant)
% N = length(og);
% acum = 0;
% for i=1:N
%     acum = acum + (abs(og(i) - cuant(i)))^2;
% end
% error = (1/N)*acum;

% VERSI�N PROFESOR: Formato vectorizado
% nos aseguramos que sean vectores columna
% og = og(:);
% cuant = cuant(:);
% Calculamos el error cuadr�tico medio
% error = sum((abs(og-cuant)).^2)/length(og);
vect = (abs(og-cuant)).^2;
error = mean(vect,'omitnan');

end

