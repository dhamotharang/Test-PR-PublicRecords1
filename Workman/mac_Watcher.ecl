import tools,_control,ut,WorkMan,std;

export mac_Watcher(

   pWorkunit
  ,pNotifyEvent      
  ,pNotifyEmails       = 'WorkMan._Config.EmailAddressNotify'
  ,pPollingFrequency   = '\'5\''                                // in minutes.  So 5 means poll every 5 minutes.
	,pESP							   = 'WorkMan._Config.localesp'                	// ESP server & port for your environment(for soapcalls).  Boca OSS dataland is '10.241.3.242'

) :=
functionmacro

  import tools,_control,ut,WorkMan;

  dPollingFrequency := pPollingFrequency;
  
  cronFreq        := CRON('0-59/' + dPollingFrequency + ' * * * *');
  emails          := pNotifyEmails;
  watchworkunit   := pWorkunit;
  
  gettimescalled  := WorkMan.get_Scalar_Result(workunit,'Times_Called'); 
  getstate        := trim(WorkMan.get_State(pWorkunit),left,right); 
  realstate       := if(getstate[1..6] = 'failed' ,'failed' ,getstate);
  // realjobname   := trim(WorkMan.get_Jobname(watchworkunit));
  // jobname       := if(realjobname = ''  ,watchworkunit  ,realjobname + ' (' + watchworkunit + ')');
  // totalthortime := WorkMan.get_TotalTime(watchworkunit);
  
  IsEspLocal := if(   pESP in WorkMan._Config.LocalEsps
                    ,true
                    ,false
                );
  
  emailsubject := 'Workman: Watcher ' + workunit + ' failed without notifying the Childrunner.\n';
  emailbody    := 'Please notify the childrunner using the following link and it will kick off another watcher:\n'
                  + WorkMan.Push_Event_Result_Link(pNotifyEvent,'*',pESP)
                  ;

  send_email_ := WorkMan.Send_Email(pNotifyEmails,EmailSubject,EmailBody);
              
  doNotify := if(IsEspLocal ,notify(pNotifyEvent, '*')
                            ,WorkMan.Remote_Notify(pNotifyEvent,pESP)
  )
  // : FAILURE(send_email_)
  ;
 // :FAILURE(WorkMan.Clone_Thyself(,,,,emailsubject,emailbody)); //not ready for prime time.  causes weird issues of notifying the childrunner even though the wuid is not finished.  more investigation needed here before putting it back in
  ;
  output_state := parallel(
     output('This watcher workunit runs in the cron every ' + pPollingFrequency + ' minutes.' ,named('Cron_Frequency'),overwrite)
    ,output('<a href="' + WorkMan.Push_Event_Result_Link(pNotifyEvent,'*',pESP) +  '">Notify_Childrunner</a>' ,named('Notify_Childrunner__html'),overwrite)
    ,output(pWorkunit             ,named('Workunit'),overwrite)
    ,output(getstate              ,named('State'   ),overwrite)
    ,output(WorkMan.getTimeDate() ,named('Time'    ),overwrite)
    ,output((unsigned)gettimescalled + 1              ,named('Times_Called'   ),overwrite)
    ,output('false'               ,named('Is_Mission_Accomplished'),overwrite)
    // ,fail('test fail')
  )
  // : FAILURE(send_email_)
  ;
  // : FAILURE(WorkMan.Clone_Thyself(,,,,emailsubject,emailbody));
    ;
  completed_condition := trim(pWorkunit) = '' or
         (    (realstate = 'completed' or realstate = 'failed' or realstate = 'aborted' or realstate = 'unknown' or realstate = 'compiled')
          and (realstate = 'completed' or realstate = 'failed' or realstate = 'aborted' or realstate = 'unknown' or realstate = 'compiled')  
          and (realstate = 'completed' or realstate = 'failed' or realstate = 'aborted' or realstate = 'unknown' or realstate = 'compiled') //do it three times to make sure
         )
  // : FAILURE(send_email_)
  ;
         // :FAILURE(WorkMan.Clone_Thyself(,,,,emailsubject,emailbody));
         ;
  dothis := sequential(
     // STD.System.Debug.Sleep ( 60000 )  //used for testing so that it will wait a sec between test failures.  basically like a break in a loop to prevent runaway clones.
     output_state
    ,iff(completed_condition
      ,sequential(
         doNotify
        ,output('true',named('Is_Mission_Accomplished'),overwrite)
        ,FAIL('Watcher stopped, Notify event has been triggered because wuid ' + pWorkunit + ' has ' + realstate + ' on ' + WorkMan.getTimeDate() + if(realstate = 'failed' or realstate = 'aborted',' with this error: ' + getstate,''))
      )
    )
  );
  
  dothis : WHEN(cronFreq);
  
  return dothis;

endmacro;
