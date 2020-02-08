function r = syncset(struct)

    zaino = struct.("zaino");
    polso = struct.("polso");
	
    % Search for min and max timestamp
    min_ts = max(min(zaino(:,1)),min(polso(:,1)));
    max_ts = min(max(zaino(:,1)),max(polso(:,1)));

    indexes_z = zaino(:,1) > min_ts & zaino(:,1) < max_ts;
    zaino = zaino(indexes_z,:);

    indexes_p = polso(:,1) > min_ts & polso(:,1) < max_ts;
    polso = polso(indexes_p,:);
    
    % Fix length matrixs
    zaino = resize(zaino,polso);
    polso = resize(polso,zaino);
    
    % Shift timestamp in origin
%     min_ts = min(zaino(:,1));
%     zaino(:,1) = (zaino(:,1) - min_ts);
% 
%     min_ts = min(polso(:,1));
%     polso(:,1) = (polso(:,1) - min_ts);
    
    struct.("zaino") = denoise(zaino);
    struct.("polso") = denoise(polso);
    r = signals(struct);

end

function r = resize(v1, v2)
    len1 = length(v1);
    len2 = length(v2);
    if len1 < len2
        for i = 1:(len2-len1)
            v1(end+1,:) = v1(end,:);
        end
    end
    r = v1;
end

function r = denoise(mat)
    len = size(mat,2);
    for i = 2:len
        mat(:,i) = smooth(mat(:,i));
    end
    r = mat;
end