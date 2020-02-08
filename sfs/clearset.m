function r = clearset(mat)
    
    % La funzione pulisce il dataset dai campioni non validi: senza etichetta o con particolari caratteristiche
    mat = buildmat(mat);
    
    subject = mat(:,3);
    start_window = mat(:,4);
    end_window = mat(:,5);
    end_jump = mat(:,end-2);
    scenario_number = mat(:,end-1);
    end_interaction = mat(:,end);
    
    % Rimuovo i campioni prima della fine del salto.
    r = find( ...
        ( ...
           ((end_jump - start_window <= 0) & (scenario_number ~= 1)) | ...
           ((end_jump - start_window <= 0) & (scenario_number == 1) & (end_window <= end_interaction)) ... % Solo per lo scenario 1: rimuovo tutti i campioni dopo la fine dell'interazione
        ) & (subject == 2 | subject == 3 | subject == 4) ... % Serve a filtrare i campioni degli utenti. Gli utenti sono: 1, 2, 3, 4
        );

end

function r = buildmat(mat)
    v = import_video_label_csv("data/video_interactions.csv");
    for i = 21:80
        v(i-20) = i;
    end
    endm = size(mat,2)+1;
    for i = 1:60
       indexes = find(mat(:,2) == v(i,1));
       for j = 1:length(indexes)
            mat(indexes(j),endm) = v(i,6);      % Timestamp di fine salto 
            mat(indexes(j),endm+1) = v(i,2);    % Numero scenario
            mat(indexes(j),endm+2) = v(i,5);    % Timestamp fine interazione
       end
    end
    
    % Associa soggetto alla finestra
    ind = find(mat(:,2) >= 1 & mat(:,2) <= 20);
    mat(ind,3) = 1;
    ind = find(mat(:,2) >= 21 & mat(:,2) <= 40);
    mat(ind,3) = 2;
    ind = find(mat(:,2) >= 41 & mat(:,2) <= 60);
    mat(ind,3) = 3;
    ind = find(mat(:,2) >= 61 & mat(:,2) <= 80);
    mat(ind,3) = 4;
    
    r = mat;
end