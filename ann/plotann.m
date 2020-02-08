function [] = plotann(ann,tr,input,target)
    % Funzione stampa le caratteristiche della rete neurale artificiale
    
    % Plot figures
    close all;
    disp('Print information about best neural network.');
    [input,target] = buildset(input,target);
    input = input';
    target = target';
    y = ann(input);
    errors = gsubtract(target,y);
    view(ann);
    
    samples = length(target);
    testInd = samples * 0.3;
    trainInd = samples - testInd;
    trainSet = 1:trainInd;
    testSet = (samples-testInd):samples;
    f1 = figure; plotperform(tr);
    f2 = figure; plottrainstate(tr);
    f3 = figure; plotconfusion(target(:,trainSet),y(:,trainSet),'Training',target(:,testSet),y(:,testSet),'Testing',target,y,'All');
    f4 = figure; ploterrhist(errors(:,trainSet),'Training',errors(:,testSet),'Testing');
    % plotroc(simpleclusterTargets,simpleclusterOutputs)
    
end