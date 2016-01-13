% NAIVE BAYES SPEAKER CLASSIFICATION

if(~exist('Sp','var'))
load('D:\Users\RMB\Drive\Monash\ECE4095\Code\FYP\Scripts\Speech Samples\Ceremony Speakers\SpFile.mat');
end

for j = 1:length(Sp)
    
    X = Sp(j).PitchFVec;
    
    UDATA(j).All = X;
    
%   Select Training
    y = randsample(1:size(X,1),size(X,1)-2);
    UDATA(j).Train = X(y,:);

   
%   Select Test
    a = ~ismember(1:size(X,1),y);
    UDATA(j).Test = X(a,:);
    
end    
    
TRAINING = [];
TEST = [];

for j = 1:length(Sp)
    
    TRAINING = [TRAINING; UDATA(j).Train, j*ones(size(UDATA(j).Train),1)]
    TEST = [TEST; UDATA(j).Test, j*ones(size(UDATA(j).Test,1))]
    
end

save('FEATUREDATA.mat','UDATA','TRAINING','TEST')

training = TRAINING(:,1:end-1);
class = TRAINING(:,end);
test_class = TEST(:,end);


nb = NaiveBayes.fit(training,class);
output = nb.predict(TEST(:,1:end-1));
post = nb.posterior(TEST(:,1:end-1));

accuracy = sum((output==test_class))/length(output)

confusionmat(TEST(:,end),output)


%% TEST WITH MEAN SUBTRACTED

A = TEST(:,1:end-1);
mA = mean(A,2);
B = A - mA*ones(1,size(A,2));

C = TRAINING(:,1:end-1);
mC = mean(C,2);
D = C - mC*ones(1,size(C,2));



nb_ms = NaiveBayes.fit(D,class);
output1 = nb_ms.predict(B)

accuracy = sum((output1==test_class))/length(output1)

confusionmat(test_class,output1)


%% TEST JUST USING MEAN

nb_ms = NaiveBayes.fit(mC,class);
output2 = nb_ms.predict(mA)

accuracy = sum((output2==test_class))/length(output2)

confusionmat(test_class,output2)

