function [J] = fcelu(x)
    global u y N Nu D tau k lambda yzad;
    ye = zeros(N,1);
    yz = ones(N,1)*yzad;
    M = zeros(N,Nu);
    dk = y(k)- snout([u(k-tau) u(k-tau-1) y(k-1) y(k-2)]);
    ye(1) = snout([u(k-tau+1) u(k-tau) y(k) y(k-1)]);
    ye(2) = snout([u(k-tau+2) u(k-tau+1) ye(1) y(k)]);
    ye(3) = snout([u(k-tau+3) u(k-tau+2) ye(1) y(k)]);
end