pkg load symbolic


datafile=fopen('data.txt','r');
data=fscanf(datafile, '%s = %f', [3 inf]);
data = data';
fclose(datafile);

simf=fopen('data_sim.txt','w');
fprintf(simf, 'R1 1 2 %fk\n', data(1,3));
fprintf(simf, 'R2 2 3 %fk\n', data(2,3));
fprintf(simf, 'R3 2 5 %fk\n', data(3,3));
fprintf(simf, 'R4 0 5 %fk\n', data(4,3));
fprintf(simf, 'R5 5 6 %fk\n', data(5,3));
fprintf(simf, 'R6 0 4 %fk\n', data(6,3));
fprintf(simf, 'R7 7 8 %fk\n', data(7,3));
fprintf(simf, 'Vs 1 0 DC %f\n', data(8,3));
fprintf(simf, 'Vf 4 7 DC 0\n');
fprintf(simf, 'C 6 8 %fu\n', data(9,3));
fprintf(simf, 'Gb 6 3 2 5 %fm\n', data(10,3));
fprintf(simf, 'Hd 5 8 Vf %fk\n', data(11,3));

fclose(simf);


R1 = sym(sprintf('%.11f', data(1,3)));
R2 = sym(sprintf('%.11f', data(2,3)));
R3 = sym(sprintf('%.11f', data(3,3)));
R4 = sym(sprintf('%.11f', data(4,3)));
R5 = sym(sprintf('%.11f', data(5,3)));
R6 = sym(sprintf('%.11f', data(6,3)));
R7 = sym(sprintf('%.11f', data(7,3)));
Vs = sym(sprintf('%.11f', data(8,3)));
Vf = sym('0');
C = sym(sprintf('%.11f', data(9,3)));
Kb = sym(sprintf('%.11f', data(10,3)));
Kd = sym(sprintf('%.11f', data(11,3)));

syms V0;
syms V1;
syms V2;
syms V3;
syms V5;
syms V6;
syms V7;
syms V8;
syms Vs;

%%  Atribuição de Valores

R1 = 1.01658203395*1000;
R2 = 2.08071598482*1000;
R3 = 3.12527703197*1000;
R4 = 4.13615246449*1000;
R5 = 3.04804224053*1000;
R6 = 2.06609096892*1000;
R7 = 1.01589064139*1000;
Vs = 5.08211987776;
Id = 1.02439571082/1000;
Kb = 7.30340439475/1000;
Kd = 8.13276803722*1000;
C = 1.02439571082*e-06;

G1 = 1/R1;
G2 = 1/R2;
G3 = 1/R3;
G4 = 1/R4;
G5 = 1/R5;
G6 = 1/R6;
G7 = 1/R7;

%%Método dos Nós_1

V0 == 0;
V8 == V6;
V1-V0 == Vs;
V5-V8 == Kd*(V0-V7)/R6;
(V1-V2)/R1 + (V3-V2)/R2 + (V5-V2)/R3 == 0; 
(V3-V2)/R2-Kb*(V2-V5) == 0;
(V2-V5)/R3 - (V8-V7)/R7 - (V5-V0)/R4-(V5-V6)/R5 == 0;
(V5-V6)/R5 - Kb*(V2-V5) == 0;
(V8-V7)/R7 - (V7-V0)/R6 == 0;

%%    V0    V1           V2          V3      V4             V5         V6      V7      V8

