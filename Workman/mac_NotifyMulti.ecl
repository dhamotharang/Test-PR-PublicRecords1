import tools,_control,ut;
/*

  wait for multiple wuids to finish(completed,failed or aborted).  All have to finish before this will notify the master workunit
  use template language to generate code for each wuid in the set

*/
export mac_NotifyMulti(

   pDs_Workunits                                              //expects dataset with layout {string wuid,string esp}
  ,pNotifyEvent      
  ,pNotifyEmails       = 'WorkMan._Config.EmailAddressNotify'
  ,pPollingFrequency   = '\'5\''                              // in minutes.  So 5 means poll every 5 minutes.
	,pESP							   = 'WorkMan._Config.LocalEsp'	        // ESP server & port for your environment(for soapcalls).  Boca OSS dataland is '10.241.3.242'

) :=
functionmacro

  import tools,_control,ut;

  dPollingFrequency := pPollingFrequency;
  
  cronFreq        := CRON('0-59/' + dPollingFrequency + ' * * * *');
  emails          := pNotifyEmails;
  // watchworkunit   := pWorkunit;

  // dnormset      := normalize(dataset([{''}],{string junk}),count(pDs_Workunits),transform({string wuid},self.wuid := pDs_Workunits[counter]))(wuid != '');
  dGetWuidsInfo := project(pDs_Workunits(wuid != ''),transform({string wuid,string esp,string state,string realstate,string realstate2,string realjobname,string jobname,string total_thor_time,string timestamp},
    self.wuid             := left.wuid;
    self.esp              := left.esp;
    self.state            := trim(WorkMan.get_State(left.wuid,left.esp),left,right);
    self.realstate        := if(self.state[1..6] = 'failed' ,'failed' ,self.state);
    self.realstate2       := if(trim(WorkMan.get_State(left.wuid,left.esp),left,right)[1..6] = 'failed' ,'failed' ,trim(WorkMan.get_State(left.wuid,left.esp),left,right));//do it twice to make sure
    self.realjobname      := trim(WorkMan.get_Jobname(left.wuid,left.esp));
    self.jobname          := if(self.realjobname = ''  ,left.wuid  ,self.realjobname + ' (' + left.wuid + ')');
    self.total_thor_time  := WorkMan.get_TotalTime(left.wuid,left.esp,true);  
    self.timestamp        := WorkMan.getTimeDate();
  ));
  
  // getstate      := trim(WorkMan.get_State(watchworkunit),left,right);
  // realstate     := if(getstate[1..6] = 'failed' ,'failed' ,getstate);
  // realjobname   := trim(WorkMan.get_Jobname(watchworkunit));
  // jobname       := if(realjobname = ''  ,watchworkunit  ,realjobname + ' (' + watchworkunit + ')');
  // totalthortime := WorkMan.get_TotalTime(watchworkunit);                                                  
  
  IsEspLocal := if(   pESP in WorkMan._Config.LocalEsps
                    ,true
                    ,false
                );
                
  doNotify := if(IsEspLocal ,notify(pNotifyEvent, '*')
                            ,WorkMan.Remote_Notify(pNotifyEvent,pESP)
  );

  AreAllWuidsFinished := count(dGetWuidsInfo) = count(dGetWuidsInfo(   (realstate  = 'completed' or realstate  = 'failed' or realstate  = 'aborted' or realstate = 'unknown')
                                                                   and (realstate2 = 'completed' or realstate2 = 'failed' or realstate2 = 'aborted' or realstate = 'unknown')));

  

  dothis := sequential(
     output(dGetWuidsInfo                       ,named('WorkunitInfo'),overwrite)
    ,output('Checked on ' + WorkMan.getTimeDate() ,named('LastChecked' ),overwrite)
    ,iff(AreAllWuidsFinished = true
      ,sequential(doNotify,FAIL('Watcher stopped, Notify event has been triggered because wuids have completed/failed/aborted on ' + WorkMan.getTimeDate() + ' with this errors: ' /*+ getstate*/)))
  );
  
  // dothis ;
  dothis : WHEN(cronFreq);
  
  return dothis;

endmacro;
