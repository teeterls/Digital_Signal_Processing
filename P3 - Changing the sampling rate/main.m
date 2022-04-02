%% Pr�ctica 3
% 
% Teresa Gonz�lez y Miguel Oleo
% 
% 
%% Introducci�n
%
% En esta pr�ctica utilizaremos los conceptos dados en teor�a de cambio de
% velocidad de muestreo en el dominio discreto: diezmado por factor entero, interpolaci�n por un factor entero y cambio de frecuencia de muestreo por un factor racional
% con la combinaci�n de ambos. El objetivo de la misma es entender mejor
% dichos conceptos y observar mediante la programaci�n del c�digo y las
% gr�ficas resultantes qu� pasa utilizando las distintas t�cnicas (por ejemplo el espectro resultante),
% comprobando as� lo dado en teor�a. Adem�s, esta pr�ctica ayuda a afianzar
% que si se tiene una necesidad de modificar la velocidad de muestreo de un
% sistema es mucho m�s sencillo hacerlo en el dominio discreto sin tener
% que pasar por el anal�gico. 

%% Diezmado por un factor entero
%% Apartado a)
% 
% Cargamos el archivo y lo reproducimos.

[Xn, fs] = audioread('PDS_P3_LE2_G3.wav');
sound(Xn,fs);

%% Apartado b)
% 
% Creamos el vector de tiempos, tal y como lo hicimos en la pr�ctica
% anterior. Con este vector podemos representar la se�al Xn en el tiempo.
% Se sigue apreciando un peque�o ruido al principio y al final de la se�al.

dt = 1/fs;
t= 0:dt:((length(Xn)-1)/fs);
figure();
plot(t,Xn)
title('Se�al  de audio original')
xlabel('Tiempo en segundos')
ylabel('Xn(t)')

%% Apartado c)
% 
% Creamos Yn a partir de Xn y eliminamos el ruido mencionado en el apartado
% anterior. Mostramos la se�al limpiada en el tiempo, donde se puede
% observar que dicho ruido ha sido eliminado.

Yn = Xn;
index1 = find(t <= 0.1412);
index2 = find(t >= 4.2303);
Yn(index1)=0;
Yn(index2)=0;

figure;
plot(t,Yn)
title('Se�al limpiada Yn')
xlabel('Tiempo en segundos')
ylabel('Yn(t)')

%% Apartado d ,e y f)
% 
% Creamos la funci�n Diezmador que recibe M (factor de diezmado) y Yn
% (se�al a diezmar). Esta funci�n devuelve Gn, la cual es la se�al Yn
% diezmada por M. Diezmar por un factor M, significa que la nueva se�al se
% genera a partir de 1 de cada M muestras de la se�al original.
% 
% Para poder representar esta se�al, hay que calcular la nueva frecuencia
% de muestreo (=fs(original)/M) y crear el nuevo vector de tiempos.

M = 2;
Gn = Diezmador(M,Yn);
fs_g = fs/M;
dt2 = 1/fs_g;
t_g = 0:dt2:((length(Gn)-1)/fs_g);
figure()
plot(t_g,Gn)
title('Yn diezmada con M=2')
ylabel('Gn(t)')
xlabel('Tiempo en segundos')

%% Apartado g)
% 
% Para poder ver gr�ficamente este proceso de diezmado, representamos una
% peque�a muestra superpuesta de las se�ales con distintos marcadores. En
% nuestro caso, como M=2, veremos que la se�al diezmada toma una muestra de
% cada dos de la original.

vect_1 = 18000:18050;
vect_2 = (18000/M):(18050/M);

figure()
plot(t(vect_1),Yn(vect_1),'-o','MarkerSize',10)
hold on
plot(t_g(vect_2),Gn(vect_2),'-*','MarkerSize',10)
title('Comprobaci�n diezmado');
xlabel('Tiempo en segundos')
ylabel('Amplitud')
legend('Se�al original','Se�al diezmada por M')

