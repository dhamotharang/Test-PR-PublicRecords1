import bipv2,wk_ut;
EXPORT Data_GetProxConfStat(string version_in= bipv2.KeySuffix) := function

path1:='~' + BIPV2_postProcess.DataCollector().superfile_version_wuid;
xx :=dataset(path1,BIPV2_postProcess.DataCollector().version_wuid_rec,flat);
//shared wu :=(string)xx(version=version_in)[1].wuid;
wu :=(string)sort(xx(version=version_in),-wuid)[1].wuid;
Conf_ProxId:= Dataset(WorkUnit(wu,'ConfidenceLevels_prox'),{UNSIGNED2 Conf,UNSIGNED MatchesFound});
Conf_ProxId_grp:=table(Conf_ProxId,{Conf,UNSIGNED MatchesFound :=sum(group,MatchesFound)},Conf);
Prox:=sort(Conf_ProxId_grp,conf);

return Prox;
end;