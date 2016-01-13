

nsub = ceil(length(Sp)/2);

X = [0.6:0.1:1.4];
figure
for i = 1:length(Sp)
    N = hist(Sp(i).HRTmat(:,1),X)
    
    subplot(nsub,2,i)
    bar(X,N)
    title(Sp(i).Name,'fontweight','bold')
    
end
    
    
    



