function [] = funreggpc()
global N Nu yz y u du ddmc k K b a;
    
    for p = 1:N
        y(k+p) = b(3)*u(min(k-3+p,k-1)) + b(4)*u(min(k-4+p,k-1)) - a(1)*y(k-1+p) - a(2)*y(k-2+p) + ddmc;
    end

    du(k:k+Nu-1) = K*(yz(k)*ones(N,1)-y(k+1:k+N));
    
end