function r = merge()

    % insert struct a
    shimmer = load_all_shimmer_data();
    
    % insert struct b
    peoplename = ["Liuzzi", "Scotto", "Porfilio", "Roberta"];
    mdek = datacleaning(load_all_mdek_data(peoplename));
    
    for j=1:length(shimmer)                             % Soggetti
        subj = fieldnames(shimmer);
        for sub = 1:length(subj)                        % Scenario
            scen = fieldnames(shimmer.(subj{sub}));
            for sc = 1:length(scen)                     % Prova
                test = fieldnames(shimmer.(subj{sub}).(scen{sc}));
                for t = 1:length(test)                  % Oggetto
                    obj = fieldnames(shimmer.(subj{sub}).(scen{sc}).(test{t}));
                    for o = 1:length(obj)               % Tipo di dato
                        data = fieldnames(shimmer.(subj{sub}).(scen{sc}).(test{t}).(obj{o}));
                            disp(['Merge & Sync: Soggetto ', num2str(sub),' Scenario: ', num2str(sc), ' Prova ', num2str(t), ' Oggetto ', num2str(o)]);

                        for d = 1:length(data)
                            
                            if d == 1
                                mat = mdek.(subj{sub}).(scen{sc}).(test{t}).(obj{o});
                                [p,q] = size(mat);
                                len = length(shimmer.(subj{sub}).(scen{sc}).(test{t}).(obj{o}).(data{d}));
                                mdek.(subj{sub}).(scen{sc}).(test{t}).(obj{o}) = zeros(len,q+10);
                                mdek.(subj{sub}).(scen{sc}).(test{t}).(obj{o})(1:p,1:q) = mat;
                            end
                            mdek.(subj{sub}).(scen{sc}).(test{t}).(obj{o})(:,(q+d)) = shimmer.(subj{sub}).(scen{sc}).(test{t}).(obj{o}).(data{d});
                            if d == 10
                               mdek.(subj{sub}).(scen{sc}).(test{t}).(obj{o}) = sync(mdek.(subj{sub}).(scen{sc}).(test{t}).(obj{o}),p,len);
                            end
                            if d == 10 && o == 2
                               mdek.(subj{sub}).(scen{sc}).(test{t}) = syncset(mdek.(subj{sub}).(scen{sc}).(test{t}));
                            end
                       
                        end
                    end
                end
            end
        end
    end
    
    r = mdek;

end