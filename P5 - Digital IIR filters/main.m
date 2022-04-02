%% Práctica 5
% 
% Teresa González y Miguel Oleo

%% Introducción
% 
% En esta práctica diseñaremos distintos tipos de filtros IIR causales con la herramienta de Matlab.
% Posteriormente analizaremos las características principales como la estabilidad a partir de los diagramas
% de polos y ceros en el plano Z y la función de transferencia de la
% transformada Z. Explicaremos los resultados obtenidos de forma matemática y teórica y
% también intuitiva. 
% Finalmente, representaremos la respuesta impulsiva de algunos filtros IIR,
% justificando de nuevo los resultados con la teoría dada en clase. 


%% Diseño de filtros IIR
% 
load('PDS_P5_LE2_G4');
%% Apartado a)
% 

load('IIR_LP_1.mat');

%% Apartado b)
% 

load('IIR_LP_2.mat');

%% Apartado c)
% 

load('IIR_LP_3.mat');

%% Apartado d)
% 

load('IIR_LP_4.mat');

%% Análisis de filtros
%
%% Modulo y fase
% 
%% Apartado a)
% 
% En este apartado se analizan las diferencias en ganancia de los cuatro
% filtros diseñados. Para ello utilizamos la función freqz con 10000
% puntos, que nos devuelve la función de transferencia de cada de cada
% filtro y el vector de frecuencias correspondiente.
% Se ha representado el módulo de la respuesta en frecuencia tanto en valores de amplitud como en dB,
% donde se ve mejor la frecuencia de corte de cada filtro cuando cae la
% ganancia en 3dB. Cabe destacar que solamente se representa la parte
% positiva de la respuesta en frecuencia.
% Se puede observar que en la banda de paso, la ganancia es 1 (0dbs), si
% bien en el primer y tercer filtro hay un rizado (el cual se explicará con
% el diagrama de polos y ceros). Además, en el filtro 2 y el filtro 3 el
% transtorio es más largo, como se puede observar en las gráficas en dBs,
% ya que no hay una caída brusca a 0, si no pendiente negativa que
% progresivamente cae hacia 0. En el primero y en el último si hay caídas a
% 0 que atenúan mucho más la señal en la banda de rechazo (esto se debe al
% número de 0's de la transformada Z). Por otro lado, observando la
% frecuencia de corte donde se produce la caída de 3dBs, se puede concluir
% que el filtro 4 es el que tiene una banda de paso ligeramente algo menor
% (fc en torno a 4 Khz), mientras que en los otros tres la fc de corte se
% encuentra en torno a 7.5 Khz, siendo ligeramente mayor la del filtro 1 y menor la del filtro 2. 
% Debido a lo ya explicado, la atenuación en el filtro 2 es progresiva y más suave que en el resto. 

n = 10000;

[h1,f1] = freqz(Num1,Den1,n,Fs);
[h2,f2] = freqz(Num2,Den2,n,Fs);
[h3,f3] = freqz(Num3,Den3,n,Fs);
[h4,f4] = freqz(Num4,Den4,n,Fs);

figure()
subplot(4,2,1)
plot(f1/1000,abs(h1))
title('Función de transferencia filtro 1')
xlabel('Frecuencias en KHz')
ylabel('|H1(z)|')
subplot(4,2,2)
plot(f1/1000,mag2db(abs(h1)))
title('Función de transferencia filtro 1')
xlabel('Frecuencias en KHz')
ylabel('|H1(z)|en dBs')
subplot(4,2,3)
plot(f2/1000,abs(h2))
title('Función de transferencia filtro 2')
xlabel('Frecuencias en KHz')
ylabel('|H2(z)|')
subplot(4,2,4)
plot(f2/1000,mag2db(abs(h2)))
title('Función de transferencia filtro 2')
xlabel('Frecuencias en KHz')
ylabel('|H2(z)| en dBs')
subplot(4,2,5)
plot(f3/1000,abs(h3))
title('Función de transferencia filtro 3')
xlabel('Frecuencias en KHz')
ylabel('|H3(z)|')
subplot(4,2,6)
plot(f3/1000,mag2db(abs(h3)))
title('Función de transferencia filtro 3')
xlabel('Frecuencias en KHz')
ylabel('|H3(z)| en dBs')
subplot(4,2,7)
plot(f4/1000,abs(h4))
title('Función de transferencia filtro 4')
xlabel('Frecuencias en KHz')
ylabel('|H4(z)|')
subplot(4,2,8)
plot(f4/1000,mag2db(abs(h4)))
title('Función de transferencia filtro 4')
xlabel('Frecuencias en KHz')
ylabel('|H4(z) en dBs')

%% Apartado b)
% 
% Para ver las fases hay que fijarse en la parte antes de la banda de paso.
% La banda de paso, el único indicador que podemos observar es que la fase
% tenga pendiente negativa. Puede ser lineal o no, en caso de ser lineal la
% fase, todas la frecuencias tendrán el mismo retardo. Si la fase no fuese
% lineal, habría distintias frecuencias con distintos retardos.
% 
% La fase en la banda de rechazo no nos aporta mucha información. Al hacer
% el módulo practicamente cero, no nos podemos fiar de la fase.

