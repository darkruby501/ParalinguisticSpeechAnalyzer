function RecordsOut = PitchAnalysis(Records)
% PITCHANALYSIS Compute pitch/f0 statistics for speech samples in records
% Ruben Bloom
% 01-06-2014

% Compute in SFS for each sample
for i = 1:length(Records)
    
    [~, name1, ext1] = fileparts(Records(i).filename);
    sfsname = [name1 '.sfs'];
    
    error = system(['fxrapt -i sp ' sfsname]);
    
    [~,FData]=sfsgetitem(sfsname,'fx');
    
    Fnan = FData;
    Fnan(Fnan == 0) = nan; %Replace Zero with Nan (for plotting)
    FDataNZ = (FData(FData>0)); %Vector of non-zero frequencies. Which are from NZ
    
    Records(i).FData = FData;
    
    Records(i).Fmean = mean(FDataNZ);
    Records(i).Fstd = std(FDataNZ);
    Records(i).Fmin = min(FDataNZ);
    Records(i).Fmax = max(FDataNZ);
    Records(i).Frange = range(FDataNZ);
    
    
    RecordsOut = Records;
    
end


end

