import WsWorkunits;
EXPORT get_Debug_Values(

   string   pWuid
  ,string   pesp           = WsWorkunits._Config.localEsp
  
) :=
function

  ds_wuinfo := WsWorkunits.soapcall_WUInfo(pwuid);
  ds_norm   := normalize(ds_wuinfo,left.DebugValues    ,transform(recordof(left.DebugValues    ),self := right));  //i get these

  return ds_norm;

end;