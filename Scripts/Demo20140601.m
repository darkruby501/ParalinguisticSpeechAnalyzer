% Paralinguistic Speech Analyser Demo
% Ruben Bloom
% 01-06-2014

clear %tabula rasa

% Settings
manual_input = 1; %else use preset inputs

% Initialisation
Records = struct('filename',[],'Fmean',nan,'Fstd',nan,'Fmin',nan,'Fmax',nan,'Frange',nan,'SpeechRate',nan);
record_num = 1; %number of files for analysis


% Determine Correct Filepath
if( strcmp(getenv('COMPUTERNAME'),'RMB-MKVIIX'))
    machine_upper = 'D:\Users\RMB\Drive';
else
    machine_upper = 'C:\Users\RMB\Google Drive';
end

% Load Audio File
cd([ machine_upper '\Monash\ECE4094\Code\Audio'])


if(manual_input)
    
    record_new = true;
    while(record_new)
        record_new = input('Record new speech sample? No means select file. Y/N\n','s');
        if isempty(record_new)
            record_new = 'Y';
        end
        
        if(strcmp(record_new,'Y')|strcmp(record_new,'y'))
            record_new = true;
        else
            record_new = false;
        end
        
        if(record_new)
            new_file = ['user_sample_' num2str(record_num) '.wav'];
            SampleRecord(new_file);
            Records(record_num).filename = new_file;
        else %Load from file
            Records(record_num).filename = (input('Enter Filename of Sample for Analysis\n','s'));
        end
        
        
%         Another sample?
        record_new = input('Add another speech sample?\n','s');
        if isempty(record_new)
            record_new = 'Y';
        end
        
        if(strcmp(record_new,'Y')|strcmp(record_new,'y'))
            record_new = true;
            record_num = record_num + 1;
        else
            record_new = false;
        end
    end
        
else %Preselected in Code
            Records(1).filename = '900yearsCUT.wav';
            Records(2).filename = 'easyname.wav';
            
            
            record_num = length(Records);
            
end
    
    
    
    %% Load Files into Speech Filing System
    
    for i = 1:record_num
        
        [path1, name1, ext1] = fileparts(Records(i).filename);
        sfsname = [name1 '.sfs'];
        
        error = system(['cnv2sfs -i sp ' Records(i).filename ' ' sfsname]);
        [SpeechHeader,SpeechData] = sfsgetitem(sfsname,'sp');
        Records(i).SpeechData = SpeechData;
        Records(i).audiolength = SpeechHeader.numframes*SpeechHeader.frameduration;
        Records(i).samplerate = 1/SpeechHeader.frameduration;
        
        %   system(['replay ' sfsname]) %Replay audio file
        
    end
    
    
    
    %% Pitch Analysis
    Records = PitchAnalysis(Records);
    
    
    %% Speech Rate Analysis
    Records = SpeechRateAnalysis(Records);
    
    
    
%  SAMPLE SPEECH PASSAGE

% 1) Slowly and in monotone
% 2) Quickly with pitch variation.

%  "When the sunlight strikes raindrops in the air, they act like a prism
%  and form a rainbow."

% "A rainbow is the division of white light into many
%  beautiful colors." 


    
    
    