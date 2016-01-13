function [pause_vec] = GlitchDetector(pause_vec,fs,min_pause,min_speech,safety)
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

for i = 2:length(pause_vec);
    
    if(pause_vec(i)~=pause_vec(i-1))
        if(~maybe) % first event
            t1 = i;
            maybe = true;
        else %second event
            t2 = i;
            maybe = false;
            
            if(CurrentState) %Currently speech, possible pause
                if(t2-t1 > min_pause)
                   CurrentState = 0;
                   pause_vec(t1+safety:t2) = 0;
                else % Glitch
                   pause_vec(t1:t2) = 1; %Correct
                end
            else %Currently pause, maybe speech
                if(t2-t1 > min_speech)
                   CurrentState = 1;
                   pause_vec(max(1,t1-safety):t2) = 1;
                else % Glitch
                   pause_vec(t1:t2) = 0; %Correct
                end
            end
        end
    end

end

