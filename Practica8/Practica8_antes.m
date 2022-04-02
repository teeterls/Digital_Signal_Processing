%% Práctica 8
%


%% Diagrama de bloques y datos
%

%% Apartado a)
%

load('PDS_P8_LE2_G4');
[Dn,fs] = audioread('PDS_P8_LE2_G4_d_n.wav');
sound(Dn,fs);

%% Apartado b)
% 

[Xn,fs] = audioread('PDS_P8_LE2_G4_x_n.wav');
sound(Xn,fs);

%% Implementación del algoritmo LMS
% 

%% Apartado a, b y c)
% 

Wn = zeros(M+1,1);
En = zeros(1,length(Xn));
Yn = zeros(1,length(Xn)-M);

for i=1:length(Xn)-M
    Yn(i) = Wn.'*Xn(i:M+i);
    En(i) = Dn(i)-Yn(i);
    
    Wn = Wn + 2*mu*En(i)*Xn(i);
end

% En no deberia de contener prácticamente solo la voz sin sirenas?
% Yn lo hemos escuchado y si que suenan solo sirenas

sound(En,fs);