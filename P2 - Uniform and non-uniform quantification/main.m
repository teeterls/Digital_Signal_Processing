%% Pr�ctica 2
% 
% Teresa Gonz�lez y Miguel Oleo
% 
% 
% En esta pr�ctica vamos a poner en pr�ctica los conceptos de
% cuantificaci�n uniforme y no uniforme. Para ello vamos a trabajar con un
% fichero de audio y aplicaremos los dos tipos de cuantificaci�n y veremos
% las diferencias que presentan y como se implementan por software.
% 
%% Conceptos de las se�ales de audio
% 
%% Apartado a)
[Xn, fs] = audioread('PDS_P3_LE1_G3.wav');
sound(Xn,fs);

%% Apartado b)
% 
% Creamos el vector de tiempos, empezando en 0 y representamos la se�al Xn
dt = 1/fs;
t= 0:dt:((length(Xn)-1)/fs);
figure();
plot(t,Xn)
title('Se�al de audio original')
xlabel('Tiempo en segundos')
ylabel('Xn(t)')

%% Apartado c)
% 
% La se�al es sim�trica, con respecto a 0. Adem�s, la gran mayor�a de
% puntos se encuentran concentrados en torno al valor medio de la se�al
% (que es aproximadamente 0)

%% Apartado d)
% 
% A partir de la gr�fica del apartado b), podemos observar que al principio
% y al final, no hay se�al (solo ruido). Para quitarlo, procedemos a poner
% los valores de Xn(t) anteriores a 0.14 segundos a 0, y lo mismo con los tiempos
% posteriores a 3.43.

Yn = Xn;
index1 = find(t <= 0.1423);
index2 = find(t >= 3.43);
Yn(index1)=0;
Yn(index2)=0;

figure;
plot(t,Yn)
title('Se�al limpiada Yn')
xlabel('Tiempo en segundos')
ylabel('Yn(t)')

%% Apartado e)
% 
% Calculamos la transformada de Fourier de la se�al anterior y
% representamos su espectro en el margen de frecuencias de interes.

Yf = (fft(Yn,length(Yn)))/length(Yn);
f_y = linspace(-fs/2,fs/2,length(Yn));
figure();
plot(f_y/1000,fftshift(abs(Yf)));
title('Transformada de Fourier de Yn')
xlabel('Frecuencia en KHz')
ylabel('|Yn(f)|')

%% Apartado f)
% 
% Como se puede observar en la transformada de Fourier, la mayores
% amplitudes se encuentran en frecuencias pr�ximas a cero. Por ello, es donde m�s energ�a se concentra.
% 
% Es una representaci�n que no muestra la energ�a que contienen los
% arm�nicos seg�n va variando la se�al. Debido a esto, recomendamos
% representarla mediante un espectrograma, ya que muestra lo anterior.

%% Apartado g)
% 
% Representamos un histograma que muestre los valores de amplitud de cada
% muestra de la se�al Yn.
% 
% Viendo esta gr�fica, se reafirma que la mayor parte de muestras, tienen
% amplitud cercana a cero.

figure()
histogram(Yn,100);
title('Histograma de Yn')
xlabel('Amplitud divida en rangos')
ylabel('Frecuencia estad�stica')

%% Apartado h)
% 
% Representaci�n en diagrama de cajas de la se�al limpiada (Yn). Se puede
% observar que el rango intercuart�lico no es muy amplio, por lo que
% volvemos, otra vez, a verificar que la gran mayor�a de muestr�s est�n muy
% concentradas en torno a la mediana. La media y mediana se puede observar
% que es pr�ximo a cero. Tambi�n cabe destacar que se muestran muchos datos at�picos.

figure()
boxplot(Yn);
title('Boxplot de Yn')
ylabel('Amplitud')

%% Apartado i)
% 
% A continuaci�n se muestran los datos estad�sticos m�s relevantes:

disp('Media de Yn: ')
media = mean(Yn)

disp('Mediana de Yn: ')
mediana = median(Yn)

disp('Desviaci�n t�pica de Yn: ')
desv_tip = std(Yn)

%% Apartado j)
% 
% La gran mayoria de datos est�n muy concentrados respescto de la media
% (aprox cero). Esto confirma que la gran mayor�a de las muest�s tienen una
% amplitud peque�a.

%% Cuantificaci�n uniforme
%% Apartado a)
% 
% Aplicamos el cuantificador, tal y como lo hicimos en la pr�cctica
% anterior.

q1 = quantizer('fixed','round','saturate',[7,5]);
Yq = num2bin(q1,Yn);
figure();
plot(t,bin2num(q1,Yq))
title('Yn cuantificada uniformemente')
xlabel('Tiempo en segundos')
ylabel('Yq(t)')

%% Apartado b)
% 
% Hemos escogido 5 bits decimales, uno entero y otro de signo (ya que la se�al
% va de -1 a 1, por lo que nos hace falta el signo y un digito entero)

%% Cuantificaci�n no uniforme
%
% Utilizamos cuantificaci�n no uniforme para mejorar la precisi�n de
% nuestra se�al cuantificada, ya que en amplitudes peque�as (la gran
% mayor�a de nuestra se�al)los intervalos de cuantificaci�n se hacen
% m�s estrechos para amplitudes bajas.

A = 87.6;

