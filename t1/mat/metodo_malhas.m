  
close all
clear all

%%EXAMPLE SYMBOLIC COMPUTATIONS

pkg load symbolic

syms R1
syms R2
syms R3
syms R4
syms R5
syms R6
syms R7

syms Kb
syms Kc

syms Va
syms Vb
syms Vc

syms Ib
syms Ic
syms Id

%%  Método das Malhas

syms Iec
syms Ieb
syms Idb
syms Idc

printf("\n\nKVL equations:\n");

-Va+Iec*R1+Vb+R4*(Iec-Ieb) == 0
Idc = -Ib
Idb = -Id
Vc+R7*Ieb+R6*Ieb+(Ieb-Iec)*R4 == 0

printf("\n\nAnalysing the circuit data:\n");

Vc = Kc*Ic
Ib = Kb*Vb
Ic = -Ieb
Vb = R3*(Iec-Idc)

%%EXAMPLE NUMERIC COMPUTATIONS

printf("\n");

R1 = 1.01658203395e3
R2 = 2.08071598482e3
R3 = 3.12527703197e3
R4 = 4.13615246449e3
R5 = 3.04804224053e3
R6 = 2.06609096892e3
R7 = 1.01589064139e3

Va = 5.08211987776

Id = 1.02439571082e-3

Kb = 7.30340439475e-3
Kc = 8.13276803722e3



A = [ R1+R4 , 0 , 0, -R4      , 1   , 0, 0, 0   ;...
      0     , 1 , 0, 0        , 0   , 0, 1, 0   ;...
      0     , 0 , 1, 0        , 0   , 0, 0, 0   ;...
      -R4   , 0 , 0, R4+R6+R7 , 0   , 1, 0, 0   ;...
      0     , 0 , 0, 0        , 0   , 1, 0, -Kc ;...
      0     , 0 , 0, 0        , -Kb , 0, 1, 0   ;...
      0     , 0 , 0, 1        , 0   , 0, 0, 1   ;...
      -R3   , R3, 0, 0        , 1   , 0, 0, 0   ]

B = [ Va; 0; -Id; 0; 0; 0; 0; 0]

x = A\B;

Iec = x(1)
Idc = x(2)
Idb = x(3)
Ieb  = x(4)
Vb    = x(5)
Vc    = x(6)
Ib    = x(7)
Ic    = x(8)

%	Impressão da Tabela
fid = fopen ("Malhas_tab.tex", "w");
fprintf(fid, "@$I_{\\EC}$ & %e \\\\ \\hline \n", Iec);
fprintf(fid, "@$I_{\\DC}$ & %e \\\\ \\hline \n",  Idc);
fprintf(fid, "@$I_{\\DB}$ & %e \\\\ \\hline \n", Idb);
fprintf(fid, "@$I_{\\EB}$ & %e \\\\ \\hline \n", Ieb);

fprintf(fid, "$V_{b}$ & %e \\\\ \\hline \n", Vb);
fprintf(fid, "$V_{c}$ & %e \\\\ \\hline \n", Vc);
fprintf(fid, "@$I_{b}$ & %e \\\\ \\hline \n", Ib);
fprintf(fid, "@$I_{c}$ & %e \\\\ \\hline \n", Ic);
fclose (fid);