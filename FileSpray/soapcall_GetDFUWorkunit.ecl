EXPORT soapcall_GetDFUWorkunit(
   string  pWorkunitID   
  ,string  pESp       = _Config.LocalEsp
) :=
function

	GetDFUWorkunitInRecord :=
	record, maxlength(100)
		string  wuid             {xpath('wuid'                   )} := pWorkunitID;
	end;
	
	GetDFUWorkunitOutRecord :=
	record, maxlength(100000)
	
		string exception_code     {xpath('Exceptions/Exception/Code'    )};
		string exception_source   {xpath('Exceptions/Exception/Source'  )};
		string exception_msg      {xpath('Exceptions/Exception/Message' )};
    string DestLogicalName    {xpath('result/DestLogicalName'       )};
	end;

		// userid 		:= _control.MyInfo.UserID;
		// password	:= _control.MyInfo.Password;
		// esp				:= if(_Constants.IsDataland
                  // ,'10.241.12.204:8010'	//oss is 242,infiniband is '10.241.3.242'
                  // ,'prod:8010'
                // );
  myurl := 'http://' + pESp + ':8010/FileSpray';

  import ut,Workman;
  
  #UNIQUENAME(SOAPCALLCREDENTIALS)
  #SET(SOAPCALLCREDENTIALS  ,ut.Credentials().mac_add2Soapcall())

  results := SOAPCALL(
     myurl
    ,'GetDFUWorkunit'
    ,GetDFUWorkunitInRecord
    ,dataset(GetDFUWorkunitOutRecord)
    // ,heading('<WUInfoRequest>','</WUInfoRequest>')
    ,xpath('GetDFUWorkunitResponse')
    ,literal
  );

  results_remote := SOAPCALL(
     myurl
    ,'GetDFUWorkunit'
    ,GetDFUWorkunitInRecord
    ,dataset(GetDFUWorkunitOutRecord)
    // ,heading('<WUInfoRequest>','</WUInfoRequest>')
    ,xpath('GetDFUWorkunitResponse')
    ,literal
   %SOAPCALLCREDENTIALS%
  );

  returnresult := iff(trim(pesp) in Workman._Config.LocalEsps ,results  ,results_remote);

  return returnresult;
  
end;