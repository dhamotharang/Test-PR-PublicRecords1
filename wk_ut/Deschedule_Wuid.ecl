EXPORT Deschedule_Wuid(

   string                      pWuid
  ,string                      pesp                     = wk_ut._constants.LocalEsp
  ,unsigned                    pRetryCount              = 3
  ,real                        pTimeOut                 = 300.0                     //5 minutes
  ,real                        pTimeLimit               = 0.0                       //no total limit
  
) := output(wk_ut.do_WUAction(dataset([{pWuid}],wk_ut.layouts.WuidItems),'Deschedule',pesp,pRetryCount,pTimeOut,pTimeLimit));