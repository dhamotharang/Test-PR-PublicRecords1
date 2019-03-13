import WsWorkunits;
EXPORT get_Timers(

   string   pWuid
  ,string   pesp           = WsWorkunits._Config.localEsp
  
) :=
function

  ds_wuinfo := WsWorkunits.soapcall_WUInfo(pwuid);
  ds_norm   := normalize(ds_wuinfo,left.Timers    ,transform(recordof(left.Timers    ),self := right));  //i get these

  return ds_norm;

end;