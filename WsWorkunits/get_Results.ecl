import WsWorkunits;
EXPORT get_Results(

   string   pWuid
  ,string   pesp           = WsWorkunits._Config.localEsp
  
) :=
function

  ds_wuinfo       := WsWorkunits.soapcall_WUInfo(pwuid);
  ds_norm_results := normalize(ds_wuinfo,left.results    ,transform(recordof(left.results    ),self := right));  //i get these

  return ds_norm_results;

end;