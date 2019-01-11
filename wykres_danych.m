load('daneucz')
load('danewer')

figure
subplot(2,1,1)
plot(x_ucz)
xlabel('k')
ylabel('u(k)')
subplot(2,1,2)
plot(y_ucz)
xlabel('k')
ylabel('y(k)')


figure
subplot(2,1,1)
plot(x_wer)
xlabel('k')
ylabel('u(k)')
subplot(2,1,2)
plot(y_wer)
xlabel('k')
ylabel('y(k)')