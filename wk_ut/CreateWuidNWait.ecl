import tools,ut,_control;
EXPORT CreateWuidNWait(

   string  ecl
  ,string  piteration
  ,string  pversion
  ,string  pcluster

  ,string  pESP               = _constants.LocalEsp
  ,string  pNotifyEmails      = wk_ut._Constants.EmailAddressNotify
  ,boolean pShouldEmail       = true
  ,string  pUniqueOutput      = ''
  ,string  pPollingFrequency  = '5'
  ,boolean pShouldWait        = true

) := 
function

  createworkunit1 := wk_ut.CreateWuid(
     ecl
    ,pcluster
    ,pESP
  ) ; // add independent so that they don't get reevalulated each time they are accessed
  #uniquename(workunitevent)

  watchercluster := if(pESP in _constants.DevEsps/*dataland*/,'infinband_hthor','hthor');
  localesp  := _constants.LocalEsp;
  
  createwatcherworkunit1 := wk_ut.CreateWuid(
     'wk_ut.mac_notify(\'' + createworkunit1 + '\',\'' + %'workunitevent'% + '\',\'' + pNotifyEmails + '\',\'' + pPollingFrequency + '\',\'' + localesp + '\');'
    ,watchercluster
    ,pESP
  ); // add independent so that they don't get reevalulated each time they are accessed

  createwatcherworkunit2 := wk_ut.CreateWuid(
     'wk_ut.mac_notify(\'' + createworkunit1 + '\',\'' + %'workunitevent'% + '\',\'' + pNotifyEmails + '\',\'' + pPollingFrequency + '\',\'' + localesp + '\');'
    ,watchercluster
    ,pESP
  ); // add independent so that they don't get reevalulated each time they are accessed

  wait4it1 := iff(pShouldWait = true  ,wait(event(%'workunitevent'%,'*')));
  
  getstate1       := wk_ut.get_State(createworkunit1,pESP);    
  realstate1      := if(getstate1[1..6] = 'failed' ,'failed' ,getstate1);

  result1 := sequential(
       output('______________________________________________________________________________')
      ,output(createworkunit1         ,named(pUniqueOutput + 'Iteration_'   + pversion + '_' + piteration))
      ,output(createwatcherworkunit1  ,named(pUniqueOutput + 'Watcher_for_' + pversion + '_' + piteration))
      ,output(%'workunitevent'%       ,named(pUniqueOutput + 'NotifyEvent_' + pversion + '_' + piteration))
      ,wait4it1
      ,output('done waiting at ' + wk_ut.getTimeDate())
      ,iff(getstate1 not in ['completed','failed','aborted']    // just in case it comes back immediately and it has not stopped running(running,compiling,submitted,etc)-- double check
        ,sequential(
           output(createwatcherworkunit2  ,named(pUniqueOutput + 'Watcher2_for_' + pversion + '_' + piteration))
          ,wait4it1
          ,output('done waiting at ' + wk_ut.getTimeDate())
      ))
  );
  
  thor_time1      := wk_ut.get_TotalTime(createworkunit1,pESP); 
  thor_time_secs  := wk_ut.Convert2Seconds(thor_time1);
  jobname1        := wk_ut.get_Jobname(createworkunit1,pESP);   
  Errors          := wk_ut.get_Errors(createworkunit1,pESP);
  
  thiswuid            := if(wk_ut.get_Scalar_Result(workunit       ,'Workunits') != '',wk_ut.get_DS_Result(workunit        ,'Workunits',wk_ut.layouts.wks_slim),dataset([],wk_ut.layouts.wks_slim));
  Run_Total_Time_secs := sum(thiswuid,Total_Time_secs) + thor_time_secs;
  Run_Total_Thor_Time := wk_ut.ConvertSecs2ReadableTime((real8)Run_Total_Time_secs);

  //name, wuid, iteration#, version, thor time, etc

  dWUDetails1 := dataset([{jobname1 ,createworkunit1 ,getstate1 ,piteration ,pversion ,thor_time1,thor_time_secs,Run_Total_Thor_Time,Run_Total_Time_secs,'',0.0,wk_ut.getTimeDate()}] ,layouts.wks_slim);
  jobname2 := if(jobname1 != '' ,jobname1 ,createworkunit1);
  sendemail1 := wk_ut.Send_Email(
                             pNotifyEmails
                            ,jobname2 + ' has ' + getstate1 + ' in ' + thor_time1 + ' on ' + _Control.ThisEnvironment.Name + ' on this date: ' + wk_ut.getTimeDate()
                            , if(jobname1 != ''
                            , 'Jobname        : ' + jobname1 + '\n','')
                            + 'workunit       : ' + createworkunit1 + '\n' 
                            + 'State          : ' + getstate1 + '\n'
                            + 'Total Thor Time: ' + thor_time1 + '\n'
                            + 'Iteration      : ' + piteration + '\n'
                            + 'Version        : ' + pversion + '\n'
                            + if(trim(Errors) != '' ,'FailMessage(s): \n' + Errors,'')
                          );

  childwuids := if(wk_ut.get_Scalar_Result(createworkunit1,'Workunits',pESP) != '' /*and pESP in _constants.LocalEsps*/,wk_ut.get_DS_Result(createworkunit1 ,'Workunits',wk_ut.layouts.wks_slim,pESP),dataset([],wk_ut.layouts.wks_slim));
  
  iterwuids  := iterate(project(childwuids,transform(recordof(left),self.Run_Total_Time_secs := left.Total_Time_secs,self := left)),transform(recordof(left)
    ,self.Run_Total_Time_secs := if(counter = 1,Run_Total_Time_secs,left.Run_Total_Time_secs) + right.Run_Total_Time_secs
    ,self.Run_Total_Thor_Time := wk_ut.ConvertSecs2ReadableTime((real8)self.Run_Total_Time_secs),self := right));


  doit :=  sequential(result1,output(dWUDetails1 + iterwuids,named('Workunits'),EXTEND),if(pShouldEmail ,sequential(sendemail1,iff(getstate1 in ['failed','aborted'] ,fail('Fail workunit because wuid ' + createworkunit1 + ' has ' + getstate1 + '.')))));
//  doit :=  iff(realstate1 = 'completed' ,sequential(output(dWUDetails1,named('Workunits'),EXTEND)/*,sendemail1*/) 
//          ,sequential(output('Attempted 3 times to get this iteration(' + piteration + ') to run, but it failed each time.' ),fail(''))
//            )));
 //         );
  return doit;

end;
