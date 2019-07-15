EXPORT get_Ds_Result(
   pWorkunitID
  ,pResultName
  ,pResultLayout
  ,pCount         = '\'1000\''
  ,pesp           = 'WsWorkunits._Config.localEsp'

) :=
functionmacro

  ds_result := WsWorkunits.httpcall_WUResult(pWorkunitID,pResultName,pResultLayout,pCount,pesp);

  return ds_result;

endmacro;