import bipv2,wk_ut;
EXPORT Data_GetLgidConfStat(string version_in= bipv2.KeySuffix) := function

path1:='~' + BIPV2_postProcess.DataCollector().superfile_version_wuid;
xx :=dataset(path1,BIPV2_postProcess.DataCollector().version_wuid_rec,flat);
//shared wu :=(string)xx(version=version_in)[1].wuid;
wu :=(string)sort(xx(version=version_in),-wuid)[1].wuid;
Conf_Lgid3:= Dataset(WorkUnit(wu,'ConfidenceLevels_lgid'),{UNSIGNED2 Conf,UNSIGNED MatchesFound});
Conf_Lgid3_grp:=table(Conf_Lgid3,{Conf,UNSIGNED MatchesFound :=sum(group,MatchesFound)},Conf);
Lgid:=sort(Conf_Lgid3_grp,conf);

return Lgid;
end;