ph1 = unwrap(angle(h1));
ph2 = unwrap(angle(h2));
ph3 = unwrap(angle(h3));
ph4 = unwrap(angle(h4));

figure()
freq = linspace(0,Fs/2,length(ph1))/1000;
subplot(4,1,1)
plot(freq,ph1)
title('Fase filtro 1')
xlabel('Frecuencias en KHz')
ylabel('Fase del filtro')
subplot(4,1,2)
plot(freq,ph2)
title('Fase filtro 2')
xlabel('Frecuencias en KHz')
ylabel('Fase del filtro')
subplot(4,1,3)
plot(freq,ph3)
title('Fase filtro 3')
xlabel('Frecuencias en KHz')
ylabel('Fase del filtro')
subplot(4,1,4)
plot(freq,ph4)
title('Fase filtro 4')
xlabel('Frecuencias en KHz')
ylabel('Fase del filtro')

%% Polos y Ceros
% 
%% Apartado a)
% 
% A continuación se muestran los diagramas de polos y ceros. Los
% comentarios respecto a estas gráficas están en apartados posteriores.

figure();
zplane(Num1,Den1)
title('Polos y ceros del filtro 1')
axis([-1.5 1.5 -1.5 1.5])
figure();
zplane(Num2,Den2)
title('Polos y ceros del filtro 2')
axis([-1.5 1.5 -1.5 1.5])
figure();
zplane(Num3,Den3)
title('Polos y ceros del filtro 3')
figure();
zplane(Num4,Den4)
title('Polos y ceros del filtro 4')
axis([-1.5 1.5 -1.5 1.5])

%% Apartado b)
% 
% Para que sea estable, la ROC debe incluir a la circunferencia de radio 1.
% En los plots anteriores se puede observar que los polos más lejanos están
% dentro de la circunferencia radio 1. Todos los filtros empleados en esta
% práctica son causales, ya que son implementables. Debido a esto, sabemos
% que la ROC es del polo más exterior hacia fuera de la circunferencia.
% 
% En nuestros filtros, todas sus ROCs contienen dicha circunferencia, por
% loq que son estables.

%% Apartado c)
% 
% En los diagramas de polos y ceros, se puede observar que los polos se
% encuentran etorno a las frecuencias bajas y los ceros en las más altas.
% Por ello, en la representación del módulo de la respuesta en frecuencia,
% la ganancia es mayor en frecuencias bajas. Bastaría mirar solo de w =
% [0,pi] ya que el espectro es simétrico.
% 
% En el primer y último filtro se puede observar que hay varios ceros
% distribuidos en las bandas altas. Esto crea un rizado en la banda de
% rechazo, que se puede ver en las gráficas del módulo de la respuesta en
% frecuencia en forma de "montañas". Por el contrario, la segunda y la
% tercera no presentan estas características, ya que todos sus ceros están
% concentrados en el mismo punto, en concreto n w = pi. 
% 
% La banda de paso también presenta un leve rizado en los filtros 1 y 3.
% Esto se debe a que en esos dos filtros, en el diagrama de polos y ceros,
% se puede observar como los polos están más separados entre si. La
% amplitud de dicho rizado dependerá de como de próximos esten los polos a
% la circunferencia de radio 1.

%% Apartado d y e)
% 
% Teniendo en cuenta que la función de transferencia consiste de una
% división entre el productorio de ceros y el productorio de polos, el
% módulo de esta función, puede descomponerse en una división de productos
% de distancias entre vectores. El numerador es el productorio de las
% distancias ente cada punto(cada w) de la circunferencia y todos ceros. De
% la misma forma, el denominador es la distancia entre cada punto de la
% circunferencia y todos los polos.
% 
% De esa última expresión podemos obtener varias conclusiones. Las
% amplitudes cambian segun los polos o los ceros estén más próximos a la
% circunferencia. Si tenemos un polo en la circunferencia, la distancia es
% cero, por lo que el denominador tiene mucho peso y el módulo de la 
% función de transferencia se aproxima a algo/0 que es infinito. 
% Igualmente, si tenemos Un cero sobre la circunferencia, el módulo se
% aproxima a 0/algo que es cero. Si se da el caso que hay un polo y ceros
% juntos, se forma una indeterminación y se anulan.
% 
% 
% Ahora nos vamos a centrar en el filtro IIR Elíptico (filtro 1). Los
% máximos, según lo visto en el anterior párrafo, se dan cuando hay un polo
% cerca de la circunferencia. En nuestro ejemplo, se da en la banda de paso
% estan entre cero y algo más de pi/4. En concreto, el mayor pico se da
% justo antes del transitorio del filtro, ya que se encuentra un polo muy
% próximo a la circunferencia.
% 
% Las frecuencias eliminadas en la banda eliminada coinciden con las w en
% las que hay ceros en la circunferencia. Entorno a pi/2 hay 3 ceros, cerca
% de 3pi/4 hay otro y a pi uno más. Esto concuerda con la respuesta en
% frecuencia vista al inicio de la práctica.

