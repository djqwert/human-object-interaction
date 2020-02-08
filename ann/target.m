function r = target(mat)
    % Selezione dei target con timestamp
    mat = buildmat(mat);
    r = evaluate(mat);
end

function r = buildmat(mat)
    % Build matrix to find targets
    v = import_video_label_csv("data/video_interactions.csv");
    for i = 21:80
        v(i-20) = i;
    end
    endm = size(mat,2)+1;
    for i = 1:60
       indexes = find(mat(:,2) == v(i,1));
       for j = 1:length(indexes)
            mat(indexes(j),endm) = v(i,4);      % ts inizio interazione
            mat(indexes(j),endm+1) = v(i,5);    % ts fine interazione
       end
    end
    r = mat;
end

function r = evaluate(mat)
    
    global CONST;
    ts_start_interaction = mat(:,end-1);
    ts_end_interaction = mat(:,end);
    ts_start_window = mat(:,4);
    ts_end_window = mat(:,5); 
    q = (ts_end_window(1) - ts_start_window(1))/CONST.window;
    
    len = length(ts_start_interaction);
    r_vett = zeros(len,1);
    for i = 1:len
        for j = 1:CONST.window
            r_vett(i) = r_vett(i) + double(((ts_start_window(i) + (j-1)*q) >= ts_start_interaction(i)) & (ts_start_window(i) + (j-1)*q <= ts_end_interaction(i)));
        end
    end
    
    th = r_vett > (CONST.threshold*CONST.window);
    
    r = ((ts_start_interaction - ts_start_window) <= 0) & ((ts_end_window - ts_end_interaction) <= 0) |...
        ((ts_start_interaction - ts_start_window) > 0 & th) | ((ts_end_window - ts_end_interaction) > 0 & th);
    r(:,2) = ~r(:,1);
    
end