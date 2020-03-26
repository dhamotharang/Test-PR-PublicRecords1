/*
  WUAction can restore archived workunits
  <WUActionRequest>
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
  </WUActionRequest>

  Possible actions:
   <ActionType>Restore</ActionType>
   <ActionType>Protect</ActionType>
   <ActionType>Unprotect</ActionType>

  Example calls:
WorkMan.do_WUAction(dataset([{'W20140116-153630'}],WorkMan.layouts.WuidItems),'Abort');
WorkMan.do_WUAction(dataset([{'W20140116-153630'}],WorkMan.layouts.WuidItems),'Protect');
WorkMan.do_WUAction(dataset([{'W20140116-153630'}],WorkMan.layouts.WuidItems),'Restore');
WorkMan.do_WUAction(dataset([{'W20140116-153630'}],WorkMan.layouts.WuidItems),'Unprotect');
WorkMan.do_WUAction(dataset([{'W20140116-153630'}],WorkMan.layouts.WuidItems),'Deschedule');
*/
import _control;
// #option('maxLength', 131072); // have to increase for the remote directory child datasets
//////////////////////////////////////////////////////////////////////////////////////////////
export soapcall_WUAction(
   dataset(layouts.WuidItems)  pWuids                   
  ,string                      pActionType                         
  ,string                      pesp                     = WsWorkunits._Config.LocalEsp
  ,unsigned                    pRetryCount              = 3
  ,real                        pTimeOut                 = 300.0 //5 minutes
  ,real                        pTimeLimit               = 0.0   //no total limit

  ,string                      pCluster                 = ''
  ,string                      pOwner                   = ''
  ,string                      pState                   = ''
  ,string                      pStartDate               = ''    
  ,string                      pEndDate                 = ''
  ,string                      pECL                     = ''
  ,string                      pJobname                 = ''
  ,string                      pTest                    = ''
  ,string                      pCurrentPage             = ''
  ,string                      pPageSize                = ''
  ,string                      pSortby                  = ''
  ,string                      pDescending              = '0'
  ,string                      pEventServer             = ''
  ,string                      pEventName               = ''
  ,string                      pPageFrom                = ''
  ,string                      pBlockTillFinishTimer    = '0'
  
) :=                           
function

	WUActionRequest_Record :=
	record
  	dataset(layouts.WuidItems)  Wuids                {xpath('Wuids'                )} := pWuids                   ;
		string                      ActionType           {xpath('ActionType'           )} := pActionType              ;
		string                      Cluster              {xpath('Cluster'              )} := pCluster                 ;
		string                      Owner                {xpath('Owner'                )} := pOwner                   ;
		string                      State                {xpath('State'                )} := pState                   ;
		string                      StartDate            {xpath('StartDate'            )} := pStartDate               ;
		string                      EndDate              {xpath('EndDate'              )} := pEndDate                 ;
		string                      ECL                  {xpath('ECL'                  )} := pECL                     ;
		string                      Jobname              {xpath('Jobname'              )} := pJobname                 ;
		string                      Test                 {xpath('Test'                 )} := pTest                    ;
		string                      CurrentPage          {xpath('CurrentPage'          )} := pCurrentPage             ;
		string                      PageSize             {xpath('PageSize'             )} := pPageSize                ;
		string                      Sortby               {xpath('Sortby'               )} := pSortby                  ;
		string                      Descending           {xpath('Descending'           )} := pDescending              ;
		string                      EventServer          {xpath('EventServer'          )} := pEventServer             ;
		string                      EventName            {xpath('EventName'            )} := pEventName               ;
		string                      PageFrom             {xpath('PageFrom'             )} := pPageFrom                ;
		string                      BlockTillFinishTimer {xpath('BlockTillFinishTimer' )} := pBlockTillFinishTimer    ;
	end;
	
	WUActionResponse_Record :=
	record	
  
		string exception_code     {xpath('Exceptions/Exception/Code'    )};
		string exception_source   {xpath('Exceptions/Exception/Source'  )};
		string exception_audience {xpath('Exceptions/Exception/Audience')};
		string exception_msg      {xpath('Exceptions/Exception/Message' )};
	
	end;

  esp				:= pesp + ':8010';

  import ut,Workman;
  
  #UNIQUENAME(SOAPCALLCREDENTIALS)
  #SET(SOAPCALLCREDENTIALS  ,ut.Credentials().mac_add2Soapcall())

  results := SOAPCALL(
    'http://' + esp + '/WsWorkunits?ver_=1.48'
    // 'http://' + esp + '/WsWorkunits'
    ,'WUAction'
    ,WUActionRequest_Record
    ,dataset(WUActionResponse_Record)
    // ,heading('<WUInfoRequest>','</WUInfoRequest>')
    ,xpath('WUActionResponse')
    ,RETRY(pRetryCount)
    ,TIMEOUT(pTimeOut)
    ,TIMELIMIT(pTimeLimit)
  );
  
  results_remote := SOAPCALL(
    'http://' + esp + '/WsWorkunits?ver_=1.48'
    // 'http://' + esp + '/WsWorkunits'
    ,'WUAction'
    ,WUActionRequest_Record
    ,dataset(WUActionResponse_Record)
    // ,heading('<WUInfoRequest>','</WUInfoRequest>')
    ,xpath('WUActionResponse')
    ,RETRY(pRetryCount)
    ,TIMEOUT(pTimeOut)
    ,TIMELIMIT(pTimeLimit)
    %SOAPCALLCREDENTIALS%
  );

  returnresult := iff(trim(pesp) in Workman._Config.LocalEsps ,results  ,results_remote);
  
  return returnresult;
  
end;
