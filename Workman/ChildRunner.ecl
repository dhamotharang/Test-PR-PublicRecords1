/*

  
  TODO:  compile list of most common "fluke" errors and allow this process to kick those wuids off again without intervention.

  for kicking off a wuid, if you get blank, you should fail use recovery to try to kick it off again.  if it fails after, say, 10 attempts, then it will email you and let you know to noftify it manually, giving you links to do that.
  should probably put this into a function call that wraps the createwuid.  you pass in the normal stuff, ecl, cluster, etc. and also pass in # of attempts and then a failure clause and what to email if fails.
  for starting where you left off, if the wuid you get from the saved dataset is blank, kick off a fresh one.  


to test:
#workunit('name','Parent Wuid');
WorkMan.ChildRunner('#workunit(\'name\',\'Child Wuid\');\noutput(\'Hello There\');fail(\'Just fail for testing\');',1,'20140813',WorkMan._Config.Groupname('5'),'notifymastervent','WORKMAN_CHILDRUNNER_EVENT','Vern\'s Master Parent',pPollingFrequency := '1');

#workunit('name','Manual Notify Wuid');
//WorkMan.mac_Notify('WORKMAN_CHILDRUNNER_EVENT','Rerun','Advice');
WorkMan.mac_Notify('WORKMAN_CHILDRUNNER_EVENT','Skip','Advice');
//WorkMan.mac_Notify('WORKMAN_CHILDRUNNER_EVENT','Fail','Advice');

so if the create wuids is not called in the sequential, it will not kick off any wuids.
if it is in the sequential, then it will kick it off each time this is run even though it is not called.

*/

import tools,ut,_control,WsWorkunits;
EXPORT ChildRunner(

   pECL
  ,pversion
  ,pcluster
  ,pNotifyEvent                                               //master event name, used to notify the master when you are done
  // ,pWaitEvent                                                 //used in when clause for this child runner.  the watcher wuid uses this to notify this childrunner that the iteration has completed/failed/aborted
  ,pStartIteration      = ''                                  // default is it will start where it left off + 1.  Or you can specify the start #.
  ,pNumMaxIterations    = ''                                  // default is no maximum.  although it is recommended to have a maximum.  in the absence of a stop condition, this is the number of iterations it will run.
  ,pNumMinIterations    = ''                                  // default is no minimum.  when populated, only works in conjunction with a stop condition
  ,pOutputFilename      = '\'\''                              // filename to output the workunits dataset to.  
  ,pOutputSuperfile     = '\'\''                              // superfile to add the above file to. 
  ,pSetResults          = '[]'                                // output these results after each iteration.  These are named results from the workunit kicked off.
  ,pStopCondition       = '\'\''                              // if condition is true, don't kick off next iteration.  In effect, making pNumMaxIterations a max # of iterations instead of total iterations
  ,pSetNameCalculations = '[]'                                //name the calculations in the above pStopCondition.  each calculation in the pStopCondition that is surrounded by parentheses will be output in the emails and to the childrunner results.
                                                              //this parameter allows you to name them.
  ,pBuildName         = '\'\''
  ,pESP               = 'WorkMan._Config.LocalEsp'            //this esp is the esp of the workunit that kicked this off.  all wuids created by this wuid are local.  the notification done at the end will be to this esp.
  ,pNotifyEmails      = 'WorkMan._Config.EmailAddressNotify'
  ,pFailureEmails     = 'WorkMan._Config.EmailAddressNotify'          // extra email addresses to which to send any failures 
  ,pShouldEmail       = 'true'
  ,pPollingFrequency  = '\'5\''
  ,pForceRun          = 'false'                               // if true, then it will kick off the wuid even if it has already run.  FALSE will skip it if it has already run
  ,pForceSkip         = 'false'                               // if true, then it will skip all failures and continue with the next iteration.  FALSE will ask if you want to rerun, skip or fail.
  ,pDebugValues       = 'dataset([],WsWorkunits.Layouts.DebugValues)' // for the spawning of the wuids.  can use other repositories using this.
  ,pOnlyCompile       = 'false'                               // if true, then it will only compile the iteration, not run it.  Useful for testing a build.

) := 
functionmacro

  import tools,std;

  
  #UNIQUENAME(FAILUREEMAILS)
  #IF(trim(pFailureEmails) != '')
    #SET(FAILUREEMAILS  ,TRIM(pNotifyEmails) + ',' + TRIM(pFailureEmails))
  #ELSE
    #SET(FAILUREEMAILS  ,TRIM(pNotifyEmails))
  #END

  #UNIQUENAME(NumMaxIterations)
  #UNIQUENAME(NumMinIterations)
  #UNIQUENAME(StartIteration  )

  #IF(trim(#TEXT(pNumMaxIterations))  = '')
    #SET(NumMaxIterations ,-1)
  #ELSE
    #SET(NumMaxIterations ,pNumMaxIterations)
  #END
  
  #IF(trim(#TEXT(pNumMinIterations))  = '')
    #SET(NumMinIterations ,-1)
  #ELSE
    #SET(NumMinIterations ,pNumMinIterations)
  #END


  #IF(trim(#TEXT(pStartIteration))  = '')
    #SET(StartIteration ,'')
  #ELSE
    #SET(StartIteration ,pStartIteration)
  #END

  // -- use buildname, version, start iteration, max and min iterations, and ecl to make the event unique
  #UNIQUENAME(WORKMAN_CHILDRUNNER_EVENT_NAME   )
  #SET(WORKMAN_CHILDRUNNER_EVENT_NAME  ,'__#__' + trim(pBuildName,all) + '_' + trim(pversion) + '_' + trim((string)%'StartIteration'%) + '_' + trim((string)%'NumMaxIterations'%) + '_' + trim((string)%'NumMinIterations'%) + '_' + length(trim(pECL)) + '_' + length(trim(regexreplace('[^;]',pECL,''),all)) + '_' + length(trim(regexreplace('[^[:alnum:]]',pECL,''),all)) + '__$__')
  #UNIQUENAME(WORKMAN_CHILDRUNNER_EVENT   ,%'WORKMAN_CHILDRUNNER_EVENT_NAME'%)

  // WORKMAN_CHILDRUNNER_EVENT  := 'CHILDRUNNER_' + regexreplace('[-]',workunit,'_');
  // #SET(WORKMAN_CHILDRUNNER_EVENT  ,'CHILDRUNNER_' + regexreplace('[-]',workunit,'_'))
  
  // ----------------------------------------------------------------------------------
  // -- #1 kick off wuid
  // ----------------------------------------------------------------------------------
  localesp        := WorkMan._Config.LocalEsp;
  watchercluster  := WorkMan._Config.Esp2Hthor(localesp);

  lay_iterations := Workman.Layouts.iterations;
  
  
  // -- generate custom module to get results, stop condition, calculations, etc.
  Get_Results(string pwuid) := WorkMan.mac_Parse_Results(pSetResults ,pStopCondition,pSetNameCalculations);
  
  
