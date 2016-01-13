function [Utter] = uttercutter(Sp,min_size)

%% Segment Utterances

%
Utter = struct('SpeechData',[],'FData',[],'start',[],'end',[],'dur',[],'start_sec',[],'end_sec',[],'dur_sec',[]);

SpeechMat = Sp.SpeechMat;

j = 1;

for i = 1:size(SpeechMat,1)
    
    if(SpeechMat(i,3)>= min_size/1000)
        
        start = SpeechMat(i,4);
        End = SpeechMat(i,5);
        dur = SpeechMat(i,6);
        
        D = Sp.fs/Sp.fs0;
        
        Utter(j).SpeechData = Sp.SpeechData(start:End);
        
        x = min(SpeechMat(i,8),length(Sp.FData));
        if (SpeechMat(i,8)>length(Sp.FData))
            warning('Not good in utter cutter!')
        end            
        Utter(j).FData = Sp.FData(SpeechMat(i,7):x);
        Utter(j).FIntrp = Sp.FDataIntrp(SpeechMat(i,7):x);
        
        Utter(j).start = start;
        Utter(j).end = End;
        Utter(j).dur = dur;
        
        Utter(j).start_sec = SpeechMat(i,1);
        Utter(j).end_sec = SpeechMat(i,2);
        Utter(j).dur_sec = SpeechMat(i,3);
        j = j + 1;
    end
    
end


end
