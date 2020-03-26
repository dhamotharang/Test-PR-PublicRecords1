import tools,_control,ut,WorkMan,std;

export mac_Watcher(

   pWorkunit
  ,pNotifyEvent      
  ,pNotifyEmails       = 'WorkMan._Config.EmailAddressNotify'
  ,pPollingFrequency   = '\'5\''                                // in minutes.  So 5 means poll every 5 minutes.
	,pESP							   = 'WorkMan._Config.localesp'                	// ESP server & port for your environment(for soapcalls).  Boca OSS dataland is '10.241.3.242'
  ,pCompiling          = 'false'

) :=
functionmacro

  import tools,_control,ut,WorkMan;

  dPollingFrequency := pPollingFrequency;
  
  cronFreq        := CRON('0-59/' + dPollingFrequency + ' * * * *');
  emails          := pNotifyEmails;
  watchworkunit   := pWorkunit;
  
  wuinfo := WsWorkunits.WUInfo_Attributes(pWorkunit);
  
  
  gettimescalled  := WorkMan.get_Scalar_Result(workunit,'Times_Called'); 
  // gettimescalled  := wuinfo.scalar_result('Times_Called'); 
  getstate        := trim(wuinfo.state,left,right) ;//: independent;
  // getstate        := trim(WorkMan.get_State(pWorkunit),left,right); 
  realstate       := if(getstate[1..6] = 'failed' ,'failed' ,getstate);

  get_state_list  := STD.System.Workunit.WorkunitList (pWorkunit,pWorkunit)[1].state;
  get_state_soap  := wuinfo.state                              ;
  // get_state_soap  := WsWorkunits.Get_State            (pWorkunit,pesp     )         ;

  
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
     output('This watcher workunit runs in the cron every ' + pPollingFrequency + ' minute' + if((unsigned)pPollingFrequency > 1  ,'s.' ,'.') ,named('Cron_Frequency'),overwrite)
    ,output('<a href="' + WorkMan.Push_Event_Result_Link(pNotifyEvent,'*',pESP) +  '">Notify_Childrunner</a>' ,named('Notify_Childrunner__html'),overwrite)
    ,output(pWorkunit             ,named('Workunit'),overwrite)
    ,output(get_state_list        ,named('State_List'   ),overwrite)
    ,output(get_state_soap        ,named('State_Soap'   ),overwrite)
    ,output(WorkMan.getTimeDate() ,named('Time'    ),overwrite)
    ,output((unsigned)gettimescalled + 1              ,named('Times_Called'   ),overwrite)
    ,output('false'               ,named('Is_Mission_Accomplished'),overwrite)
    // ,fail('test fail')
  )
  // : FAILURE(send_email_)
  ;
  // : FAILURE(WorkMan.Clone_Thyself(,,,,emailsubject,emailbody));
    ;
  #IF(pCompiling = true)
  set_completed_states := ['completed' ,'failed' ,'aborted' ,'unknown' ,'compiled'];
  #ELSE
  set_completed_states := ['completed' ,'failed' ,'aborted' ,'unknown' ];
  #END
  
  completed_condition :=    trim(pWorkunit) = '' or
                      (     get_state_list  = get_state_soap 
                        and get_state_list in set_completed_states 
                        and get_state_soap in set_completed_states
                      )
  ;       

  // completed_condition := trim(pWorkunit) = '' or
         // (    (realstate = 'completed' or realstate = 'failed' or realstate = 'aborted' or realstate = 'unknown' or realstate = 'compiled')
          // and (realstate = 'completed' or realstate = 'failed' or realstate = 'aborted' or realstate = 'unknown' or realstate = 'compiled')  
          // and (realstate = 'completed' or realstate = 'failed' or realstate = 'aborted' or realstate = 'unknown' or realstate = 'compiled') //do it three times to make sure
         // )
  // : FAILURE(send_email_)
  // ;
         // :FAILURE(WorkMan.Clone_Thyself(,,,,emailsubject,emailbody));
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
