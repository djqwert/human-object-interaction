function r = searching(input,target,minNeurons,maxNeurons)
    
    % Pre-allocazione matrice degli errori                                
    errors = zeros(20,maxNeurons);
    
    % Prepara la matrice alla KFoldCV
    [input,target] = buildset(input,target);
    
    disp('New network search');
    for h = minNeurons:maxNeurons
        disp(['Test network n.',num2str(h-minNeurons+1)]);
        errors(:,h) = newnet(input,target,h);
    end
    disp('End network search');
    
    % Find best neurons number
    errors = errors(:,minNeurons:maxNeurons);
    success = 1 - errors;
    ttmat = nttest(success,mean(errors),maxNeurons-minNeurons+1);
    ttmat = sum(ttmat);
    
    [val,y] = max(ttmat);
    r = y+minNeurons-1;
    if val == 0
        r = minNeurons;
        %error('Student''s test is negative.');
    end
    
    disp(['Optimal neurons number to train neural network: ',num2str(r)]);
    
end