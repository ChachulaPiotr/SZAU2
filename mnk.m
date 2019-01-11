load('daneucz')
load('danewer')

M = [x_ucz(2:1997) x_ucz(1:1996) y_ucz(4:1999) y_ucz(3:1998)];
w = M\y_ucz(5:end);

n = length(y_wer);
y_mod_wer = y_wer;
y_mod_ucz = y_ucz;
for k = 5:n
    y_mod_ucz(k) = [x_ucz(k-3) x_ucz(k-4) y_mod_ucz(k-1) y_mod_ucz(k-2)]*w;
    y_mod_wer(k) = [x_wer(k-3) x_wer(k-4) y_mod_wer(k-1) y_mod_wer(k-2)]*w;
end

nb = 4;
na = 2;
S = max(na,nb) + 1;

figure
subplot(2,1,2)
hold on
plot(y_wer)
plot(y_mod_wer)
title('Dane weryfikuj¹ce')
legend('dane', 'model')
xlabel('krok')
ylabel('y(k)')
Ewer = (y_wer(S:end)-y_mod_wer(S:end))'*(y_wer(S:end)-y_mod_wer(S:end))

subplot(2,1,1)
hold on
plot(y_ucz)
plot(y_mod_ucz)
title('Dane ucz¹ce')
legend('dane', 'model')
xlabel('krok')
ylabel('y(k)')
Eucz = (y_ucz(S:end)-y_mod_ucz(S:end))'*(y_ucz(S:end)-y_mod_ucz(S:end))