function [r1, r2] = training(input,target,hidden,attempts)
    
    disp('Searching for optimal neural network');
    sf = input; t = target;
    [input,target] = buildset(input,target);
    e = 1;
    
    for i = 1:attempts
        [error,net,tr] = newnet(input,target,hidden);
        error = mean(error);
        disp(['Mean error n.',num2str(i),': ',num2str(error)]);
        if  error < e
            r1 = net;
            r2 = tr;
            e = error;
        end    
    end
    
    saveann(r1,r2,sf,t);
    disp(['Best mean error: ',num2str(e)]);
    
end