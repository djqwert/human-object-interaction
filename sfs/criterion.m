function R = criterion(input,target,hidden)    

    input = input';
    target = target';
   
    net = patternnet(hidden(1,1),'trainrp');
    
    net.divideParam.trainRatio = 70/100;
    net.divideParam.testRatio = 30/100;
    net.divideParam.valRatio = 0;
    
    net.trainParam.showWindow = 0;
    
    [net,tr,output] = train(net,input,target);

    testInd = tr.testInd;
    testTarget = target(:,testInd);
    testOutput = output(:,testInd);

    R = perform(net,testTarget,testOutput);

end