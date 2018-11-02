EXPORT httpcall_WUResult(
   pWorkunitID
  ,pResultName
  ,pResultLayout
  ,pCount         = '\'1000\''
  ,pesp           = 'WsWorkunits._Config.localEsp'

) :=
functionmacro

  seq := WsWorkunits.Get_Result_Sequence_Number(pWorkunitID,pResultName,pesp);
  
  myd := {dataset(pResultLayout) fred{xpath('Row')}};

  raw := HTTPCALL('http://' + pesp + ':8010/WsWorkunits/WUResult.xml?Wuid=' + pWorkunitID + '&Count=' + pCount + '&Sequence=' + (string)seq
          ,'GET'
          ,'text/xml'
          ,myd
          ,xpath('WUResultResponse/Result/Dataset')
        ); 

  result  := normalize(dataset(raw),left.fred,transform(pResultLayout,self := right));
  
  return result;

endmacro;