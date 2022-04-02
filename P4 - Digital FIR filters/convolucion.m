%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% subrutina de CONVOLUCI�N
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% @Author: Carlos Garc�a de la Cueva

function [y] = convolucion(h,x)

% Se convierten las se�ales de entrada a vectores columna
h = h(:);
x = x(:);

% Creaci�n del vector de salida
y = zeros(1,length(x)+length(h)-1);

% Aplicaci�n de la convoluci�n
for i = 1:length(y)
    % �ndices de la se�al a tener en cuenta en cada iteraci�n
    indexes = (i-length(h)+1):i;
    % Se crea un vector de datos de la misma longitud del filtro
    signal_frame = zeros(length(h),1);
    % Se identifican los indices de se�al existen (pertenecen a la se�al)
    valid_indexes = (indexes >= 1 & indexes <= length(x));
    % Se rellena los datos de la trama con los datos de se�al v�lidos
    signal_frame(valid_indexes) = x(indexes(valid_indexes));
    % Se calcula el producto vectorial entre la trama de se�al y el filtro
    y(i) = h.'*signal_frame;
end

end

