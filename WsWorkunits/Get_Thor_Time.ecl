EXPORT Get_Thor_Time(
   string pWorkunitID = ''
  ,string pesp        = WsWorkunits._Config.localEsp
) :=
function

 wuinfo := WsWorkunits.soapcall_WUInfo(pWorkunitID,pesp);

 ds_norm_timers := normalize(wuinfo ,left.Timers  ,transform(right));

 //-- returns 7h50m09s
 return ds_norm_timers(regexfind('(Process: TimeTotalExecute|Total thor time)',name,nocase))[1].value; //for STD.System.Workunit.WorkunitTimings

end;