function fcelu = funregno(x)
    global N Nu lambda w1 w10 w2 w20 yz y u du ddmc k;
    
    l=1;
    for p = 0:Nu-1
        u(k+p) = x(l);
        l=l+1;
    end
    for p = p+1:N
        u(k+p) = u(k+Nu-1);
    end
    for p = 0:Nu-1
        du(k+p) = u(k+p) - u(k-p);
    end
    
    fcelu = 0;
    for p = 1:N
        wesn = [u(k-3+p) u(k-4+p) y(k-1+p) y(k-2+p)]';
        y(k+p) = w20 + w2*tanh(w10+w1*wesn) + ddmc;
    end
    
    for p=1:N
        fcelu = fcelu + (yz(k)-y(k+p))^2;
    end
    for p = 1:Nu
        fcelu = fcelu + lambda*du(k+p);
    end
    
end