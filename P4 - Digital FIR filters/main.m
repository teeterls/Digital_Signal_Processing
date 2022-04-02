%% Pr�ctica 4
% 
% Teresa Gonz�lez y Miguel Oleo
% LE2 G4

%% Introducci�n
%
% El objetivo de la pr�ctica es familiarizarnos con el uso de las funciones
% conv y filt, para aplicar un filtro, y conocer sus diferencias. En esta
% pr�ctica tambi�n tenemos el primer acercamiento al dise�o de filtros y
% aplicaci�n de los mismos.

%% Filtrado de se�ales

%% Apartado a)
% Cargamos el fichero y calculamos fs, tal y como hemos hecho en pr�cticas
% anteriores.

load('PDS_P4_LE2_G4.mat');
fs = (max(t)/size(x,1))^-1;

%% Apartado b)
% En este apartado hemos implementado la funci�n convoluci�n proporcionada
% por el profesor. 
% 
% El tama�o de la se�al de salida es de m(length x) + n (length b) - 1.
% Este tama�o se puede justificar f�cilmente haci�ndolo manualmente. El
% vector tiene tama�o m, pero como "se va moviendo" el vector b, para
% convolucionar, al final tendremos n - 1 muestras extra, con lo que nos
% queda un tama�o de m + n - 1. El -1 se debe a que la ultima muestra, es
% la del vector n - 1, ya que el n ya se multiplicar�a por 0.

Yn = convolucion(b,x);

%% Apartado c)
% Aqu� volvemos hacer una convoluci�n, pero esta vez de con la funci�n
% propia de Matlab. El tama�o de salida sigue siendo m + n - 1. M�s tarde
% se comprueba como la salida de esta funci�n es la misma que la del
% apartado b)

Gn = conv(b,x);

%% Apartado d)
% Con la funci�n filter la se�al de salida se queda acotada a la se�al de
% entrada, por lo que la longitud=m

Hn = filter(b,1,x);

%% Apartado e)
% Representamos en un subplot tanto la se�al original, como la se�al
% filtrada con los tres m�todos anteriores.
% 
% En la gr�fica no se puede apreciar diferencias entre las 3 formas de
% filtrar empleadas. En la gr�fica de Hn (se�al filtrada con funci�n
% filter) se ha realizado un ajuste, ya que el tama�o del vector es menor
% que el de las otras dos funciones (como ya hemos explicado en el apartado
% d)

t_y = 0:1/fs:(length(Yn)-1)/fs;
t_g = t_y;
t_h = 0:1/fs:(length(Hn)-1)/fs;

figure()
subplot(4,1,1)
plot(t,x)
title('Se�al Original')
xlabel('tiempo en segundos')
ylabel('x(t)')


subplot(4,1,2)
plot(t_y,Yn)
title('Se�al convolucionada con funci�n propia')
xlabel('tiempo en segundos')
ylabel('Y(t)')
xlim([0 0.1])

subplot(4,1,3)
plot(t_g,Gn)
title('Se�al convolucionada con funci�n conv')
xlabel('tiempo en segundos')
ylabel('G(t)')
xlim([0 0.1])

subplot(4,1,4)
plot(t_h,Hn)
title('Se�al convolucionada con funci�n filter')
xlabel('tiempo en segundos')
ylabel('H(t)')

%% Apartado f)
% Transitorio: ms que tarda en llenarse la memoria del filtro con todas las
% muestras de la se�al de entrada. L-1 muestras.
% 
% Retardo de grupo: retardo de la informaci�n de la se�al de salida
% respecto a la original. L-1/2 muestras.

disp('Transitorio de Yn en ms')
tranYn = ((length(Yn)-1)/fs)*1000

disp('Transitorio de Gn en ms')
tranGn = ((length(Gn)-1)/fs)*1000

disp('Transitorio de Hn en ms')
tranHn = ((length(Hn)-1)/fs)*1000

disp('Retardo de grupo de Yn en ms')
RgYn = ((length(Yn)-1)/(2*fs))*1000

