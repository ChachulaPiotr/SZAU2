function fcelu = funregno(x)
    global N Nu lambda w1 w10 w2 w20 yz y u du ddmc k;
    
    for p = 0:Nu-1
        u(k+p) = x(p+1);
    end
    for p = Nu:N
        u(k+p) = u(k+Nu-1);
    end
    for p = 0:Nu-1
        du(k+p) = u(k+p) - u(k+p-1);
    end
    
    fcelu = 0;
    for p = 1:N
        wesn = [u(k-3+p) u(k-4+p) y(k-1+p) y(k-2+p)]';
        y(k+p) = w20 + w2*tanh(w10+w1*wesn) + ddmc;
    end
    
    for p=1:N
        fcelu = fcelu + (yz(k)-y(k+p))^2;
    end
    for p = 0:Nu-1
        fcelu = fcelu + lambda*du(k+p)^2;
    end
    
end