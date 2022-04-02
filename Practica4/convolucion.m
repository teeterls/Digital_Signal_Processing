%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% subrutina de CONVOLUCIÓN
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% @Author: Carlos García de la Cueva

function [y] = convolucion(h,x)

% Se convierten las señales de entrada a vectores columna
h = h(:);
x = x(:);

% Creación del vector de salida
y = zeros(1,length(x)+length(h)-1);

% Aplicación de la convolución
for i = 1:length(y)
    % Índices de la señal a tener en cuenta en cada iteración
    indexes = (i-length(h)+1):i;
    % Se crea un vector de datos de la misma longitud del filtro
    signal_frame = zeros(length(h),1);
    % Se identifican los indices de señal existen (pertenecen a la señal)
    valid_indexes = (indexes >= 1 & indexes <= length(x));
    % Se rellena los datos de la trama con los datos de señal válidos
    signal_frame(valid_indexes) = x(indexes(valid_indexes));
    % Se calcula el producto vectorial entre la trama de señal y el filtro
    y(i) = h.'*signal_frame;
end

end

