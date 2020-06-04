EXPORT soapcall_DFUWorkunitsAction(
   dataset(layouts.WuidItems)   pWuids                   
  ,string                       pActionType = ''                  // 'Delete' ,'Protect' ,'Unprotect' ,'Restore' ,'SetToFailed'
  ,string                       pESp        = _Config.LocalEsp
) :=
function

	DFUWorkunitsActionRequest_Record :=
	record
  	dataset(layouts.WuidItems)  Wuids                {xpath('wuids'          )} := pWuids                   ;
		string                      ActionType           {xpath('Type'           )} := pActionType              ;
	end;
		
	DFUActionResult_Record :=
	record
		string                      DFU_Wuid         {xpath('ID'           )};
		string                      Action           {xpath('Action'       )};
		string                      Result           {xpath('Result'       )};
	end;

	// DFUActionResults_Record :=
	// record
  	// dataset(DFUActionResult_Record)  DFUActionResult                {xpath('DFUActionResult'          )} := pWuids                   ;
	// end;

	DFUWorkunitsActionOut_Record :=
	record, maxlength(100000)
	
		string exception_code     {xpath('Exceptions/Exception/Code'    )};
		string exception_source   {xpath('Exceptions/Exception/Source'  )};
		string exception_msg      {xpath('Exceptions/Exception/Message' )};
    string FirstColumn        {xpath('FirstColumn'                  )};
    dataset(DFUActionResult_Record) DFUActionResults   {xpath('DFUActionResults/DFUActionResult' )};
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
    ,'DFUWorkunitsAction'
    ,DFUWorkunitsActionRequest_Record
    ,dataset(DFUWorkunitsActionOut_Record)
    // ,heading('<WUInfoRequest>','</WUInfoRequest>')
    ,xpath('DFUWorkunitsActionResponse')
    ,literal
  );

  results_remote := SOAPCALL(
     myurl
    ,'DFUWorkunitsAction'
    ,DFUWorkunitsActionRequest_Record
    ,dataset(DFUWorkunitsActionOut_Record)
    // ,heading('<WUInfoRequest>','</WUInfoRequest>')
    ,xpath('DFUWorkunitsActionResponse')
    ,literal
   %SOAPCALLCREDENTIALS%
  );

  returnresult := iff(trim(pesp) in Workman._Config.LocalEsps ,results  ,results_remote);

  return returnresult;
  
end;