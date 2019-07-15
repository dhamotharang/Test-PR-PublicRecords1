import tools,_control,ut;

export mac_wait(

   string pWorkunit
  ,string pNotifyEvent        = ''  
  ,string pNotifyEmails       = WorkMan._Config.EmailAddressNotify
  ,string pPollingFrequency   = '1'                              //in minutes.  So 5 means poll every 5 minutes.

) :=
function

  dPollingFrequency := '5';
  
  cronFreq        := CRON('0-59/' + dPollingFrequency + ' * * * *');
  emails          := pNotifyEmails;
  watchworkunit   := pWorkunit;

  getstate    := trim(WorkMan.get_State(watchworkunit),left,right);
  realstate   := if(getstate[1..6] = 'failed' ,'failed' ,getstate);
  realjobname := trim(WorkMan.get_Jobname(watchworkunit));
  jobname     := if(realjobname = ''  ,watchworkunit  ,realjobname + ' (' + watchworkunit + ')');
  totalthortime := WorkMan.get_TotalTime(watchworkunit);
  
/*  sendemail := WorkMan.Send_Email(
                             emails
                            ,jobname + ' has ' + realstate + ' on ' + _Control.ThisEnvironment.Name + ' on this date: ' + WorkMan.getTimeDate()
                            ,watchworkunit + ' ' + if(realjobname != '',realjobname,'') + '\n' + getstate + ' with Total thor time of: ' + totalthortime
                          );
*/
  dothis := sequential(
     output(pWorkunit + if(regexfind('ing',realstate,nocase) ,' is ',' has ') + getstate + ' on ' + WorkMan.getTimeDate())
    ,iff(realstate = 'completed' or realstate = 'failed' or realstate = 'aborted'  ,sequential(notify(pNotifyEvent, '*'),FAIL('Watcher stopped, Notify event has been triggered because wuid ' + pWorkunit + ' has ' + realstate + ' on ' + WorkMan.getTimeDate() + ' with this error: ' + getstate)))
  );
  
  dothis : WHEN(cronFreq);
  
  return dothis;

end;
