EXPORT Wuid_Restore(

   string wuid
  ,string pesp                     = WsWorkunits._Config.LocalEsp

) :=
function
  dme := dataset([{wuid}],layouts.WuidItems);
  lesp := pesp;
  return WsWorkunits.soapcall_WUAction(dme,'Restore',pesp := lesp);

end;