function [r1,r2,r3] = newnet(input,target,hidden)
    % La funzione addestra una rete neurale
    % rng('default');
    
    % Creazione vettore errori (20, uno per ogni addestramento)
    errors = zeros(20,1);
    net = buildnet(hidden,size(target,1));
    % net = configure(net,input',target');
    i = 1;
    
    % Si attiva la KFoldCrossValidation per due volte di seguito
    for rip = 1:2
        % Si modificano la matrice per bene
        [input,target] = mixup(input,target);
        
        for b = 1:10
            [net tr] = train(net,input',target');
            errors(i) = mean(tr.tperf); % Oppure tr.best_tperf
            
            % Si scombussalano le matrici per il prossimo training
            [input,target] = shift(input,target);
            i = i + 1;
        end
    end

    r1 = errors;
    r2 = net;
    r3 = tr;
    
end

function [r1,r2] = shift(input,target)
     samples = size(target,1);
     dec = samples * 0.1;
     r1 = circshift(input,dec,1);
     r2 = circshift(target,dec,1);
end

function [r1,r2] = mixup(input,target)
    set = input;
    set(:,(end+1):(end+2)) = target;
    samples = size(target,1);
    
    perm = randperm(samples);
    set = set(perm,:);
    r1 = set(:,1:end-2);
    r2 = set(:,(end-1):end);
end