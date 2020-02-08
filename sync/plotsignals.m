function [] = plotsignals(struct)
    close all;
    i = 0;
    
    for j=1:length(struct)                              % Soggetti
        subj = fieldnames(struct);
        for sub = 1:length(subj)                        % Scenario
            scen = fieldnames(struct.(subj{sub}));
            for sc = 1:length(scen)                     % Prova
                test = fieldnames(struct.(subj{sub}).(scen{sc}));
                for t = 1:length(test)                  % Oggetto
                    
                    i = i + 1;
                    if mod(i,21) == 0
                        figure;
                        i = 1;
                    end
                    subplot(4,5,i);
                    disp(['Plot: Soggetto ', num2str(sub),' Scenario: ', num2str(sc), ' Prova ', num2str(t)]);

                    obj = fieldnames(struct.(subj{sub}).(scen{sc}).(test{t}));

                    hold on;
                    title([['S', num2str(sub),'SC', num2str(sc), 'P', num2str(t)]])
                    for o = 1:length(obj)               % Tipo di dato
                        
                        plot(milliseconds(struct.(subj{sub}).(scen{sc}).(test{t}).(obj{o})(:,1)),struct.(subj{sub}).(scen{sc}).(test{t}).(obj{o})(:,[15 16 20]));
                     
                    end
                    hold off;
                    if mod(i,20) == 0
                        legend(["Polso","Zaino"]);
                    end
                    
                end
            end
        end
    end
    

end