import WsWorkunits;
EXPORT get_All_Results(

   string   pWuid
  ,string   pesp           = WsWorkunits._Config.localEsp
  ,unsigned pCount         = 1000
  ,string   pFilterResults = ''
  
) :=
function

  ds_wuinfo       := WsWorkunits.soapcall_WUInfo(pwuid);
  ds_norm_results := normalize(ds_wuinfo,left.results    ,transform(recordof(left.results    ),self := right));  //i get these

  // ds_wuinfo := WorkMan.get_WUInfo(pwuid).dnormresults3;
  
  // -- remove files
  ds_proj := project(ds_norm_results(filename = ''),transform({dataset({string result_name ,string field_name ,string field_value  ,unsigned record_number}) recs},
    self.recs := WsWorkunits.get_Ds_Result_XmlBlob(pWuid,left.name,pesp,pCount);
  ));

  ds_norm := normalize(ds_proj  ,left.recs  ,transform({string result_name ,string field_name ,string field_value  ,unsigned record_number},
    self := right
  ));

  return ds_norm(pFilterResults = '' or regexfind(pFilterResults,result_name + ' ' + field_name + ' ' + field_value,nocase));

/*
result_name     field_name  field_value       record_number
MatchStatistics	label	      MatchesPerformed	1
MatchStatistics	value	      135082	          1

*/



end;