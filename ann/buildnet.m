function r = buildnet(h,samples)
    % Costruzione della rete neurale
    testInd = samples * 0.3;
    trainInd = samples - testInd;
    
    net = patternnet(h,'trainrp');
    net.trainParam.showWindow = false;
    net.divideFcn = 'divideind';
    net.divideParam.trainInd = 1:trainInd;
    net.divideParam.testInd  = (samples-testInd):samples;
    net.divideParam.valInd   = [];
    net.performFcn = 'mse';
    r = net;
end