function r = signals(struct)
    % La matrice zaino/polso ha dimensione K x S, dove K è il numero di
    % campioni ed S è il numero dei segnali.
    % I segnali nella matrice sono S = 20. Il primo di questi è la
    % colonna del timestamp la quale si può ignorare, allora S = 19. 
    %
    % I segnali saranno descritti in commento di seguito per colonna: 
    % Col 2: Posizione X
    % Col 3: Posizione Y
    % Col 4: Posizione Z
    % Col 5: Derivata interdistanza
    % Col 6: Accelerazione LN X
    % Col 7: Accelerazione LN Y
    % Col 8: Accelerazione LN Z
    % Col 9: Accelerazione WR X
    % Col 10: Accelerazione WR Y
    % Col 11: Accelerazione WR Z
    % Col 12: Giroscopio X
    % Col 13: Giroscopio Y
    % Col 14: Giroscopio Z
    % Col 15: Norma accelerazione
    % Col 16: Interdistanza
    % Col 17: Correlazione incrociata norma accelerazione
    % Col 18: Derivata norma accelerazione
    % Col 19: Derivata norma giroscopio
    % Col 20: Norma giroscopio
    % Col 21: Correlazione incrociata norma giroscopio
  
    global CONST;

    zaino = struct.("zaino");
    polso = struct.("polso");

    norm2_ACC = @(mat) sqrt(power(mat(:,CONST.Accel_LN_X),2)+power(mat(:,CONST.Accel_LN_Y),2)+power(mat(:,CONST.Accel_LN_Z),2));
    norm2_GYRO = @(mat) sqrt(power(mat(:,CONST.Gyr_X),2)+power(mat(:,CONST.Gyr_Y),2)+power(mat(:,CONST.Gyr_Z),2));
    intdis = @(mat1,mat2) sqrt(power(mat1(:,CONST.Position_X)-mat2(:,CONST.Position_X),2)+power(mat1(:,CONST.Position_Y)-mat2(:,CONST.Position_Y),2)+power(mat1(:,CONST.Position_Z)-mat2(:,CONST.Position_Z),2));
    
    zaino(:,15) = norm2_ACC(zaino);
    zaino(:,16) = intdis(zaino,polso);
    zaino(:,20) = norm2_GYRO(zaino);
    
    polso(:,15) = norm2_ACC(polso);
    polso(:,16) = intdis(polso,zaino);
    polso(:,20) = norm2_GYRO(polso);
    
    zaino(:,17) = xcorrelation(zaino(:,15), polso(:,15));   % Correlazione incrociata norma accelerazione
    zaino(:,18) = resize(diff(zaino(:,15)),zaino(:,1));     % Derivata Acc
    zaino(:,19) = resize(diff(zaino(:,20)),zaino(:,1));     % Derivata Gyro
    zaino(:,5) = resize(diff(zaino(:,16)),zaino(:,1));      % Derivata Interdistanza
    zaino(:,21) = xcorrelation(zaino(:,20), polso(:,20));   % Correlazione incrociata norma giroscopio
    
    polso(:,17) = xcorrelation(polso(:,15), zaino(:,15));   % Correlazione incrociata norma accelerazione
    polso(:,18) = resize(diff(polso(:,15)),polso(:,1));     % Derivata Acc
    polso(:,19) = resize(diff(polso(:,20)),polso(:,1));     % Derivata Gyro
    polso(:,5) = resize(diff(polso(:,16)),polso(:,1));      % Derivata interdistanza
    polso(:,21) = xcorrelation(polso(:,20), zaino(:,20));   % Correlazione incrociata norma accelerazione
    
    struct.("zaino") = zaino;
    struct.("polso") = polso;
    
    r = struct;
end

function r = xcorrelation(v1, v2)
	global CONST;
    step = CONST.window;
    len = length(v1);
    xc = zeros(len,1);
    for scan = step:step:len
        row_s = 1+(scan-step);
        row_e = scan;
        xc_tmp = xcorr(v1(row_s:row_e),v2(row_s:row_e),step/2);
        xc(row_s:row_e) = xc_tmp(1:step);
        if scan + step > len
            scan = len - step;
        end
    end
    r = xc;
end
        
function r = resize(v1, v2)
    len1 = length(v1);
    len2 = length(v2);
    if len1 < len2
        for i = 1:(len2-len1)
            v1(end+1,1) = v1(end,1);
        end
    end
    r = v1;
end