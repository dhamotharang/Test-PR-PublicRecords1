/*
to test:
#workunit('name','Parent Wuid');
wk_ut_dev.RunWuid('#workunit(\'name\',\'Child Wuid\');\noutput(\'Hello There\');fail(\'Just fail for testing\');',1,'20140813',wk_ut_dev._Constants.Groupname('5'),'notifymastervent','wait4masterevent','Vern\'s Master Parent',pPollingFrequency := '1');

#workunit('name','Manual Notify Wuid');
//wk_ut_dev.mac_Notify('wait4masterevent','Rerun','Advice');
wk_ut_dev.mac_Notify('wait4masterevent','Skip','Advice');
//wk_ut_dev.mac_Notify('wait4masterevent','Fail','Advice');

so if the create wuids is not called in the sequential, it will not kick off any wuids.
if it is in the sequential, then it will kick it off each time this is run even though it is not called.

*/

import tools,ut,_control;
EXPORT RunWuid(

   pECL
  ,piteration
  ,pversion
  ,pcluster
  ,pNotifyEvent                                               //notify the master that you are done
  ,pWaitEvent                                                 //used in when clause.  the watcher wuid uses this to notify you that the iteration has completed/failed/aborted
  ,pParentWuid        = '\'\''
  ,pOutputFilename    = '\'\''                                // filename to output the workunits dataset to.  
  ,pOutputSuperfile   = '\'\''                                // superfile to add the above file to. 
  ,pESP               = 'wk_ut_dev._constants.LocalEsp'       //this esp is the esp of the workunit that kicked this off.  all wuids created by this wuid are local.  the notification done at the end will be to this esp.
  ,pNotifyEmails      = '_control.MyInfo.EmailAddressNotify'
  ,pShouldEmail       = 'true'
  ,pUniqueOutput      = '\'\''
  ,pPollingFrequency  = '\'5\''

) := 
functionmacro

  import tools;
  
  ECL := regexreplace('\\n',pECL,'\n');

  // ----------------------------------------------------------------------------------
  // -- #1 kick off wuid
  // ----------------------------------------------------------------------------------
  localesp        := wk_ut_dev._constants.LocalEsp;
  watchercluster  := wk_ut_dev._Constants.Esp2Hthor(localesp);

  createworkunit := wk_ut_dev.CreateWuid_Raw(
     ECL
    ,pcluster
    ,localesp
  ) ; 
  // #uniquename(workunitevent)
  
  try_Number    := (unsigned)wk_ut_dev.get_Scalar_Result(workunit,'Try_Number') + 1;

  StartFilename       := pOutputFilename + '___Start';  //make this unique
  StartFilenameTemp   := pOutputFilename + '___Start___Temp';  //make this unique

  DoesFileExist := pOutputFilename != '' and STD.File.FileExists(StartFilename) and try_Number = 2;
  
  StartExistingDataset    := dataset(StartFilename  ,wk_ut_dev.layouts.wks_slim ,flat,opt);
  child_wuid1     := StartExistingDataset[if(count(StartExistingDataset) = 0,1,count(StartExistingDataset))].wuid;

  Child_Wuid     := iff(STD.File.FileExists(StartFilename) and DoesFileExist  ,child_wuid1  ,wk_ut_dev.get_Scalar_Result(workunit ,pUniqueOutput + 'Iteration_'   + pversion + '_' + piteration));
 
  //use child wuid so it doesn't reevaluate it and create another workunit
  createwatcherworkunit := wk_ut_dev.CreateWuid_Raw(
     'wk_ut_dev.mac_Watcher(\'' + Child_Wuid + '\',\'' + pWaitEvent + '\',\'' + pNotifyEmails + '\',\'' + pPollingFrequency + '\',\'' + localesp + '\');'
    ,watchercluster
    ,localesp
  );

  clickablewuid  := '<a href="/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + Child_Wuid + '">' + Child_Wuid + '</a>';

  StartDataset  := dataset([{'',Child_Wuid,'',piteration,pversion,'',''}],wk_ut_dev.layouts.wks_slim);
  
  kick_Off_Child := sequential(
       // output('______________________________________________________________________________')
       output(try_Number             ,named('Try_Number'                                                ),overwrite)
      ,output('Kicked Off Iteration' ,named('LastWork'                                                  ),overwrite)
      ,output(iff(DoesFileExist ,Child_Wuid ,createworkunit  )       ,named(pUniqueOutput + 'Iteration_'   + pversion + '_' + piteration           ),overwrite)
      ,output(clickablewuid          ,named(pUniqueOutput + 'Iteration_'   + pversion + '_' + piteration + '__html'),overwrite)

      // wk_ut_dev.Update_File('~temp::lbentley::wk_ut_dev.Update_File::testing',dme);

      ,if(pOutputFilename != '' and not DoesFileExist ,wk_ut_dev.Update_File(StartFilename,StartExistingDataset + StartDataset,false,true))
      // ,if(pOutputFilename != '' and not DoesFileExist ,sequential(tools.macf_WriteFile(StartFilenameTemp,StartDataset,false,false,true),if(STD.File.FileExists(StartFilename),fileservices.deletelogicalfile(StartFilename)),fileservices.RenameLogicalFile(StartFilenameTemp,StartFilename)))
      ,output(createwatcherworkunit  ,named(pUniqueOutput + 'Watcher_for_' + pversion + '_' + piteration),overwrite)
      ,output(pWaitEvent             ,named(pUniqueOutput + 'NotifyEvent_' + pversion + '_' + piteration),overwrite)
  );
  
  // ----------------------------------------------------------------------------------
  // -- Gather Child Info
  // ----------------------------------------------------------------------------------
  // Child_Wuid     := wk_ut_dev.get_Scalar_Result(workunit ,pUniqueOutput + 'Iteration_'   + pversion + '_' + piteration);
  getstate       := wk_ut_dev.get_State(Child_Wuid,localesp);    
  realstate      := if(getstate[1..6] = 'failed' ,'failed' ,getstate);
  thor_time      := wk_ut_dev.get_TotalTime(Child_Wuid,localesp); 
  thor_time_secs := wk_ut_dev.Convert2Seconds(thor_time);
  jobname        := wk_ut_dev.get_Jobname(Child_Wuid,localesp);   
  Errors         := wk_ut_dev.get_Errors(Child_Wuid,localesp);
  
  thiswuid            := if(wk_ut_dev.get_Scalar_Result(workunit       ,'Workunits') != '',wk_ut_dev.get_DS_Result(workunit        ,'Workunits',wk_ut_dev.layouts.wks_slim),dataset([],wk_ut_dev.layouts.wks_slim));
  Run_Total_Time_secs := sum(thiswuid,Total_Time_secs) + thor_time_secs;
  Run_Total_Thor_Time := wk_ut_dev.ConvertSecs2ReadableTime((real8)Run_Total_Time_secs);

  //name, wuid, iteration#, version, thor time, etc

  dWUDetails := dataset([{jobname ,Child_Wuid ,getstate ,piteration ,pversion ,thor_time,thor_time_secs,Run_Total_Thor_Time,Run_Total_Time_secs,'',0.0,ut.GetTimeDate(),Errors}] ,wk_ut_dev.layouts.wks_slim);
  jobname2 := if(jobname != '' ,jobname ,Child_Wuid);
  sendemail := wk_ut_dev.Send_Email(
                             pNotifyEmails
                            ,jobname2 + ' has ' + getstate + ' in ' + thor_time + ' on ' + _Control.ThisEnvironment.Name + ' on this date: ' + ut.GetTimeDate()
                            , if(jobname != ''
                            , 'Jobname        : ' + jobname + '\n','')
                            + 'workunit       : ' + Child_Wuid + '\n' 
                            + 'State          : ' + getstate + '\n'
                            + 'Total Thor Time: ' + thor_time + '\n'
                            + 'Iteration      : ' + piteration + '\n'
                            + 'Version        : ' + pversion + '\n'
                            + if(trim(Errors) != '' ,'FailMessage(s): \n' + Errors + '\n','')
                            + iff(getstate not in ['completed']
                                , '\nThis workunit ' + getstate + '.  I am awaiting your advice on what to do next.\n'
                                + 'Here are your options:\n'
                                + 'Rerun iteration              : wk_ut_dev.Provide_Advice(\'' + pWaitEvent + '\',\'Rerun\');\n'
                                + 'Move on to the next iteration: wk_ut_dev.Provide_Advice(\'' + pWaitEvent + '\',\'Skip\');\n'
                                + 'Fail workunit                : wk_ut_dev.Provide_Advice(\'' + pWaitEvent + '\',\'Fail\');\n'
                              ,'')
                          );

  childwuids := if(wk_ut_dev.get_Scalar_Result(Child_Wuid,'Workunits',localesp) != '' and localesp in wk_ut_dev._constants.LocalEsps,wk_ut_dev.get_DS_Result(Child_Wuid ,'Workunits',wk_ut_dev.layouts.wks_slim),dataset([],wk_ut_dev.layouts.wks_slim));
  
  iterwuids  := iterate(project(childwuids,transform(recordof(left),self.Run_Total_Time_secs := left.Total_Time_secs,self := left)),transform(recordof(left)
    ,self.Run_Total_Time_secs := if(counter = 1,Run_Total_Time_secs,left.Run_Total_Time_secs) + right.Run_Total_Time_secs
    ,self.Run_Total_Thor_Time := wk_ut_dev.ConvertSecs2ReadableTime((real8)self.Run_Total_Time_secs),self := right));

  temp_wuid_bucket_fname    := pOutputFilename + '___temp___bucket';
  temp_wuid_bucket_dataset  := dataset(temp_wuid_bucket_fname,wk_ut_dev.layouts.wks_slim,thor,opt);
  
  Gather_Child_Info :=  sequential(
              if(pOutputFilename != ''  ,wk_ut_dev.Update_File(temp_wuid_bucket_fname,dWUDetails + iterwuids,false,true))
             ,output(dWUDetails + iterwuids,named('Workunits'),EXTEND)
             ,output('Get Iteration Info' ,named('LastWork'),overwrite)
             ,if(getstate in ['completed']         
                ,sequential(
                   iff(pOutputFilename != ''
                      ,sequential(
                         tools.macf_WriteFile(pOutputFilename,temp_wuid_bucket_dataset,false,false,true)
                        ,if(pOutputSuperfile != '' ,std.file.addsuperfile(pOutputSuperfile,pOutputFilename))
                        ,fileservices.deletelogicalfile(StartFilename         )  //don't need this around anymore after this finishes successfully.  it is only used to restart.
                        ,fileservices.deletelogicalfile(temp_wuid_bucket_fname)  //don't need this around anymore after this finishes successfully.  it is only used to restart.
                      )
                   )
                  ,wk_ut_dev.mac_Notify(pNotifyEvent,,,pESP) 
                  ,fail('Fail workunit to get it out of the scheduler.  The child wuid completed.')
                )
             )
             ,sendemail
             //,if failed or aborted, go back in scheduler waiting for instructions
                  // getstate in ['failed','aborted']  => sequential()
             // ,iff(getstate in ['failed','aborted'] ,fail('Fail workunit because wuid ' + Child_Wuid + ' has ' + getstate + '.'))
          )
          ;

  // ----------------------------------------------------------------------------------
  // -- Get EventExtra text
  // ----------------------------------------------------------------------------------
  Advice := eventextra('Advice');
  
  sendFeedbackEmail := wk_ut_dev.Send_Email(
                             pNotifyEmails
                            ,'Your Advice is to ' + Advice + ' this workunit: ' + jobname2 +  ' on ' + _Control.ThisEnvironment.Name + ' on this date: ' + ut.GetTimeDate()
                            ,  'Child wuid   : ' + Child_Wuid + '\n'
                             + 'Child Jobname: ' + jobname + '\n'
                             + 'Advice       : ' + Advice + '\n'
                             + 'From Wuid    : ' + workunit
                          );
