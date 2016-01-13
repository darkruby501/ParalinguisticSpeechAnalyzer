function [pause_vec] = GlitchDetector2(pause_vec,fs,min_pause,min_speech,safety)
%GLICHDETECTOR Detects and removes 'glitches' in pause/speech detection. Ensures all speech and pauses are greater than minimum duration.
%   Detailed explanation goes here
% Pauses in ms

pause_vec = logical(pause_vec); % Make sure pause vec is logical
min_pause = round(min_pause*(fs/1000));
min_speech = round(min_speech*(fs/1000));
safety = round(safety*(fs/1000));



CurrentState = pause_vec(1);
t1 = 0; %first transition
t2 = 0; %second transition
maybe = 0; %flag for investigating change

t1 = 1;
for i = 2:length(pause_vec);
    
    if(pause_vec(i)~=pause_vec(i-1)||i==length(pause_vec)) %CHANGES ONLY HAPPEN ON TRANSITIONS
    t2 = i;    
       
        
        if(CurrentState) %Currently speech, possible pause
            if(t2-t1 > min_speech)
                pause_vec(max(1,t1-safety):t2-1) = 1;
            else % Glitch
                pause_vec(t1:t2) = 1; %Fix glitch
            end
            CurrentState = 0;
            t1 = t2;
            
        else %Currently pause
            if(t2-t1 > min_pause)
                pause_vec(t1+safety:t2-1) = 0;
                if (t1>1)
                    if(pause_vec(t1-1))
                        pause_vec(t1:t1+safety) = 1;
                    end
                end
            else % Glitch
                pause_vec(t1:t2-1) = 1; %Correct
            end
            CurrentState = 1;
            t1 = t2;
        end
        
    end
end

pause_vec(end) = pause_vec(end-1);