%% Apartado h)
% 
% A continuaci�n se muestran los espectros de las se�ales original y
% diezmadas (con eje de frecuencias fs/M es decir, normalizados) y
% por �ltimo, la misma se�al diezmada pero sin normalizar el eje de
% frecuencias con su nueva fs.
% 
% En los plot se puede apreciar como en la
% �ltima gr�fica el espectro se ha ensanchado por un factor M. En la
% gr�fica en la que est� normalizado con fs/M se puede apreciar mejor
% como es la misma se�al y por ello, si quisieramos recuperar la misma
% se�al, tendr�amos que muestrear de nuevo a una fs' = fs/M.

figure()
subplot(3,1,1)
Yf = (fft(Yn,length(Yn)))/length(Yn);
f_y = linspace(-fs/2,fs/2,length(Yn));
plot(f_y/1000,fftshift(abs(Yf)));
xlim([-5 5]);
title('Transformada de Fourier de Yn')
xlabel('Frecuencia en KHz')
ylabel('|Yn(f)|')

subplot(3,1,2)
Gf = (fft(Gn,length(Gn)))/length(Gn);
f_g = linspace(-fs_g/2,fs_g/2,length(Gn));
plot(f_g/1000,fftshift(abs(Gf)));
xlim([-5 5]);
title('Transformada de Fourier de Gn con eje de frecuencias normalizado')
xlabel('Frecuencia en KHz')
ylabel('|Gn(f)|')


subplot(3,1,3)
f_g2 = linspace(-fs/2,fs/2,length(Gn));
plot(f_g2/1000,fftshift(abs(Gf)));
xlim([-5 5]);
title('Transformada de Fourier de Gn sin normalizar eje de frecuencias')
xlabel('Frecuencia en KHz')
ylabel('|Gn(f)|')

%% Apartado i)
% 
% En ese caso, al pasar por el diezmador (fs2 = fs1/2), por lo que si hay
% se�al estre fs1/2 y fs1/4 (fs2/2), se producir� aliasing. Esto concuerda
% con lo visto en teor�a, donde vimos que si la se�al tiene componentes por
% encima de fs1/(2*M), al diezmar habr� aliassing.
% 
% Para solucionar esto, proponemos poner un filtro de ancho de banda f1/4
% (fs2/2) antes de diezmar.

%% Interpolaci�n por un factor entero
% 
%% Apartado a, b y c)
% 
% Creamos una funcion Interpolador, que recibe L (factor de interpolaci�n)
% e Yn (se�al original). Como resultado devuelve Hn, que es la se�al
% original pero con L-1 ceros entre cada muestra. La nueva frecuencia de
% muestreo ser� fs1*L.

L = 2;
Hn = Interpolador(L,Yn);
fs_h = fs*L;
dt3 = 1/fs_h;
t_h= 0:dt3:((length(Hn)-1)/fs_h);

figure()
plot(t_h,Hn)
title('Yn interpolada con L=2')
ylabel('Hn(t)')
xlabel('Tiempo en segundos')

%% Apartado d)

Kn = Filtro(Hn,fs_h,L,fs_h/(2*L));

% funci�n para quitar el retardo en tiempo del filtro
Ka = Kn;
index_1 = find(Yn~=0,1,'first')-1;
index_2 = find(Kn~=0,1,'first')-1;
index = 1:(index_2-index_1);
Ka(index)=[];
index_f = index+length(Ka);
Ka(index_f)=0;

%% Apartado e)
% 
% G=2 , porque L=2. El ancho se comprime por 1/L para que el �rea (potencia) se
% mantenga, hay que multiplicar la amplitud por L.

%% Apartado f)
% 
% Frecuencia de corte=fs_h/(2*L), para quedarnos con el ancho de
% banda de inter�s y asegurarnos que borramos las r�plicas (las cuales
% est�ran L veces m�s juntas porque el espectro se comprime).

