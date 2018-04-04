/*

  TODO:  compile list of most common "fluke" errors and allow this process to kick those wuids off again without intervention.


to test:
#workunit('name','Parent Wuid');
wk_ut.RunWuid('#workunit(\'name\',\'Child Wuid\');\noutput(\'Hello There\');fail(\'Just fail for testing\');',1,'20140813',wk_ut._Constants.Groupname('5'),'notifymastervent','wait4masterevent','Vern\'s Master Parent',pPollingFrequency := '1');

#workunit('name','Manual Notify Wuid');
//wk_ut.mac_Notify('wait4masterevent','Rerun','Advice');
wk_ut.mac_Notify('wait4masterevent','Skip','Advice');
//wk_ut.mac_Notify('wait4masterevent','Fail','Advice');

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
  ,pESP               = 'wk_ut._constants.LocalEsp'           //this esp is the esp of the workunit that kicked this off.  all wuids created by this wuid are local.  the notification done at the end will be to this esp.
  ,pNotifyEmails      = 'wk_ut._Constants.EmailAddressNotify'
  ,pShouldEmail       = 'true'
  ,pUniqueOutput      = '\'\''
  ,pPollingFrequency  = '\'5\''
  ,pForceRun          = 'false'                               // if true, then it will kick off the wuid even if it has already run.  FALSE will skip it if it has already run
  ,pForceSkip         = 'false'                               // if true, then it will kick off the wuid even if it has already run.  FALSE will skip it if it has already run

) := 
functionmacro

  import tools,std;
  
  ECL := regexreplace('\\n',pECL,'\n');

  // ----------------------------------------------------------------------------------
  // -- #1 kick off wuid
  // ----------------------------------------------------------------------------------
  localesp        := wk_ut._constants.LocalEsp;
  watchercluster  := wk_ut._Constants.Esp2Hthor(localesp);

  blank_reruns := parallel(
                     output(''  ,named('Rerun__html'),overwrite)
                    ,output(''  ,named('Skip__html' ),overwrite)
                    ,output(''  ,named('Fail__html' ),overwrite) 
                  );

  reruns := parallel(
                     output('<a href="' + wk_ut.Push_Event_Result_Link(pWaitEvent,'Rerun',localesp) + '">Rerun Workunit</a>',named('Rerun__html'),overwrite)
                    ,output('<a href="' + wk_ut.Push_Event_Result_Link(pWaitEvent,'Skip' ,localesp) + '">Skip Workunit</a>' ,named('Skip__html' ),overwrite)
                    ,output('<a href="' + wk_ut.Push_Event_Result_Link(pWaitEvent,'Fail' ,localesp) + '">Fail Workunit</a>' ,named('Fail__html' ),overwrite)                              

                     // output('<a href="http://' + localesp + ':8010/WsWorkunits/WUPushEvent?ver_=1.48&.EventName=' + pWaitEvent + '&.EventText=%3CEvent%3E%3CAdvice%3E' + 'Rerun' + '%3C%2FAdvice%3E%3C%2FEvent%3E">Rerun Workunit</a>' ,named('Rerun__html'),overwrite)
                    // ,output('<a href="http://' + localesp + ':8010/WsWorkunits/WUPushEvent?ver_=1.48&.EventName=' + pWaitEvent + '&.EventText=%3CEvent%3E%3CAdvice%3E' + 'Skip'  + '%3C%2FAdvice%3E%3C%2FEvent%3E">Skip Workunit</a>'  ,named('Skip__html' ),overwrite)
                    // ,output('<a href="http://' + localesp + ':8010/WsWorkunits/WUPushEvent?ver_=1.48&.EventName=' + pWaitEvent + '&.EventText=%3CEvent%3E%3CAdvice%3E' + 'Fail'  + '%3C%2FAdvice%3E%3C%2FEvent%3E">Fail Workunit</a>'  ,named('Fail__html' ),overwrite)                              
                  );
           
// myevent := '<a href="http://' + 'prod_esp.br.seisint.com' + ':8010/WsWorkunits/WUPushEvent?ver_=1.48&.EventName=' + 'VernEvent' + '&.EventText=%3CEvent%3E%3CAdvice%3E' + 'Rerun' + '%3C%2FAdvice%3E%3C%2FEvent%3E">Rerun Workunit</a>';

//  http://10.241.3.241:8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=W20150330-165839#/stub/Summary
//  output('<a href="http://10.241.3.242:8010/?inner=../WsWorkunits/WUInfo%3FWuid%3DW20150330-165839">W20150330-165839</a>' ,named('RelativeWU_WithUrl__html'));  //works
//  output('<a href="/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=W20150330-165839">W20150330-165839</a>'                ,named('RelativeWU__html'));   //works
  
  // -- Add this code to the Child/Iteration so you know what wuid kicked it off.
  // outputRunnerwuidcode  := 'output(\'<a href="http://' + localesp + ':8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + workunit + '#/stub/Summary">Parent Workunit</a>\' ,named(\'Parent_Wuid__html\'));\n';

// http://prod_esp.br.seisint.com:8010/?inner=../WsWorkunits/WUInfo%3FWuid%3DW20150331-151832#/stub/Main-DL/Activity-DL/DetailW20150331x101550-DL/Summary
// http://10.241.3.241:8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=W20150330-165839#/stub/Summary

  createworkunit        := wk_ut.CreateWuid_Raw(/* outputRunnerwuidcode + */ECL  ,pcluster ,localesp ); 
  
  // -- Number of times this wuid called
  try_Number            := (unsigned)wk_ut.get_Scalar_Result(workunit,'Try_Number') + 1;

  // -- Temp filenames
  StartFilename         := pOutputFilename + '___Start'       ;  
  StartFilenameTemp     := pOutputFilename + '___Start___Temp';  

  DoesFileExist         := pOutputFilename != '' and STD.File.FileExists(StartFilename) and try_Number = 2 and pForceRun = false;
  
  // -- Get new child wuid, or previous one(could be any status;running, aborted,queued, etc)
  StartExistingDataset  := dataset(StartFilename  ,wk_ut.layouts.wks_slim ,flat,opt);
  child_wuid1           := StartExistingDataset[if(count(StartExistingDataset) = 0,1,count(StartExistingDataset))].wuid;
  Child_Wuid            := iff(STD.File.FileExists(StartFilename) and DoesFileExist and trim(child_wuid1) != '' ,child_wuid1  ,wk_ut.get_Scalar_Result(workunit ,pUniqueOutput + 'Iteration_'   + pversion + '_' + piteration));
 
  //use child wuid so it doesn't reevaluate it and create another workunit
  createwatcherworkunit := wk_ut.CreateWuid_Raw(
       '#workunit(\'name\',\'---Watcher--- for wuid: ' + Child_Wuid + ', ' + if(pUniqueOutput != '' , pUniqueOutput ,'') +  ', version: ' + pversion + ' iteration: ' + piteration + '\');\n'       
     + 'wk_ut.mac_Watcher(\'' + Child_Wuid + '\',\'' + pWaitEvent + '\',\'' + pNotifyEmails + '\',\'' + pPollingFrequency + '\',\'' + localesp + '\');'
    ,watchercluster
    ,localesp
  );

  clickablewuid           := '<a href="/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + Child_Wuid + '">' + Child_Wuid + '</a>';
  
  Child_watcher_Wuid            := wk_ut.get_Scalar_Result(workunit ,pUniqueOutput + 'Watcher_for_' + pversion + '_' + piteration);

  clickableWatcher_wuid   := '<a href="/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + Child_watcher_Wuid + '">' + Child_watcher_Wuid + '</a>';

  StartDataset          := dataset([{'',Child_Wuid,'','','',piteration,pversion,'',''}],wk_ut.layouts.wks_slim);
  
  kick_Off_Child := sequential(
       output(try_Number                                        ,named('Try_Number'                                                           ),overwrite)
      ,output('Kicked Off Iteration'                            ,named('LastWork'                                                             ),overwrite)
      ,output(iff(DoesFileExist and trim(child_wuid1) != '' ,Child_Wuid ,createworkunit  )  ,named(pUniqueOutput + 'Iteration_'   + pversion + '_' + piteration           ),overwrite)
      ,output(clickablewuid                                     ,named(pUniqueOutput + 'Iteration_'   + pversion + '_' + piteration + '__html'),overwrite)
      ,if(pOutputFilename != '' and not DoesFileExist ,wk_ut.Update_File(StartFilename,StartExistingDataset + StartDataset,false,true,'wuid'))
      ,output(createwatcherworkunit                             ,named(pUniqueOutput + 'Watcher_for_' + pversion + '_' + piteration           ),overwrite)
      ,output(clickableWatcher_wuid                             ,named(pUniqueOutput + 'Watcher_for_' + pversion + '_' + piteration + '__html'),overwrite)
      ,output(pWaitEvent                                        ,named(pUniqueOutput + 'NotifyEvent_' + pversion + '_' + piteration           ),overwrite)
  );
  
  // ----------------------------------------------------------------------------------
  // -- Gather Child Info
  // ----------------------------------------------------------------------------------
  getstate       := wk_ut.get_State(Child_Wuid,localesp);    
  realstate      := if(getstate[1..6] = 'failed' ,'failed' ,getstate);
  thor_time      := wk_ut.get_TotalTime(Child_Wuid,localesp); 
  thor_time_secs := wk_ut.Convert2Seconds(thor_time);
  jobname        := wk_ut.get_Jobname(Child_Wuid,localesp);   
  Errors         := wk_ut.get_Errors(Child_Wuid,localesp);
  
  thiswuid       := if(pOutputSuperfile = '' ,if(wk_ut.get_Scalar_Result(workunit       ,'Workunits') != '',wk_ut.get_DS_Result(workunit        ,'Workunits',wk_ut.layouts.wks_slim),dataset([],wk_ut.layouts.wks_slim))
                                             ,dataset(pOutputSuperfile,wk_ut.layouts.wks_slim,flat,opt)(version = pversion)
  );
  
  Run_Total_Time_secs := sum(thiswuid,Total_Time_secs) + thor_time_secs;
  Run_Total_Thor_Time := wk_ut.ConvertSecs2ReadableTime((real8)Run_Total_Time_secs);

  //name, wuid, iteration#, version, thor time, etc

  dWUDetails  := dataset([{jobname ,Child_Wuid ,localesp,wk_ut._Constants.LocalENV,getstate ,piteration ,pversion ,thor_time,thor_time_secs,Run_Total_Thor_Time,Run_Total_Time_secs,'',0.0,wk_ut.getTimeDate(),Errors}] ,wk_ut.layouts.wks_slim);
  jobname2    := if(jobname != '' ,jobname ,Child_Wuid);
  sendemail   := wk_ut.Send_Email(
                             pNotifyEmails
                            ,jobname2 + ' has ' + getstate + ' in ' + thor_time + ' on ' + _Control.ThisEnvironment.Name + ' on this date: ' + wk_ut.getTimeDate()
                            , if(jobname != ''
                            , 'Jobname         : ' + jobname                                                                            + '\n','')
                            + 'workunit        : ' + Child_Wuid                                                                         + '\n' 
                            + 'workunit link   : ' + 'http://' + localesp + ':8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + Child_Wuid + '#/stub/Summary\n' 
                            + 'State           : ' + getstate                                                                           + '\n'
                            + 'Total Thor Time : ' + thor_time                                                                          + '\n'
                            + 'Iteration       : ' + piteration                                                                         + '\n'
                            + 'Version         : ' + pversion                                                                           + '\n'
                            + 'Runner Wuid link: ' + 'http://' + localesp + ':8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + workunit   + '#/stub/Summary\n' 
                            + if(trim(Errors) != '' ,'FailMessage(s): \n' + Errors + '\n','')
                            + iff(getstate in ['failed','aborted','unknown']
                                , '\nThis workunit ' + getstate + '.  I am awaiting your advice on what to do next.\n'
                                + 'Here are your options(Simply click the link beside your choice to advise the process.):\n\n'
                                + 'Rerun iteration              : ' + wk_ut.Push_Event_Result_Link(pWaitEvent,'Rerun',localesp) + '\n'
                                + 'Move on to the next iteration: ' + wk_ut.Push_Event_Result_Link(pWaitEvent,'Skip' ,localesp) + '\n'
                                + 'Fail workunit                : ' + wk_ut.Push_Event_Result_Link(pWaitEvent,'Fail' ,localesp) + '\n'                                
                              ,'')
                  );

  //if you are using a superfile, then the children should be in there, no need to get the workunits dataset from the children.
  childwuids        := if(pOutputSuperfile = '' and wk_ut.get_Scalar_Result(Child_Wuid,'Workunits',localesp) != '' and localesp in wk_ut._constants.LocalEsps,wk_ut.get_DS_Result(Child_Wuid ,'Workunits',wk_ut.layouts.wks_slim),dataset([],wk_ut.layouts.wks_slim));
  
  iter_Child_Wuids  := iterate(project(childwuids,transform(recordof(left),self.Run_Total_Time_secs := left.Total_Time_secs,self := left)),transform(recordof(left)
    ,self.Run_Total_Time_secs := if(counter = 1,Run_Total_Time_secs,left.Run_Total_Time_secs) + right.Run_Total_Time_secs
    ,self.Run_Total_Thor_Time := wk_ut.ConvertSecs2ReadableTime((real8)self.Run_Total_Time_secs),self := right));

  temp_wuid_bucket_fname    := pOutputFilename + '___temp___bucket';
  temp_wuid_bucket_dataset  := dataset(temp_wuid_bucket_fname,wk_ut.layouts.wks_slim,thor,opt);

  
  Gather_Child_Info :=  sequential(
              output(dataset([{'Get Iteration Info',wk_ut.getTimeDate()}],{string doing,string time}),named('doingNow'),extend)
             ,if(pOutputFilename != ''  ,wk_ut.Update_File(temp_wuid_bucket_fname,dWUDetails + iter_Child_Wuids,false,true,'wuid'))
             ,output(dWUDetails + iter_Child_Wuids,named('Workunits'),EXTEND    )
             ,output('Get Iteration Info'         ,named('LastWork' ),overwrite )
             ,if(getstate in ['completed'] or pForceSkip = true        
                ,sequential(
                   iff(pOutputFilename != ''
                      ,sequential(
                         tools.macf_WriteFile(pOutputFilename,temp_wuid_bucket_dataset,false,false,true)
                        ,if(pOutputSuperfile != '' ,std.file.addsuperfile(pOutputSuperfile,pOutputFilename))
                        ,if(std.file.fileexists(StartFilename         )  ,std.file.deletelogicalfile(StartFilename         ))  //don't need this around anymore after this finishes successfully.  it is only used to restart.
                        ,if(std.file.fileexists(temp_wuid_bucket_fname)  ,std.file.deletelogicalfile(temp_wuid_bucket_fname))  //don't need this around anymore after this finishes successfully.  it is only used to restart.
                      )
                   )
                  ,wk_ut.mac_Notify(pNotifyEvent,,,pESP) 
                  ,blank_reruns                              
                  ,fail('Fail workunit to get it out of the scheduler.  The child wuid completed.')
                  // ,output('Deschedule workunit to get it out of the scheduler.  The child wuid completed.')
                  // ,wk_ut.Deschedule_Wuid(workunit)
                )
               ,reruns
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
  
  tidy_Up_For_Skip := iff(regexfind('skip' ,Advice,nocase)          
              ,sequential(
                 iff(pOutputFilename != ''
                    ,sequential(
                       tools.macf_WriteFile(pOutputFilename,temp_wuid_bucket_dataset,false,false,true)
                      ,if(pOutputSuperfile != '' ,std.file.addsuperfile(pOutputSuperfile,pOutputFilename))
                      ,if(std.file.fileexists(StartFilename         )  ,std.file.deletelogicalfile(StartFilename         ))  //don't need this around anymore after this finishes successfully.  it is only used to restart.
                      ,if(std.file.fileexists(temp_wuid_bucket_fname)  ,std.file.deletelogicalfile(temp_wuid_bucket_fname))  //don't need this around anymore after this finishes successfully.  it is only used to restart.
                    )
                 )
              )
           );
             
  sendFeedbackEmail := wk_ut.Send_Email(
                             pNotifyEmails
                            ,'Your Advice is to ' + Advice + ' this workunit: ' + jobname2 +  ' on ' + _Control.ThisEnvironment.Name + ' on this date: ' + wk_ut.getTimeDate()
                            ,  'Child wuid    : ' + Child_Wuid                                                                          + '\n'
                             + 'Child link    : ' + 'http://' + localesp + ':8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + Child_Wuid  + '#/stub/Summary\n' 
                             + 'Child Jobname : ' + jobname                                                                             + '\n'
                             + 'Advice        : ' + Advice                                                                              + '\n'
                             + 'From Wuid     : ' + workunit                                                                            + '\n'
                             + 'From Wuid link: ' + 'http://' + localesp + ':8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + workunit    + '#/stub/Summary\n' 
                          );
  // http://10.241.3.241:8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=W20150330-165839#/stub/Summary

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
  LastWork     := global(wk_ut.get_Scalar_Result(workunit ,'LastWork'   )                                                                       ,few);
  TimesCalled  := global(wk_ut.get_Scalar_Result(workunit ,'TimesCalled')                                                                       ,few);
  childstate   := global(wk_ut.get_State(trim(wk_ut.get_Scalar_Result(workunit ,pUniqueOutput + 'Iteration_'   + pversion + '_' + piteration))) ,few);
  
  // lay_actions := {string doing,string time,string };
  // ----------------------------------------------------------------------------------
  // -- Return result
  // ----------------------------------------------------------------------------------
  // http://10.241.3.241:8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=W20150330-165839#/stub/Summary

  clickable_parent_wuid := '<a href="http://' + pESP + ':8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + pParentWuid + '#/stub/Summary">Parent Workunit</a>';
  // outputRunnerwuidcode  := 'output(\'<a href="http://' + localesp + ':8010/?inner=../WsWorkunits/WUInfo%3FWuid%3D' + workunit + '">Parent Workunit</a>\' ,named(\'Parent_Wuid__html\'));\n';

  kickWuid   := sequential(if(try_Number > 1  ,sendFeedbackEmail),output(dataset([{'Kicked Off Iteration',wk_ut.getTimeDate()}],{string doing,string time}),named('doingNow'),extend),blank_reruns,kick_Off_Child);    
  failOrSkip := sequential(output(dataset([{'Received advice after failure.  It is: ' + Advice,wk_ut.getTimeDate()}],{string doing,string time}),named('doingNow'),extend),sendFeedbackEmail,tidy_Up_For_Skip,wk_ut.mac_Notify(pNotifyEvent,,,pESP),blank_reruns,fail('Fail workunit because wuid ' + Child_Wuid + ' has ' + getstate + ', and your advice was to ' + Advice + ' it on ' + wk_ut.getTimeDate()));
  // failOrSkip := sequential(output(dataset([{'Received advice after failure.  It is: ' + Advice,wk_ut.getTimeDate()}],{string doing,string time}),named('doingNow'),extend),sendFeedbackEmail,tidy_Up_For_Skip,wk_ut.mac_Notify(pNotifyEvent,,,pESP),blank_reruns,output('Deschedule workunit because wuid ' + Child_Wuid + ' has ' + getstate + ', and your advice was to ' + Advice + ' it on ' + wk_ut.getTimeDate()),wk_ut.Deschedule_Wuid(workunit));

  default    := sequential(
         output(dataset([{'Sending email--default',wk_ut.getTimeDate()}],{string doing,string time}),named('doingNow'),extend)
        ,output('Sending email--default' ,named('LastWork'),overwrite)
        // ,output('Do dummy output to see if it doesn\'t matter what is in here, it will kick off new wuids anyway',named('DefaultOutput'),overwrite)
        ,sendemail
        ,blank_reruns
      );//default  send an email 

  child_status_result := trim(wk_ut.get_Scalar_Result(workunit ,'ChildStatus'));

  doit := sequential(
     output(wk_ut.getTimeDate()                             ,named('DateTime'         ),overwrite)
    ,output(pParentWuid                                     ,named('ParentWuid'       ),overwrite)
    // ,output(clickable_parent_wuid                           ,named('ParentWuid__html' ),overwrite) //so can click back and forth between the parent and child
    ,output((unsigned)TimesCalled + 1                       ,named('TimesCalled'      ),overwrite)
    ,output(if(pForceSkip = false,Advice,'skip')            ,named('Advice'           ),overwrite) // master will get this result to see what happened with the child
    ,output(if((unsigned)TimesCalled + 1 > 1, childstate,''),named('ChildStatus'      ),overwrite)
    ,map(
       (trim(LastWork) in ['Get Iteration Info'  ,'Sending email--default'] and regexfind('run'       ,Advice,nocase) and child_status_result in ['failed','aborted','unknown']) or trim(LastWork) in ['','[undefined]']  => kickWuid                         //Kick off new wuid(first time or rerun)
      , trim(LastWork) in ['Get Iteration Info'  ,'Sending email--default'] and regexfind('fail|skip' ,Advice,nocase) and child_status_result in ['failed','aborted','unknown']                                           => failOrSkip                       //if advice to skip or fail, notify parent.
      , child_status_result     in ['completed','failed','aborted','unknown']                                                                                                                                             => Gather_Child_Info                //Gather info on wuid after completed/failed/aborted.  if completed, fail this wuid and notify parent.
      , child_status_result not in ['completed','failed','aborted','unknown']                                                                                                                                             => default //STD.System.Debug.Sleep ( 1000 )  //if it gets notified before the iteration is finished, sleep for a second, then go back in the scheduler.  No biggie.
      ,                                                                                                                                                                                                                      default                          //send default email.  shouldn't happen, but if does no biggie.
    )  
  );

  doit  : when(pWaitEvent);
  
  return doit;

endmacro;
