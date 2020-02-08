function R = nttest(S,ME,dim)
    % La funzione esegue il test di Student.
    fprintf('Start Student''s test.');
    M = zeros(dim,dim);
    for i = 1:dim
        for t = 1:dim
            r = ttest2(S(:,i),S(:,t));
            if(r == 1)
                if(ME(i) < ME(t))
                    M(t,i) = 1;
                end
            end
        end
        fprintf('.');
    end
    disp('End Student''s test.');
    R = M;
end