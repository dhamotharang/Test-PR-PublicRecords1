/*
  WUFile can restore archived workunits
  <WUFileRequest>
   <Wuids>
    <Item>W20130603-104908</Item>
   </Wuids>
   <ActionType>Restore</ActionType>
   <Cluster/>
   <Owner/>
   <State/>
   <StartDate/>
   <EndDate/>
   <ECL/>
   <Jobname/>
   <Test/>
   <CurrentPage/>
   <PageSize/>
   <Sortby/>
   <Descending>0</Descending>
   <EventServer/>
   <EventName/>
   <PageFrom/>
   <BlockTillFinishTimer>0</BlockTillFinishTimer>
  </WUFileRequest>

  Possible actions:
   <ActionType>Restore</ActionType>
   <ActionType>Protect</ActionType>
   <ActionType>Unprotect</ActionType>

  Example calls:
WorkMan.do_WUFile(dataset([{'W20140116-153630'}],WorkMan.layouts.WuidItems),'Abort');
WorkMan.do_WUFile(dataset([{'W20140116-153630'}],WorkMan.layouts.WuidItems),'Protect');
WorkMan.do_WUFile(dataset([{'W20140116-153630'}],WorkMan.layouts.WuidItems),'Restore');
WorkMan.do_WUFile(dataset([{'W20140116-153630'}],WorkMan.layouts.WuidItems),'Unprotect');
WorkMan.do_WUFile(dataset([{'W20140116-153630'}],WorkMan.layouts.WuidItems),'Deschedule');
*/
import _control;
// #option('maxLength', 131072); // have to increase for the remote directory child datasets
//////////////////////////////////////////////////////////////////////////////////////////////
export soapcall_WUFile(
   string    pWuid                   
  ,string    pesp       = WsWorkunits._Config.LocalEsp
  ,string    pSizeLimit = '0'
  ,string    pName      = 'ArchiveQuery'
  ,string    pOption    = '0'
  
) :=                           
function

	WUFileRequest_Record :=
	record
		string                      Name      {xpath('Name'      )} := pName       ;
		string                      Wuid      {xpath('Wuid'      )} := pWuid       ;
		string                      Type      {xpath('Type'      )} := pName       ;
		string                      Option    {xpath('Option'    )} := pOption     ;
		string                      SizeLimit {xpath('SizeLimit' )} := pSizeLimit  ;
	end;

	eclAttribute_Layout :=
	record, maxlength(500)
	
		string	name			{xpath('@key'		      )};
		string 	path  		{xpath('@sourcePath'	)};
		string 	ecl 			{xpath('<>'			      )};
	
	end;
	
	eclModule_Layout :=
	record, maxlength(500)
	
		string	key			{xpath('@key'		)};
		string 	name    {xpath('@name'	)};
	  dataset(eclAttribute_Layout  ) Attributes     {xpath('Attribute'         )};
	
	end;

	// WUFileResponse_Record :=
	// record	
  
		// string exception_code     {xpath('Exceptions/Exception/Code'    )};
		// string exception_source   {xpath('Exceptions/Exception/Source'  )};
		// string exception_audience {xpath('Exceptions/Exception/Audience')};
		// string exception_msg      {xpath('Exceptions/Exception/Message' )};

	  // dataset(eclModule_Layout  ) Modules     {xpath('Archive/Module'         )};
	
	// end;

	WUFileResponse_Record :=
	record	
  
		string exception_code     {xpath('Exceptions/Exception/Code'    )};
		string exception_source   {xpath('Exceptions/Exception/Source'  )};
		string exception_audience {xpath('Exceptions/Exception/Audience')};
		string exception_msg      {xpath('Exceptions/Exception/Message' )};

	  string Modules     {xpath('thefile'         )};
	
	end;

  esp				:= pesp + ':8010';

  import ut,Workman;
  
  #UNIQUENAME(SOAPCALLCREDENTIALS)
  #SET(SOAPCALLCREDENTIALS  ,ut.Credentials().mac_add2Soapcall())

  results := SOAPCALL(
    'http://' + esp + '/WsWorkunits?form&ver_=1.69'
    // 'http://' + esp + '/WsWorkunits'
    ,'WUFile'
    ,WUFileRequest_Record
    ,dataset(WUFileResponse_Record)
    // ,heading('<WUInfoRequest>','</WUInfoRequest>')
    ,xpath('WULogFileResponse')
    ,Literal
    // ,RETRY(pRetryCount)
    // ,TIMEOUT(pTimeOut)
    // ,TIMELIMIT(pTimeLimit)
  );
  
  results_remote := SOAPCALL(
    'http://' + esp + '/WsWorkunits?form&ver_=1.69'
    // 'http://' + esp + '/WsWorkunits'
    ,'WUFile'
    ,WUFileRequest_Record
    ,dataset(WUFileResponse_Record)
    // ,heading('<WUInfoRequest>','</WUInfoRequest>')
    ,xpath('WULogFileResponse')
    ,Literal
    // ,RETRY(pRetryCount)
    // ,TIMEOUT(pTimeOut)
    // ,TIMELIMIT(pTimeLimit)
    %SOAPCALLCREDENTIALS%
  );

  returnresult := iff(trim(pesp) in Workman._Config.LocalEsps ,results  ,results_remote);
  
  return returnresult;
  
end;
