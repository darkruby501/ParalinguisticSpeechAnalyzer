function [ PauseMat ] = PauseCounter(speech_vec,fs,min_pause)
%PAUSECOUNTER Takes an input of glitch-free inverted pause vector (1 for
%speech, 0 for pause) and counts pauses and detects duration. Outputs
%matrix where each row is one pause, columns are pause start, pause end,
%and duration. 




speech_vec = logical(speech_vec); % Make sure pause vec is logical
PauseMat = [];


t1 = 0; %first transition
t2 = 0; %second transition
pause_flag = 0; %~speech_vec(1); %flag for counting pause duration

for i = 2:length(speech_vec)
    
    if(~pause_flag)
        if(speech_vec(i) - speech_vec(i-1) == -1) %start pause
            t1 = i;
            pause_flag = 1;
        end
    else
        if(speech_vec(i) - speech_vec(i-1) == 1)
            t2 = i;
            duration = t2 - t1;
            PauseMat = [PauseMat; t1, t2, duration];
            pause_flag = 0;
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

PauseMat = PauseMat/fs;

end