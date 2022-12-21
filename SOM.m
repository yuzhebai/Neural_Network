clc
clear all;
close all;
%%
% BEGIN ---- read input data; set all parameters here
opts = detectImportOptions('NML502_Project/data.csv');
df = readmatrix('NML502_Project/data.csv',opts);
train_data = df(:,2:14); 
y = df(:,15);

columns = {'EUR','EAS','NH','AFR','CHF','bmi','waist_hip_ratio','hdl2',...
    'triglycerides2','age','sex','education','cigs_per_day'};


% transform hdl2 and triglycerides2 from mg/dl to mg/L
train_data(:,8) = train_data(:,7)/1000;
train_data(:,9) = train_data(:,8)/1000;

% transform age
avg = min(train_data(:,10));
train_data(:,10) = train_data(:,10)-avg;

% transform BMI
avg = min(train_data(:,6));
train_data(:,6) = train_data(:,6)-avg;


% Set network parameters
somRow = 15;
somCol = 15;

% Max. number of learning steps allowed. Increase this as needed.
maxsteps = 130000; 

% Decay schedule for learning rate mu
mu = [0.55*ones(5000,1)' 0.32*ones(15000,1)' 0.11*ones(30000,1)' ...
      0.05*ones(maxsteps-50000,1)' ];    

% Monitoring frequency 
%Mfrsched = [1 1000 5000 10000 maxsteps]; % Schedule of monitoring frequency
Mfrsched = [ maxsteps];
%decacy neighborhood
width = [7.5*ones(5000,1)' 4*ones(15000,1)' 2*ones(30000,1)' ...
           1*ones(maxsteps-50000,1)' ];        


%  END of ---- Set all parameters here, generate or read input data
%% ============== Learning SOM ===================run
% Initialize weight vector matrix
[dataRow, dataCol] = size(train_data);
somMap = zeros(somRow, somCol, dataCol);

for r = 1:somRow
    for c = 1:somCol
        somMap(r,c,:) = rand(1,dataCol);
    end
end


for t = 1:maxsteps

    %Phase 1 Competition: 
    %Present a randomly drawn input pattern x, select winning PEc :
    idx = randi([1 dataRow]);
    X = train_data(idx,:);
    eucl_dis = euclideanDistance(X,somMap);
    [~,ind] = min(eucl_dis(:));
    [win_Row,win_Col] = ind2sub(size(eucl_dis),ind);

    %Phase 2
    %Cooperation: Winning PEc activates other PEs in its neighborhood
    
    %decacy neighborhood
    neighborhood = gaussianNeighbourhood(win_Row,win_Col,width(t)^2,somMap);
    
    %Phase 3
    %Weight adaptation:
    %WeightVectorUpdated = zeros(somRow, somCol, dataCol);
    for r = 1: somRow
       for c = 1:somCol
           
           % Reshape the dimension of the current weight vector
           currentWeightVector = reshape(somMap(r,c,:),1,dataCol);
           
           % Update the weight vector for each neuron
           somMap(r,c,:) = currentWeightVector + mu(t)*neighborhood(r,c)*(X-currentWeightVector);
            
       end
    end

    if ismember(t,Mfrsched) == 1
        w1 = reshape(somMap(:,:,1)',1,somCol*somRow);
        w2 = reshape(somMap(:,:,2)',1,somCol*somRow);
        w3 = reshape(somMap(:,:,3)',1,somCol*somRow);
        w4 = reshape(somMap(:,:,4)',1,somCol*somRow);
        w5 = reshape(somMap(:,:,5)',1,somCol*somRow);
        w6 = reshape(somMap(:,:,6)',1,somCol*somRow);
        w7 = reshape(somMap(:,:,7)',1,somCol*somRow);
        w8 = reshape(somMap(:,:,8)',1,somCol*somRow);
        w9 = reshape(somMap(:,:,9)',1,somCol*somRow);
        w10 = reshape(somMap(:,:,10)',1,somCol*somRow);
        w11 = reshape(somMap(:,:,11)',1,somCol*somRow);
        w12 = reshape(somMap(:,:,12)',1,somCol*somRow);   
        w13 = reshape(somMap(:,:,13)',1,somCol*somRow); 
        
        [recallmap,PE] = recallSOM(train_data,somMap);
        
        h = figure('Renderer', 'painters', 'Position', [10 10 900 600]);
        for i = 1:somCol*somRow
            subplot(somRow,somCol,i)
            weight = [w1(i),w2(i),w3(i),w4(i),...
                w5(i),w6(i),w7(i),w8(i),w9(i),w10(i),w11(i),w12(i),w13(i)];
            plot(1:13,weight)
            set(gca,'XTick',[], 'YTick', [])
            xlim([1 12])
            ylim([-2 25])
            if isempty(y(PE == i))
                set(gca,'Color','k')
            end
        end
        sgtitle(sprintf(' Weight Vectors at Learning Step #%d',t))
        saveas(h,sprintf('WV%d.png',t))


        h = figure('Renderer', 'painters', 'Position', [10 10 900 600]);
        for i = 1:somRow*somCol
            subplot(somRow,somCol,i)
            list = y(PE == i);
            if isempty(list)
                negative = sum(list == 0)/length(list);
                p = pie([0]);
                delete(findobj(p,'Type','text'))
            else
                negative = sum(list == 0)/length(list);
                labels = [{sprintf('%d', length(list))} {sprintf(' ')}];
                p = pie([negative,1-negative],labels);
                %delete(findobj(p,'Type','text'))
                %annotation('textbox',[.9 .5 .1 .2], ...
                %        'String',sprintf('%d', length(list)),'EdgeColor','none')
            end
       
        end
        sgtitle(sprintf(' True Density Mapping #%d',t))
        saveas(h,sprintf('TD%d.png',t))

        % modifed_U
        U = modifed_U2(somMap,recallmap);
        h = figure('Renderer', 'painters', 'Position', [10 10 900 600]);
        image(U)
        sgtitle(sprintf('Modified U at #%d',t))
        saveas(h,sprintf('M_U%d.png',t))

        fprintf('=========')
        disp(t)
        disp(max(weight))
        disp(min(weight))
    end
end






%% weight graph
