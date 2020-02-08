function [] = labelfeatures(f)
    
    global CONST;
	s = CONST.signals;             % Numero di segnali
	n = CONST.features;            % Numero di feature
	len = length(f);
    
	for i = 1:len
		
        if f(i) > s*n*2
            error('Segnale %d non identificato', f(i));
        end
        
		fprintf('Col: %d, ',f(i));
        if(f(i) <= s * n)
            fprintf('Polso - ');
        else
            fprintf('Zaino - ');
            f(i) = f(i) - s * n;             
        end
        ids = f(i);

		if ids <= 10
			fprintf('Posizione X ');
        elseif ids <= 20
			fprintf('Posizione Y ');
        elseif ids <= 30
			fprintf('Posizione Z ');
        elseif ids <= 40
			fprintf('Derivata interdistanza ');
        elseif ids <= 50
			fprintf('Accelerazione LN X ');
		elseif ids <= 60
			fprintf('Accelerazione LN Y ');
		elseif ids <= 70
			fprintf('Accelerazione LN Z ');
		elseif ids <= 80
			fprintf('Accelerazione WR X ');
		elseif ids <= 90
			fprintf('Accelerazione WR Y ');
		elseif ids <= 100
			fprintf('Accelerazione WR Z ');
		elseif ids <= 110
			fprintf('Giroscopio X ');
		elseif ids <= 120
			fprintf('Giroscopio Y ');
		elseif ids <= 130
			fprintf('Giroscopio Z ');
            
		elseif ids <= 140
			fprintf('Norma accelerazione ');
		elseif ids <= 150
			fprintf('Interdistanza ');
		elseif ids <= 160
			fprintf('Correlazione incrociata Accelerazione ');
		elseif ids <= 170
			fprintf('Derivata norma accelerazione ');
		elseif ids <= 180
            fprintf('Derivata norma giroscopio ');
        elseif ids <= 190
			fprintf('Norma giroscopio ');
        elseif ids <= 200
			fprintf('Correlazione incrociata Giroscopio ');
        end
		
		idn = rem(f(i),n);
        fprintf('(');
		switch idn
			case 1
				fprintf('Min');
			case 2
				fprintf('Max');
			case 3
				fprintf('Mean');
			case 4
				fprintf('Median');
			case 5
				%fprintf('Skewness');
                fprintf('Man Trend');
			case 6
				%fprintf('Kurtosis');
                fprintf('Energia');
			case 7
				fprintf('Mean ABS');
			case 8
				fprintf('IQR');
			case 9
				fprintf('Var');
			case 0
				fprintf('Std');
			otherwise
				error('Feature non identificata');
        end
        
        fprintf(')\n');
		
	end

end