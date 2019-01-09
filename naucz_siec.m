clear variables
close all
load danewer
load daneucz
tau = 3;
nb = 4;
na = 2;
K = 4;
maxEpoch = 200;
err = 0.00001;
algucz = 2; %1 - najszybszy spadek / 2 - BFGS
trybucz = 2;%1 - arx / 2 - oe
ustawienia = fopen('ustawienia.txt','w');
fprintf(ustawienia,'%d %d %d %d %d %f %d %d',tau,nb,na,K,maxEpoch,err,algucz,trybucz);
fclose(ustawienia);
S = max(na,nb) + 1;
system('sieci.exe');
model

figure
y_mod = siec(x_wer,y_wer,w10,w20,w1,w2);
subplot(2,1,2)
hold on
plot(y_wer)
plot(y_mod)
Ewer = (y_wer(S:end)-y_mod(S:end))'*(y_wer(S:end)-y_mod(S:end))
y_mod = siec(x_ucz,y_ucz,w10,w20,w1,w2);
subplot(2,1,1)
hold on
plot(y_ucz)
plot(y_mod)
Eucz = (y_ucz(S:end)-y_mod(S:end))'*(y_ucz(S:end)-y_mod(S:end))

uczenie