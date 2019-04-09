
// creates a blank dummy wuid.  need to call WUUpdate followed by WUCreate to get it to compile or run.
EXPORT soapcall_WUCreate(

   string  pESP               = WsWorkunits._Config.LocalEsp
  ,string  pESPPort           = '8010'

) := 
function

  rWUCreateRequest  :=
  record
    string                    blank        {xpath('blank'                 ),maxlength(20)}  :=  ''   ;
  end;

  rESPExceptions  :=
  record
    string    Code      {xpath('Code'     ),maxlength(10 )};
    string    Audience  {xpath('Audience' ),maxlength(50 )};
    string    Source    {xpath('Source'   ),maxlength(30 )};
    string    Message   {xpath('Message'  ),maxlength(200)};
  end;

  rWUCreateResponse  :=
  record
    string                     Wuid       {xpath('Workunit/Wuid'          ),maxlength(20 )};
    dataset(rESPExceptions)    Exceptions {xpath('Exceptions/ESPException'),maxcount (110)};
  end;

  import ut,Workman;

  #UNIQUENAME(SOAPCALLCREDENTIALS)
  #SET(SOAPCALLCREDENTIALS  ,ut.Credentials().mac_add2Soapcall())

  dWUCreateResult  :=  
    soapcall(
       'http://' + pESP + ':' + pESPPort + '/WsWorkunits'
      ,'WUCreate'
      ,rWUCreateRequest
      ,rWUCreateResponse
      ,xpath('WUCreateResponse')
    );

  dWUCreateResult_remote  :=  
    soapcall(
       'http://' + pESP + ':' + pESPPort + '/WsWorkunits'
      ,'WUCreate'
      ,rWUCreateRequest
      ,rWUCreateResponse
      ,xpath('WUCreateResponse')
      %SOAPCALLCREDENTIALS%
   );

  returnresult := iff(trim(pesp) in Workman._Config.LocalEsps ,dWUCreateResult  ,dWUCreateResult_remote);

  return  returnresult;

end;