function r = featureselection(input,target)
    %% Save diary
    files = dir('./results/*.log');
    final = length(files)+1;
    savefile = ['./results/sfs' num2str(final) '.log'];
    diary(savefile);
    diary on;
    
    %% Body sfs
    hidden = zeros(size(input,1),size(input,2));
    hidden(1,1) = 10;
    %mdek_features = [1:40 181:220];                                        % Pos X, Pos Y, Pos Z, ???
    %shimmer_features = [41:70 71:100 101:130 221:250 251:280 281:310];     % ACC LN X/Y/Z, ACC WR X/Y/Z, GYRO X/Y/Z
    %cancel_column = horzcat(mdek_features, shimmer_features);
    %cancel_column = [1:130 141:150 201:330 341:350];                       % Rimosso 171:180/371:380
    %cancel_column = [1:30 41:130 201:230 241:330];                     % MDEK+SHIMMER
    %cancel_column = [1:130 141:150 201:330 341:350];                   % SHIMMER
    cancel_column = [1:30 41:140 151:200 201:230 241:340 351:400];     % MDEK
    opts = statset('display','iter');
    [r,history] = sequentialfs(@criterion,input,target,hidden,'cv','none',...
                                    'KeepOut',cancel_column,'direction','forward','options',opts);
                         
    labelfeatures(find(r == 1));
    disp('Features selection completed.');
    
    %% Store diary
    diary off;
    savefile = ['./results/sfs' num2str(final) '.mat']; id = r;
    save(savefile, 'id');
end