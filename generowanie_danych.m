n = 2000;
x_1 = zeros(n,1);
x_2 = zeros(n,1);
u = zeros(n,1);
y = zeros(n,1);
alpha_1 = -1.422574;
alpha_2 = 0.466776;
beta_1 = 0.017421;
beta_2 = 0.013521;
for k = 1:50:n
    u(k:k+50-1)= -1 + 2*rand(1,1);
end
for k = 4:n
    x_1(k) = -alpha_1*x_1(k-1)+x_2(k-1)+beta_1*g_1(u(k-3));
    x_2(k) = -alpha_2*x_1(k-1)+beta_2*g_1(u(k-3));
    y(k) = g_2(x_1(k));
end
y_ucz = y;
x_ucz = u;
save('daneucz.mat','y_ucz','x_ucz');
for k = 1:50:n
    u(k:k+50-1)= -1 + 2*rand(1,1);
end
for k = 4:n
    x_1(k) = -alpha_1*x_1(k-1)+x_2(k-1)+beta_1*g_1(u(k-3));
    x_2(k) = -alpha_2*x_1(k-1)+beta_2*g_1(u(k-3));
    y(k) = g_2(x_1(k));
end
y_wer = y;
x_wer = u;
save('danewer.mat','y_wer','x_wer');