disp('Retardo de grupo de Gn en ms')
RgGn = ((length(Gn)-1)/(2*fs))*1000

disp('Retardo de grupo de Hn en ms')
RgHn = ((length(Hn)-1)/(2*fs))*1000

%% Apartado g)
% En este apartado se calcula la transformada de Fourier de las se�ales
% originales y las filtradas con los tres m�todos distintos. Con est�s
% gr�ficas se puede apreciar mejor que en el apartado e) que el
% funcionamiento del dichas funciones es correcto y es igual para las tres.
% 
% Al ver las originales y las filtradas, podemos extraer informaci�n de
% que tipo de filtro se trata. En este caso se observa claramente que se
% trata de un filtro paso banda, ya que elimina las frecuencias bajas y las
% altas, pero no unas intermedias. Podr�amos decir que la frecuencia de
% corte por abajo ser�a de aproximadamente 20KHz y la superior estar�a
% aproximadamente sobre los 50KHz.

figure()
subplot(4,1,1)
Xf = (fft(x,length(x)))/length(x);
f_x = linspace(-fs/2,fs/2,length(x));
plot(f_x/1000,fftshift(abs(Xf)));
title('Transformada de Fourier de Xn')
xlabel('Frecuencia en KHz')
ylabel('|Xn(f)|')

subplot(4,1,2)
Yf = (fft(Yn,length(Yn)))/length(Yn);
f_y = linspace(-fs/2,fs/2,length(Yn));
plot(f_y/1000,fftshift(abs(Yf)));
title('Transformada de Fourier de Yn')
xlabel('Frecuencia en KHz')
ylabel('|Yn(f)|')

subplot(4,1,3)
Gf = (fft(Gn,length(Gn)))/length(Gn);
f_g = linspace(-fs/2,fs/2,length(Gn));
plot(f_g/1000,fftshift(abs(Gf)));
title('Transformada de Fourier de Gn')
xlabel('Frecuencia en KHz')
ylabel('|Gn(f)|')


subplot(4,1,4)
Hf = (fft(Hn,length(Hn)))/length(Hn);
f_h = linspace(-fs/2,fs/2,length(Hn));
plot(f_h/1000,fftshift(abs(Hf)));
title('Transformada de Fourier de Hn')
xlabel('Frecuencia en KHz')
ylabel('|Hn(f)|')

%% Dise�o de filtros
% 
% 

%% Apartado a y b)
% Se procede a dise�ar un filtro paso bajo con las especificaciones del
% enunciado. Dicho filtro lo exportamos en un .mat, para poder leer dicho
% vector sin tener que dise�ar el filtro todas las veces. Debido a esto, la
% primera instruccion es la del load del fichero.
% 
% Para comprobar que el dise�o es correcto, hemos decidido realizar una
% serie de subplots de los espectros. La primera gr�fica es la se
% corresponde a la se�al original en dBs y la seguna a la filtrada tambi�n
% en dBs. Esta representaci�n en decibelos la hemos escogido por la
% facilidad de comprobar si el filtro cumple con las especificaciones
% indicadas. Las ultimas dos gr�ficas son iguales que las primeras, pero en
% unidades naturales. En estas �ltimas dos, son menos expresivos los
% valores de amplitud, pero se ve m�s claro el proceso de filtrado, ya que
% no se ve tanto pico en la se�al.
% 
% Es importante indicar que, cuando (por ejemplo en este filtro) te indican
% que la banda de paso tiene atenuaci�n de 80dBs, se refiere a que la se�al
% filtrada, esas frecuencias deben estar a 80dBs por debajo de la original,
% no a -80dBs respecto del 0. Por ello, hemos ploteado tambi�n la se�al
% original en dBs.

load('lpf1.mat');
X_filt = filter(lpf1,1,x);
 
Xf_filt = (fft(X_filt,length(X_filt)))/length(X_filt);
f_xfilt = linspace(-fs/2,fs/2,length(X_filt));

