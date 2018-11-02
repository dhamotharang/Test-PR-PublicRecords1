// need to call WsWorkunits.soapcall_WUUpdate first to get the wuid to submit
EXPORT soapcall_WUSubmit(

   string  pWUID
  ,string  pcluster
  ,string  pESP               = WsWorkunits._Config.LocalEsp
  ,string  pESPPort           = '8010'

) := 
function

  rWUSubmitRequest  :=
  record
    string                    WUID        {xpath('Wuid'                 ),maxlength(20)}  :=  pWUID   ;
    string                    Cluster     {xpath('Cluster'              ),maxlength(30)}  :=  pCluster;
    string                    Queue       {xpath('Queue'                ),maxlength(30)}  :=  pCluster;
    string                    Snapshot    {xpath('Snapshot'             ),maxlength(10)}  :=  ''      ;
    string                    MaxRunTime  {xpath('MaxRunTime'           ),maxlength(10)}  :=  '0'     ;
    string                    Block       {xpath('BlockTillFinishTimer' ),maxlength(10)}  :=  '0'     ;
  end;

  rWUSubmitResponse  :=
  record
    string                    Code      {xpath('Code'     ),maxlength(10  )};
    string                    Audience  {xpath('Audience' ),maxlength(50  )};
    string                    Source    {xpath('Source'   ),maxlength(30  )};
    string                    Message   {xpath('Message'  ),maxlength(200 )};
  end;

  dWUSubmitResult  :=  
    soapcall(
       'http://' + pESP + ':' + pESPPort + '/WsWorkunits'
      ,'WUSubmit'
      ,rWUSubmitRequest
      ,rWUSubmitResponse
      ,xpath('WUSubmitResponse/Exceptions/Exception')
    );

  return  dWUSubmitResult;

end;