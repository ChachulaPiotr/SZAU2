clear variables
load danewer
load daneucz
osiagi = fopen('osiagi.txt','w');
fprintf(osiagi,"Liczba Neuronow\tBlad Uczenia\tBladWeryfikacji\n");
tau = 3;
nb = 4;
na = 2;
S = max(na,nb) + 1;
maxEpoch = 400;
err = 0.00001;
algucz = 2; %1 - najszybszy spadek / 2 - BFGS
trybucz = 2;%1 - arx / 2 - oe
bestEucz = ones(10,1)*10000000;
bestEwer = ones(10,1)*10000000;
for i = 1:10
    for j = 1:5
        ustawienia = fopen('ustawienia.txt','w');
        fprintf(ustawienia,'%d %d %d %d %d %f %d %d',tau,nb,na,i,maxEpoch,err,algucz,trybucz);
        fclose(ustawienia);
        system('sieci.exe');
        pause(5);
        model
        y_mod = siec(x_wer,y_wer,w10,w20,w1,w2);
        Ewer = (y_wer(S:end)-y_mod(S:end))'*(y_wer(S:end)-y_mod(S:end))
        y_mod = siec(x_ucz,y_ucz,w10,w20,w1,w2);
        Eucz = (y_ucz(S:end)-y_mod(S:end))'*(y_ucz(S:end)-y_mod(S:end))
        if (Ewer < bestEwer(i))
            bestEwer(i)=Ewer;
            bestEucz(i)=Eucz;
            save(sprintf('bestM%d',i), 'w1', 'w10', 'w2', 'w20', 'Ewer', 'Eucz')
        end
    end
    fprintf(osiagi,"%d\t\t\t\t%d\t%d\n",i,bestEucz(i),bestEwer(i));
end
fclose(osiagi);