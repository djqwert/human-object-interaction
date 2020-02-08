function [] = plotwindow(struct, wclasses)
    
    len = size(wclasses,1);
    sub_t = wclasses(:,1);
    test(:,1) = wclasses(:,2);
    sw(:,1) = wclasses(:,4);
    ew(:,1) = wclasses(:,5);
    
    for i = 1:len
       sc_t(i,1) = fix(test(i)/5)+1;
       t_t(i,1) = rem(test(i),5);
       if t_t(i) == 0
           sc_t(i) = sc_t(i) - 1;
           t_t(i) = 5;
       end
    end
    
    v = import_video_label_csv("data/video_interactions.csv");
    len_v = size(v,1);
    close all;
    
    for j=1:length(struct)                              % Soggetti
        subj = fieldnames(struct);
        for sub = 1:length(subj)                        % Scenario
            scen = fieldnames(struct.(subj{sub}));
            for sc = 1:length(scen)                     % Prova
                test = fieldnames(struct.(subj{sub}).(scen{sc}));
                for t = 1:length(test)                  % Oggetto
                    
                    obj = fieldnames(struct.(subj{sub}).(scen{sc}).(test{t}));
                    
                    for i = 1:len

                        if sub == sub_t(i) && sc == sc_t(i) && t == t_t(i)
                            figure;
                            disp(['Plot: Soggetto ', num2str(sub),' Scenario: ', num2str(sc), ' Prova ', num2str(t)]);
                            ts = struct.(subj{sub}).(scen{sc}).(test{t}).(obj{1})(:,1);
                            min_ts = min(struct.(subj{sub}).(scen{sc}).(test{t}).(obj{1})(:,1));
                            x = milliseconds(ts - min_ts);
                            y = struct.(subj{sub}).(scen{sc}).(test{t}).(obj{1})(:,15);
                            y1 = struct.(subj{sub}).(scen{sc}).(test{t}).(obj{2})(:,15);
                            p = plot(x, y, '--', x, y1, '--');
                            title(['SUBJ: ', num2str(sub),' SCEN: ', num2str(sc), ' PROV: ', num2str(t), ' (CA: ' num2str(wclasses(i,6)), ' - CP: ' num2str(~wclasses(i,6)), ')']);
                            legend(["User","Backpack"]);
                            xlabel("Time");
                            ylabel("Acceleration [m/s^{2}]");
                            vline(milliseconds(sw(i) - min_ts - 250),'k','SW'); 
                            vline(milliseconds(ew(i) - min_ts),'k','EW');
                            for k = 1:len_v
                                if v(k,1) == sub && v(k,2) == sc && v(k,3) == t
                                   vline(milliseconds(v(k,4) - min_ts),'m','SI'); 
                                   vline(milliseconds(v(k,5) - min_ts),'m','EI');
                                end 
                            end
                        end
                        
                    end
                    
                end
            end
            
        end

end