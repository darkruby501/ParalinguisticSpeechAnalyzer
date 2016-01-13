function [ Vec ] = safetybuffer( Vec,fs,safety)
%SAFETYBUFFER ads a 'safety buffer' around postive cylce in square wave
%(widens).

safety = safety*(fs/1000);

SPEECH = Vec(1);


for i = 2:length(Vec)
    
    if(Vec(i)>Vec(i-1)&&~SPEECH) %Positive Transition
        Vec(max(i-safety,1):i-1) = 1;
        SPEECH = true;
    elseif(Vec(i)<Vec(i-1)&&SPEECH) %Negative Transition
        Vec(i:min(i+safety,length(Vec))) = 1;
        SPEECH = false;
    end
    
end
    
        
        