%% Apartado g)
% 
% A continuaci�n se muestran las se�ales original, interpolada y
% filtrada. Se puede ver que el procesor es correcto, ya que en la se�al
% interpolada se puede observar que introduce L-1 ceros entre cada muestra.
% En cuanto al filtro, tambi�n se observa que funciona correctamente, ya
% que vemos el retardo citado en el enunciado.

vect_1 = 25000:25020;
vect_2 = (25000*L):(25020*L);

figure()
plot(t(vect_1),Yn(vect_1),'-o','MarkerSize',10)
hold on
plot(t_h(vect_2),Hn(vect_2),'-*','MarkerSize',10)
hold on
plot(t_h(vect_2),Kn(vect_2),'-d','MarkerSize',10)
title('Comprobaci�n Interpolaci�n');
xlabel('Tiempo en segundos')
ylabel('Amplitud')
legend('Se�al original','Se�al interpolada por L','Se�al filtrada con retardo')

%% Apartado h)
% 
% El interpolador mete L-1 ceros entre cada muestra. Por ello, el espectro
% se ve estrechado y nos aparecen r�plicas de la se�al a la nueva
% frecuencia de muestreo. Para poder recuperar la se�al original, filtramos
% esta se�al interpolada para quitar dichas r�plicas y para recuperar la
% amplitud de la se�al original.

figure()
subplot(3,1,1)
Yf = (fft(Yn,length(Yn)))/length(Yn);
f_y = linspace(-fs/2,fs/2,length(Yn));
plot(f_y/1000,fftshift(abs(Yf)));
xlim([-5 5]);
title('Transformada de Fourier de Yn')
xlabel('Frecuencia en KHz')
ylabel('|Yn(f)|')

subplot(3,1,2)
Kf = (fft(Ka,length(Ka)))/length(Ka);
f_k = linspace(-fs_h/2,fs_h/2,length(Kf));
plot(f_k/1000,fftshift(abs(Kf)));
xlim([-5 5]);
title('Transformada de Fourier de Kn normalizando eje de frecuencias')
xlabel('Frecuencia en KHz')
ylabel('|Kn(f)|')

subplot(3,1,3)
Kf = (fft(Ka,length(Ka)))/length(Ka);
f_k2 = linspace(-fs/2,fs/2,length(Kf));
plot(f_k2/1000,fftshift(abs(Kf)));
xlim([-5 5]);
title('Transformada de Fourier de Kn sin normalizar eje de frecuencias')
xlabel('Frecuencia en KHz')
ylabel('|Kn(f)|')

%% Apartado i)
% 
% Ya que la interpolaci�n consiste en insertar 0's en el dominio discreto,
% lo que se traduce en una compresi�n del espectro, otra alternativa es
% hacer la fft de la se�al original (representaci�n entre -0.5 y 0.5) y meter 0's a la derecha y la izquierda
% (si L=2, N/2 en cada lado, siendo N el BW del espectro original comprendido entre -0.5
% y 0.5, por lo que el total del BW ser�a 2N). Por lo tanto, al hacer la fft inversa obtendr�amos el espectro de la se�al original comprimido (con la ganancia inicial), tal como si hubieramos realizado interpolaci�n. 
% 

%% Cambio de la frecuancia de muestreo por un factor facional
% 
%% Apartado a)
% 
% 128 KHz = 4/3 * fs
% 
L = 4; 
M = 3;

%% Apartado b)

Hn = Interpolador(L,Yn);

%% Apartado c)

fs_1 = fs*L;

%% Apartado d)
% 
% Los valores escogidos para filtrar la se�al, siguen la misma explicaci�n
% que el anterior filtro realizado.

Kn = Filtro(Hn,fs_1,L,fs_1/(2*L));

% funci�n para quitar el retardo en tiempo del filtro
Ka = Kn;
index_1 = find(Yn~=0,1,'first')-1;
index_2 = find(Kn~=0,1,'first')-1;
index = 1:(index_2-index_1);
Ka(index)=[];
index_f = index+length(Ka);
Ka(index_f)=0;


