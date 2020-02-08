function r = features(mat,n,p)

    for i = 1:p
        col = 1+(i-1)*n;
        r(1,col) = min(mat(:,i)); 
        r(1,col+1) = max(mat(:,i));
        r(1,col+2) = mean(mat(:,i));
        r(1,col+3) = median(mat(:,i));
        %r(1,col+4) = skewness(mat(:,i));
        %r(1,col+5) = kurtosis(mat(:,i));
        r(1,col+4) = mean_trend(mat(:,i));
        r(1,col+5) = energy(mat(:,i));
        r(1,col+6) = meanabs(mat(:,i));
        r(1,col+7) = iqr(mat(:,i));
        r(1,col+8) = var(mat(:,i));
        r(1,col+9) = std(mat(:,i));
        
    end

end

function mt = mean_trend(signal)
    %Calcola il mean trend
        for i=2:length(signal)
            tmp(i-1) = abs(signal(i) - signal(i-1));
        end
        mt = mean(tmp);
end
function e = energy(signal)
    %Calcola l'energia del segnale
        F = fft(signal);
        pow = F.*conj(F);
        e = sum(pow);
end
