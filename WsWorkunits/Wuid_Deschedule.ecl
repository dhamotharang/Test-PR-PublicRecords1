EXPORT Wuid_Deschedule(

   string                      pWuid
  ,string                      pesp                     = WsWorkunits._Config.LocalEsp
  ,unsigned                    pRetryCount              = 3
  ,real                        pTimeOut                 = 300.0                     //5 minutes
  ,real                        pTimeLimit               = 0.0                       //no total limit
  
) := output(WsWorkunits.soapcall_WUAction(dataset([{pWuid}],WsWorkunits.layouts.WuidItems),'Deschedule',pesp,pRetryCount,pTimeOut,pTimeLimit));