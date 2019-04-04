EXPORT soapcall_WUResult(
   string   pWorkunitID
  ,string   pResultName
  ,string   pSequence
  ,string   pesp           = _Config.localEsp
  ,unsigned pCount         = 1000
) :=
function

  lay_return := {string payload{xpath('Result')}};

	WUResultIn :=
	record
		string  Wuid                     {xpath('Wuid'                     )} := pWorkunitID;
		string  Sequence                 {xpath('Sequence'                 )} := (string)pSequence;
		string  ResultName               {xpath('ResultName'               )} := pResultName;
		string  Count                    {xpath('Count'                    )} := (string)pCount;
	end;

  esp				:= pesp + ':8010';	//oss is 242,infiniband is '10.241.3.242'

  import ut,Workman;

  #UNIQUENAME(SOAPCALLCREDENTIALS)
  #SET(SOAPCALLCREDENTIALS  ,ut.Credentials().mac_add2Soapcall())

  results := SOAPCALL('http://' + esp + '/WsWorkunits?ver_=1.48'
          ,'WUResult'
          ,WUResultIn
          ,dataset(lay_return)
          ,xpath('WUResultResponse')
          // ,timelimit(600) //5 minutes
        ); 
    
  results_remote := SOAPCALL('http://' + esp + '/WsWorkunits?ver_=1.48'
          ,'WUResult'
          ,WUResultIn
          ,dataset(lay_return)
          ,xpath('WUResultResponse')
          // ,timelimit(600) //5 minutes
          %SOAPCALLCREDENTIALS%
        ); 

  returnresult := iff(trim(pesp) in Workman._Config.LocalEsps ,results  ,results_remote);

  return if(Is_Valid_Wuid(pWorkunitID)  ,returnresult ,dataset([],lay_return));
		
end;



