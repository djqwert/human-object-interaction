function [] = wclassification(ann,d,sf,ef,t,id,indexes)

    % Find wrong classification
    y = ann(sf');
    s = ef(indexes,[1:5 find(id==1)]);
    s = horzcat(s,t);
    s = horzcat(s,y');
    len = size(s,2);
    
    ind = find((s(:,len - 3) == 1 & s(:,len - 1) < 0.5) | (s(:,len - 2) == 1 & s(:,len) < 0.5));
    s(ind,len+1) = 1;
    ind = find(s(:,len+1) == 1);
    s = s(ind,:);
    s = s(:,[1:5 (len-3) (len-2)]);
    
    % Associa soggetto alla finestra
    ind = find(s(:,2) >= 21 & s(:,2) <= 40);
    s(ind,1) = 2;
    ind = find(s(:,2) >= 41 & s(:,2) <= 60);
    s(ind,1) = 3;
    ind = find(s(:,2) >= 61 & s(:,2) <= 80);
    s(ind,1) = 4;
    s(:,2) = rem(s(:,2),20);
    ind = find(s(:,2) == 0);
    s(ind,2) = 20;

    plotwindows(d,s);

end