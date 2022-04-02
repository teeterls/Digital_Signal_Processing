%% Práctica 6
% 
% 
% Teresa González y Miguel Oleo
% 
%% Introducción
% 

%% Cuantificación de los coeficientes de un filtro
% 
%% Apartado a y b)
load('PDS_P6_LE2_G4.mat')
load('Filter_1.mat')

q = quantizer('fixed','round','saturate',[16,8]);

Num1_bin = num2bin(q,Num1);
Den1_bin = num2bin(q,Den1);

%% Secciones de segundo orden
% 

%% Apartado a)
% 

[sos,g] = tf2sos(Num1,Den1);

%% Apartado b)
% 

Num1_bin_1 = num2bin(q,sos(1,1:3));
Den1_bin_1 = num2bin(q,sos(1,4:end));

Num1_bin_2 = num2bin(q,sos(2,1:3));
Den1_bin_2 = num2bin(q,sos(2,4:end));

Num1_bin_3 = num2bin(q,sos(3,1:3));
Den1_bin_3 = num2bin(q,sos(3,4:end));

Num1_bin_4 = num2bin(q,sos(4,1:3));
Den1_bin_4 = num2bin(q,sos(4,4:end));

%sos_bin = num2bin(q,sos);

%% Raíces en Secciones de Segundo Orden
% 

%% Apartado a)
% 

R_Num1_1 = roots(sos(1,1:3));
R_Num1_2 = roots(sos(2,1:3));
R_Num1_3 = roots(sos(3,1:3));
R_Num1_4 = roots(sos(4,1:3));

R_Den1_1 = roots(sos(1,4:end));
R_Den1_2 = roots(sos(2,4:end));
R_Den1_3 = roots(sos(3,4:end));
R_Den1_4 = roots(sos(4,4:end));

%% Apartado b)
% 

R_Num1_1_bin =num2bin(q,R_Num1_1);
R_Num1_2_bin =num2bin(q,R_Num1_2);
R_Num1_3_bin =num2bin(q,R_Num1_3);
R_Num1_4_bin =num2bin(q,R_Num1_4);

R_Den1_1_bin =num2bin(q,R_Den1_1);
R_Den1_2_bin =num2bin(q,R_Den1_2);
R_Den1_3_bin =num2bin(q,R_Den1_3);
R_Den1_4_bin =num2bin(q,R_Den1_4);

%% Análisis general
% 

%% Apartado a)
% 
% raices filtro original Num1 y Den1 BIEN CONCATENADAS
%%R_Num1= roots(Num1);
%%R_Den1= roots(Den1);
original=[Num1  Den1]; 
r_original=roots(original);

% raices filtro original cuantificado Num1_bin MAL CONCATENADAS ?

Num1_q= num2bin(q,roots(Num1));
Den1_q= num2bin(q,roots(Den1));
original_cuant= [Num1_q  Den1_q];

%%original_cuant=num2bin(q, original);
%%R= roots(original_cuant);
 
% raices secciones cuantificadas 

raices_secciones_q= [R_Num1_1_bin R_Num1_2_bin R_Num1_3_bin R_Num1_4_bin R_Den1_1_bin R_Den1_2_bin R_Den1_3_bin R_Den1_4_bin];

disp('Error raices original cuantificado con respecto al original')
ECM(original,original_cuant)

disp('Error raices secciones cuantificadas con respecto al original')
ECM(original,raices_secciones)







