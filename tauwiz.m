n = 10;
u = zeros(n,1);
u(5:n) = 1;
x_1 = zeros(n,1);
x_2 = zeros(n,1);
y = zeros(n,1);
for k = 5:n
    x_1(k) = -alpha_1*x_1(k-1)+x_2(k-1)+beta_1*g_1(u(k-3));
    x_2(k) = -alpha_2*x_1(k-1)+beta_2*g_1(u(k-3));
    y(k) = g_2(x_1(k));
end
figure
plot(y,'o');
hold on;
stairs(u);
axis([0 10 0 0.1]);
legend ('wyjscie','sterowanie');
xlabel ('k')