figure()
subplot(4,1,1)
plot(f_x/1000,mag2db(fftshift(abs(Xf))));
title('Transformada de Fourier de X')
xlabel('Frecuencia en KHz')
ylabel('|X(f)| en dBs')

subplot(4,1,2)
plot(f_xfilt/1000,mag2db(fftshift(abs(Xf_filt))));
title('Transformada de Fourier de X filtrada')
xlabel('Frecuencia en KHz')
ylabel('|X filtrada(f)| en dBs')

subplot (4,1,3)
plot(f_x/1000,fftshift(abs(Xf)));
title('Transformada de Fourier de X')
xlabel('Frecuencia en KHz')
ylabel('|X(f)|')

subplot(4,1,4)
plot(f_xfilt/1000,fftshift(abs(Xf_filt)));
title('Transformada de Fourier de X filtrada')
xlabel('Frecuencia en KHz')
ylabel('|X filtrada(f)|')

%% Apartado c y d)
% Ahora, repetimos todo lo anterior pero con un nuevo filtro a dise�ar,
% esta vez paso alto. En la gr�ficas se puede observar que se cumplen con
% las especificaciones, siguiendo el mismo procedimiento que el apartado
% anterior y con las mismas gr�ficas.

load('hpf1.mat');
X_filt = filter(hpf1,1,x);
 
Xf_filt = (fft(X_filt,length(X_filt)))/length(X_filt);
f_xfilt = linspace(-fs/2,fs/2,length(Xf_filt));

figure()
subplot(4,1,1)
plot(f_x/1000,mag2db(fftshift(abs(Xf))));
title('Transformada de Fourier de X')
xlabel('Frecuencia en KHz')
ylabel('|X(f)| en dBs')

subplot(4,1,2)
plot(f_xfilt/1000,mag2db(fftshift(abs(Xf_filt))));
title('Transformada de Fourier de X filtrada')
xlabel('Frecuencia en KHz')
ylabel('|X filtrada(f)| en dBs')

subplot(4,1,3)
plot(f_x/1000,fftshift(abs(Xf)));
title('Transformada de Fourier de X')
xlabel('Frecuencia en KHz')
ylabel('|X(f)|')

subplot(4,1,4)
plot(f_xfilt/1000,fftshift(abs(Xf_filt)));
title('Transformada de Fourier de X filtrada')
xlabel('Frecuencia en KHz')
ylabel('|X filtrada(f)|')

%% An�lisis de Filtros

%% Apartado a)
% Se pide filtrar con el filtro paso bajo dise�ado la se�al original.
% Nosotros hemos optado por usar la funci�n proporcionada por Matlab
% filter().

Yn1 = filter(lpf1,1,x);

%% Apartado b)
% Ahora procedemos a filtrar la se�al original con el filtro paso alto
% dise�ado anteriormente con la funci�n filter().

Gn1 = filter(hpf1,1,x);

%% Apartado c)
% Dise�amos un filtrom paso banda llamado bpf1 con las especificaciones
% requeridas y lo exportamos en un .mat por las razones indicadas 
% anteriormente.

%% Apartado d)
% Cargamos el filtro paso banda y filtramos la se�al original con filter().

load('bpf1.mat');
Hn1 = filter(bpf1,1,x);

%% Apartado e)
% Representamos los espectros de la se�al original, la original filtrada por un
% filtro paso bajo y por un paso alto. Los plots los volvemos a representar
% en dBs para poder asegurar que los requisitos del enunciado se cumplen.

Yn1f = (fft(Yn1,length(Yn1)))/length(Yn1);
f_hfilt = linspace(-fs/2,fs/2,length(Yn1f));

Gn1f = (fft(Gn1,length(Gn1)))/length(Gn1);

figure()
subplot(3,1,1)
plot(f_h/1000,mag2db(fftshift(abs(Xf))));
title('Transformada de Fourier de Xf')
xlabel('Frecuencia en KHz')
ylabel('|X(f)| en dBs')

