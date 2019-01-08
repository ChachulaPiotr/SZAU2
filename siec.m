function [y] = siec(x_wer,y_wer,w10,w20,w1,w2)
    n = length(y_wer);
    y = y_wer;
    for k = 5:n
        x = [x_wer(k-3);x_wer(k-4);y(k-1);y(k-2)];
        y(k) = w2*tanh(w1*x+w10)+w20;
    end
end