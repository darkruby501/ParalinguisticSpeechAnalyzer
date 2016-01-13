function [ PauseMat ] = UtterCounter(speech_vec,fs,min_speech)
%UTTERCOUNTER Takes an input of glitch-free inverted pause vector (1 for
%speech, 0 for pause) and counts speech segments and detects duration. Outputs
%matrix where each row is one utterance, columns are utterance start, utterance end,
%and duration. These three are then repeated in samples

min_speech = min_speech/1000;


speech_vec = logical(speech_vec); % Make sure pause vec is logical
PauseMat = [];


t1 = 0; %first transition
t2 = 0; %second transition
speech_flag = speech_vec(1); %flag for counting speech duration

for i = 2:length(speech_vec)
    
    if(~speech_flag)
        if(speech_vec(i) - speech_vec(i-1) == 1) %start speech
            t1 = i;
            speech_flag = 1;
        end
    else
        if(speech_vec(i) - speech_vec(i-1) == -1) %end speech
            t2 = i;
            duration = t2 - t1;
            PauseMat = [PauseMat; t1, t2, duration];
            speech_flag = 0;
        end
    end
    
end

% %Check for final pause:
% if(pause_flag)
%             t2 = length(speech_vec);
%             duration = t2 - t1;
%             if(duration > min_pause)
%                 PauseMat = [PauseMat; t1, t2, duration];
%             end
% end

% Convert to s

% Check

PauseMat = [PauseMat/fs, PauseMat];
CHECK = min(PauseMat(:,3)) > min_speech


end