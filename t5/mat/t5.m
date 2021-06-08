%frequency response

R1=1/(1/1000+1/1000);
R2=1/(1/10000+1/10000+1/10000);
R3=100000;
R4=1000;
C1= 220e-9;
C2= 220e-9;

f = logspace(1, 8, 70);
s = i*2*pi*f;
Ts = (R1*C1*s)./(1+R1*C1*s).*(1+R3/R4).*(1./(1+R2*C2*s));

figure;
semilogx(f, 20*log(abs(Ts)), 'g');
xlabel ("f (Hz)");
ylabel ("Frequency Response dB");
title ("Frequency Response")
print ("fresponse1.eps");

figure;
semilogx(f,180*arg(Ts)/pi, 'g');
xlabel("f [Hz]");
ylabel("Phase [Degrees]");
title("Phase frequency response");
print("fresponse2.eps");




%central frequency
fLow = 1/(R1*C1*2*pi);
fHigh = 1/(R2*C2*2*pi);

fr = sqrt(fLow*fHigh)

%gain for fr
s = i*2*pi*fr;
Tsr = ((R1*C1*s)/(1+R1*C1*s))*(1+R3/R4)*(1/(1+R2*C2*s));
gain = 20*log(abs(Tsr))

%Impedance for fr
ZC1 = 1/(i*2*pi*fr*C1);
ZR1 = R1;
ZC2 = 1/(i*2*pi*fr*C2);
ZR2 = R2;
ZI = ZC1+ZR1
ZO = (ZC2*ZR2)/(ZC2+ZR2) 



%Table data

fid = fopen ("docImp.tex", "w");
fprintf(fid, "Central Frequency & %e \\\\ \\hline \n", fr);
fprintf(fid, "Voltage Gain dB & %e \\\\ \\hline \n", gain);
fprintf(fid, "Input Impedance & %e \\\\ \\hline \n", ZI);
fprintf(fid, "Output Impedance & %e \\\\ \n", ZO);
fclose (fid);

fid = fopen ("docImp2.tex", "w");
fprintf(fid, "Central Frequency & %e \\\\ \\hline \n", fr);
fprintf(fid, "Voltage Gain dB & %e \\\\ \n", gain);
fclose (fid);

fid = fopen ("docImp3.tex", "w");
fprintf(fid, "Input Impedance & %e \\\\ \\hline \n", ZI);
fprintf(fid, "Output Impedance & %e \\\\ \n", ZO);
fclose (fid);
