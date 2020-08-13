﻿EXPORT Wuid_Protect(

   string                      pWuid
  ,string                      pesp                     = WsWorkunits._Config.LocalEsp
  ,unsigned                    pRetryCount              = 3
  ,real                        pTimeOut                 = 300.0                     //5 minutes
  ,real                        pTimeLimit               = 0.0                       //no total limit
  
) := WsWorkunits.soapcall_WUAction(dataset([{pWuid}],WsWorkunits.layouts.WuidItems),'Protect',pesp,pRetryCount,pTimeOut,pTimeLimit);