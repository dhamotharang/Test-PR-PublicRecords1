import tools,_control,ut;

export mac_wait(

   string pWorkunit
  ,string pNotifyEvent        = ''  
  ,string pNotifyEmails       = _control.MyInfo.EmailAddressNotify
  ,string pPollingFrequency   = '1'                              //in minutes.  So 5 means poll every 5 minutes.

) :=
function

  dPollingFrequency := '5';
  
  cronFreq        := CRON('0-59/' + dPollingFrequency + ' * * * *');
  emails          := pNotifyEmails;
  watchworkunit   := pWorkunit;

  getstate    := trim(wk_ut_dev.get_WUInfo(watchworkunit).State,left,right);
  realstate   := if(getstate[1..6] = 'failed' ,'failed' ,getstate);
  realjobname := trim(wk_ut_dev.get_WUInfo(watchworkunit).JobName);
  jobname     := if(realjobname = ''  ,watchworkunit  ,realjobname + ' (' + watchworkunit + ')');
  totalthortime := wk_ut_dev.get_TotalTime(watchworkunit);
  
/*  sendemail := wk_ut_dev.Send_Email(
                             emails
                            ,jobname + ' has ' + realstate + ' on ' + _Control.ThisEnvironment.Name + ' on this date: ' + ut.GetTimeDate()
                            ,watchworkunit + ' ' + if(realjobname != '',realjobname,'') + '\n' + getstate + ' with Total thor time of: ' + totalthortime
                          );
*/
  dothis := sequential(
     output(pWorkunit + if(regexfind('ing',realstate,nocase) ,' is ',' has ') + getstate + ' on ' + ut.GetTimeDate())
    ,iff(realstate = 'completed' or realstate = 'failed' or realstate = 'aborted'  ,sequential(notify(pNotifyEvent, '*'),FAIL('Watcher stopped, Notify event has been triggered because wuid ' + pWorkunit + ' has ' + realstate + ' on ' + ut.GetTimeDate() + ' with this error: ' + getstate)))
  );
  
  dothis : WHEN(cronFreq);
  
  return dothis;

end;
