%% Data cleaning
clc;
clear;
close all;

%% Add path
addpath('./data/');
addpath('./sync/');
addpath('./ann/');
addpath('./sfs/');
addpath('./results/');

%% Initialize costant
init();

% Formatting data
d = merge();
% plotsignals(d);

%% Features extraction
ef = featuresextraction(d);

%% Clear dataset
indexes = clearset(ef);

%% Prepare features
f = ef(indexes,6:end);
t = target(ef);
t = double(t(indexes,:));
% ds = horzcat(f,t);

%% Features selection
% id = featureselection(f,t);
str = 'results/sfs25.mat';
load(str);
sf = f(:,id);

%% Build Neural Network
minNeurons = sum(id);
maxNeurons = minNeurons*2;
attempts = 100;

n = searching(sf,t,minNeurons,maxNeurons);
[ann, tr] = training(sf,t,n,attempts);
plotann(ann,tr,sf,t);
% wclassification(ann,d,sf,ef,t,id,indexes);