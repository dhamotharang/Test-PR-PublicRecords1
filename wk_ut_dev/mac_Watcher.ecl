import tools,_control,ut,wk_ut_dev;

export mac_Watcher(

   pWorkunit
  ,pNotifyEvent      
  ,pNotifyEmails       = '_control.MyInfo.EmailAddressNotify'
  ,pPollingFrequency   = '\'5\''                                // in minutes.  So 5 means poll every 5 minutes.
	,pESP							   = 'wk_ut_dev._constants.localesp'                	// ESP server & port for your environment(for soapcalls).  Boca OSS dataland is '10.241.3.242'

) :=
functionmacro

  import tools,_control,ut,wk_ut_dev;

  dPollingFrequency := pPollingFrequency;
  
  cronFreq        := CRON('0-59/' + dPollingFrequency + ' * * * *');
  emails          := pNotifyEmails;
  watchworkunit   := pWorkunit;

  getstate      := trim(wk_ut_dev.get_WUInfo(watchworkunit).State_nofail,left,right); //use nofail because even if soapcall fails, don't want to fail this workunit.  Just try again according to cronfreq
  realstate     := if(getstate[1..6] = 'failed' ,'failed' ,getstate);
  // realjobname   := trim(wk_ut_dev.get_Jobname(watchworkunit));
  // jobname       := if(realjobname = ''  ,watchworkunit  ,realjobname + ' (' + watchworkunit + ')');
  // totalthortime := wk_ut_dev.get_TotalTime(watchworkunit);
  
  IsEspLocal := if(   pESP in wk_ut_dev._constants.LocalEsps
                    ,true
                    ,false
                );
                
  doNotify := if(IsEspLocal ,notify(pNotifyEvent, '*')
                            ,wk_ut_dev.Remote_Notify(pNotifyEvent,pESP)
  );

  dothis := sequential(
     output(pWorkunit + if(regexfind('ing',realstate,nocase) ,' is ',' has ') + getstate + ' on ' + ut.GetTimeDate(),named('State'),overwrite)
    ,iff(   (realstate = 'completed' or realstate = 'failed' or realstate = 'aborted')
        and (realstate = 'completed' or realstate = 'failed' or realstate = 'aborted')  
        and (realstate = 'completed' or realstate = 'failed' or realstate = 'aborted')  //do it three times to make sure
      ,sequential(doNotify,FAIL('Watcher stopped, Notify event has been triggered because wuid ' + pWorkunit + ' has ' + realstate + ' on ' + ut.GetTimeDate() + if(realstate = 'failed' or realstate = 'aborted',' with this error: ' + getstate,''))))
  );
  
  dothis : WHEN(cronFreq);
  
  return dothis;

endmacro;
