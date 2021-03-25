pkg load symbolic

syms R1;
syms R2;
syms R3;
syms R4;
syms R5;
syms R6;
syms R7;

syms G1;
syms G2;
syms G3;
syms G4;
syms G5;
syms G6;
syms G7;

syms Kb;
syms Kc;

syms Va;
syms Vb;
syms Vc;
syms Ib;
syms Ic;
syms Id;

syms V0;
syms V1;
syms V2;
syms V3;
syms V4;
syms V5;
syms V6;
syms V7;

%%Método dos Nós

printf("\n\nKCL:\n");

V5*G1 - V4*(G1 + G2) + V3*G2 - Vb*G3 == 0
-V3*G2 + V4*G2 + Ib == 0
V2*G5 + V0*G5 + Id == Ib
V6*G6 - V7*(G6 - G7) - V1*G7 == 0 %% <=> G6(V6-V7) - Ic = 0


printf("\n\nPor observação do circuito:\n");
V5 - V6 == Va
Vc == V0 - V1
Vc == Kc*Ic
Vb == V4 - V0
V0 = 0
Ic == V6*G6 - V7*G6

printf("\n\nExtras\n:");
Ib == Kb*Vb
V5*G1 - V4*G1 + Ic + V0*G4 - V6*G4 == 0

%%  Atribuição de Valores

R1 = 1.01658203395*1000;
R2 = 2.08071598482*1000;
R3 = 3.12527703197*1000;
R4 = 4.13615246449*1000;
R5 = 3.04804224053*1000;
R6 = 2.06609096892*1000;
R7 = 1.01589064139*1000;
Va = 5.08211987776;
Id = 1.02439571082/1000;
Kb = 7.30340439475/1000;
Kc = 8.13276803722*1000;

G1 = 1/R1;
G2 = 1/R2;
G3 = 1/R3;
G4 = 1/R4;
G5 = 1/R5;
G6 = 1/R6;
G7 = 1/R7;
   

A = [ G5   , 0    , -G5  , 0   , 0       , 0     , 0     , 0     , 0     , 0  , -1, 0   ;...
      0    , 0    , 0    , -G2 , G2      , 0     , 0     , 0     , 0     , 0  , 1 , 0   ;...
      0    , 0    , 0    , G2  , -G2-G1  , G1    , 0     , 0     , -G3   , 0  , 0 , 0   ;...
      0    , 0    , 0    , 0   , 0       , 0     , G6    , -G6   , 0     , 0  , 0 , -1  ;...
      0    , 0    , 0    , 0   , 0       , 1     , -1    , 0     , 0     , 0  , 0 , 0   ;...
      1    , -1   , 0    , 0   , 0       , 0     , 0     , 0     , 0     , -1 , 0 , 0   ;...
      0    , 0    , 0    , 0   , 0       , 0     , 0     , 0     , 0     , 1  , 0 , -Kc ;...
      -1   , 0    , 0    , 0   , 1       , 0     , 0     , 0     , -1    , 0  , 0 , 0   ;...
      1    , 0    , 0    , 0   , 0       , 0     , 0     , 0     , 0     , 0  , 0 , 0   ;...
      0    , G7   , 0    , 0   , 0       , 0     , 0     , -G7   , 0     , 0  , 0 , 1   ;...
      0    , 0    , 0    , 0   , 0       , 0     , 0     , 0     , -Kb   , 0  , 1 , 0   ;... 
      G4   , 0    , 0    , 0   , G1      ,-G1    , -G4   , 0     , 0     , 0  , 0 , -1  ];


B = [-Id; 0; 0; 0; Va; 0; 0; 0; 0; 0; 0; 0];

x = A\B
V0=x(1) 
V1=x(2)
V2=x(3) 
V3=x(4) 
V4=x(5)
V5=x(6) 
V6=x(7) 
V7=x(8) 
Vb=x(9)
Vc=x(10)
Ib=x(11)
Ic=x(12)


%%    Impressão da Tabela
fid = fopen ("Tabela_nos.tex", "w");
fprintf(fid, "$V_{0}$ & - & %e \\\\ \\hline \n", V0);
fprintf(fid, "$V_{1}$ & - & %e \\\\ \\hline \n", V1);
fprintf(fid, "$V_{2}$ & - & %e \\\\ \\hline \n", V2);
fprintf(fid, "$V_{3}$ & - & %e \\\\ \\hline \n", V3);
fprintf(fid, "$V_{4}$ & - & %e \\\\ \\hline \n", V4);
fprintf(fid, "$V_{5}$ & - & %e \\\\ \\hline \n", V5);
fprintf(fid, "$V_{6}$ & - & %e \\\\ \\hline \n", V6);
fprintf(fid, "$V_{7}$ & - & %e \\\\ \\hline \n", V7);

fprintf(fid, "$V_{b}$ & - & %e \\\\ \\hline \n", Vb);
fprintf(fid, "$V_{c}$ & - & %e \\\\ \\hline \n", Vc);
fprintf(fid, "$I_{b}$ & %e & - \\\\ \\hline \n", Ib);
fprintf(fid, "$I_{c}$ & %e & - \\\\ \\hline \n", Ic);
fclose (fid);