import tools,_control,ut;
/*

  wait for multiple wuids to finish(completed,failed or aborted).  All have to finish before this will notify the master workunit
  use template language to generate code for each wuid in the set

*/
export mac_NotifyMulti(

   pSetWorkunits
  ,pNotifyEvent      
  ,pNotifyEmails       = 'wk_ut._Constants.EmailAddressNotify'
  ,pPollingFrequency   = '\'5\''                              // in minutes.  So 5 means poll every 5 minutes.
	,pESP							   = 'wk_ut._Constants.LocalEsp'	        // ESP server & port for your environment(for soapcalls).  Boca OSS dataland is '10.241.3.242'

) :=
functionmacro

  import tools,_control,ut;

  dPollingFrequency := pPollingFrequency;
  
  cronFreq        := CRON('0-59/' + dPollingFrequency + ' * * * *');
  emails          := pNotifyEmails;
  // watchworkunit   := pWorkunit;

  dnormset      := normalize(dataset([{''}],{string junk}),count(pSetWorkunits),transform({string wuid},self.wuid := pSetWorkunits[counter]))(wuid != '');
  dGetWuidsInfo := project(dnormset,transform({string wuid,string state,string realstate,string realstate2,string realjobname,string jobname,string total_thor_time,string timestamp},
    self.wuid             := left.wuid;
    self.state            := trim(wk_ut.get_State(left.wuid),left,right);
    self.realstate        := if(self.state[1..6] = 'failed' ,'failed' ,self.state);
    self.realstate2       := if(trim(wk_ut.get_State(left.wuid),left,right)[1..6] = 'failed' ,'failed' ,trim(wk_ut.get_State(left.wuid),left,right));//do it twice to make sure
    self.realjobname      := trim(wk_ut.get_Jobname(left.wuid));
    self.jobname          := if(self.realjobname = ''  ,left.wuid  ,self.realjobname + ' (' + left.wuid + ')');
    self.total_thor_time  := wk_ut.get_TotalTime(left.wuid,,true);  
    self.timestamp        := wk_ut.getTimeDate();
  ));
  
  // getstate      := trim(wk_ut.get_State(watchworkunit),left,right);
  // realstate     := if(getstate[1..6] = 'failed' ,'failed' ,getstate);
  // realjobname   := trim(wk_ut.get_Jobname(watchworkunit));
  // jobname       := if(realjobname = ''  ,watchworkunit  ,realjobname + ' (' + watchworkunit + ')');
  // totalthortime := wk_ut.get_TotalTime(watchworkunit);                                                  
  
  IsEspLocal := if(   pESP in wk_ut._Constants.LocalEsps
                    ,true
                    ,false
                );
                
  doNotify := if(IsEspLocal ,notify(pNotifyEvent, '*')
                            ,wk_ut.Remote_Notify(pNotifyEvent,pESP)
  );

  AreAllWuidsFinished := count(dGetWuidsInfo) = count(dGetWuidsInfo(   (realstate  = 'completed' or realstate  = 'failed' or realstate  = 'aborted')
                                                                   and (realstate2 = 'completed' or realstate2 = 'failed' or realstate2 = 'aborted')));

  

  dothis := sequential(
     output(dGetWuidsInfo                       ,named('WorkunitInfo'),overwrite)
    ,output('Checked on ' + wk_ut.getTimeDate() ,named('LastChecked' ),overwrite)
    ,iff(AreAllWuidsFinished = true
      ,sequential(doNotify,FAIL('Watcher stopped, Notify event has been triggered because wuids have completed/failed/aborted on ' + wk_ut.getTimeDate() + ' with this errors: ' /*+ getstate*/)))
  );
  
  // dothis ;
  dothis : WHEN(cronFreq);
  
  return dothis;

endmacro;
