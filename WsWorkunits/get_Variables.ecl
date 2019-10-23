import WsWorkunits;
EXPORT get_Variables(

   string   pWuid
  ,string   pesp           = WsWorkunits._Config.localEsp
  
) :=
function

  ds_wuinfo := WsWorkunits.soapcall_WUInfo(pwuid);
  ds_norm   := normalize(ds_wuinfo,left.Variables    ,transform(recordof(left.Variables    ),self := right));  //i get these

  return ds_norm;

end;