subplot(3,1,2)
plot(f_hfilt/1000,mag2db(fftshift(abs(Yn1f))));
title('Transformada de Fourier de Yn1 filtrada')
xlabel('Frecuencia en KHz')
ylabel('|Yn1 filtrada(f)| en dBs')

subplot(3,1,3)
plot(f_hfilt/1000,mag2db(fftshift(abs(Gn1f))));
title('Transformada de Fourier de Gn1 filtrada')
xlabel('Frecuencia en KHz')
ylabel('|Gn1 filtrada(f)| en dBs')

%% Apartado f)
% Repetimos el apartado anterior pero esta vez representanando la se�al
% original, la filtrada con un paso alto y la filtrada con un paso banda.
% Volvemos a representaro en dBs para ver que el proceso es correcto.

Hn1f = (fft(Hn1,length(Hn1)))/length(Hn1);
figure()
subplot(3,1,1)
plot(f_h/1000,mag2db(fftshift(abs(Xf))));
title('Transformada de Fourier de Xf')
xlabel('Frecuencia en KHz')
ylabel('|X(f)| en dBs')

subplot(3,1,2)
plot(f_hfilt/1000,mag2db(fftshift(abs(Hn1f))));
title('Transformada de Fourier de Yn1 filtrada')
xlabel('Frecuencia en KHz')
ylabel('|Yn1 filtrada(f)| en dBs')

subplot(3,1,3)
plot(f_hfilt/1000,mag2db(fftshift(abs(Gn1f))));
title('Transformada de Fourier de Gn1 filtrada')
xlabel('Frecuencia en KHz')
ylabel('|Gn1 filtrada(f)| en dBs')

%% Orden del filtro

%% Apartado a y b)
% Creamos los filtros paso bajo con 10, 20 y 50 coeficientes y lo
% exportamos en un .mat. Para representar gr�ficamente los espectros de los
% filtros paso bajo, empleamos la funci�n freqz proporcionada por Matlab.
% En la documentaci�n se observa que los imputs de dicha funci�n son muy
% diversos, seg�n lo que queramos a la salida. Nosotros hemos optado por
% imputs: freqz(filtro,Tam_Filtro,Fs), ya que nos proporciona a la salida,
% tanto la transformada de Fourier como el vector de frecuencias, as� no
% tenemos que calcularlo nosotros.

load('lpf1_10.mat');
load('lpf1_20.mat');
load('lpf1_50.mat');
[h1,f1]=freqz(lpf1_10,length(lpf1_10), 185010);
[h2,f2]=freqz(lpf1_20,length(lpf1_20), 185010);
[h3,f3]=freqz(lpf1_50,length(lpf1_50), 185010);
[h4,f4]=freqz(lpf1,length(lpf1), 185010);
figure();
subplot (4,1,1)
plot (f1,mag2db(abs(h1)))
title('Respuesta en frecuencia de lpf1 10')
xlabel('Frecuencias')
ylabel('H1(f) en dBs')
subplot (4,1,2)
plot (f2,mag2db(abs(h2)))
title('Respuesta en frecuencia de lpf1 20')
xlabel('Frecuencias')
ylabel('H2(f) en dBs')
subplot (4,1,3)
plot (f3,mag2db(abs(h3)))
title('Respuesta en frecuencia de lpf1 50')
xlabel('Frecuencias')
ylabel('H3(f) en dBs')
subplot (4,1,4)
plot (f4,mag2db(abs(h4)))
title('Respuesta en frecuencia de lpf1')
xlabel('Frecuencias')
ylabel('H4(f) en dBs')

%% Apartado c)
% Se ha calculado de la misma forma que en la primera parte.

disp('Retardo de grupo de H1 en ms')
RgH1 = ((length(h1)-1)/(2*fs))*1000

disp('Retardo de grupo de H2 en ms')
RgH2 = ((length(h2)-1)/(2*fs))*1000

disp('Retardo de grupo de H3 en ms')
RgH3 = ((length(h3)-1)/(2*fs))*1000

disp('Retardo de grupo de H4 en ms')
RgH4 = ((length(h4)-1)/(2*fs))*1000
