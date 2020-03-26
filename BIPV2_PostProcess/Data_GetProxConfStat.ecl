import bipv2,wk_ut;
EXPORT Data_GetProxConfStat(string version_in= bipv2.KeySuffix  ,boolean pOutputDebug = false) := function

  path1:='~' + BIPV2_postProcess.DataCollector().superfile_version_wuid;
  xx :=dataset(path1,BIPV2_postProcess.DataCollector().version_wuid_rec,flat);
  //shared wu :=(string)xx(version=version_in)[1].wuid;
  wu :=(string)sort(xx(version=version_in),-wuid)[1].wuid;
  Conf_ProxId:= Dataset(WorkUnit(wu,'ConfidenceLevels_prox'),{UNSIGNED2 Conf,UNSIGNED MatchesFound});
  Conf_ProxId_grp:=table(Conf_ProxId,{Conf,UNSIGNED MatchesFound :=sum(group,MatchesFound)},Conf);
  Prox:=sort(Conf_ProxId_grp,conf);

  output_debug := sequential(
    output(path1            ,named('path1'          ))
   ,output(xx               ,named('xx'             ))
   ,output(wu               ,named('wu'             ))
   ,output(Conf_ProxId      ,named('Conf_ProxId'    ))
   ,output(Conf_ProxId_grp  ,named('Conf_ProxId_grp'))
   ,output(Prox             ,named('Prox'           ))

  );
  
  return when(Prox  ,if(pOutputDebug = true ,output_debug));

end;