A = [ 1    , 0    , 0               , 0   , 0       , 0               , 0     , 0           , 0     ;...
      0    , 0    , 0               , 0   , 0       , 0               , 1     , 0           , -1    ;...
      -1   , 1    , 0               , 0   , 0       , 0               , 0     , 0           , 0     ;...
      -G6  , 0    , 0               , 0   , 0       , 1/Kd            , 0     , G6          , -1/Kd ;...
      0    , G1   , -(G1 + G2 + G3) , G2  , 0       , G3              , 0     , 0           , 0     ;...
      0    , 0    , -(G2 + Kb)      , G2  , 0       , Kb              , 0     , 0           , 0     ;...
      G4   , 0    , G3              , 0   , 0       , -(G3 + G4 + G5  , G5    , G7          , G7    ;...
      0    , 0    , -Kb             , 0   , 0       , Kb + G5         , -G6   , 0           , 0     ;...
      G6  , 0    , 0               , 0   , 0       , 0               , 0     , -(G7 + G6)  , G7     ;...];
  


B = [0; 0; Vs; 0; 0; 0; 0; 0; 0; 0; 0; 0];
x = A\B
V0=x(1) 
V1=x(2)
V2=x(3) 
V3=x(4) 
V4=x(5)
V5=x(6) 
V6=x(7) 
V7=x(8) 
V8=x(9)

I_r1 = (V2 -V1)/(R1);
I_r2 = (V3 -V2)/(R2);
I_r3 = (V5 -V2)/(R3);
I_r4 = (V5 -V0)/(R4);
I_r5 = (V6 -V5)/(R5);
I_r6 = (V4 -V0)/(R6);
I_r7 = (V8 -V7)/(R7);
Ib = I_r5;
Id = (Kd)*(V0-V4)/(R6);

%%    Impressão da Tabela_nos1
fid = fopen ("Tabela_nos1.tex", "w");
fprintf(fid, "$V_{0}$ & - & %e \\\\ \\hline \n", V0);
fprintf(fid, "$V_{1}$ & - & %e \\\\ \\hline \n", V1);
fprintf(fid, "$V_{2}$ & - & %e \\\\ \\hline \n", V2);
fprintf(fid, "$V_{3}$ & - & %e \\\\ \\hline \n", V3);
fprintf(fid, "$V_{4}$ & - & %e \\\\ \\hline \n", V4);
fprintf(fid, "$V_{5}$ & - & %e \\\\ \\hline \n", V5);
fprintf(fid, "$V_{6}$ & - & %e \\\\ \\hline \n", V6);
fprintf(fid, "$V_{7}$ & - & %e \\\\ \\hline \n", V7);
fprintf(fid, "$V_{8}$ & - & %e \\\\ \\hline \n", V8);

fprintf(fid, "$V_{b}$ & - & %e \\\\ \\hline \n", Vb);
fprintf(fid, "$V_{c}$ & - & %e \\\\ \\hline \n", Vc);
fprintf(fid, "$I_{b}$ & %e & - \\\\ \\hline \n", Ib);
fprintf(fid, "$I_{c}$ & %e & - \\\\ \\hline \n", Ic);
fprintf(fid, "$I_{R1}$ & %e & - \\\\ \\hline \n", I_r1);
fprintf(fid, "$I_{R2}$ & %e & - \\\\ \\hline \n", I_r2);
fprintf(fid, "$I_{R3}$ & %e & - \\\\ \\hline \n", I_r3);
fprintf(fid, "$I_{R4}$ & %e & - \\\\ \\hline \n", I_r4);
fprintf(fid, "$I_{R5}$ & %e & - \\\\ \\hline \n", I_r5);
fprintf(fid, "$I_{R6}$ & %e & - \\\\ \\hline \n", I_r6);
fprintf(fid, "$I_{R7}$ & %e & - \\\\ \\hline \n", I_r7);
fclose (fid);




%%Método dos Nós_2

Vs = sym('0');
Vx = sym(V6-V8);

syms V0eq V1eq V2eq V3eq V4eq V5eq V6eq V7eq V8eq Ix

m2_v0 = V0eq == 0;
m2_aux = V6eq - V8eq == Vx; 
m2_s = V1eq-V0eq == Vs;
m2_d = V5eq-V8eq == Kd*(V0eq-V7eq)/R6;
m2_2 = (V1eq-V2eq)/R1 + (V3eq-V2eq)/R2 + (V5eq-V2eq)/R3 == 0; 
m2_3 = (V3eq-V2eq)/R2-Kb*(V2eq-V5eq) == 0;
m2_5 = (V2eq-V5eq)/R3 - (V8eq-V7eq)/R7 - (V5eq-V0eq)/R4-(V5eq-V6eq)/R5 == 0;
m2_6 = (V5eq-V6eq)/R5 - Kb*(V2eq-V5eq) == 0;
m2_7 = (V8eq-V7eq)/R7 - (V7eq-V0eq)/R6 == 0;
Req = (Vx)/(Ix);
tau = Req*1000*(C)*10^(-6);

sn = solve(m2_v0,m2_aux,m2_s,m2_d,m2_2,m2_3,md_5,md_6,md_7);

diary "nodal_tab.tex"
diary on

V0 = double(sn.V0)
V1 = double(sn.V1)
V2 = double(sn.V2)
V3 = double(sn.V3)
V4 = double(sn.V4)
V5 = double(sn.V5)
V6 = double(sn.V6)
V7 = double(sn.V7)
V8 = double(sn.V8)

%%    Impressão da Tabela_nos2
fid = fopen ("Tabela_nos2.tex", "w");
fprintf(fid, "$V_{0}$ & - & %e \\\\ \\hline \n", V0eq);
fprintf(fid, "$V_{1}$ & - & %e \\\\ \\hline \n", V1eq);
fprintf(fid, "$V_{2}$ & - & %e \\\\ \\hline \n", V2eq);
fprintf(fid, "$V_{3}$ & - & %e \\\\ \\hline \n", V3eq);
fprintf(fid, "$V_{4}$ & - & %e \\\\ \\hline \n", V4eq);
fprintf(fid, "$V_{5}$ & - & %e \\\\ \\hline \n", V5eq);
fprintf(fid, "$V_{6}$ & - & %e \\\\ \\hline \n", V6eq);
fprintf(fid, "$V_{7}$ & - & %e \\\\ \\hline \n", V7eq);
fprintf(fid, "$V_{8}$ & - & %e \\\\ \\hline \n", V8eq);

fprintf(fid, "$V_{b}$ & - & %e \\\\ \\hline \n", Vb);
fprintf(fid, "$V_{c}$ & - & %e \\\\ \\hline \n", Vc);
fprintf(fid, "$I_{b}$ & %e & - \\\\ \\hline \n", Ib);
fprintf(fid, "$I_{c}$ & %e & - \\\\ \\hline \n", Ic);
fprintf(fid, "$I_{R1}$ & %e & - \\\\ \\hline \n", I_r1);
fprintf(fid, "$I_{R2}$ & %e & - \\\\ \\hline \n", I_r2);
fprintf(fid, "$I_{R3}$ & %e & - \\\\ \\hline \n", I_r3);
fprintf(fid, "$I_{R4}$ & %e & - \\\\ \\hline \n", I_r4);
fprintf(fid, "$I_{R5}$ & %e & - \\\\ \\hline \n", I_r5);
fprintf(fid, "$I_{R6}$ & %e & - \\\\ \\hline \n", I_r6);
fprintf(fid, "$I_{R7}$ & %e & - \\\\ \\hline \n", I_r7);
fprintf(fid, "$R_{eq}$ & - & %e \\\\ \\hline \n", Req);
fprintf(fid, "$tau$ & - & %e \\\\ \\hline \n", tau);
fclose (fid);




