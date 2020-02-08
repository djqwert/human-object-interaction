function r = featuresextraction(struct)
    % Variabili di configurazione
    global CONST;
    mat = []; 
    
    n = CONST.features;     % numero features
    p = CONST.signals;      % numero di segnali (2:19)
    step = CONST.window;    % Dimensione della finestra mobile
   
    id_w = 1;               % id della finestra
    id_subj = 1;            % id del soggetto (1..4)
    id_vid = 1;             % id del video (1..20)
    
    % Corpo della funzione                            
    subj = fieldnames(struct);
    for sub = 1:length(subj)                        % Soggetto
        scen = fieldnames(struct.(subj{sub}));
        disp(['Subject features n.',num2str(id_subj)]);
        for sc = 1:length(scen)                     % Scenario
            test = fieldnames(struct.(subj{sub}).(scen{sc}));
            for t = 1:length(test)                  % Prova
                obj = fieldnames(struct.(subj{sub}).(scen{sc}).(test{t}));  % Polso o zaino
                id_seq = 1;
                zaino = struct.(subj{sub}).(scen{sc}).(test{t}).(obj{1});
                polso = struct.(subj{sub}).(scen{sc}).(test{t}).(obj{2});
                len_data = length(zaino(:,1));
                r_mat = [];
                
                for scan = step:step:len_data
                    row_s = 1+(scan-step);          % Riga di inizio finestra della matrice mat
                    row_e = scan;                   % Riga di fine finestra della matrice mat
                    mat(id_w,1) = id_w;             % Inizio identificatori della finestra
                    mat(id_w,2) = id_vid;
                    mat(id_w,3) = id_seq;
                    mat(id_w,4) = zaino(row_s,1);
                    mat(id_w,5) = zaino(row_e,1);   % Fine identificatori della finestra
                    r_mat(1,1:n*p) = features(zaino(row_s:row_e,2:end),n,p);  
                    r_mat(1,(n*p+1):(2*n*p)) = features(polso(row_s:row_e,2:end),n,p);
                    mat(id_w,(5+1):(2*n*p+5)) = r_mat(1,:);
                    id_seq = id_seq + 1;
                    id_w = id_w + 1;
                    if scan + step > len_data
                        scan = len_data - step;
                    end
                end
                
               id_vid = id_vid + 1;
            end
        end
        id_subj = id_subj + 1;
    end
    
    r = fillmissing(norm(mat),'linear');
    
end

function r = norm(mat)
    y = size(mat,2);
    for i = 6:y
        v = mat(:,i);
        if (max(v) - min(v)) ~= 0 
            %mat(:,i) = (mat(:,i) - min(mat(:,i))) ./ (max(mat(:,i)) - min(mat(:,i)));
            mat(:,i) = (v - mean(v)) ./ std(v);
        else
            mat(:,i) = 0;
        end
    end
    r = mat;
end