/*
// -- put in option for WorkMan.Cleanup_Super.  should be easy
// -- need to put in copy of workman output file to the parent environment.  hopefully can do this in the childrunner.
// -- also make sure that all soapcalls here in the parent reference the correct esp, not just the local in case the childrunner runs on a remote environment.  
// -- also in the childrunner, make sure when it does the notify that it uses the correct esp!!!
// -- also get all attributes ready and check in with correct bug #
// -- then migrate code to alpha_dev using AMT.
// -- and then notify cody and kevin, ask them to test
// -- how to allow it to start where it left off + 1 iteration wise?  so if you specify the start iteration, it will use that.  if you do not specify, it will use last iteration performed + 1.
// -- easy to run multiple ones in parallel????
// -- function/macro to convert old wk_ut files to workman files.  should be easy project.  results child dataset will be blank/null
// -- add cloning to the childrunner carefully

myecl := 
  '#workunit(\'name\',\'bipv2_proxid @version@-@iteration@ workman test\');\n'
+ 'setpreclustercount  := [392933809 ,382870103  ,381654002  ,381326072  ,381147324];\n'
+ 'setmatchesperformed := [6265107   ,1032750    ,346601     ,192764     ,117560   ];\n'
+ 'setconvergence      := [98.406    ,99.730     ,99.909     ,99.949     ,99.969   ];\n'
+ 'output(setpreclustercount [@iteration@]  ,named(\'PreClusterCount\'));\n'
+ 'output(setmatchesperformed[@iteration@]  ,named(\'MatchesPerformed\'));\n'
+ 'output(setconvergence     [@iteration@]  ,named(\'Convergence\'));\n'
// + 'iff(@iteration@ = 2  ,fail(\'Just fail for testing\'));  '                                         
;

// run two iterations, then complete because of the condition
// Then add an iterations, it should run one more and NOT rerun the second.
#workunit('name','Parent Wuid');
WorkMan.mac_WorkMan(
   myecl                                                                            //pECL
  ,'20171204c'                                                                       //pversion
  ,WorkMan._Config.Groupname('50')                                               //pcluster
  ,1                                                                                //pStartIteration
  ,2                                                                                    //pNumMaxIterations 
  ,                                                                                     //pNumMinIterations
  ,'~workman_testing::@version@::simpletest'                                        //pOutputFilename      = '\'\''
  ,'~workman_testing::qa::simpletest'                                               //pOutputSuperfile     = '\'\''
  ,['MatchesPerformed','PreClusterCount','Convergence']                             //pSetResults            
  ,'MatchesPerformed < (100000) or (100 - (MatchesPerformed / PreClusterCount * 100.0)) > (99.9)' //pStopCondition               
  ,['MatchesPerformed_Threshold','Pct_Convergence','Convergence_Threshold']         //pSetNameCalculations
  ,'BIPV2_Best'
  ,pPollingFrequency := '1'
);


  when the childrunner does all of the iterating, emailing, etc., this top level macro is much simpler
    1. kick off the childrunner
    2. check whether all iterations have finished.  so check existence of final file. and also check to make sure that these fields are the same by looking at the last iteration's values 
        start_iteration       
        max_iterations        
        min_iterations        
        stop_condition_formula

    4. it should maintain the workunits result dataset and also have html outputs for the current childrunner.
    5. also another output for all of the childrunners with links to each one in it 
    6. also have another output for all of the skipped wuids.  might want to email if one is skipped out of order.  i.e. if it runs three things, then skips a thing, then runs another thing.
    5. also have output for the last time it returned back to this workunit.  also have this time in the html output for the childrunners.
    7. it also needs to vet all parameters so that the childrunner doesn't have to.  big one is cluster.  make sure the cluster exists in the environment and can accept wuids.
        might be harder when doing remote kickoffs

    3. should it generate any code for the childrunner, such as code for figuring out the iterate condition?  I don't think it needs to...  NOOOO, childrunner does this.

datetime
workunits
build 
version
Current notify event
Current Child Build
Current Child Runner
Childrunner Wuids__html -- wuid, childrunner, watcher, notify event-- maybe pull this from the childrunner -- put time in here
Skipped_Builds  -- should probably email when skipping
returned datetime after wuid kickoff

*/

