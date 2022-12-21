function [recallmap,index] = recallSOM(train_data,somMap)

    index = zeros(1,length(train_data));
    for i = 1:length(train_data)
        X = train_data(i,:);
        eucl_dis = euclideanDistance(X,somMap);
        [~,ind] = min(eucl_dis(:));
        index(i) = ind;
    end
    binc = 1:size(eucl_dis,1)*size(eucl_dis,2);
    counts = hist(index,binc);    
    recallmap = reshape(counts,[size(eucl_dis,1),size(eucl_dis,2)])';
end