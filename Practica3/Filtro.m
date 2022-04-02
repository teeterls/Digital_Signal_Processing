%
%  Funci�n: Filtro paso bajo
%
%  Descripci�n: Aplica un filtro IIR paso bajo a una se�al muestreada.
%
%  Argumentos de entrada:
%  - x_n: se�al muestreada.
%  - fs: frecuencia de muestreo de la se�al muestreada [Hz].
%  - G: ganancia del filtro en la banda de paso [V/V].
%  - fc: frecuencia de corte del filtro [Hz].
%
%  Argumentos de salida:
%  - y_n: se�al muestreada filtrada.
%
%  ~ ~ ~ Universidad Ponficia Comillas ~ ~ ~ 
%

function y_n = Filtro(x_n, fs, G, fc)

    % Dise�o del filtro.
    filtro = designfilt('lowpassiir', 'PassbandFrequency', fc, 'StopbandFrequency', fc*1.5, 'PassbandRipple', .1, 'StopbandAttenuation', 200, 'SampleRate', fs, 'MatchExactly', 'passband');
    
    % Representaci�n del filtro
    fvtool(filtro);
    
    % Se aplica el filtro a la se�al y se corrige la amplitud.
    y_n = filter(filtro, x_n) * G;
    
end

