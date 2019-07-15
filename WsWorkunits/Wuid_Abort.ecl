EXPORT Wuid_Abort(

   string wuid
  ,string pesp = WsWorkunits._Config.LocalEsp

) :=
function

  dme := dataset([{wuid}],layouts.WuidItems);
  
  return WsWorkunits.soapcall_WUAction(dme,'Abort',pesp);

end;