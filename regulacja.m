clear variables
close all
global N Nu lambda w1 w10 w2 w20 yz y u du ddmc k;
tau = 3;
nb = 4;
na = 2;
S = max(na,nb) + 1;
model;

reg = 3; % 0 - NPL, 1 - GPC, 2 - PID, 3 - NO
N = 10;
Nu = 2;
lambda = 0.1;

n = 510;
n0 = 10;
u = zeros(n+N,1);
du = zeros(n+N,1);

alpha_1 = -1.422574;
alpha_2 = 0.466776;
beta_1 = 0.017421;
beta_2 = 0.013521;
umin = -1;
umax = 1;
x1 = zeros(n,1);
x2 = zeros(n,1);

y = zeros(n+N,1);
yz = zeros(n,1);
z = [0.5 -1.5 0.25 -0.75 0];
for i=1:length(z)
    yz((i-1)*100+10:end,1)=z(i);
end

for k=n0:n
    k
    x1(k) = -alpha_1*x1(k-1)+x2(k-1)+beta_1*g_1(u(k-3));
    x2(k) = -alpha_2*x1(k-1)+beta_2*g_1(u(k-3));
    y(k)= g_2(x1(k));
    
    if reg==0
        %NPL
    elseif reg==1
        %GPC
    elseif reg==2
        %PID
    elseif reg==3
        %NO
        wesn = [u(k-3) u(k-4) y(k-1) y(k-2)]';
        ym = w20 + w2*tanh(w10+w1*wesn);
        ddmc = y(k)-ym;
        uopt0 = u(k-1)*ones(1,Nu);
        opcje = optimset('Algorithm', 'sqp', 'TolFun', 1e-10, 'TolX', 1e-10, 'Display', 'none');%
        uopt = fmincon(@funregno, uopt0,[],[],[],[],[],[],[],opcje);
        u(k) = uopt(1);
    end
    
    u(k) = min(max(u(k),umin), umax);
    
end

figure
subplot(4,1,1)
plot(u(1:n))
subplot(4,1,2)
plot(x1)
subplot(4,1,3)
plot(x2)
subplot(4,1,4)
plot(y(1:n))
hold on
plot(yz)