%% Estabilidad
% 
%% Apartado a ,b ,c, d y f)
% 
% Para multiplicar los polos por un factor, primero necesitamos sacar las
% raices del denominador, escalarlas por el factor y sacar los nuevos
% coeficientes. Estos nuevos coeficientes son Den1_1 y Den1_2.
% 
% En el diagrama de polos y ceros, se puede observar como solo se han
% desplazado levemente los polos. En el caso de 0.95, el tipo de filtro es
% el mismo y sigue siendo estable, pero en el de 1.05 se observa como hay
% un polo fuera de la circunferencia. Debido a esto, como la ROC tambien se
% escala por el factor, en este caso no estable.

raices = roots(Den1);
Den1_1 = poly((raices.*0.95));
Den1_2 = poly((raices.*1.05));

figure();
zplane(Num1,Den1)
title('Polos y ceros del filtro 1')
axis([-1.5 1.5 -1.5 1.5])
figure()
zplane(Num1,Den1_1)
title('Polos y ceros del filtro 1 con Polos*0.95')
axis([-1.5 1.5 -1.5 1.5])
figure()
zplane(Num1,Den1_2)
title('Polos y ceros del filtro 1 con Polos*1.05')
axis([-1.5 1.5 -1.5 1.5])

%% Apartado e y g)
% 
% Los filtros siguen siendo pasos bajo. En el caso de 0.95, ahora los polos
% están mas juntos, por lo que el rizado es menor (despreciable), pero al
% estar más lejos de la circunferencia, su aportación es menor. Por ello,
% se ve en la respuesta al impulso como es de menor ganancia la banda de
% paso.
% 
% En el caso de 1.05, como ya hemos citado, hay un poco fuera de la
% circunferencia y los polos están mas separados. Esto se traduce a algo
% más de rizado y en el polo fuera de la circunferencia, la amplitud de
% dicho rizado será notablemente mayor.

[h1,f1] = freqz(Num1,Den1,n,Fs);
[h2,f2] = freqz(Num1,Den1_1,n,Fs);
[h3,f3] = freqz(Num1,Den1_2,n,Fs);

figure()
subplot(3,1,1)
plot(f1/1000,abs(h1))
title('Filtro 1')
xlabel('Frecuencias en KHz')
ylabel('|H(f)|')
subplot(3,1,2)
plot(f2/1000,abs(h2))
title('Filtro 1 con Polos*0.95')
xlabel('Frecuencias en KHz')
ylabel('|H(f)|')
subplot(3,1,3)
plot(f3/1000,abs(h3))
title('Filtro 1 con Polos*1.05')
xlabel('Frecuencias en KHz')
ylabel('|H(f)|')

%% Apartado h)
%
% En las gráficas se muestra cómo la respuesta impulsional de los filtros
% IIR tiende a infinito. 
% En los dos primeros casos (filtro original y filtro con los
% polos*0.95),el filtro es estable, como se ha explicado en el apartado
% anterior. Por ello, se ve como la respuesta impulsiva converge.
% Sin embargo, en el último caso (filtro con los polos*1.05), el filtro se
% convierte en inestable. Por lo tanto, la respuesta impulsiva diverge. 

[h1,t1] = impz(Num1,Den1);
[h2,t2] = impz(Num1,Den1_1);
[h3,t3] = impz(Num1,Den1_2);

figure()
subplot(3,1,1)
plot(t1,h1)
title('Respuesta al impulso filtro original')
xlabel('Tiempo en segundos')
ylabel('H(n)')
subplot(3,1,2)
plot(t2,h2)
title('Respuesta al impulso del filtro con polos*0.95')
xlabel('Tiempo en segundos')
ylabel('H(n)')
subplot(3,1,3)
plot(t3,h3)
title('Respuesta al impulso del filtro con polos*1.05')
xlabel('Tiempo en segundos')
ylabel('H(n)')