// myevent := '<a href="http://' + 'prod_esp.br.seisint.com' + ':8010/WsWorkunits/WUPushEvent?ver_=1.48&.EventName=' + 'VernEvent' + '&.EventText=%3CEvent%3E%3CAdvice%3E' + 'Rerun' + '%3C%2FAdvice%3E%3C%2FEvent%3E">Rerun Workunit</a>';

//  http://10.241.3.241:8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=W20150330-165839#/stub/Summary
//  output('<a href="http://10.241.3.242:8010/?inner=../WsWorkunits/WUInfo%3FWuid%3DW20150330-165839">W20150330-165839</a>' ,named('RelativeWU_WithUrl__html'));  //works
//  output('<a href="/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=W20150330-165839">W20150330-165839</a>'                ,named('RelativeWU__html'));   //works
  
  // -- Add this code to the Child/Iteration so you know what wuid kicked it off.
  // outputRunnerwuidcode  := 'output(\'<a href="http://' + localesp + ':8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + workunit + '#/stub/Summary">Parent Workunit</a>\' ,named(\'Parent_Wuid__html\'));\n';

// http://prod_esp.br.seisint.com:8010/?inner=../WsWorkunits/WUInfo%3FWuid%3DW20150331-151832#/stub/Main-DL/Activity-DL/DetailW20150331x101550-DL/Summary
// http://10.241.3.241:8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=W20150330-165839#/stub/Summary
  
  // -- Number of times this wuid called
  try_Number            := (unsigned)WorkMan.get_Scalar_Result(workunit,'Try_Number') + 1;

  // -- Temp filenames
  // OutputFilename        := regexreplace('@iteration@',regexreplace('@version@' ,pOutputFilename  ,pversion),Iteration);
  OutputFilename        := regexreplace('@version@' ,pOutputFilename  ,pversion);

  outputfilename_dataset:= dataset(OutputFilename      ,WorkMan.layouts.wks_slim,thor,opt);

  StartFilename         := OutputFilename + '___Start'       ;  
  StartFilenameTemp     := OutputFilename + '___Start___Temp';  

  DoesFileExist         := OutputFilename != '' and STD.File.FileExists(StartFilename) and try_Number = 2 and pForceRun = false;
  
  // -- Get new child wuid, or previous one(could be any status;running, aborted,queued, etc)
  StartExistingDataset        := dataset(StartFilename  ,WorkMan.layouts.wks_slim ,flat,opt);

  child_wuid1                 := StartExistingDataset   [if(count(StartExistingDataset  ) = 0,1,count(StartExistingDataset  ))].wuid     ;
  child_iteration1            := StartExistingDataset   [if(count(StartExistingDataset  ) = 0,1,count(StartExistingDataset  ))].iteration;
  
  latest_completed_wuid       := outputfilename_dataset [if(count(outputfilename_dataset) = 0,1,count(outputfilename_dataset))].wuid     ;
  latest_completed_iteration  := outputfilename_dataset [if(count(outputfilename_dataset) = 0,1,count(outputfilename_dataset))].iteration;

  Child_Wuid                  := map(STD.File.FileExists(StartFilename ) and DoesFileExist       => child_wuid1 
                                    // ,STD.File.FileExists(OutputFilename)                         => latest_completed_wuid
                                    ,                                                               WorkMan.get_Scalar_Result(workunit ,'Iteration_Wuid')
                                 );
  
  // Child_Wuid                  := iff(STD.File.FileExists(StartFilename) and DoesFileExist  
                                  // ,child_wuid1  
                                  // ,WorkMan.get_Scalar_Result(workunit ,'Iteration_Wuid')
                                 // );

  // -- figure out start iteration #
  ds_output_superfile                := dataset(pOutputSuperfile,WorkMan.layouts.wks_slim,flat,opt);
  ds_previous_builds                 := ds_output_superfile(version < pversion,pBuildName = '' or StringLib.StringToLowerCase(Build_name) = StringLib.StringToLowerCase(pBuildName));
  ds_previous_build_final_iterations := sort(ds_previous_builds,-version,-(unsigned)iteration);

  #IF(#TEXT(pStartIteration) = '' or #TEXT(pStartIteration) = '\'\'') // it is blank
    default_start_iteration            := if(pOutputSuperfile != ''  
    // default_start_iteration            := if((#TEXT(pStartIteration) = '' or trim((string)pStartIteration) = '') and pOutputSuperfile != '' //and trim(ds_previous_build_final_iterations[1].iteration) != '' 
                                            ,(string)((unsigned)ds_previous_build_final_iterations[1].iteration + 1)
                                            ,''
                                         );
    StartIteration := default_start_iteration;
  #ELSE

    StartIteration := (string)pStartIteration;

  #END
  
  
  // -- Iteration #
  Iteration            := map(
     (unsigned)WorkMan.get_Scalar_Result(workunit,'Current_Iteration')  !=  0                                                                       => WorkMan.get_Scalar_Result(workunit,'Current_Iteration')
    ,child_iteration1                                                   != ''  and (unsigned)StartIteration < (unsigned)child_iteration1            => child_iteration1             //if start iteration is more than what you find in a file, use the start iteration
    ,latest_completed_iteration                                         != ''  and (unsigned)StartIteration < (unsigned)latest_completed_iteration  => latest_completed_iteration
  ,                                                                                                                                                    (string)StartIteration
  );
                          
  ECL := regexreplace('@iteration@',regexreplace('@version@' ,regexreplace('\\n',pECL,'\n')  ,pversion),Iteration);

  Iteration_Wuid_result   := WorkMan.get_Scalar_Result(workunit ,'Iteration_Wuid');
 
  #IF(pOnlyCompile = false)
    createworkunit        := WorkMan.CreateWuid_Raw  (ECL  ,pcluster ,localesp ,,pDebugValues);
  #ELSE
    createworkunit        := WsWorkunits.Compile_Wuid(ECL  ,pcluster ,localesp ,,pDebugValues);
  #END

  // -- Get the wuid, either an existing one, or create a new one.
  // -- don't think I need to check condition here yet.
  // -- added output of wuid instead of just returning the string wuid because
  // -- platform was executing both the "then" and "else" results each time, creating a new iteration wuid even when 
  // -- it returned the old one(child_wuid).  changing this to the output stopped that.
  iteration_wuid := iff((     DoesFileExist //start file exists(a temp file, so this is a rerun)
                          or  (unsigned)latest_completed_iteration  >= ((unsigned)StartIteration + (unsigned)pNumMaxIterations - 1) 
                          or  (unsigned)Iteration                   >  ((unsigned)StartIteration + (unsigned)pNumMaxIterations - 1)
                        ) 
                        and (unsigned)StartIteration < (unsigned)latest_completed_iteration 
                        and (unsigned)StartIteration < (unsigned)child_iteration1
                        and trim(child_wuid1) != '' 
                        and pOnlyCompile = false
                            ,output(Child_Wuid                                     ,named('Iteration_Wuid'                                      ),overwrite)
                            ,output(createworkunit                                 ,named('Iteration_Wuid'                                      ),overwrite)  
                            // ,Child_Wuid 
                            // ,createworkunit  
                    );

