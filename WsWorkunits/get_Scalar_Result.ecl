EXPORT get_Scalar_Result(
   string pWorkunitID   = ''
  ,string pNamedOutput
  ,string pesp          = WsWorkunits._Config.localEsp
) :=
function

 wuinfo := WsWorkunits.soapcall_WUInfo(pWorkunitID,pesp);

 return wuinfo[1].results(name = pNamedOutput)[1].Value;

end;