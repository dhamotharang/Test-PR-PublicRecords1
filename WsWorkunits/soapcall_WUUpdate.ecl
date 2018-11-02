EXPORT soapcall_WUUpdate(

   string                                     pECLText
  ,string                                     pESP               = WsWorkunits._Config.LocalEsp
  ,string                                     pESPPort           = '8010'
  ,dataset(WsWorkunits.Layouts.DebugValues)   pDebugValues       = dataset([],WsWorkunits.Layouts.DebugValues)
  ,string                                     pWuid              = ''   // for compiles, need to use WUCreate first, then pass in that wuid to this and use action 1.
  ,string                                     pAction            = ''   //action 1 is compile
                                                                        //action 2 is check
                                                                        //action 3 is run 
) := 
function

  rWUCreateAndUpdateRequest  :=
  record
    string                                    QueryText     {xpath('QueryText'              ),maxlength(20000)}   := pECLText       ;
    dataset(WsWorkunits.Layouts.DebugValues)  DebugValues   {xpath('DebugValues/DebugValue' ),maxlength(20000)}   := pDebugValues   ;
    string                                    Action        {xpath('Action'                 )                 }   := pAction        ;
    string                                    Wuid          {xpath('Wuid'                   )                 }   := pWuid          ;
  end;

  rESPExceptions  :=
  record
    string    Code      {xpath('Code'     ),maxlength(10 )};
    string    Audience  {xpath('Audience' ),maxlength(50 )};
    string    Source    {xpath('Source'   ),maxlength(30 )};
    string    Message   {xpath('Message'  ),maxlength(200)};
  end;

  rWUCreateAndUpdateResponse  :=
  record
    string                     Wuid       {xpath('Workunit/Wuid'          ),maxlength(20 )};
    dataset(rESPExceptions)    Exceptions {xpath('Exceptions/ESPException'),maxcount (110)};
  end;

  dWUCreateAndUpdateResult  :=  
    soapcall(
        'http://' + pESP + ':' + pESPPort + '/WsWorkunits'
       ,'WUUpdate'
       ,rWUCreateAndUpdateRequest
       ,rWUCreateAndUpdateResponse
       ,xpath('WUUpdateResponse')
    );

  return  dWUCreateAndUpdateResult;
  
end;
