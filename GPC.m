function [] = GPC(yzad)
    global u y N Nu D tau k lambda;
    y0 = zeros(N,1);
    yz = ones(N,1)*yzad;
    ys = zeros(D,1);
    us = zeros(D,1);
    M = zeros(N,Nu);
    a = zeros(2,1);
    b = zeros(2,1);
    delta = 1e-5;
    a(1) = (snout([u(k-tau-1)+delta u(k-tau-2) y(k-1) y(k-2)])-snout([u(k-tau-1) u(k-tau-2) y(k-1) y(k-2)]))/delta;
    a(2) = (snout([u(k-tau-1) u(k-tau-2)+delta y(k-1) y(k-2)])-snout([u(k-tau-1) u(k-tau-2) y(k-1) y(k-2)]))/delta;
    b(1) = (snout([u(k-tau-1) u(k-tau-2) y(k-1)+delta y(k-2)])-snout([u(k-tau-1) u(k-tau-2) y(k-1) y(k-2)]))/delta;
    b(2) = (snout([u(k-tau-1) u(k-tau-2) y(k-1) y(k-2)+delta])-snout([u(k-tau-1) u(k-tau-2) y(k-1) y(k-2)]))/delta;
    dk = y(k)-a*[u(k-tau-1);u(k-tau-2)] + b*[y(k-1);y(k-2)];
    y0(1) = a*[u(k-tau);u(k-tau-1)] + b*[y(k);y(k-1)]+dk;
    y0(2) = a*[u(k-tau+1);u(k-tau)] +  b*[y0(1);y(k)]+dk;
    y0(3) = a*[u(k-tau+2);u(k-tau+1)] + b*[y0(2);y0(1)]+dk;
    for i = 4:tau
        y0(i) = a*[u(k-tau+i-1);u(k-tau+i-2)] + b*[y0(i-1);y0(i-2)]+dk;
    end
    y0(tau+1) = a*[u(k-1);u(k-2)] + b*[y0(tau) y0(tau-1)]+dk;
    for i = tau+2:N
        y0(i) = a*[u(k-1);u(k-1)] + b*[y0(i-1);y0(i-2)]+dk;
    end
    for i = 1:D
        ys = circshift(ys,-1);
        us = circshift(us,-1);
        us(D) = 1;
        ys(D)=a*[us(D-tau);us(D-tau-1)]+b*[ys(D-1);ys(D-2)];
    end
    for i = 1 : N
        for j = 1 : Nu
            if (i-j+1)>0
                M(i,j)=ys(i-j+1);
            end
        end
    end
    du = (M'*M + lambda * eye(Nu))^(-1)*M'*(yz - y0);
    u(k)=u(k-1)+du(1);
end