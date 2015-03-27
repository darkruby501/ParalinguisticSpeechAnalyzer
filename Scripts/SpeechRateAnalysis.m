function [ RecordsOut ] = SpeechRateAnalysis(Records)
%SPEECHRATEANALYSIS determines speech rate in speech samlpe.
% Ruben Bloom
% 2-6-2014

for i = 1:length(Records)
    
    [~, name1, ext1] = fileparts(Records(i).filename);
    sfsname = [name1 '.sfs'];
    
    
    error = system(['voc19 -i sp ' sfsname]);
    [SubBandHeader,SubBandData]=sfsgetitem(sfsname,'co');
    
    root = name1;
    e19_file=sprintf('%s.e19', root);
    pch_file=sprintf('%s.pch', root);
    cor_file=sprintf('%s.cor', root);
    max_file=sprintf('%s.max', root);
    min_file=sprintf('%s.min', root);
    
    eng_full = SubBandData(:,6:end)'; % eng_full=dlmread(e19_file); eng_full=eng_full';
    pitch = Records(i).FData; % pitch=textread(pch_file,'%f');
    
    
    [twin, t_sigma, subband_num, swin, s_sigma, mwin, max_threshold]=set_para;
    
    eng=spectral_selection(eng_full, subband_num);
    
    t_cor=temporal_corr(eng, twin, t_sigma);
    
    s_cor=spectral_corr(t_cor);
    
    ts_cor=smooth(s_cor, swin, s_sigma);
    % dlmwrite(cor_file, ts_cor, '\n');
    
    cor_max=find_maxima_pitch(ts_cor, mwin, pitch, max_threshold);
    % dlmwrite(max_file, sign(cor_max),'\n');
    
    cor_min=find_minimal(ts_cor);
    % dlmwrite(min_file, sign(cor_min), '\n');
    
    
    % Count Number of Syllables
    a = cor_max > 0;
    Syllables = sum(a);
 
    Records(i).Syllables = Syllables;
    Records(i).SpeechRate = Syllables/Records(i).audiolength;
    
    RecordsOut = Records;
    
end


end

