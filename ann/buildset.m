function [r1,r2] = buildset(input,target)
    % La funzione genera il dataset da dare in ingresso alla rete.
    set = input;
    set(:,(end+1):(end+2)) = target;
    
    % Padding set
    samples = size(target,1);
    rest = rem(samples,10);
    if rest ~= 0
        diff = 10 - rest;
        indexes = randi(samples,[diff,1]);
        set((end+1):(end+diff),:) = set(indexes,:);
        samples = length(set(:,1));
    end

    % Mixture
    perm = randperm(samples);
    set = set(perm,:);
    
    r1 = set(:,1:end-2);
    r2 = set(:,(end-1):end);
    
end