/*
  first call(without a notify)
    LastWork = nothing
    no advice
    try number will be zero
    child wuid will be blank
    kicks off iteration
  second call(because iteration finished, now need to get wuid details)
    LastWork = kicked iteration
    no advice
    try number will be 1
    child wuid non-blank
    child wuid not in workunits dataset yet
    gathers info on iteration, either notifies parent that it completed and fails itself, or sends email asking for advice and goes back in scheduler because the iteration failed/aborted 
  third call(this will only happen if the workunit failed or aborted)
    LastWork = 'Get Iteration Info'
    advice hopefully will be rerun,skip or fail.  in absense of advice, send email requesting advice again & go back in scheduler
    try number will be 1
    child wuid non-blank
    child wuid in workunits dataset
    for reruns, will kick off iteration again
  fourth call
    LastWork = kicked iteration
    no advice
    try number will be 2
    child wuid non-blank
    child wuid not in workunits dataset
    gathers info on iteration, either notifies parent that it completed and fails itself, or goes back in scheduler because the iteration failed/aborted 

*/  
  LastWork     := global(wk_ut_dev.get_Scalar_Result(workunit ,'LastWork'),few);
  TimesCalled  := global(wk_ut_dev.get_Scalar_Result(workunit ,'TimesCalled'),few);
  childstate   := global(wk_ut_dev.get_State(trim(wk_ut_dev.get_Scalar_Result(workunit ,pUniqueOutput + 'Iteration_'   + pversion + '_' + piteration))),few);
  // lay_actions := {string doing,string time,string };
  // ----------------------------------------------------------------------------------
  // -- Return result
  // ----------------------------------------------------------------------------------
  clickable_parent_wuid := 'http://' + pESP + ':8010/?inner=../WsWorkunits/WUInfo%3FWuid%3D' + pParentWuid;

  doit := sequential(
     output(pParentWuid                 ,named('ParentWuid' ),overwrite)
    ,output(clickable_parent_wuid       ,named('ParentWuid__html' ),overwrite)    //so can click back and forth between the parent and child
    ,output((unsigned)TimesCalled + 1   ,named('TimesCalled'),overwrite)
    ,output(Advice                      ,named('Advice'     ),overwrite) // master will get this result to see what happened with the child
    ,output(if((unsigned)TimesCalled + 1 > 1, childstate,''),named('ChildStatus'),overwrite)
    ,map(
       //first time running, kick off iteration
       LastWork in ['','[undefined]'] or (LastWork = 'Get Iteration Info' and regexfind('run' ,Advice,nocase))  => sequential(if(try_Number > 1  ,sendFeedbackEmail),output(dataset([{'Kicking off wuid',ut.GetTimeDate()}],{string doing,string time}),named('doingNow'),extend),kick_Off_Child)
      ,LastWork = 'Get Iteration Info' and regexfind('fail|skip' ,Advice,nocase)                                => sequential(output(dataset([{'Received advice after failure.  It is: ' + Advice,ut.GetTimeDate()}],{string doing,string time}),named('doingNow'),extend),sendFeedbackEmail,wk_ut_dev.mac_Notify(pNotifyEvent,,,pESP),fail('Fail workunit because wuid ' + Child_Wuid + ' has ' + getstate + ', and your advice was to ' + Advice + ' it on ' + ut.GetTimeDate()))
      ,LastWork = 'Kicked Off Iteration' and Advice = ''/*might want to not even check this*/                   => sequential(output(dataset([{'Gathering Child info',ut.GetTimeDate()}],{string doing,string time}),named('doingNow'),extend),Gather_Child_Info)
      ,sequential(
         output(dataset([{'Sending email--default',ut.GetTimeDate()}],{string doing,string time}),named('doingNow'),extend)
        // ,output('Do dummy output to see if it doesn\'t matter what is in here, it will kick off new wuids anyway',named('DefaultOutput'),overwrite)
        ,sendemail
      )//default  send an email 
    )  
  );

  doit  : when(pWaitEvent);
  
  return doit;

endmacro;
