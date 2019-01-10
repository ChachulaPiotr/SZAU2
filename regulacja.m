clear variables
close all
global N Nu lambda w1 w10 w2 w20 yz y u du ddmc k K b a;
tau = 3;
nb = 4;
na = 2;
S = max(na,nb) + 1;
model;

reg = 1; % 0 - NPL, 1 - GPC, 2 - PID, 3 - NO

% predykcja
N = 10;
Nu = 2;
lambda = 1;

% PID
if reg == 2
    Kp = 1;
    Ti = 10;
    Td = 0.1;
    T = 1;
    r0 = Kp*(1+T/2/Ti+Td/T);
    r1 = Kp*(T/2/Ti - 2*Td/T - 1);
    r2 = Kp*Td/T;
end

% GPC
if reg == 1
    load('daneucz');
    M = [x_ucz(2:1997) x_ucz(1:1996) y_ucz(4:1999) y_ucz(3:1998)];
    w = M\y_ucz(5:end);
    s = zeros(N,1);
    b = zeros(N,1);
    b(3:4) = w(1:2);
    a = zeros(N,1);
    a(1:2) = -w(3:4);
    for j=1:N
        s(j) = 0;
        for i = 1:min(j,nb)
            s(j) = s(j) + b(i);
        end
        for i = 1:min(j-1,na)
            s(j) = s(j) - a(i)*s(j-i);
        end
    end
    
    M = zeros(N,Nu);
    for i = 1 : N
        for j = 1 : Nu
            if (i-j+1)>0
                M(i,j)=s(i-j+1);
            end
        end
    end
    
    K = (M'*M + lambda*ones(Nu,Nu))^-1*M';
end

% NPL
if reg == 0
    delta = 1e-5;
end

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
ym = zeros(n,1);
yz = zeros(n,1);
z = [0.5 -1.5 0.25 -0.75 0];
for i=1:length(z)
    yz((i-1)*100+10:end,1)=z(i);
end
e = zeros(n,1);

for k=n0:n
    k
    x1(k) = -alpha_1*x1(k-1)+x2(k-1)+beta_1*g_1(u(k-3));
    x2(k) = -alpha_2*x1(k-1)+beta_2*g_1(u(k-3));
    y(k)= g_2(x1(k));
    
    if reg==0
        %NPL
    elseif reg==1
        %GPC
        ym(k) = b(3)*u(k-3)+b(4)*u(k-4)-a(1)*y(k-1)-a(2)*y(k-2);
        ddmc = y(k)-ym(k);
        funreggpc();
        u(k) = u(k-1) + du(k);
        u(k) = min(max(u(k),umin), umax);
    elseif reg==2
        %PID
        e(k) = yz(k)-y(k);
        u(k) = r0*e(k) + r1*e(k-1) + r2*e(k-2) + u(k-1);
        u(k) = min(max(u(k),umin), umax);
    elseif reg==3
        %NO
        wesn = [u(k-3) u(k-4) y(k-1) y(k-2)]';
        ym(k) = w20 + w2*tanh(w10+w1*wesn);
        ddmc = y(k)-ym(k);
        uopt0 = u(k-1)*ones(1,Nu);
        opcje = optimset('Algorithm', 'sqp', 'TolFun', 1e-10, 'TolX', 1e-10, 'Display', 'none');%
        uopt = fmincon(@funregno, uopt0,[],[],[],[],umin*ones(1,Nu),umax*ones(1,Nu),[],opcje);
        u(k) = uopt(1);
    end
    
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
