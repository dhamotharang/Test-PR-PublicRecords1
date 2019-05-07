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

  import ut,Workman;

  #UNIQUENAME(SOAPCALLCREDENTIALS)
  #SET(SOAPCALLCREDENTIALS  ,ut.Credentials().mac_add2Soapcall())

  raw := HTTPCALL('http://' + pesp + ':8010/WsWorkunits/WUResult.xml?Wuid=' + pWorkunitID + '&Count=' + pCount + '&Sequence=' + (string)seq
          ,'GET'
          ,'text/xml'
          ,myd
          ,xpath('WUResultResponse/Result/Dataset')
        ); 

  raw_remote := HTTPCALL('http://' + pesp + ':8010/WsWorkunits/WUResult.xml?Wuid=' + pWorkunitID + '&Count=' + pCount + '&Sequence=' + (string)seq
          ,'GET'
          ,'text/xml'
          ,myd
          ,xpath('WUResultResponse/Result/Dataset')
          %SOAPCALLCREDENTIALS%
        ); 

  returnresult := iff(trim(pesp) in Workman._Config.LocalEsps ,raw  ,raw_remote);

  result  := normalize(dataset(returnresult),left.fred,transform(pResultLayout,self := right));
  
  return result;

endmacro;