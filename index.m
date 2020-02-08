clc;
clear;
close all;

addpath('./demo/');

% Try our smart model

load dataset;
load sfs;
load ann;

x = sf';
view(ann);
y = ann(x);
perf = perform(ann,t',y);

aclasses = vec2ind(t'); % Classe assegnata
pclasses = vec2ind(y);  % Classe predetta
classes = aclasses - pclasses;  % Campione predetto correttamente = 0, campione errato != 0
windexes = find(classes ~= 0);  
gindexes = find(classes == 0);

len = size(sf,1);
c = zeros(len,3);

% Color class
for i = 1:len
    if aclasses(i) == 1
        c(i,:) = [0 0 1];
    else
        c(i,:) = [1 0 0];
    end
end

c1 = intersect(gindexes,find(aclasses == 1));
c2 = intersect(gindexes,find(aclasses == 2));
w1 = intersect(windexes,find(aclasses == 1));   % ASSEGNATA CLASSE 1, la rete ha PREDETTO 0
w2 = intersect(windexes,find(aclasses == 2));   % ASSEGNATA CLASSE 0, la rete ha PREDETTO 1

hold on;
grid on;
scatter(sf(c1,1),sf(c1,2),[],c(c1,:),'o','filled');
scatter(sf(c2,1),sf(c2,2),[],c(c2,:),'o','filled');
scatter(sf(w1,1),sf(w1,2),300,c(w1,:),'x');
scatter(sf(w2,1),sf(w2,2),300,c(w2,:),'x');
legend({'Good - Interaction' 'Good - Not interaction' 'Wrong - Interaction' 'Wrong - Not interaction'});
xlabel('Crosscorrelation','FontSize',25) 
ylabel('Angular acceleration [rad/s^{2}]','FontSize',25) 
hold off;

hold on;
grid on;
scatter3(sf(c1,1),sf(c1,2),sf(c1,3),[],c(c1,:),'o','filled');
scatter3(sf(c2,1),sf(c2,2),sf(c2,3),[],c(c2,:),'o','filled');
scatter3(sf(w1,1),sf(w1,2),sf(w1,3),300,c(w1,:),'x');
scatter3(sf(w2,1),sf(w2,2),sf(w2,3),300,c(w2,:),'x');
legend({'Good - Interaction' 'Good - Not interaction' 'Wrong - Interaction' 'Wrong - Not interaction'});
xlabel('Crosscorrelation','fontsize',15) 
ylabel('Angular acceleration [rad/s^{2}]',15) 
hold off;