import tools,WorkMan,_control,ut,std,WsWorkunits;
EXPORT mac_Work(

   pECL                                                               // ECL Code to run.
  ,pversion                                                           // version date
  ,pcluster                                                           // cluster on which to run the above code
  ,pStartIteration      = '1'                                         // default it starts at 1.  If you blank this out(''), it will start where it left off + 1.  
  ,pNumMaxIterations    = '1'                                         // default is 1 iteration.  in the absence of a stop condition, this is the static number of iterations it will run.  for no maximum, pass in ''
  ,pNumMinIterations    = ''                                          // default is no minimum.  when populated, only works in conjunction with a stop condition.
  ,pOutputFilename      = '\'\''                                      // filename to output the workunits dataset to.  
  ,pOutputSuperfile     = '\'\''                                      // superfile to add the above file to. 
  ,pSetResults          = '[]'                                        // output these results from the iteration wuid after each iteration.  These are named results from the workunit kicked off. For dataset results, you do not need to specify the layout.  
  ,pStopCondition       = '\'\''                                      // if condition is true, don't kick off next iteration.  Use above results from set results in this condition.
  ,pSetNameCalculations = '[]'                                        // name the calculations in the above pStopCondition.  each calculation in the pStopCondition that is surrounded by parentheses will be output in the emails and to the childrunner results.
                                                                      // this parameter allows you to name them.
  ,pBuildName         = '\'\''                                        // name of your build/sub-build
  ,pESP               = 'WorkMan._Config.LocalEsp'                    // esp of environment you want your iteration to run on.
  ,pNotifyEmails      = 'WorkMan._Config.EmailAddressNotify'          // email addresses to which to send user communications 
  ,pFailureEmails     = 'WorkMan._Config.EmailAddressNotify'          // email addresses to which to send any failures 
  ,pShouldEmail       = 'true'                                        // boolean on whether to email or not
  ,pPollingFrequency  = '\'5\''                                       // polling frequency of how often the watcher wuid should check the status of the iteration.  Default is 5 which is 5 minutes.
  ,pForceRun          = 'false'                                       // if true, then it will kick off the wuid even if it has already run.  FALSE will skip it if it has already run
  ,pForceSkip         = 'false'                                       // if true, then it will skip all failures and continue with the next iteration.  FALSE will ask if you want to rerun, skip or fail.
  ,pCleanupSuper      = 'false'                                       // if true, then it will cleanup the superfile for all subfiles except ones that contain this version(pversion above)
  ,pDebugValues       = 'dataset([],WsWorkunits.Layouts.DebugValues)' // for the spawning of the wuids.  can use other repositories using this.
  ,pDont_Wait         = 'false'                                       // if false, will wait for the childrunner to finish.  true = it will not wait, it will just submit the childrunner
  ,pParallel          = 'false'                                       // if false, will wait for the childrunner to finish.  true = it will not wait, it will submit the childrunner and also compile set results with the previous call
  ,pCompileOnly       = 'false'                                       // if false, will run the build as normal.  true = it will compile the wuid.  this also means it will only compile one iteration of it.  it will not save the workman files either.  this is mainly for testing.
) :=
functionmacro

  // -- Set max and min iterations
  #UNIQUENAME(MAX_ITERATIONS)
  #UNIQUENAME(MIN_ITERATIONS)

  #IF(trim(#TEXT(pNumMaxIterations))  != '')
    #SET(MAX_ITERATIONS ,pNumMaxIterations)
  #ELSE
    #SET(MAX_ITERATIONS ,'')
  #END
  
  #IF(trim(#TEXT(pNumMinIterations))  != '')
    #SET(MIN_ITERATIONS ,pNumMinIterations)
  #ELSE
    #SET(MIN_ITERATIONS ,'')
  #END

  #UNIQUENAME(LVERSION)
  #UNIQUENAME(LBUILD_NAME)

  #SET(LVERSION     ,trim(pversion  ) )
  #SET(LBUILD_NAME  ,trim(pBuildName) )

  ds_version_build := dataset([{trim(pversion)},{trim(pBuildName)}],{string stuff});


  localesp := WorkMan._Config.LocalEsp;
  // pNumMaxIterations   = '' and pNumMinIterations  = '' and pStopCondition   = ''  //INVALID, should error out
  // pNumMaxIterations   = '' and pNumMinIterations != '' and pStopCondition   = ''  //INVALID, need max iterations
  // pNumMaxIterations  != '' and pNumMinIterations != '' and pStopCondition   = ''  //INVALID, do not need minimum number since there is no condition.  

  // pNumMaxIterations   = '' and pNumMinIterations  = '' and pStopCondition  != ''  //good
  // pNumMaxIterations   = '' and pNumMinIterations != '' and pStopCondition  != ''  //good, stop condition will stop it after the minimum has been reached
  
  // pNumMaxIterations  != '' and pNumMinIterations  = '' and pStopCondition   = ''  //default, will do max iterations period.

  // pNumMaxIterations  != '' and pNumMinIterations  = '' and pStopCondition  != ''  //if hit stop condition before max iteration, stop there.  no minimum number, but will do at least one.
  // pNumMaxIterations  != '' and pNumMinIterations != '' and pStopCondition  != ''  //will do minimum number of iterations at least, stop at maximum unless the stop condition is true


  // -- Validate the parameters
  test_parameters := map(
     trim(#TEXT(pNumMaxIterations))   = '' and trim(#TEXT(pNumMinIterations))   = '' and trim(pStopCondition)   = ''                                => fail('WorkMan.mac_WorkMan ERROR----Invalid Parameters.  In the absence of a stop condition, please pass in the number of iterations as pNumMaxIterations.'                                         )
    ,trim(#TEXT(pNumMaxIterations))   = '' and trim(#TEXT(pNumMinIterations))  != '' and trim(pStopCondition)   = ''                                => fail('WorkMan.mac_WorkMan ERROR----Invalid Parameters.  In the absence of a stop condition, please pass in the number of iterations as pNumMaxIterations.'                                         )
    ,trim(#TEXT(pNumMaxIterations))  != '' and trim(#TEXT(pNumMinIterations))  != '' and trim(pStopCondition)   = ''                                => fail('WorkMan.mac_WorkMan ERROR----Invalid Parameters.  In the absence of a stop condition, please pass in the number of iterations as pNumMaxIterations.  no need for pNumMinIterations.'         )
    ,trim(#TEXT(pNumMaxIterations))  != '' and trim(#TEXT(pNumMinIterations))  != '' and (unsigned)%MAX_ITERATIONS%  < (unsigned)%MIN_ITERATIONS%   => fail('WorkMan.mac_WorkMan ERROR----Invalid Parameters. pNumMaxIterations(' + trim(#TEXT(pNumMaxIterations)) + ') should be greater than pNumMinIterations(' + trim(#TEXT(pNumMinIterations)) + ').')
    ,count(pECL) > 1 and (pNumMaxIterations != 1 or trim(#TEXT(pNumMinIterations))   != '' or trim(pStopCondition)   != '')                         => fail('WorkMan.mac_WorkMan ERROR----Invalid Parameters.  When passing in a dataset of ecl code, only use pNumMaxIterations of 1, no pNumMinIterations and no stop condition.'         )
    ,STD.System.Debug.Sleep(1)
  );

  // -- Use lots of different parameters to make the event unique
  #UNIQUENAME(WORKMAN_MAC_WORKMAN_EVENT_NAME   )
  #SET(WORKMAN_MAC_WORKMAN_EVENT_NAME  ,'__#__' + trim(pBuildName,all) + '_' + trim(pversion) + '_' + trim((string)pStartIteration) + '_' + trim((string)%'MAX_ITERATIONS'%) + '_' + trim((string)%'MIN_ITERATIONS'%) + '_' + length(trim(pECL)) + '_' + length(trim(regexreplace('[^;]',pECL,''),all)) + '_' + length(trim(regexreplace('[^[:alnum:]]',pECL,''),all)) + '__$__')
  #UNIQUENAME(WORKMAN_MAC_WORKMAN_EVENT   ,%'WORKMAN_MAC_WORKMAN_EVENT_NAME'%)
  
  // -- Fix backslashes and quotes in the ecl
  //need three slashes for quotes, \\\'.  have 7 now which uses 29 slashes here .  4 slashes = 1, + 1. So three slashes would be 13.  4*3 + 1
  //need two slashes for line feed, \\n.. have 4 now.  uses 13 slashes here, so 3 slashes = 1 + 1 extra.  so for 2 resultant slashes we need 2*3 + 1 = 7.

  ecltext1 := regexreplace('\r',regexreplace('\n',regexreplace('\'',pECL,'\\\\\''),'\\\\n',nocase),'');
  ecltext2 := if(regexfind('@version@'  ,ecltext1 ,nocase)
                ,regexreplace('@version@'   ,ecltext1 ,pversion               ,nocase)
                ,ecltext1
             );
  ecltext := regexreplace('\n',regexreplace('\r\n',ecltext2,'\\\\n'),'\\\\n');

  // #UNIQUENAME(ECLTEXT)
  // #SET(ECLTEXT  ,regexreplace('\r',regexreplace('\n',regexreplace('\'',pECL,'\\\\\''),'\\\\n',nocase),''))
  // #IF(regexfind('@version@'  ,%'ECLTEXT'% ,nocase))
    // #SET(ECLTEXT  ,regexreplace('@version@'   ,%'ECLTEXT'% ,pversion               ,nocase))
  // #END
  // #SET(ECLTEXT  ,regexreplace('\n',regexreplace('\r\n',%'ECLTEXT'%,'\\\\n'),'\\\\n'))


  // -- Set and define output file
  OutputFilename                  := regexreplace('@version@' ,pOutputFilename  ,pversion);
  outputfilename_dataset          := dataset(OutputFilename      ,WorkMan.layouts.wks_slim  ,thor ,opt);
  count_outputfile                := count(outputfilename_dataset);
  outputfilename_remote_dataset   := dataset(trim(WorkMan._Config.foreign_env(pESP) + OutputFilename[2..])  ,WorkMan.layouts.wks_slim  ,thor ,opt);

  // -- copy the remote workman file after iteration finishes if necessary
  copy_remote_workman_file := 
    if(trim(pOutputFilename) != '' and pEsp != localesp and std.file.fileexists(trim(WorkMan._Config.foreign_env(pESP) + OutputFilename[2..])) and not std.file.fileexists(OutputFilename)
    ,sequential(
       tools.macf_writefile(OutputFilename,outputfilename_remote_dataset,false,false,true)
      ,if(pOutputSuperfile != ''  ,std.file.addsuperfile(pOutputSuperfile ,OutputFilename))
    ));

  // -- Get information about the last time this was run.  start iteration, max iterations, condition, etc.
  previous_start_iteration        := outputfilename_dataset[count_outputfile].start_iteration       ;
  previous_max_iterations         := outputfilename_dataset[count_outputfile].max_iterations        ;
  previous_min_iterations         := outputfilename_dataset[count_outputfile].min_iterations        ;
  previous_stop_condition_formula := outputfilename_dataset[count_outputfile].stop_condition_formula;
  previous_advice                 := outputfilename_dataset[count_outputfile].advice                ;
  previous_last_iteration         := outputfilename_dataset[count_outputfile].iteration             ;
  
  // -- figure out whether to run this or not.  if it was already run, and there are no changes, skip it
  // we could run something, it almost finishes then fails and we skip it which cleans up the output file just like if it finished.
  // giving advice to fail does not clean up the output file, so on a re-kick off, it would come back into the childrunner automatically
  #IF(trim(pOutputFilename) = '' or pCompileOnly = true)
    Is_Already_Done := false;
  #ELSE
    Is_Already_Done := if(    count_outputfile > 0 
                          and (     (unsigned)pStartIteration         = (unsigned)previous_start_iteration 
                                and (unsigned)%MAX_ITERATIONS%        = (unsigned)previous_max_iterations 
                                and (unsigned)%'MIN_ITERATIONS'%      = (unsigned)previous_min_iterations
                                and trim(pStopCondition)              = trim(previous_stop_condition_formula)
                              ) 
                          ,true  
                          ,false
                       );
  #END

  
// datetime
// workunits
// build date
// build name
// Current Child Build
// Current Child Runner
// Current notify event
// Childrunner Wuids__html -- wuid, childrunner, watcher, notify event-- maybe pull this from the childrunner -- put time in here
// Skipped_Builds  -- should probably email when skipping
// returned datetime after wuid kickoff


string_set_results    := if(count(pSetResults) != 0           ,WorkMan.set2string(pSetResults          )   ,'[]');
string_set_name_calcs := if(count(pSetNameCalculations) != 0  ,WorkMan.set2string(pSetNameCalculations )   ,'[]');

// string_set_results    := if(count(pSetResults) != 0           ,'\'' + WorkMan.set2string(pSetResults          ) + '\''  ,'[]');
// string_set_name_calcs := if(count(pSetNameCalculations) != 0  ,'\'' + WorkMan.set2string(pSetNameCalculations ) + '\''  ,'[]');


// -- Put together the ecl code for the childrunner
fbool(boolean pboolean) := if(pboolean = true,'true','false');
childrunner_ecl_code := 
    '#workunit(\'name\',\'---WorkMan.ChildRunner--- ' + if(pBuildName != '',pBuildName + ', ','') + 'version: ' + pversion + '\');\n'
  + 'WorkMan.ChildRunner(\n'
  + '   \'' + ecltext                 + '\'\n'                                                                            
  + '  ,\'' + pversion                    + '\'\n'                                                                         
  + '  ,\'' + pcluster                    + '\'\n'                                                                          
  + '  ,\'' + %'WORKMAN_MAC_WORKMAN_EVENT'%    + '\'\n'                                                                                 
  + '  ,'   + pStartIteration             + '\n'                                                                              
  + '  ,'   + %'MAX_ITERATIONS'%          + '\n'                                                                                   
  + '  ,'   + %'MIN_ITERATIONS'%          + '\n'                                                                                  
  + '  ,\'' + pOutputFilename             + '\'\n'                                        
  + '  ,\'' + pOutputSuperfile            + '\'\n'                                               
  + '  ,'   + string_set_results          + '\n'                                        
  + '  ,\'' + pStopCondition              + '\'\n'              
  + '  ,'   + string_set_name_calcs       + '\n'         
  + '  ,\'' + pBuildName                  + '\'\n'        
  + '  ,\'' + localesp                    + '\'\n'               
  + '  ,\'' + pNotifyEmails               + '\'\n'   
  + '  ,\'' + pFailureEmails              + '\'\n'   
  + '  ,'   + fbool(pShouldEmail)         + '\n'     
  + '  ,\'' + pPollingFrequency           + '\'\n' 
  + '  ,'   + fbool(pForceRun   )         + '\n'                                         
  + '  ,'   + fbool(pForceSkip  )         + '\n'  
  + '  ,'   + #TEXT(pDebugValues  )         + '\n'  
  + '  ,'   + fbool(pCompileOnly  )         + '\n'  
  + ');\n'
  ;

  // -- kickoff the childrunner
  childrunner_hthor   := WorkMan._Config.Esp2Hthor(pESP);
  kickoff_childrunner := WorkMan.CreateWuid(childrunner_ecl_code  ,childrunner_hthor   ,pESP,,pDebugValues);
 
  // -- get info after child is finished
  current_childrunner       := STD.Str.FilterOut(workman.get_set_Result(workunit,'Current_Running_Wuid',localesp)[1],'\'');
  current_childrunner_wuids := if(trim(WorkMan.get_Scalar_Result(current_childrunner,'Workunits',pESP)) not in ['','[undefined]'] 
                                  ,WorkMan.get_DS_Result(current_childrunner  ,'Workunits',WorkMan.layouts.wks_slim,pESP,,pDont_Wait)
                                  ,dataset([],WorkMan.layouts.wks_slim)
                               );
  consecutive_skipped_builds := if(trim(WorkMan.get_Scalar_Result(workunit,'Consecutive_Skipped_Builds',localesp)) not in ['','[undefined]'] 
                                  ,WorkMan.get_DS_Result(workunit  ,'Consecutive_Skipped_Builds',WorkMan.layouts.wks_slim,localesp,,pDont_Wait)
                                  ,dataset([],WorkMan.layouts.wks_slim)
                               );
	
	
  // -- get all workunits run by workman, either from the superfile, or from the workunits dataset result
  #IF(trim(pOutputSuperfile) != '')            
    ds_all_wuids := dataset(pOutputSuperfile,WorkMan.layouts.wks_slim,thor,opt);
  #ELSE
    ds_all_wuids := dataset([],WorkMan.layouts.wks_slim);
  #END

  ds_all_wuids_version := ds_all_wuids(version = pversion);

  // -- cleanup the superfile if requested
  cleanupsuper := if(pCleanupSuper = true
    ,WorkMan.Cleanup_Super(
       pSuperFile_Dataset   := ds_all_wuids                         //Superfile dataset that contains all the subfiles
      ,pSuperFile_Name      := pOutputSuperfile                     //Superfile name of above dataset
      ,pCurrent_Version     := pversion                             //version date of current build(which will NOT be cleaned up)
      ,pSummary_Filename    := pOutputSuperfile + '::' + workunit   //New logical filename for all cleaned up subfiles.
    ));


  // -- get all wuids and dedup to get the last per 
  ds_wuids := WorkMan.get_DS_Result(workunit        ,'Workunits',WorkMan.layouts.wks_slim);
  ds_wuids2 := if(trim(WorkMan.get_Scalar_Result(workunit,'Workunits')) not in ['','[undefined]']
                ,ds_wuids
                ,dataset([],WorkMan.layouts.wks_slim)
               );
               
  ds_wuids_all_skip := dedup(sort(ds_wuids2 + ds_all_wuids_version                            ,wuid,-time_finished),wuid);
  ds_wuids_all      := dedup(sort(ds_wuids2 + current_childrunner_wuids + ds_all_wuids_version,wuid,-time_finished),wuid);
  
  // '<a href="http://' + pESP + ':8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + current_childrunner + '#/stub/Summary">' + current_childrunner + '</a>'
  
  // -- get the current running wuids and add html results
  Current_Running_Wuids       := WorkMan.get_DS_Result    (current_childrunner ,'Iteration_Wuids__html',Workman.Layouts.iterations,pESP,,pDont_Wait);
  Current_Running_Wuids_proj  := project(Current_Running_Wuids  ,transform(Workman.Layouts.childrunner_wuids  
    ,self.childrunner_wuid__html  := '<a href="http://' + pESP + ':8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + current_childrunner + '#/stub/Summary">' + current_childrunner + '</a>'
    ,self.childrunner_jobname     := WorkMan.get_Jobname(current_childrunner,pESP)
    ,self.parent_event            := %'WORKMAN_MAC_WORKMAN_EVENT'%
    ,self                         := left
  ));
  
  // export iterations := {string wuid__html,string jobname,string watcher_wuid__html,string watcher_jobname};
  // export childrunner_wuids  := {string wuid__html,string jobname,string childrunner_wuid__html,string childrunner_jobname,string watcher_wuid__html,string watcher_jobname,string parent_event};

  Current_Running_Wuid__html := '<a href="http://' + pESP + ':8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + current_childrunner + '#/stub/Summary">' + current_childrunner + '</a>';

  // -- get the state of the child wuid, any errors, and any advice that was given
  //also put in one from the output file.  might be more reliable
  get_childrunner_state := workman.get_State        (current_childrunner  ,pESP);
  get_child_wuid        := workman.get_Scalar_Result(current_childrunner  ,'Iteration_Wuid' ,pESP);
  get_child_wuid_state  := workman.get_State        (trim(get_child_wuid) ,pESP);
  get_child_wuid_errors := workman.get_Errors       (trim(get_child_wuid) ,pESP);
  get_Advice            := workman.get_Scalar_Result(current_childrunner  ,'Advice'         ,pESP);

  // -- get how many times this macro has been called for this wuid
  get_times_called      := workman.get_Scalar_Result(workunit  ,'Times_Called');
  times_called          := (unsigned)get_times_called + 1;
  
  // -- check for failures
  check_for_failures := 
    iff(
          (   get_child_wuid_state not in ['completed'] 
          and get_child_wuid_state not in ['completed']
          ) 
       and not regexfind('(skip|move on)',get_Advice,nocase)
          ,fail('Fail workunit because wuid ' + get_child_wuid + ' has/is ' + get_child_wuid_state + ' with the following error(s):\n' + get_child_wuid_errors)
    );

  // -- compile the current build attributes vs the previous builds
  build_attributes := dataset([
     {pBuildName  ,'count_outputfile'                 ,count_outputfile               }
    ,{pBuildName  ,'pStartIteration'                  ,pStartIteration                }
    ,{pBuildName  ,'MAX_ITERATIONS'                   ,%'MAX_ITERATIONS'%             }
    ,{pBuildName  ,'MIN_ITERATIONS'                   ,%'MIN_ITERATIONS'%             }
    ,{pBuildName  ,'pStopCondition'                   ,pStopCondition                 }
      
    ,{pBuildName  ,'previous_start_iteration'         ,previous_start_iteration       }
    ,{pBuildName  ,'previous_max_iterations '         ,previous_max_iterations        }
    ,{pBuildName  ,'previous_min_iterations '         ,previous_min_iterations        }
    ,{pBuildName  ,'previous_stop_condition_formula'  ,previous_stop_condition_formula}
  ]  ,Workman.layouts.build_attributes);

  // -- Compile any skipped builds and send one email for all as a reminder
	builds_skipped       := rollup(project(consecutive_skipped_builds,transform({string line},self.line := left.name))	,true,transform(recordof(left),self.line := left.line + '\n' + right.line));
	email_skipped_builds := if(count(consecutive_skipped_builds) > 0 and trim(pNotifyEmails) != ''	,WorkMan.Send_Email(
                             pNotifyEmails
                            ,'Your Build ' + pversion + ' just skipped the following jobs on ' + _Control.ThisEnvironment.Name + ' on this date: ' + WorkMan.getTimeDate()
                            ,   'Wuid' 		+ '\t\t: ' 		  + workunit                                                                            + '\n'
															+ 'Wuid link' + '\t: ' 	  + 'http://' + localesp + ':8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + workunit    + '#/stub/Summary\n\n' 
															+ 'The following builds were skipped because they were already run: \n'
															+ builds_skipped[1].line
                          ));


  get_BuildName     := workman.get_set_Result(workunit  ,'Current_Running_Build');
  build_names       := get_BuildName + [pBuildName];

  get_build_attributes     := WorkMan.get_DS_Result    (workunit ,'Current_Build_attributes',Workman.layouts.build_attributes);
  compile_build_attributes := get_build_attributes + build_attributes;

  get_running_wuids       := workman.get_set_Result(workunit  ,'Current_Running_Wuid');
  compile_running_wuids   := [kickoff_childrunner] + get_running_wuids;

  get_running_wuids_html       := workman.get_set_Result(workunit  ,'Current_Running_Wuid__html');
  compile_running_wuids_html   := get_running_wuids_html + [Current_Running_Wuid__html];

  set_blank_versions := [''];
  ds_Total_Skipped_Builds := project(dataset([{''}],{string stuff}),transform(WorkMan.layouts.wks_slim,self := []));  //make it more than just a blank dataset because the output was not showing up in the results

  ds_existing_skipped_builds := WorkMan.get_DS_Result(workunit ,'Total_Skipped_Builds',WorkMan.layouts.wks_slim);
  ds_concat_skipped_builds := ds_existing_skipped_builds + outputfilename_dataset;

  // -- outputs when running the build
  do_outputs := sequential(
     output(WorkMan.getTimeDate()                                             ,named('DateTime'                     ),overwrite     )
    ,output(ds_wuids_all                                                      ,named('Workunits'                    ),overwrite,ALL )
    ,output(times_called                                                      ,named('Times_Called'                 ),overwrite     )
    ,output(%'WORKMAN_MAC_WORKMAN_EVENT'%                                     ,named('Current_Parent_Event'         ),overwrite     )

    ,output([ds_version_build[1].stuff  ]                                     ,named('Current_Version'              ),overwrite     )
             
    #IF(pParallel = false)
    ,output([ds_version_build[2].stuff]                                       ,named('Current_Running_Build'        ),overwrite     )
    ,output(build_attributes                                                  ,named('Current_Build_attributes'     ),overwrite     )
    ,output([kickoff_childrunner]                                             ,named('Current_Running_Wuid'         ),overwrite     )
    ,output([Current_Running_Wuid__html]                                      ,named('Current_Running_Wuid__html'   ),overwrite     )
    #ELSE 
    ,output(build_names                                                       ,named('Current_Running_Build'        ),overwrite     )
    ,output(compile_build_attributes                                          ,named('Current_Build_attributes'     ),overwrite     )
    ,output(compile_running_wuids                                             ,named('Current_Running_Wuid'         ),overwrite     )
    ,output(compile_running_wuids_html                                        ,named('Current_Running_Wuid__html'   ),overwrite     )
    #END  
    ,output(''                                                                ,named('Current_Parallel_Watcher_Wuid'         ),overwrite     )
    ,output(''                                                                ,named('Current_Parallel_Watcher_Wuid__html'   ),overwrite     )
  
		,email_skipped_builds 
		,output(dataset([],WorkMan.layouts.wks_slim)                   					  ,named('Consecutive_Skipped_Builds'   ),overwrite   ,all )
    #IF(pDont_Wait = false and pParallel = false)
      ,output(WsWorkunits.soapcall_WUWaitComplete(current_childrunner,,,pESP) ,named('Waiting'                      ),overwrite     )
      // ,wait(%'WORKMAN_MAC_WORKMAN_EVENT'%)  // in 6.4.4  works but the other things after the wait do not get run. HPCC-11172 -- assert error after master workunit notified when used in if-then.
    #ELSE
      ,output(dataset([],WsWorkunits.layouts.WUWaitCompleteOutRecord)         ,named('Waiting'                      ),overwrite     )
    #END
    ,output(WorkMan.getTimeDate()                                             ,named('DateTime_Finished'            ),overwrite     )
    ,output(Current_Running_Wuids_proj                                        ,named('Current_Running_Wuids__html'  ),extend   ,all )
    ,output(ds_Total_Skipped_Builds                                           ,named('Total_Skipped_Builds'         ),overwrite,all )
    ,output(ds_wuids_all                                                      ,named('Workunits'                    ),overwrite,ALL )
    ,copy_remote_workman_file
    #IF(pDont_Wait = false and pParallel = false)
      ,check_for_failures
    #END
  );
  
  // -- outputs when skipping the build
  do_outputs_null := sequential(
     output(WorkMan.getTimeDate()                                           ,named('DateTime'                     ),overwrite     )
    ,output(ds_wuids_all_skip                                               ,named('Workunits'                    ),overwrite,ALL )
    // ,output(%'WORKMAN_MAC_WORKMAN_EVENT'%                                        ,named('Current_Parent_Event'         ),overwrite     )
    // ,output(pversion                                                        ,named('Current_Version'              ),overwrite     )
    // ,output(pBuildName                                                      ,named('Current_Running_Build'        ),overwrite     )
    // ,output(build_attributes                                                ,named('Current_Build_attributes'     ),overwrite     )
    // ,output(''                                                              ,named('Current_Running_Wuid'         ),overwrite     )
    // ,output(''                                                              ,named('Current_Running_Wuid__html'   ),overwrite     )
    // ,output(dataset([],WsWorkunits.Layouts.WUWaitCompleteOutRecord)         ,named('Waiting'                      ),overwrite     )
    // ,output(WorkMan.getTimeDate()                                           ,named('DateTime_Finished'            ),overwrite     )
    // ,output(dataset([],Workman.Layouts.childrunner_wuids)                   ,named('Current_Running_Wuids__html'  ),extend   ,all )
     ,output(times_called                                                    ,named('Times_Called'                 ),overwrite     )
     ,output(consecutive_skipped_builds + outputfilename_dataset							,named('Consecutive_Skipped_Builds'         ),overwrite,all )
		 // ,email_skipped_builds
     ,output(ds_concat_skipped_builds(trim(wuid) != '')                       ,named('Total_Skipped_Builds'               ),overwrite   ,all )
    // ,wait(%'WORKMAN_MAC_WORKMAN_EVENT'%)  // in 6.4.4
  );

	//want to flag when you are skipping a build/builds in the middle of other running builds.
	/*
			run two builds.  so workunits is populated with two builds.  and skipped build has zero workunits
			


*/




// datetime bh-385
// workunits
// build 
// version
// Current notify event
// Current Child Build
// Current Child Runner
// Childrunner Wuids__html -- wuid, childrunner, watcher, notify event-- maybe pull this from the childrunner -- put time in here
// Skipped_Builds  -- should probably email when skipping
// returned datetime after wuid kickoff


return sequential(
   output('---------------------Workman_Outputs_Follow-----------------'  ,named('Workman_Outputs_Follow'       ),overwrite     )
  ,test_parameters
  ,cleanupsuper
  // ,output(childrunner_ecl_code)
  // ,iff(Is_Already_Done = false ,do_outputs)
  ,iff(Is_Already_Done = false ,do_outputs,do_outputs_null)
  ,output('---------------------Workman_Outputs_End-----------------'  ,named('Workman_Outputs_End'       ),overwrite     )
);

/*

#workunit('name','Parent Wuid');
WorkMan.ChildRunner(
   myecl                                                                            //pECL
  ,'20171128b'                                                                       //pversion
  ,WorkMan._Config.Groupname('50')                                               //pcluster
  ,'notifymastevent'                                                                //pNotifyEvent                 
  ,1                                                                                //pStartIteration
  ,5                                                                                   //pNumMaxIterations 
  ,3                                                                                   //pNumMinIterations
  ,'~workman_testing::@version@::simpletest'                                        //pOutputFilename      = '\'\''
  ,'~workman_testing::qa::simpletest'                                               //pOutputSuperfile     = '\'\''
  ,['MatchesPerformed','PreClusterCount','Convergence']                             //pSetResults            
  ,'MatchesPerformed < (100000) or (100 - (MatchesPerformed / PreClusterCount * 100.0)) > (99.9)' //pStopCondition               
  ,['MatchesPerformed_Threshold','Pct_Convergence','Convergence_Threshold']         //pSetNameCalculations
  ,pPollingFrequency := '1'
  // ,pBuildName        := 'BIPV2_Seleid_Relative'
);


\'#workunit(\\\'name\\\',\\\'---WorkMan.ChildRunner---' + if(pUniqueOutput != '' ,' for ' + pUniqueOutput ,'') + ', version: ' + pversion + ', iteration: ' + %'CNTR'% + '\\\');\\n'

  kickiter1       := WorkMan.CreateWuid('#workunit(\'name\',\'---WorkMan.ChildRunner---, version: 20171115g\');\n'
  + 'WorkMan.ChildRunner(\'#workunit(\\'name\\\',\\\'bipv2_proxid 20171115g-1 workman test\\\');\\nsetpreclustercount  := [392933809 ,382870103  ,381654002  ,381326072  ,381147324];\\nsetmatchesperformed := [6265107   ,1032750    ,346601     ,192764     ,117560   ];\\nsetconvergence      := [98.406    ,99.730     ,99.909     ,99.949     ,99.969   ];\\noutput(setpreclustercount [1]  ,named(\\\'PreClusterCount\\\'));\\noutput(setmatchesperformed[1]  ,named(\\\'MatchesPerformed\\\'));\\noutput(setconvergence     [1]  ,named(\\\'Convergence\\\'));\'
  ,'1'
  ,'20171115g'
  ,'thor50_dev'
  ,'__NOTIFYMASTEREVENT__195555__'
  ,'__WAIT4MASTEREVENT__195556__'
  ,'' + WORKUNIT + '\'
  ,\'~workman_testing::20171115g::simpletest\'
  ,\'~workman_testing::qa::simpletest\'
  ,\'10.241.12.207\'
  ,\'laverne.bentley@lexisnexis.com\'
  ,,\'\',\'1\',false,true)'
  ,'hthor_dev'
  ,'10.241.12.207');


#workunit('name','---WorkMan.ChildRunner--- ' + pBuildName + ', version: ' + pversion + '');
WorkMan.ChildRunner(
   pECL                                                                            //pECL
  ,'20171117b'                                                                       //pversion
  ,WorkMan._Config.Groupname('50')                                               //pcluster
  ,'notifymastevent'                                                                //pNotifyEvent                 
  ,'wait4masterevent'                                                               //pWaitEvent                   
  ,1                                                                                //pStartIteration
  ,5                                                                                   //pNumMaxIterations 
  ,3                                                                                   //pNumMinIterations
  ,'~workman_testing::@version@::simpletest'                                        //pOutputFilename      = '\'\''
  ,'~workman_testing::qa::simpletest'                                               //pOutputSuperfile     = '\'\''
  ,['MatchesPerformed','PreClusterCount','Convergence']                             //pSetResults            
  ,'MatchesPerformed < (100000) or (100 - (MatchesPerformed / PreClusterCount * 100.0)) > (99.9)' //pStopCondition               
  ,['MatchesPerformed_Threshold','Pct_Convergence','Convergence_Threshold']         //pSetNameCalculations
  ,pPollingFrequency := '1'
);


  //- need to get Advice result from childrunner--or could put it into the workunits result.
  kick_iter :=  sequential(
      output(WorkMan.getTimeDate() ,named('DateTime'           ),overwrite)
    #IF(pOutputSuperfile != '')
      ,output(dataset(pOutputSuperfile ,wk_ut.layouts.wks_slim,thor,opt)(regexfind(pversion,version,nocase)),named('Workunits'),overwrite,all)
    #ELSE
      ,output(ds_wuids              ,named('Workunits'          ),overwrite,all)
    #END
      ,output(pversion              ,named('Current_Build_Date' ),overwrite)
      ,output(pBuildName            ,named('Current_Build_Name' ),overwrite)
      ,output(            ,named('Current_Child_Runner' ),overwrite)
      ,output(            ,named('Current_Notify_Event' ),overwrite)
      ,output(            ,named('Child_Runners__html' ),overwrite)
      ,output(            ,named('Skipped_Builds__html' ),overwrite)
    
    
    
     output(kickiter1,named('_Child_Runner_20171115g_1'))
    ,output('<a href="http://10.241.12.207:8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + kickiter1 + '#/stub/Summary">_Child_Runner_20171115g_1</a>' ,named('_Child_Runner_20171115g_1__html'))
    ,output('__NOTIFYMASTEREVENT__195555__',named('NotifyEvent_20171115g_1'))
    ,output(WorkMan.do_WUWaitComplete(kickiter1,,,'10.241.12.207'))
    ,output(WorkMan.do_WUWaitComplete(kickiter1,,,'10.241.12.207'))//do twice because sometimes it comes back too early
    ,output('done waiting at ' + WorkMan.getTimeDate())
    ,sendemail1
    ,output(dataset('~workman_testing::qa::simpletest',WorkMan.layouts.wks_slim,thor)(regexfind('20171115g',version,nocase)),named('Workunits'),overwrite,all)
    ,outsummary1
    ,fail1
    ,output('_____________________________________________________________')
    );








// -- old stuff
  ChildRunner1    := nothor(global(WorkMan.get_Scalar_Result(workunit,'_Child_Runner_20171115g_1'),few)) : global;
  wuid1           := nothor(global(WorkMan.get_Scalar_Result(ChildRunner1,'Iteration_20171115g_1','10.241.12.207'),few)) : global;
  get_wuids1      := WorkMan.get_DS_Result(global(WorkMan.get_Scalar_Result(workunit,'_Child_Runner_20171115g_1','10.241.12.207'),few),'Workunits',WorkMan.layouts.wks_slim,'10.241.12.207'); //get workunit info for these wuids
  get_thiswuids1  := WorkMan.get_DS_Result(workunit,'Workunits',WorkMan.layouts.wks_slim); //get workunit info for this wuid
  Errors1         := global(WorkMan.get_Errors(wuid1,'10.241.12.207'),few);
  get_wuids_1     := WorkMan.get_DS_Result(workunit,'Workunits',WorkMan.layouts.wks_slim); //get workunit info for these wuids
  get_wuids_iter1 := iterate(project(get_wuids1,transform(recordof(left)
                              ,self.Total_thor_Time     := left.total_thor_time
                              ,self.Total_Time_secs     := WorkMan.Convert2Seconds(self.Total_thor_Time)
                              ,self.Run_Total_Time_secs := if(counter = 1 ,self.Total_Time_secs + sum(get_thiswuids1,Total_Time_secs)
                              ,self.Total_Time_secs),self := left)
                            )
                    ,transform(recordof(left)
                    ,self.Run_Total_Time_secs := if(counter = 1,0,left.Run_Total_Time_secs) + right.Run_Total_Time_secs
                    ,self.Run_Total_Thor_Time := WorkMan.ConvertSecs2ReadableTime((real8)self.Run_Total_Time_secs)
                    ,self := right
                    ));
  getAdvice1      := global(WorkMan.get_Scalar_Result(global(WorkMan.get_Scalar_Result(workunit,'_Child_Runner_20171115g_1','10.241.12.207'),few),'Advice','10.241.12.207'),few);
  getstate1       := global(WorkMan.get_State(wuid1,'10.241.12.207'),few);
  realstate1      := if(getstate1[1..6] = 'failed' ,'failed' ,getstate1);
  thor_time1      := global(WorkMan.get_TotalTime(wuid1,'10.241.12.207'),few);
  realjobname1    := global(WorkMan.get_Jobname(wuid1,'10.241.12.207'),few);  
  jobname1        := if(realjobname1 != '' ,realjobname1 ,wuid1);
  fail1           := iff((getstate1 not in ['completed'] and getstate1 not in ['completed']) and not regexfind('skip|move on',getAdvice1,nocase),fail('Fail workunit because wuid ' + wuid1 + ' has/is ' + getstate1 + ' with the following error(s):\n' + Errors1));
  20171115g1      := global(WorkMan.get_Scalar_Result(wuid1,'','10.241.12.207'),few);
  20171115g1      := global(WorkMan.get_Scalar_Result(wuid1,'','10.241.12.207'),few);
  20171115g1      := global(WorkMan.get_Scalar_Result(wuid1,'','10.241.12.207'),few);
  sendemail1      := WorkMan.Send_Email(
                        WorkMan._Config.EmailAddressNotify
                        ,jobname1                + ' has ' + getstate1 + ' in ' + thor_time1 + ' on ' + WorkMan._Config.Esp2Name('10.241.12.207') + ' on this date: ' + WorkMan.getTimeDate()
                        , if(jobname1 != ''
                        , 'Jobname                                   : ' + jobname1 + '\n','')
                        + 'workunit                                  : ' + wuid1 + '\n' 
                        + 'workunit Link                             : ' + 'http://10.241.12.207:8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + wuid1 + '#/stub/Summary\n' 
                        + 'State                                     : ' + getstate1 + '\n'
                        + 'Total Thor Time                           : ' + thor_time1 + '\n'
                        + 'Iteration                                 : 1\n'
                        + 'Version                                   : 20171115g\n'
                        + 'MatchesPerformed                          : ' + 20171115g1 + '\n'
                        + 'PreClusterCount                           : ' + 20171115g1 + '\n'
                        + 'Convergence                               : ' + 20171115g1 + '\n'
                        + 'ChildRunner Wuid                          : ' + ChildRunner1 + '\n'
                        + 'ChildRunner Wuid Link                     : ' + 'http://10.241.12.207:8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + ChildRunner1 + '#/stub/Summary\n' 
                        + if(trim(Errors1) != '' ,'FailMessage(s): \n' + Errors1,'')
                        );
                        
\'#workunit(\\\'name\\\',\\\'---ChildRunner---' + if(pUniqueOutput != '' ,' for ' + pUniqueOutput ,'') + ', version: ' + pversion + ', iteration: ' + %'CNTR'% + '\\\');\\n'

  kickiter1       := WorkMan.CreateWuid('#workunit(\'name\',\'---ChildRunner---, version: 20171115g\');\nWorkMan.ChildRunner(\'#workunit(\\'name\\\',\\\'bipv2_proxid 20171115g-1 workman test\\\');\\nsetpreclustercount  := [392933809 ,382870103  ,381654002  ,381326072  ,381147324];\\nsetmatchesperformed := [6265107   ,1032750    ,346601     ,192764     ,117560   ];\\nsetconvergence      := [98.406    ,99.730     ,99.909     ,99.949     ,99.969   ];\\noutput(setpreclustercount [1]  ,named(\\\'PreClusterCount\\\'));\\noutput(setmatchesperformed[1]  ,named(\\\'MatchesPerformed\\\'));\\noutput(setconvergence     [1]  ,named(\\\'Convergence\\\'));\'
  ,'1'
  ,'20171115g'
  ,'thor50_dev'
  ,'__NOTIFYMASTEREVENT__195555__'
  ,'__WAIT4MASTEREVENT__195556__'
  ,'' + WORKUNIT + '\'
  ,\'~workman_testing::20171115g::simpletest\'
  ,\'~workman_testing::qa::simpletest\'
  ,\'10.241.12.207\'
  ,\'laverne.bentley@lexisnexis.com\'
  ,,\'\',\'1\',false,true)'
  ,'hthor_dev'
  ,'10.241.12.207');
  // -----------------------------------------------------------------------------------------

  cond1 := STD.File.FileExists('~workman_testing::20171115g::simpletest');

  cond := rejected(	 cond1
  );
  kick_iter1 :=  sequential(
     output(kickiter1,named('_Child_Runner_20171115g_1'))
    ,output('<a href="http://10.241.12.207:8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + kickiter1 + '#/stub/Summary">_Child_Runner_20171115g_1</a>' ,named('_Child_Runner_20171115g_1__html'))
    ,output('__NOTIFYMASTEREVENT__195555__',named('NotifyEvent_20171115g_1'))
    ,output(WorkMan.do_WUWaitComplete(kickiter1,,,'10.241.12.207'))
    ,output(WorkMan.do_WUWaitComplete(kickiter1,,,'10.241.12.207'))//do twice because sometimes it comes back too early
    ,output('done waiting at ' + WorkMan.getTimeDate())
    ,sendemail1
    ,output(dataset('~workman_testing::qa::simpletest',WorkMan.layouts.wks_slim,thor)(regexfind('20171115g',version,nocase)),named('Workunits'),overwrite,all)
    ,outsummary1
    ,fail1
    ,output('_____________________________________________________________')
    );
  return sequential(
    case(cond
      ,1 => sequential(kick_iter1)
    )
  );
*/

endmacro;