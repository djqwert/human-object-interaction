function r = datacleaning(struct)
    
    for j=1:length(struct)                             % Soggetti
        subj = fieldnames(struct);
        for sub = 1:length(subj)                        % Scenario
            scen = fieldnames(struct.(subj{sub}));
            for sc = 1:length(scen)                     % Prova
                test = fieldnames(struct.(subj{sub}).(scen{sc}));
                for t = 1:length(test)                  % Oggetto
                    obj = fieldnames(struct.(subj{sub}).(scen{sc}).(test{t}));
                    for o = 1:length(obj)               % Tipo di dato
                          struct.(subj{sub}).(scen{sc}).(test{t}).(obj{o}) = fillmissing(struct.(subj{sub}).(scen{sc}).(test{t}).(obj{o}),'linear');
                    end
                end
            end
        end
    end
    
    r = struct;

end