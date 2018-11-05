EXPORT Get_Ds_Result_Count(
   string pWorkunitID
  ,string pResultName
  ,string pesp        = WsWorkunits._Config.localEsp
) :=
function

 wuinfo := WsWorkunits.soapcall_WUInfo(pWorkunitID,pesp);

 return wuinfo[1].results(name = pResultName)[1].Total;

end;