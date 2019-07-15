EXPORT Get_State(
   string pWorkunitID = ''
  ,string pesp        = WsWorkunits._Config.localEsp
) :=
function

 wuinfo := WsWorkunits.soapcall_WUInfo(pWorkunitID,pesp);

 return wuinfo[1].State;

end;