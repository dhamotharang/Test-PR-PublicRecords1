import tools,_control,ut,wk_ut;

export mac_Watcher(

   pWorkunit
  ,pNotifyEvent      
  ,pNotifyEmails       = 'wk_ut._Constants.EmailAddressNotify'
  ,pPollingFrequency   = '\'5\''                                // in minutes.  So 5 means poll every 5 minutes.
  ,pESP                = 'wk_ut._constants.localesp'                  // ESP server & port for your environment(for soapcalls).  Boca OSS dataland is '10.241.3.242'

) :=
functionmacro

  import tools,_control,ut,wk_ut;

  dPollingFrequency := pPollingFrequency;
  
  cronFreq        := CRON('0-59/' + dPollingFrequency + ' * * * *');
  emails          := pNotifyEmails;
  watchworkunit   := pWorkunit;

  getstate      := trim(wk_ut.get_WUInfo(watchworkunit).State_nofail,left,right); //use nofail because even if soapcall fails, don't want to fail this workunit.  Just try again according to cronfreq
  realstate     := if(getstate[1..6] = 'failed' ,'failed' ,getstate);
  // realjobname   := trim(wk_ut.get_Jobname(watchworkunit));
  // jobname       := if(realjobname = ''  ,watchworkunit  ,realjobname + ' (' + watchworkunit + ')');
  // totalthortime := wk_ut.get_TotalTime(watchworkunit);
  
  IsEspLocal := if(   pESP in wk_ut._constants.LocalEsps
                    ,true
                    ,false
                );
                
  doNotify := if(IsEspLocal ,notify(pNotifyEvent, '*')
                            ,wk_ut.Remote_Notify(pNotifyEvent,pESP)
  );

  dothis := sequential(
     output(pWorkunit + if(regexfind('ing',realstate,nocase) ,' is ',' has ') + getstate + ' on ' + wk_ut.getTimeDate(),named('State'),overwrite)
    ,iff(pWorkunit = '' or
       (    (realstate = 'completed' or realstate = 'failed' or realstate = 'aborted' or realstate = 'unknown')
        and (realstate = 'completed' or realstate = 'failed' or realstate = 'aborted' or realstate = 'unknown')  
        and (realstate = 'completed' or realstate = 'failed' or realstate = 'aborted' or realstate = 'unknown') //do it three times to make sure
       )
      ,sequential(doNotify,FAIL('Watcher stopped, Notify event has been triggered because wuid ' + pWorkunit + ' has ' + realstate + ' on ' + wk_ut.getTimeDate() + if(realstate = 'failed' or realstate = 'aborted',' with this error: ' + getstate,''))))
  );
  
  dothis : WHEN(cronFreq);
  
  return dothis;

endmacro;