//use child wuid so it doesn't reevaluate it and create another workunit
  createwatcherworkunit := WorkMan.CreateWuid_Raw(
       '#workunit(\'name\',\'---WorkMan.mac_Watcher--- for wuid: ' + Iteration_Wuid_result + ', ' + if(pBuildName != '' , pBuildName ,'') +  ', version: ' + pversion + ' iteration: ' + Iteration + '\');\n'       
     + 'WorkMan.mac_Watcher(\'' + Iteration_Wuid_result + '\',\'' + %'WORKMAN_CHILDRUNNER_EVENT'% + '\',\'' + %'FAILUREEMAILS'% + '\',\'' + pPollingFrequency + '\',\'' + localesp + '\');'
    ,watchercluster
    ,localesp
    ,
    ,pDebugValues
  );

  child_wuid2    := WorkMan.get_Scalar_Result(workunit ,'Iteration_Wuid');
  stop_condition := Get_Results(child_wuid2).stopcondition;

                       

  // shouldexit := iff((unsigned)latest_completed_iteration >= ((unsigned)pStartIteration + (unsigned)pNumMaxIterations - 1) 
  shouldexit := iff(   (trim(#TEXT(pNumMaxIterations))  != '' and trim(#TEXT(pNumMinIterations))  = '' and trim(pStopCondition)   = '' and (unsigned)latest_completed_iteration + 1 >= ((unsigned)StartIteration + (unsigned)%NumMaxIterations%))  //default, will do max iterations period.
                    or (trim(#TEXT(pNumMaxIterations))   = '' and trim(#TEXT(pNumMinIterations))  = '' and trim(pStopCondition)  != '' and stop_condition = true) //open ended iterating, no min or max # of iterations
                    or (trim(#TEXT(pNumMaxIterations))   = '' and trim(#TEXT(pNumMinIterations)) != '' and trim(pStopCondition)  != '' and ( unsigned)latest_completed_iteration + 1 >= ((unsigned)StartIteration + (unsigned)%NumMinIterations%) and stop_condition = true)//good, stop condition will stop it after the minimum has been reached
                    or (trim(#TEXT(pNumMaxIterations))  != '' and trim(#TEXT(pNumMinIterations))  = '' and trim(pStopCondition)  != '' and ((unsigned)latest_completed_iteration + 1 >= ((unsigned)StartIteration + (unsigned)%NumMaxIterations%) or  stop_condition = true))//if hit stop condition before max iteration, stop there.  no minimum number, but will do at least one.
                    or (trim(#TEXT(pNumMaxIterations))  != '' and trim(#TEXT(pNumMinIterations)) != '' and trim(pStopCondition)  != '' and ((unsigned)latest_completed_iteration + 1 >= ((unsigned)StartIteration + (unsigned)%NumMaxIterations%) or ((unsigned)latest_completed_iteration + 1 >= ((unsigned)StartIteration + (unsigned)%NumMinIterations%) and stop_condition = true) )) //will do minimum number of iterations at least, stop at maximum unless the stop condition is true                  
                  ,sequential(output('Completed Successfully on ' + WorkMan.getTimeDate(),named('ChildRunner_Status'    ),overwrite),fail('Fail workunit to get it out of the scheduler.  All iterations completed on ' + WorkMan.getTimeDate() + '.'))
                );
  
  iteration_wuid_html     := '<a href="/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + Iteration_Wuid_result + '">' + Iteration_Wuid_result + '</a>';
  
  Child_watcher_Wuid      := WorkMan.get_Scalar_Result(workunit ,'Watcher_Wuid');

  clickableWatcher_wuid   := '<a href="/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + Child_watcher_Wuid + '">' + Child_watcher_Wuid + '</a>';

  StartDataset            := dataset([{'',pBuildName,Child_Wuid2,WorkMan.get_Owner(Child_Wuid2,localesp),'','','',Iteration,pversion,'',''}],WorkMan.layouts.wks_slim);
  
  ds_wuids := WorkMan.get_DS_Result(workunit        ,'Workunits',WorkMan.layouts.wks_slim);

  import std;
  kick_Off_Child := sequential(
       output(try_Number                                        ,named('Try_Number'                                          ),overwrite)
      ,output('Kicked Off Iteration'                            ,named('Last_Action_Performed'                               ),overwrite)
      ,output(dataset([{'kick_Off_Child',(unsigned)Iteration  ,Iteration,WorkMan.getTimeDate()}],{string action,unsigned int_iteration,string str_iteration,string datetime})              ,named('dsIteration'           ),extend   )  //just for organizing these results
      ,if((unsigned)WorkMan.get_Scalar_Result(workunit,'Current_Iteration') =  0 and (unsigned)WorkMan.get_Scalar_Result(workunit,'Current_Iteration') < 1000000  ,output((unsigned)Iteration                                         ,named('Current_Iteration'                                           ),overwrite))
      ,shouldexit
      ,iteration_wuid                                    
      // ,output(iteration_wuid                                    ,named('Iteration_Wuid'                                      ),overwrite)
      ,output(iteration_wuid_html                               ,named('Iteration_Wuid__html'                                ),overwrite)
      // ,output(dataset([{WorkMan.get_Scalar_Result(workunit ,'Iteration_Wuid__html'),WorkMan.get_Jobname(Iteration_Wuid_result,localesp)}  ],lay_iterations)  ,named('Iteration_Wuids__html'                               ),extend)
      // ,output(dataset([{WorkMan.get_Scalar_Result(workunit ,'Iteration_Wuid__html'),WorkMan.get_Jobname(Iteration_Wuid_result,localesp)}  ],lay_iterations2)  ,named('Iteration_Wuids__html2'                               ),extend)
      ,output(''                                                ,named('Watcher_Wuid'                                        ),overwrite)
      ,output(''                                                ,named('Watcher_Wuid__html'                                  ),overwrite)
      ,output(%'WORKMAN_CHILDRUNNER_EVENT'%                                        ,named('NotifyEvent'                                         ),overwrite)
      ,output('------------------------------------------------------------------------------'  ,named('_'  ),overwrite)
      ,output('-- Restart Functionality Work Follows'                                           ,named('__' ),overwrite)
      ,output('------------------------------------------------------------------------------'  ,named('___'),overwrite)
      #IF(pOnlyCompile = false)
      ,if(OutputFilename != '' and not DoesFileExist ,WorkMan.Update_File(StartFilename,ds_wuids + StartExistingDataset + StartDataset,false,true,'wuid'))
      #END
      ,STD.System.Debug.Sleep(30000)  //sleep for 30 seconds before kicking this off because of problems with it returning in a compile state
      ,output(createwatcherworkunit                             ,named('Watcher_Wuid'                                        ),overwrite)
      ,output(clickableWatcher_wuid                             ,named('Watcher_Wuid__html'                                  ),overwrite)
      // ,output(dataset([{WorkMan.get_Scalar_Result(workunit ,'Watcher_Wuid__html'),WorkMan.get_Jobname(Child_watcher_Wuid,localesp)}  ],lay_iterations)  ,named('Watcher_Wuids__html'                               ),extend)
  );
  
  // ----------------------------------------------------------------------------------
  // -- Gather Child Info
  // ----------------------------------------------------------------------------------
  getstate       := WorkMan.get_State(child_wuid2,localesp);    
  realstate      := if(getstate[1..6] = 'failed' ,'failed' ,getstate);
  thor_time      := WorkMan.get_TotalTime(child_wuid2,localesp); 
  thor_time_secs := WorkMan.Convert2Seconds(thor_time);
  jobname        := WorkMan.get_Jobname(child_wuid2,localesp);   
  Errors         := WorkMan.get_Errors(child_wuid2,localesp);
  Owner          := WorkMan.get_Owner(child_wuid2,localesp);
  
  thiswuid       := if(pOutputSuperfile = '' ,if(WorkMan.get_Scalar_Result(workunit       ,'Workunits') != '',WorkMan.get_DS_Result(workunit        ,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim))
                                             ,ds_output_superfile(version = pversion)
  );
  
  Run_Total_Time_secs := sum(thiswuid,Total_Time_secs) + thor_time_secs;
  Run_Total_Thor_Time := WorkMan.ConvertSecs2ReadableTime((real8)Run_Total_Time_secs);

  //name, wuid, iteration#, version, thor time, etc
// max_iterations     
// min_iterations     
// stop_condition_calc
// stop_condition     

  Advice := eventextra('Advice');



  dWUDetails  := project(dataset([{jobname ,pBuildName,child_wuid2 ,Owner,localesp,WorkMan._Config.LocalENV,getstate ,Iteration ,pversion ,thor_time,thor_time_secs,Run_Total_Thor_Time,Run_Total_Time_secs,'',0.0,WorkMan.getTimeDate()
    ,StartIteration ,#TEXT(pNumMaxIterations),#TEXT(pNumMinIterations),pStopCondition,Get_Results(child_wuid2).stopcondition   
    // ,#TEXT(pStartIteration) ,%'NumMaxIterations'%,%'NumMinIterations'%,pStopCondition,Get_Results(child_wuid2).stopcondition   
    ,Get_Results(child_wuid2).ds_results
    ,Advice
    ,Errors}] ,WorkMan.layouts.wks_slim),transform(WorkMan.layouts.wks_slim ,self.results := Get_Results(child_wuid2).ds_results,self := left));
    
  jobname2    := if(jobname != '' ,jobname ,child_wuid2);
  sendemail   := WorkMan.Send_Email(
                             iff(getstate in ['failed','aborted']  ,%'FAILUREEMAILS'% ,pNotifyEmails)
                            ,jobname2 + ' has ' + getstate + ' in ' + thor_time + ' on ' + _Control.ThisEnvironment.Name + ' on this date: ' + WorkMan.getTimeDate()
                            , if(jobname != ''
                            , 'Jobname'         + '\t\t\t: '    + jobname                                                                             + '\n','')
                            + 'workunit'        + '\t\t\t: '    + child_wuid2                                                                         + '\n' 
                            + 'workunit link'   + '\t\t\t: '    + 'http://' + localesp + ':8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + child_wuid2 + '#/stub/Summary\n' 
                            + 'Owner'           + '\t\t\t\t: '  + Owner                                                                               + '\n'
                            + 'State'           + '\t\t\t\t: '  + getstate                                                                            + '\n'
                            + 'Total Thor Time' + '\t\t\t: '    + thor_time                                                                           + '\n'
                            + 'Iteration'       + '\t\t\t: '    + Iteration                                                                           + '\n'
                            + 'Version'         + '\t\t\t\t: '  + pversion                                                                            + '\n'

#IF(trim(#TEXT(pStartIteration))  != '') 
                            + 'Start Iteration\t\t\t: ' + #TEXT(pStartIteration) + '\n'
#END 
#IF(trim(#TEXT(pNumMinIterations))  != '') 
                            + 'Min Iterations\t\t\t: ' + %'NumMinIterations'%+ '\n'
#END 
#IF(trim(#TEXT(pNumMaxIterations))  != '') 
                            + 'Max Iterations\t\t\t: ' + %'NumMaxIterations'%+ '\n'
#END 
                            + Get_Results(child_wuid2).email_outputs
                            + 'Runner Wuid link\t\t: ' + 'http://' + localesp + ':8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + workunit   + '#/stub/Summary\n' 
                            + if(trim(Errors) != '' ,'FailMessage(s)\t\t\t: \n' + Errors + '\n','')
                            + iff(getstate in ['failed','aborted']
                                , '\nThis workunit ' + getstate + '.  I am awaiting your advice on what to do next.\n'
                                + 'Here are your options(Simply click the link beside your choice to advise the process.DO NOT CLICK SUBMIT ON THE WEBPAGE THAT COMES UP!):\n\n'
                                + 'Rerun iteration'               + '\t\t\t: '  + WorkMan.Push_Event_Result_Link(%'WORKMAN_CHILDRUNNER_EVENT'%,'Rerun',localesp) + '\n'
                                + 'Move on to the next iteration' + '\t: '      + WorkMan.Push_Event_Result_Link(%'WORKMAN_CHILDRUNNER_EVENT'%,'Skip' ,localesp) + '\n'
                                + 'Fail workunit'                 + '\t\t\t: '  + WorkMan.Push_Event_Result_Link(%'WORKMAN_CHILDRUNNER_EVENT'%,'Fail' ,localesp) + '\n'                                
                              ,'')
                  );

  //if you are using a superfile, then the children should be in there, no need to get the workunits dataset from the children.
  childwuids        := if(pOutputSuperfile = '' and WorkMan.get_Scalar_Result(child_wuid2,'Workunits',localesp) != '' and localesp in WorkMan._Config.LocalEsps
                          ,WorkMan.get_DS_Result(child_wuid2 ,'Workunits',WorkMan.layouts.wks_slim)
                          ,dataset([],WorkMan.layouts.wks_slim)
                       );
  
  iter_Child_Wuids  := iterate(project(childwuids,transform(recordof(left),self.Run_Total_Time_secs := left.Total_Time_secs,self := left)),transform(recordof(left)
    ,self.Run_Total_Time_secs := if(counter = 1,Run_Total_Time_secs,left.Run_Total_Time_secs) + right.Run_Total_Time_secs
    ,self.Run_Total_Thor_Time := WorkMan.ConvertSecs2ReadableTime((real8)self.Run_Total_Time_secs),self := right));

  temp_wuid_bucket_fname    := OutputFilename + '___temp___bucket';
  temp_wuid_bucket_dataset  := dataset(temp_wuid_bucket_fname ,WorkMan.layouts.wks_slim,thor,opt);
  iterations_bucket_filename:= OutputFilename + '___iterations___bucket';
  iterations_bucket_dataset := dataset(iterations_bucket_filename   ,WorkMan.layouts.wks_slim,thor,opt);

  blank_reruns := parallel(
                     output(''  ,named('Rerun__html'),overwrite)
                    ,output(''  ,named('Skip__html' ),overwrite)
                    ,output(''  ,named('Fail__html' ),overwrite) 
                  );

  reruns := parallel(
                     output('------------------------------------------------------------------------------'                                          ,named('_______'   ),overwrite)
                    ,output('-- The workunit ' + getstate + '.  Please click one of the 3 links below to rerun it, skip it, or fail the whole thing.' ,named('________'  ),overwrite)
                    ,output('------------------------------------------------------------------------------'                                          ,named('_________' ),overwrite)
                    ,output('<a href="' + WorkMan.Push_Event_Result_Link(%'WORKMAN_CHILDRUNNER_EVENT'%,'Rerun',localesp) + '">Rerun Workunit</a>'                        ,named('Rerun__html'),overwrite)
                    ,output('<a href="' + WorkMan.Push_Event_Result_Link(%'WORKMAN_CHILDRUNNER_EVENT'%,'Skip' ,localesp) + '">Skip Workunit</a>'                         ,named('Skip__html' ),overwrite)
                    ,output('<a href="' + WorkMan.Push_Event_Result_Link(%'WORKMAN_CHILDRUNNER_EVENT'%,'Fail' ,localesp) + '">Fail Workunit</a>'                         ,named('Fail__html' ),overwrite)                              

                     // output('<a href="http://' + localesp + ':8010/WsWorkunits/WUPushEvent?ver_=1.48&.EventName=' + %'WORKMAN_CHILDRUNNER_EVENT'% + '&.EventText=%3CEvent%3E%3CAdvice%3E' + 'Rerun' + '%3C%2FAdvice%3E%3C%2FEvent%3E">Rerun Workunit</a>' ,named('Rerun__html'),overwrite)
                    // ,output('<a href="http://' + localesp + ':8010/WsWorkunits/WUPushEvent?ver_=1.48&.EventName=' + %'WORKMAN_CHILDRUNNER_EVENT'% + '&.EventText=%3CEvent%3E%3CAdvice%3E' + 'Skip'  + '%3C%2FAdvice%3E%3C%2FEvent%3E">Skip Workunit</a>'  ,named('Skip__html' ),overwrite)
                    // ,output('<a href="http://' + localesp + ':8010/WsWorkunits/WUPushEvent?ver_=1.48&.EventName=' + %'WORKMAN_CHILDRUNNER_EVENT'% + '&.EventText=%3CEvent%3E%3CAdvice%3E' + 'Fail'  + '%3C%2FAdvice%3E%3C%2FEvent%3E">Fail Workunit</a>'  ,named('Fail__html' ),overwrite)                              
                  );
  result_Iteration_Number      := WorkMan.get_Scalar_Result(workunit ,'Current_Iteration'           );
  result_Iteration_Number2     := WorkMan.get_Scalar_Result(workunit ,'Current_Iteration'           );
  result_Iteration_Wuid        := WorkMan.get_Scalar_Result(workunit ,'Iteration_Wuid'      );
  result_Iteration_Wuid__html  := WorkMan.get_Scalar_Result(workunit ,'Iteration_Wuid__html');
  result_Iteration_Wuids__html := WorkMan.get_DS_Result    (workunit ,'Iteration_Wuids__html',lay_iterations);
  result_Watcher_Wuid          := WorkMan.get_Scalar_Result(workunit ,'Watcher_Wuid'        );
  result_Watcher_Wuid__html    := WorkMan.get_Scalar_Result(workunit ,'Watcher_Wuid__html'  );
  result_NotifyEvent           := WorkMan.get_Scalar_Result(workunit ,'NotifyEvent'         );

  // ----------------------------------------------------------------------------------
  // -- Get EventExtra text
  // ----------------------------------------------------------------------------------
  
  tidy_Up_For_Skip := iff(regexfind('skip' ,Advice,nocase)          
              ,sequential(
                 iff(OutputFilename != ''
                    ,sequential(
                       WorkMan.Update_File (iterations_bucket_filename,ds_wuids + iterations_bucket_dataset + temp_wuid_bucket_dataset,false,true,'wuid')
                       // tools.macf_WriteFile(OutputFilename,temp_wuid_bucket_dataset,false,false,true)
                      // ,if(pOutputSuperfile != '' ,std.file.addsuperfile(pOutputSuperfile,OutputFilename))
                      ,if(std.file.fileexists(StartFilename         )  ,std.file.deletelogicalfile(StartFilename         ))  //don't need this around anymore after this finishes successfully.  it is only used to restart.
                      ,if(std.file.fileexists(temp_wuid_bucket_fname)  ,std.file.deletelogicalfile(temp_wuid_bucket_fname))  //don't need this around anymore after this finishes successfully.  it is only used to restart.
                    )
                 )
              )
           );
             
  sendFeedbackEmail := WorkMan.Send_Email(
                             iff(getstate in ['failed','aborted']  ,%'FAILUREEMAILS'% ,pNotifyEmails)
                            ,'Your Advice is to ' + Advice + ' this workunit: ' + jobname2 +  ' on ' + _Control.ThisEnvironment.Name + ' on this date: ' + WorkMan.getTimeDate()
                            ,  'Child wuid' 			+ '\t\t\t: ' 		+ child_wuid2                                                                          + '\n'
                             + 'Child link' 			+ '\t\t\t: ' 		+ 'http://' + localesp + ':8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + child_wuid2  + '#/stub/Summary\n' 
                             + 'Child Jobname' 		+ '\t\t\t: ' 		+ jobname                                                                             + '\n'
                             + 'Advice'           + '\t\t\t\t: ' 	+ Advice                                                                              + '\n'
                             + 'ChildRunner Wuid' + '\t\t: ' 		  + workunit                                                                            + '\n'
                             + 'ChildRunner link' + '\t\t: ' 		  + 'http://' + localesp + ':8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + workunit    + '#/stub/Summary\n' 
                          );


  kickWuid   := sequential(if(try_Number > 1  
                        ,sequential(sendFeedbackEmail,output(dedup(sort(ds_wuids + dWUDetails + iter_Child_Wuids + StartExistingDataset,wuid,-time_finished),wuid),named('Workunits'),OVERWRITE,ALL)))
                        ,output(dataset([{'Kicked Off Iteration',WorkMan.getTimeDate()}],{string Action_Performed,string time}),named('Actions_Performed'),extend),blank_reruns,kick_Off_Child);    
   
  Gather_Child_Info :=  sequential(
              output(dataset([{'Get Iteration Info',WorkMan.getTimeDate()}],{string Action_Performed,string time}),named('Actions_Performed'),extend)
             ,output('------------------------------------------------------------------------------' ,named('____'  ),overwrite)
             ,output('-- Updating Workunit Details Follows'                                           ,named('_____' ),overwrite)
             ,output('------------------------------------------------------------------------------' ,named('______'),overwrite)
          #IF(pOnlyCompile = false)
             ,if(OutputFilename != ''  ,WorkMan.Update_File(temp_wuid_bucket_fname,ds_wuids + dWUDetails + iter_Child_Wuids + StartExistingDataset,false,true,'wuid'))
          #END
             ,output(dedup(sort(ds_wuids + dWUDetails + iter_Child_Wuids + StartExistingDataset,wuid,-time_finished),wuid),named('Workunits'),OVERWRITE,ALL    )
             // ,output(dWUDetails + iter_Child_Wuids,named('Workunits'),EXTEND    )
             // ,output(dWUDetails,named('dWUDetails'),EXTEND    )
             // ,output(iter_Child_Wuids,named('iter_Child_Wuids'),EXTEND    )
             // ,output(Get_Results(child_wuid2).ds_results ,named('Results'),EXTEND)
             ,output('Get Iteration Info'         ,named('Last_Action_Performed' ),overwrite )
             ,output(dataset([{WorkMan.get_Scalar_Result(workunit ,'Iteration_Wuid__html'),WorkMan.get_Jobname(Iteration_Wuid_result,localesp),WorkMan.get_Scalar_Result(workunit ,'Watcher_Wuid__html'),WorkMan.get_Jobname(Child_watcher_Wuid,localesp)}  ],lay_iterations)  ,named('Iteration_Wuids__html'                               ),extend)
            ,if(getstate in ['completed'] or pForceSkip = true or pOnlyCompile = true
                ,sequential(
                   iff(OutputFilename != '' and pOnlyCompile = false
                      ,sequential(
                         WorkMan.Update_File (iterations_bucket_filename,ds_wuids + iterations_bucket_dataset + temp_wuid_bucket_dataset,false,true,'wuid')
                         // tools.macf_WriteFile(OutputFilename,temp_wuid_bucket_dataset,false,false,true)
                        // ,if(pOutputSuperfile != '' ,std.file.addsuperfile(pOutputSuperfile,OutputFilename))
                        ,if(std.file.fileexists(StartFilename         )  ,std.file.deletelogicalfile(StartFilename         ))  //don't need this around anymore after this finishes successfully.  it is only used to restart.
                        ,if(std.file.fileexists(temp_wuid_bucket_fname)  ,std.file.deletelogicalfile(temp_wuid_bucket_fname))  //don't need this around anymore after this finishes successfully.  it is only used to restart.
                      )
                   )
                                                                 
  // pNumMaxIterations   = '' and pNumMinIterations  = '' and pStopCondition   = ''  //INVALID, should error out
  // pNumMaxIterations   = '' and pNumMinIterations != '' and pStopCondition   = ''  //INVALID, need max iterations
  // pNumMaxIterations  != '' and pNumMinIterations != '' and pStopCondition   = ''  //INVALID, do not need minimum number since there is no condition.  

                 ,if(
                       (trim(#TEXT(pNumMaxIterations))  != '' and trim(#TEXT(pNumMinIterations))  = '' and trim(pStopCondition)   = '' and (unsigned)result_Iteration_Number + 1 >= ((unsigned)StartIteration + (unsigned)%NumMaxIterations%))  //default, will do max iterations period.
                    or (trim(#TEXT(pNumMaxIterations))   = '' and trim(#TEXT(pNumMinIterations))  = '' and trim(pStopCondition)  != '' and stop_condition = true) //open ended iterating, no min or max # of iterations
                    or (trim(#TEXT(pNumMaxIterations))   = '' and trim(#TEXT(pNumMinIterations)) != '' and trim(pStopCondition)  != '' and ( unsigned)result_Iteration_Number + 1 >= ((unsigned)StartIteration + (unsigned)%NumMinIterations%) and stop_condition = true)//good, stop condition will stop it after the minimum has been reached
                    or (trim(#TEXT(pNumMaxIterations))  != '' and trim(#TEXT(pNumMinIterations))  = '' and trim(pStopCondition)  != '' and ((unsigned)result_Iteration_Number + 1 >= ((unsigned)StartIteration + (unsigned)%NumMaxIterations%) or  stop_condition = true))//if hit stop condition before max iteration, stop there.  no minimum number, but will do at least one.
                    or (trim(#TEXT(pNumMaxIterations))  != '' and trim(#TEXT(pNumMinIterations)) != '' and trim(pStopCondition)  != '' and ((unsigned)result_Iteration_Number + 1 >= ((unsigned)StartIteration + (unsigned)%NumMaxIterations%) or ((unsigned)result_Iteration_Number + 1 >= ((unsigned)StartIteration + (unsigned)%NumMinIterations%) and stop_condition = true) )) //will do minimum number of iterations at least, stop at maximum unless the stop condition is true                  
                    or pOnlyCompile = true
                    // ,if((unsigned)result_Iteration_Number + 1 < ((unsigned)pStartIteration + (unsigned)pNumMaxIterations) and Get_Results(child_wuid2).stopcondition = false
                    // -- all iterations are finished either by max number iterations reached, or stop condition is true
                    ,sequential(
                       sendemail
                      ,WorkMan.mac_Notify(pNotifyEvent,,,pESP) 
                      ,blank_reruns   
                      #IF(pOnlyCompile = false)
                      ,tools.macf_WriteFile(OutputFilename,iterations_bucket_dataset,false,false,true)  //write out final file telling the parent that all iterations are complete
                      ,if(pOutputSuperfile != '' ,std.file.addsuperfile(pOutputSuperfile,OutputFilename)) //add it to the superfile
                      #END
                      ,if(std.file.fileexists(iterations_bucket_filename)  ,std.file.deletelogicalfile(iterations_bucket_filename))  //don't need this around anymore after this finishes successfully.  it is only used to restart.
                      ,output('Completed Successfully on ' + WorkMan.getTimeDate() ,named('ChildRunner_Status'    ),overwrite)
                      ,fail('Fail workunit to get it out of the scheduler.  All iterations completed on ' + WorkMan.getTimeDate() + '.')
                      // ,output('Deschedule workunit to get it out of the scheduler.  The child wuid completed.')
                      // ,WorkMan.Deschedule_Wuid(workunit)
                    )
                    // -- all iterations not finished
                    ,sequential(
                       // -- increment iteration #, kick off next iteration
                       sendemail
                      ,output(dataset([{'Gather_Child_Info',(unsigned)result_Iteration_Number2 + 1  ,result_Iteration_Number2,WorkMan.getTimeDate()}],{string action,unsigned int_iteration,string str_iteration,string datetime})              ,named('dsIteration'           ),extend   )  //just for organizing these results
                      ,output((unsigned)result_Iteration_Number2 + 1           ,named('Current_Iteration'          ),overwrite)
                      ,output(0                                                ,named('Try_Number'         ),overwrite) //zero this out if going to next iteration
                      ,kickWuid

                    )
                  )
                )
                ,sequential(
                  reruns
                 ,sendemail
               )
             )
             
             //,if failed or aborted, go back in scheduler waiting for instructions
                  // getstate in ['failed','aborted']  => sequential()
             // ,iff(getstate in ['failed','aborted'] ,fail('Fail workunit because wuid ' + Child_Wuid + ' has ' + getstate + '.'))
          )
          ;

  // http://10.241.3.241:8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=W20150330-165839#/stub/Summary

/*
  first call(without a notify)
    Last_Action_Performed = nothing
    no advice
    try number will be zero
    child wuid will be blank
    kicks off iteration
  second call(because iteration finished, now need to get wuid details)
    Last_Action_Performed = kicked iteration
    no advice
    try number will be 1
    child wuid non-blank
    child wuid not in workunits dataset yet
    gathers info on iteration, either notifies parent that it completed and fails itself, or sends email asking for advice and goes back in scheduler because the iteration failed/aborted 
  third call(this will only happen if the workunit failed or aborted)
    Last_Action_Performed = 'Get Iteration Info'
    advice hopefully will be rerun,skip or fail.  in absense of advice, send email requesting advice again & go back in scheduler
    try number will be 1
    child wuid non-blank
    child wuid in workunits dataset
    for reruns, will kick off iteration again
  fourth call
    Last_Action_Performed = kicked iteration
    no advice
    try number will be 2
    child wuid non-blank
    child wuid not in workunits dataset
    gathers info on iteration, either notifies parent that it completed and fails itself, or goes back in scheduler because the iteration failed/aborted 

*/  
  Last_Action_Performed     := global(WorkMan.get_Scalar_Result(workunit ,'Last_Action_Performed'    )                            ,few);
  Loop_Counter := global(WorkMan.get_Scalar_Result(workunit ,'Loop_Counter')                            ,few);
  childstate   := global(WorkMan.get_State(trim(WorkMan.get_Scalar_Result(workunit ,'Iteration_Wuid'))) ,few);
  
  // lay_actions := {string Action_Performed,string time,string };
  // ----------------------------------------------------------------------------------
  // -- Return result
  // ----------------------------------------------------------------------------------
  // http://10.241.3.241:8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=W20150330-165839#/stub/Summary

  // clickable_parent_wuid := '<a href="http://' + pESP + ':8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + pParentWuid + '#/stub/Summary">Parent Workunit</a>';
  // outputRunnerwuidcode  := 'output(\'<a href="http://' + localesp + ':8010/?inner=../WsWorkunits/WUInfo%3FWuid%3D' + workunit + '">Parent Workunit</a>\' ,named(\'Parent_Wuid__html\'));\n';

  failOrSkip := sequential(
     output(dataset([{'Received advice after failure.  It is: ' + Advice,WorkMan.getTimeDate()}],{string Action_Performed,string time}),named('Actions_Performed'),extend)
    ,sendFeedbackEmail
    ,output(dedup(sort(ds_wuids + dWUDetails + iter_Child_Wuids,wuid,-time_finished),wuid),named('Workunits'),OVERWRITE,ALL)
    ,tidy_Up_For_Skip
    ,if(~(  (trim(#TEXT(pNumMaxIterations))  != '' and trim(#TEXT(pNumMinIterations))  = '' and trim(pStopCondition)   = '' and (unsigned)result_Iteration_Number + 1 >= ((unsigned)StartIteration + (unsigned)%NumMaxIterations%))  //default, will do max iterations period.
         or (trim(#TEXT(pNumMaxIterations))   = '' and trim(#TEXT(pNumMinIterations))  = '' and trim(pStopCondition)  != '' and stop_condition = true) //open ended iterating, no min or max # of iterations
         or (trim(#TEXT(pNumMaxIterations))   = '' and trim(#TEXT(pNumMinIterations)) != '' and trim(pStopCondition)  != '' and ( unsigned)result_Iteration_Number + 1 >= ((unsigned)StartIteration + (unsigned)%NumMinIterations%) and stop_condition = true)//good, stop condition will stop it after the minimum has been reached
         or (trim(#TEXT(pNumMaxIterations))  != '' and trim(#TEXT(pNumMinIterations))  = '' and trim(pStopCondition)  != '' and ((unsigned)result_Iteration_Number + 1 >= ((unsigned)StartIteration + (unsigned)%NumMaxIterations%) or  stop_condition = true))//if hit stop condition before max iteration, stop there.  no minimum number, but will do at least one.
         or (trim(#TEXT(pNumMaxIterations))  != '' and trim(#TEXT(pNumMinIterations)) != '' and trim(pStopCondition)  != '' and ((unsigned)result_Iteration_Number + 1 >= ((unsigned)StartIteration + (unsigned)%NumMaxIterations%) or ((unsigned)result_Iteration_Number + 1 >= ((unsigned)StartIteration + (unsigned)%NumMinIterations%) and stop_condition = true) )) //will do minimum number of iterations at least, stop at maximum unless the stop condition is true                  
        )  and not regexfind('fail' ,Advice,nocase)
    // ,if((unsigned)result_Iteration_Number + 1 < ((unsigned)pStartIteration + (unsigned)pNumMaxIterations) and not regexfind('fail' ,Advice,nocase)
      ,sequential(
         // -- increment iteration #, kick off next iteration
         output(dataset([{'failOrSkip',(unsigned)result_Iteration_Number2 + 1  ,result_Iteration_Number2,WorkMan.getTimeDate()}],{string action,unsigned int_iteration,string str_iteration,string datetime})              ,named('dsIteration'           ),extend   )  //just for organizing these results
        ,output((unsigned)result_Iteration_Number2 + 1            ,named('Current_Iteration'          ),overwrite)
        ,output(0                                                 ,named('Try_Number'         ),overwrite) //zero this out if going to next iteration
        ,kickWuid

      )
      ,sequential(
         WorkMan.mac_Notify(pNotifyEvent,,,pESP)
        ,blank_reruns
        ,if(regexfind('skip' ,Advice,nocase)  //cleanup for skip because only will be here with skip if we are done iterating
          ,sequential(
             tools.macf_WriteFile(OutputFilename,iterations_bucket_dataset,false,false,true)  //write out final file telling the parent that all iterations are complete
            ,if(pOutputSuperfile != '' ,std.file.addsuperfile(pOutputSuperfile,OutputFilename)) //add it to the superfile
            ,if(std.file.fileexists(iterations_bucket_filename)  ,std.file.deletelogicalfile(iterations_bucket_filename))  //don't need this around anymore after this finishes successfully.  it is only used to restart.
            ,output('Completed Successfully on ' + WorkMan.getTimeDate() ,named('ChildRunner_Status'    ),overwrite)
            ,fail('Fail workunit to get it out of the scheduler.  All iterations completed on ' + WorkMan.getTimeDate() + '.')
          )
        )
        ,output('Failed on ' + WorkMan.getTimeDate() + ' because wuid ' + child_wuid2 + ' has ' + getstate + ', and your advice was to ' + Advice + ' it' ,named('ChildRunner_Status'    ),overwrite)
        ,fail('Fail workunit because wuid ' + child_wuid2 + ' has ' + getstate + ', and your advice was to ' + Advice + ' it on ' + WorkMan.getTimeDate())
      )
    )
  );
  // failOrSkip := sequential(output(dataset([{'Received advice after failure.  It is: ' + Advice,WorkMan.getTimeDate()}],{string Action_Performed,string time}),named('Actions_Performed'),extend),sendFeedbackEmail,tidy_Up_For_Skip,WorkMan.mac_Notify(pNotifyEvent,,,pESP),blank_reruns,output('Deschedule workunit because wuid ' + Child_Wuid + ' has ' + getstate + ', and your advice was to ' + Advice + ' it on ' + WorkMan.getTimeDate()),WorkMan.Deschedule_Wuid(workunit));

  default    := sequential(
         output(dataset([{'Sending email--default',WorkMan.getTimeDate()}],{string Action_Performed,string time}),named('Actions_Performed'),extend)
        ,output('Sending email--default' ,named('Last_Action_Performed'),overwrite)
        // ,output('Do dummy output to see if it doesn\'t matter what is in here, it will kick off new wuids anyway',named('DefaultOutput'),overwrite)
        ,sendemail
        ,blank_reruns
      );//default  send an email 

  // -- in case we finished the iterations but come back in here to run more
  // -- need to remove the output file from any supers
  // -- then rename it to the __start file so the childrunner can see it
  import tools;
  fixstart_filename := 
    if(std.file.fileexists(OutputFilename) and not std.file.fileexists(StartFilename)
      ,sequential(
         nothor(Tools.fun_ClearfilesFromSupers(dataset([{OutputFilename}], Tools.Layout_Names), false))
        ,std.file.renamelogicalfile(OutputFilename,StartFilename)
      )
  );

  ds_wuids2 := if(trim(WorkMan.get_Scalar_Result(workunit,'Workunits')) not in ['','[undefined]']
                ,dedup(sort(ds_wuids + StartExistingDataset,wuid,-time_finished),wuid)
                ,dataset([],WorkMan.layouts.wks_slim)
               );

  child_status_result := trim(wk_ut.get_Scalar_Result(workunit ,'Iteration_Status'));


  doit := sequential(
     fixstart_filename
    ,output(WorkMan.getTimeDate()                            ,named('DateTime'              ),overwrite)
    ,output(Last_Action_Performed                            ,named('ChildRunner_Status'    ),overwrite)
    ,output(ds_wuids2                                        ,named('Workunits'             ),overwrite,ALL)
    ,output(pBuildName                                       ,named('Build'                 ),overwrite)
    ,output(pversion                                         ,named('Version'               ),overwrite)
    ,output((unsigned)result_Iteration_Number                ,named('Current_Iteration'     ),overwrite)  //just for organizing these results
// #IF(trim(#TEXT(pStartIteration))  != '') 
    ,output(StartIteration                                   ,named('Start_Iteration'       ),overwrite)  //we will have a start iteration no matter if you pass one in or not
// #END 
#IF(trim(#TEXT(pNumMinIterations))  != '') 
    ,output(%'NumMinIterations'%                ,named('Minimum_Iterations'             ),overwrite)  //just for organizing these results
#END 
#IF(trim(#TEXT(pNumMaxIterations))  != '') 
    ,output(%'NumMaxIterations'%                ,named('Maximum_Iterations'             ),overwrite)  //just for organizing these results
#END 
    ,output(dataset([{'doit',(unsigned)result_Iteration_Number  ,result_Iteration_Number,WorkMan.getTimeDate()}],{string action,unsigned int_iteration,string str_iteration,string datetime})              ,named('dsIteration'           ),extend   )  //just for organizing these results
    ,output(if((unsigned)Loop_Counter + 1 > 1, childstate,''),named('Iteration_Status'      ),overwrite)
    ,output(result_Iteration_Wuid                            ,named('Iteration_Wuid'        ),overwrite)
    ,output(result_Iteration_Wuid__html                      ,named('Iteration_Wuid__html'  ),overwrite)
    ,output(dataset([],lay_iterations)                       ,named('Iteration_Wuids__html' ),extend   )
    ,output(result_Watcher_Wuid                              ,named('Watcher_Wuid'          ),overwrite)
    ,output(result_Watcher_Wuid__html                        ,named('Watcher_Wuid__html'    ),overwrite)
    // ,output(dataset([],lay_iterations)                       ,named('Watcher_Wuids__html'   ),extend   )
    ,output(result_NotifyEvent                               ,named('NotifyEvent'           ),overwrite)

    ,output((unsigned)Loop_Counter + 1                       ,named('Loop_Counter'          ),overwrite)
    ,output(dataset([],{string Action_Performed,string time}),named('Actions_Performed'     ),extend   )
    ,output(Last_Action_Performed                            ,named('Last_Action_Performed' ),overwrite)

    ,Get_Results(result_Iteration_Wuid).output_results
    ,output('' ,named('_______'   ),overwrite)
    ,output('' ,named('________'  ),overwrite)
    ,output('' ,named('_________' ),overwrite)
    ,blank_reruns
    ,output(if(pForceSkip = false,Advice,'skip')             ,named('Advice'           ),overwrite) // master will get this result to see what happened with the child
    ,map(

       (Last_Action_Performed in ['Get Iteration Info','Sending email--default'] and regexfind('run'       ,Advice,nocase) and child_status_result in ['failed','aborted','unknown']) or Last_Action_Performed in ['','[undefined]']  => kickWuid           //Kick off new wuid(first time or rerun)
      , Last_Action_Performed in ['Get Iteration Info','Sending email--default'] and regexfind('fail|skip' ,Advice,nocase) and child_status_result in ['failed','aborted','unknown']                                                  => failOrSkip         //if advice to skip or fail, notify parent.
      , Last_Action_Performed =   'Kicked Off Iteration'                                                                   or  child_status_result in ['completed','failed','aborted','unknown']                                      => Gather_Child_Info  //Gather info on wuid after completed/failed/aborted.  if completed, fail this wuid and notify parent.
      , child_status_result not in ['completed','failed','aborted','unknown']                                                                                                                                                         => default //STD.System.Debug.Sleep ( 1000 )  //if it gets notified before the iteration is finished, sleep for a second, then go back in the scheduler.  No biggie.
      ,                                                                                                                                                                                                                                  default                          //send default email.  shouldn't happen, but if does no biggie.
    )  
  );

  doit  : when(%'WORKMAN_CHILDRUNNER_EVENT'%);
  
  return doit;

endmacro;