%% Apartado e)
%
% g = L
% fc = fs_1/(2*L)

%% Apartado f)

Gn = Diezmador(M,Ka);

%% Apartado g)
% 
% A continuaci�n se muestra la se�al original, la se�al interpolada por L,
% la se�al filtrada y la se�al diezmada por M. Se puede observar que el
% proceso es correcto, ya que al interpolar, mete L-1 (3) ceros cada
% muestras y al diezmar coge una de cada M (3) muestras.

dt3 = 1/fs_1;
t_h = 0:dt3:((length(Hn)-1)/fs_1);

fs_g = fs_1/M;
dt2 = 1/fs_g;
t_g = 0:dt2:((length(Gn)-1)/fs_g);

vect_1 = 25000:25010;
vect_2 = (25000*L):(25010*L);
vect_3 = round((25000*L/M):(25010*L/M));

figure()
subplot(2,1,1)
plot(t(vect_1),Yn(vect_1),'-o','MarkerSize',10)
hold on
plot(t_h(vect_2),Hn(vect_2),'-*','MarkerSize',10)
legend('Se�al original','Se�al interpolada por L')
xlabel('Tiempo en segundos')
ylabel('Amplitud')

subplot(2,1,2)
plot(t_h(vect_2),Ka(vect_2),'-d','MarkerSize',10)
hold on
plot(t_g(vect_3),Gn(vect_3),'-s','MarkerSize',10)
legend('Se�al filtrada sin ajustar','Se�al diezmada por M')
xlabel('Tiempo en segundos')
ylabel('Amplitud')

%% Apartado h)
% 
% Viendo los espectros de las se�ales originales, interpoladas, filtradas y
% diezmadas, podemos afirmar que el proceso ha sido correcto.
% 
% En las gr�ficas no se aprecia ni la expansi�n (diezmador), ni compresi�n
% (interpolador) del espectro. Esto se debe a que cada espectro ha sido
% representado respecto de su nueva frecuencia normalizada (frecuencia
% dividida entre su frecuencia de muestreo), por ello, todas tienen el
% mismo ancho de banda. Ya demostramos en plot anteriores como el espectro
% se ensancha al diezmar y se estrecha al interpolar.

figure()
subplot(4,1,1)
Yf = (fft(Yn,length(Yn)))/length(Yn);
f_y = linspace(-fs/2,fs/2,length(Yn));
plot(f_y/1000,fftshift(abs(Yf)));
xlim([-5 5]);
title('Transformada de Fourier de Yn')
xlabel('Frecuencia en KHz')
ylabel('|Yn(f)|')

subplot(4,1,2)
Hf = (fft(Hn,length(Hn)))/length(Hn);
f_h = linspace(-fs_1/2,fs_1/2,length(Hf));
plot(f_h/1000,fftshift(abs(Hf)));
xlim([-5 5]);
title('Transformada de Fourier de se�al Interpolada (Hn)')
xlabel('Frecuencia en KHz')
ylabel('|Hn(f)|')

subplot(4,1,3)
Kf = (fft(Ka,length(Ka)))/length(Ka);
f_h = linspace(-fs_1/2,fs_1/2,length(Kf));
plot(f_h/1000,fftshift(abs(Kf)));
xlim([-5 5]);
title('Transformada de Fourier de Hn filtrada')
xlabel('Frecuencia en KHz')
ylabel('|Hn(f)|')

subplot(4,1,4)
Gf = (fft(Gn,length(Gn)))/length(Gn);
f_g = linspace(-fs_g/2,fs_g/2,length(Gf));
plot(f_g/1000,fftshift(abs(Gf)));
xlim([-5 5]);
title('Transformada de Fourier de la se�al diezmada (Gn)')
xlabel('Frecuencia en KHz')
ylabel('|Gn(f)|')