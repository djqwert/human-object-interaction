function r = sync(mat,len_mdek, len_shimmer)

    mat_a =  mat;   % Copia della matrice
    j_index = 1;    % Indice della matrice degli MDEK
    
    for i = 1:len_shimmer
        
        if j_index >= len_mdek
            i_index = i-1;
            break;
        end
        
        ts_shimmer = mat_a(i,6);    % Timestamp SHIMMER
        ts_diffp = 99999;           % Differenza Timestamp precedente
        ts_diff = 99999;            % Differenza Timestamp attuale
        diff = 99999;               % Differenza Timestamp memorizzata
        
        for j = j_index:len_mdek
            
            ts_mdek = mat_a(j,1);   % Timestamp MDEK
            ts_diffp = ts_diff;
            ts_diff = abs(ts_shimmer - ts_mdek);
            if ts_diff < diff
                diff = ts_diff;
                i_index = i;        % Indice della matrice degli SHIMMER
                j_index = j;
                continue;
            end
            if ts_diffp < ts_diff
               
                %disp(['Min: ', num2str(diff),' Ind i: ', num2str(i_index), ' Ind j: ', num2str(j_index)]);
                val = mat_a(j_index,1:5);                
                for k = 1:10
                    if (i_index-1)*10+k > len_shimmer
                        break;
                    end
                    mat((i_index-1)*10+k,1:5) = val; 
                end
                j_index = j_index + 1;
                break;
                
            end
        end
        
    end
    
    % Taglio i valori SHIMMER di troppo in fondo alla matrice
    rows = i_index*10;
    if rows < len_shimmer
        mat = mat(1:rows,:);
    end
    
    % Delete old timestamp column and resize matrix
    mat(:,1) = mat(:,6);
    mat(:,6:(end-1)) = mat(:,7:end);
    mat(:,end) = []; % Rimuovi ultima colonna
    
    r = mat;

end