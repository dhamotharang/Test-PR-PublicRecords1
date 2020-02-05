EXPORT WUInfo_Attributes(
   string pWorkunitID = ''
  ,string pesp        = WsWorkunits._Config.localEsp
) :=
module

 shared wuinfo := WsWorkunits.soapcall_WUInfo(pWorkunitID,pesp);

 export state                               := wuinfo[1].State                                ;
 export scalar_result(string pNamedOutput)  := wuinfo[1].results(name = pNamedOutput)[1].Value;

end;