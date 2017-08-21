import tools,wk_ut;

EXPORT proc_Watch_This_Workunit(

   pversion
  ,pWuid
	,pESP							    = 'wk_ut._constants.localesp'	// ESP server & port for your environment(for soapcalls).  Boca OSS dataland is '10.241.3.242:8145'
  ,pCluster             = '\'\''

) :=
functionmacro

  Cluster  := map(pCluster != ''                                    => pCluster                      
                 ,wk_ut._constants.Esp2Hthor(pESP)
              );

  import BIPV2,tools,BizLinkFull,wk_ut,bipv2_build;

  ECL   := '#workunit(\'name\',\'BIPV2_Build.proc_Watch_This_Workunit ' + pversion + '\');\n' + 'wk_ut.mac_wait_Email(\'' + pWuid + '\');';
  
  createworkunit := wk_ut.CreateWuid(ecl,trim(Cluster),pESP) ; // add independent so that they don\'t get reevalulated each time they are accessed'
  
  return output(createworkunit ,named('WatcherWuid4FullBuild'));
  
endmacro;