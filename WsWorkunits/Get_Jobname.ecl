EXPORT Get_Jobname(
   string pWorkunitID = ''
  ,string pesp        = WsWorkunits._Config.localEsp
) :=
function

 wuinfo := WsWorkunits.soapcall_WUInfo(pWorkunitID,pesp);

 return wuinfo[1].Jobname;

end;