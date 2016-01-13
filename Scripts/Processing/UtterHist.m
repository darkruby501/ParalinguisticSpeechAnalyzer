% HISTOGRAM OF SPEECH UTTERANCES

UttersDurTotal = [];

figure
subplot(2,3,1)

for i = 1:6
subplot(2,3,i) 

UttersDur = Sp(i).SpeechMat(:,3);
UttersDurTotal = [UttersDurTotal; UttersDur];
hist(UttersDur,5);
title(Sp(i).name)


end

G = 10;
figure
[N,X] = hist(UttersDurTotal,G);
hist(UttersDurTotal,G)
title(['G = ' num2str(G)])

[X',N']
d = X(2)-X(1)

[X(:)-d*0.5, X(:)+d*0.5,N'] 

bin_centres = [1,1.5,2,2.5];
bin_hwidth = 0.25;

bins = [bin_centres(:)-bin_hwidth,bin_centres(:)+bin_hwidth]

bin_index = zeros(length(UttersDurTotal),length(bins));
for i = 1:length(bins)
    bin_index(:,i) = (UttersDurTotal>bins(i,1))&(UttersDurTotal<bins(i,2));
    bin_nums(i) = sum(bin_index(:,i));
end
   


