function [] = saveann(ann,tr,sf,t)
    
    % Perform error
    y = ann(sf');
    s = t;
    s = horzcat(s,y');
    [len_x, len_y] = size(s);
    ind = (s(:,len_y - 3) == 1 & s(:,len_y - 1) < 0.5) | (s(:,len_y - 2) == 1 & s(:,len_y) < 0.5);
    s(ind,len_y+1) = 1;
    err = sum(s(:,len_y+1)/len_x);
    
    % Save results
    succ = round(100 - 100*err,1);
    features = size(sf,2);
    files = dir('./results/ann*.mat');
    final = length(files)+1;
    savefile = ['./results/ann' num2str(final) '-F' num2str(features) '-H' num2str(ann.layers{1}.size) '-R' num2str(succ) '.mat'];
    save(savefile, 'ann', 'tr', 'sf', 't');

end