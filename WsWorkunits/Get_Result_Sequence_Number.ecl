EXPORT Get_Result_Sequence_Number(
   string pWorkunitID
  ,string pResultName
  ,string pesp        = WsWorkunits._Config.localEsp
) :=
function

  wuinfo                  := WsWorkunits.soapcall_WUInfo(pWorkunitID,pesp);
  ds_norm_results         := normalize(wuinfo ,left.results ,transform(recordof(left.results) ,self := right));
  Result_sequence_number  := ds_norm_results(name = pResultName)[1].Sequence;
  
  return Result_sequence_number;

end;