%
%  Función: Filtro paso bajo
%
%  Descripción: Aplica un filtro IIR paso bajo a una señal muestreada.
%
%  Argumentos de entrada:
%  - x_n: señal muestreada.
%  - fs: frecuencia de muestreo de la señal muestreada [Hz].
%  - G: ganancia del filtro en la banda de paso [V/V].
%  - fc: frecuencia de corte del filtro [Hz].
%
%  Argumentos de salida:
%  - y_n: señal muestreada filtrada.
%
%  ~ ~ ~ Universidad Ponficia Comillas ~ ~ ~ 
%

function y_n = Filtro(x_n, fs, G, fc)

    % Diseño del filtro.
    filtro = designfilt('lowpassiir', 'PassbandFrequency', fc, 'StopbandFrequency', fc*1.5, 'PassbandRipple', .1, 'StopbandAttenuation', 200, 'SampleRate', fs, 'MatchExactly', 'passband');
    
    % Representación del filtro
    fvtool(filtro);
    
    % Se aplica el filtro a la señal y se corrige la amplitud.
    y_n = filter(filtro, x_n) * G;
    
end