%% Apartado a, b y c)
% 
% Hemos implementado el compresor y expansor en una funci�n de Matlab aparte. Como argumentos de entrada
% recibe primero A (que la hemos fijado anteriormente en el "main") y luego
% recibe la se�al que queremos comprimir. En el expansor, tiene los mismos
% arguumentos que el compresor.
% 
% Para caracterizar estos bloques y apreciar mejor su funcionamiento,
% creamos un vector de -1:1 y se los pasamos a las funciones. En los plots,
% se puede ver como en el expansor, las amplitudes cercanas a 0 (eje y),
% acaparan m�s rango de amplitud. Sin embargo, el expansor hace todo lo
% contario, los valores pr�ximos a cero abarcan muy poco rango de amplitud.
% 
% Por �ltimo se muestra un subplot con la se�al original y la se�al
% comprimida y expandida. En esta gr�fica se puede observar con m�s
% facilidad, c�mo las amplitudes peque�as de la se�al original, en el
% compresor, se han expandido, y en el expansor se han comprimido.
% 
% Los nombres de estos bloques pueden ser algo liosos, pero las gr�ficas
% muestran fielmente su funcionamiento.

vect = linspace(-1,1,length(t));
figure()
subplot(2,1,1)
plot(t,compresor(A,vect));
title('Compresor vector -1:1')
xlabel('Tiempo en segundos')
ylabel('Amplitud')
subplot(2,1,2)
plot(t,expansor(A,vect));
title('Expansor vector -1:1')
xlabel('Tiempo en segundos')
ylabel('Amplitud')

figure()
subplot(3,1,1)
plot(t,Yn);
title('Se�al original Yn')
xlabel('Tiempo en segundos')
ylabel('Yn(t)')
subplot(3,1,2)
plot(t,compresor(A,Yn));
title('Compresor se�al Yn')
xlabel('Tiempo en segundos')
ylabel('Yn(t) comprimida')
subplot(3,1,3)
plot(t,expansor(A,Yn));
title('Expansor se�al Yn')
xlabel('Tiempo en segundos')
ylabel('Yn(t) expandida')

%% Apartado d)
% 
% Para cuantificar no uniformemente, primero pasamos la se�al por el
% compresor, luego por el cuantificador uniforme y, por �ltimo, por el
% expansor.

Ycomp = compresor(A,Yn);
Ycuant = bin2num(q1,num2bin(q1,Ycomp));
Ynuni = expansor(A,Ycuant);
figure();
plot(t,Ynuni);
title('Cuantificaci�n no unfirme')
ylabel('Ynuni(t)')
xlabel('Tiempo en segundos')

%% Analisis resultados
%% Apartado a)
% 
% Reproducimos las tres se�ales y podemos observar, que al cuantificar, se
% introduce un leve ruido de fondo (ruido de cuantificaci�n). La se�al
% cuantificada no uniformemente, es levemente m�s fiel a la se�al original (se escucha menos ruido).

Yuni = bin2num(q1,Yq);
sound(Yn,fs);
sound(Yuni,fs);
sound(Ynuni,fs);

%% Apartado b)
% 
% En la primera gr�fica, hemos representado las tres se�ales por separado.
% Debido a esto, no se puede apreciar mucha diferencia hasta que no hacemos
% zoom. Por ello, en la siguiente gr�fica hemos representado un pequ�o
% segmento de las se�ales y las hemos superpuesto. En esta �ltima gr�fica
% se puede apreciar muiy bien como funcionan los distintos codificadores.
% Es muy visible como el codificador uniforme no es capaz de distinguir
% niveles de amplitud peque�os, mientras que el no uniforme si los
% cuantifica con m�s precisi�n.
% 
% Por �ltimo, la tercera gr�fica es la misma que la segunda pero con una
% secci�n de se�al con mayor amplitud. En esta, se puede observar como el
% detalle que se consigue al cuantificar entre no uniforme y uniforme en
% amplitudes mas altas, es similar.

figure();
subplot(3,1,1)
plot(t,Yn)
title('Se�al original Yn')
xlabel('Tiempo en segundo')
ylabel('Yn(t)')
subplot(3,1,2)
plot(t,Yuni)
title('Se�al cuantificada uniformemente Yuni')
xlabel('Tiempo en segundos')
ylabel('Yuni(t)')
subplot(3,1,3)
plot(t,Ynuni)
title('Se�al cuantificada no uniformemente Ynuni')
xlabel('Tiempo en segundos')
ylabel('Ynuni(t)')

figure()
plot(t(14000:15000),Yn(14000:15000))
title('Comparativa amplitudes peque�as')
xlabel('tiempo en segundos')
ylabel('Amplitud')
hold on
plot(t(14000:15000),Yuni(14000:15000))
hold on
plot(t(14000:15000),Ynuni(14000:15000))
legend('Original','Cuant. uniforme','Cuant. no uniforme')

figure()
plot(t(18000:20000),Yn(18000:20000))
title('Comparativa amplitudes grandes')
xlabel('tiempo en segundos')
ylabel('Amplitud')
hold on
plot(t(18000:20000),Yuni(18000:20000))
hold on
plot(t(18000:20000),Ynuni(18000:20000))
legend('Original','Cuant. uniforme','Cuant. no uniforme')

%% Apartado c)
% 
% A continuaci�n mostramos los resultados del error cuadr�tico medio de las
% se�ales cuantifiacas respecto de la se�al original.
% 
% Como nos esper�bamos, la cuantificaci�n no uniforme presenta una
% mejora en t�rminos de error cuadr�tico medio. Concuerda con nuestra
% intuici�n, ya que nos parec�a que se escuchaba mejor la se�al
% cuantificada no uniformemente. Tambi�n concuerda con las gr�ficas
% anteriores en las que se puede apreciar que la cuantificaci�n no uniforme
% es capar de representar mejor la se�al original en comparaci�n con la
% uniforme

disp('ECM con la se�al Uniformemente cuantificada')
disp(ECM(Yn,Yuni))

disp('ECM con la se�al no uniformemente cuantificada')
disp(ECM(Yn,Ynuni))



    