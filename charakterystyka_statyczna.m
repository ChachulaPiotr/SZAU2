u = [-1:0.01:1];
[~,n] = size(u);
y=zeros(n,1);
alpha_1 = -1.422574;
alpha_2 = 0.466776;
beta_1 = 0.017421;
beta_2 = 0.013521;
for i=1:n
    y(i)=g_2(((beta_1+beta_2)*g_1(u(i)))/(1+alpha_1+alpha_2));
end
figure
plot(u,y)
title('Charakterystyka statyczna y(u)')
xlabel('Sterowanie u')
ylabel('Wyjœcie y')