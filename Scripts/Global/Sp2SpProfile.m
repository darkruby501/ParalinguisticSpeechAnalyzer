
function SpProfile = Sp2SpProfile(Sp)


SpProfile.Name = Sp.Name;
SpProfile.Group = [];
SpProfile.Length = Sp.TotalDuration;

SpProfile.F0mean = Sp.PitchStat.Fmean;
SpProfile.F0std = Sp.PitchStat.Fstd;

SpProfile.Pdur_mean = Sp.PauseStat.mean_dur;
SpProfile.Pstd = Sp.PauseStat.var_dur;
SpProfile.NumPauses = Sp.PauseStat.num;
SpProfile.Ppercent = Sp.PauseStat.percent;

SpProfile.Udur_mean = Sp.UtterStat.mean_dur;
SpProfile.Ustd = Sp.UtterStat.var_dur;
SpProfile.NumUtter = Sp.UtterStat.num;
SpProfile.Upercent = Sp.UtterStat.percent;


SpProfile.PeakRatio_mean = Sp.HRTstat.meanratio;
SpProfile.HRTratio_mean = Sp.HRTstat.meanHRTratio;
SpProfile.HRTpercentage = Sp.HRTstat.percentage;
SpProfile.HRTnumHRT = Sp.HRTstat.numHRT;
SpProfile.HRTnumAS = Sp.HRTstat.num;
SpProfile.HRTdiff_mean = Sp.HRTstat.meanHRTdiff;

SpProfile.AverageRatio_mean = Sp.FIstat.meanratio;
SpProfile.FIratio_mean = Sp.FIstat.meanFIratio;
SpProfile.FIpercentage = Sp.FIstat.percentage;
SpProfile.FInumFI = Sp.FIstat.numFI;
SpProfile.FInumAS = Sp.FIstat.num;
SpProfile.FIdiff_mean = Sp.FIstat.meanFIdiff;

end

