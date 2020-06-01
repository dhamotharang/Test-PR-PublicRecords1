﻿EXPORT mac_Workman(

   pECL                                                               // ECL Code to run.  Can be a string for one wuid, or a dataset for multiple parallel wuids.  dataset([],WorkMan.Layouts.parallel_ecl)
  ,pversion             = '\'\''                                      // version date
  ,pcluster             = '\'\''                                      // cluster on which to run the above code
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
  ,pFailureEmails     = ''                                            // email addresses to which to send any failures. maybe an email address to send a text to your cell phone?
  ,pShouldEmail       = 'true'                                        // boolean on whether to email or not
  ,pPollingFrequency  = '\'5\''                                       // polling frequency of how often the watcher wuid should check the status of the iteration.  Default is 5 which is 5 minutes.
  ,pForceRun          = 'false'                                       // if true, then it will kick off the wuid even if it has already run.  FALSE will skip it if it has already run
  ,pForceSkip         = 'false'                                       // if true, then it will skip all failures and continue with the next iteration.  FALSE will ask if you want to rerun, skip or fail.
  ,pCleanupSuper      = 'false'                                       // if true, then it will cleanup the superfile for all subfiles except ones that contain this version(pversion above)
  ,pDebugValues       = '\'dataset([],WsWorkunits.Layouts.DebugValues)\'' // for the spawning of the wuids.  can use other repositories/branches that have been pushed to your origin in gitlab.  It is a string because that helps with specifying only selective named parameters
                                                                          // Ex for boca publicrecords: pDebugValues := 'dataset([{\'Boca-branch\',\'LBP-183\'},{\'Boca-URL\',\'https://gitlab.ins.risk.regn.net/BentleLA/PublicRecords.git\'}],WsWorkunits.Layouts.DebugValues)'
                                                                          // DO NOT USE #TEXT() around the code because it causes weird issues with the parameter order, just pass this parameter in as a string and backslash any embedded quotes.  embed the actual dataset definition,
                                                                          // DO NOT assign the dataset definition to a value type, then assign this parameter to that value type because this is going to get used in spawned wuids which will not know what that value type is.
  ,pDont_Wait         = 'false'                                       // if false, will wait for the childrunner to finish.  true = it will not wait, it will just submit the childrunner.  doesn't work if pECL is a dataset.
  ,pParallel          = 'false'                                       // if false, will wait for the childrunner to finish.  true = it will not wait, it will submit the childrunner and also compile set results with the previous call
  ,pCompileOnly       = 'false'                                       // if false, will run the build as normal.  true = it will compile the wuid.  this also means it will only compile one iteration of it.  it will not save the workman files either.  this is mainly for testing.
  ,pAutoResubmit      = 'false'                                       // if true, then it will automatically resubmit the wuid upon failure.  FALSE it will not(the default).  This only works for runtime failures.  If it fails to compile, it will not autoreubmit.
                                                                      // this is because fixing a compile time failure requires manual intervention, and we don't want to be constantly resubmitting code with syntax errors.

) :=
functionmacro

  #IF(trim(#GETDATATYPE(pECL)) = 'string')
    return_result := 
    WorkMan.mac_Work(
       pECL                        
      ,pversion                    
      ,pcluster                    
      ,pStartIteration             
      ,pNumMaxIterations           
      ,pNumMinIterations           
      ,pOutputFilename             
      ,pOutputSuperfile            
      ,pSetResults                 
      ,pStopCondition              
      ,pSetNameCalculations     
      ,pBuildName               
      ,pESP                     
      ,pNotifyEmails            
      ,pFailureEmails           
      ,pShouldEmail             
      ,pPollingFrequency        
      ,pForceRun                
      ,pForceSkip               
      ,pCleanupSuper            
      ,pDebugValues             
      ,pDont_Wait               
      ,pParallel                
      ,pCompileOnly             
      ,pAutoResubmit
    );
  #ELSE
    //first thing is to generate the code for each call to WorkMan.mac_Work in a transform
    // then project the transform and create a wuid for each
    // then generate code using the wuids to call WorkMan.Wait4Workunits.
    // that call waits for them to finish

  ds_prep := project(pECL  ,transform(
    // {string version,string build_name,string iteration,string ecl_cluster ,string esp,string wuid := '' ,string ecl_query }
    WorkMan.Layouts.parallel_ecl_wuid,
    ecltext1 := regexreplace('\r',regexreplace('\n',regexreplace('\'',left.ecl,'\\\\\''),'\\\\n',nocase),'');
    ecltext  := regexreplace('\n',regexreplace('\r\n',ecltext1,'\\\\n'),'\\\\n');

    self.build_name         := if(left.build_name          = '' ,pBuildName          ,left.build_name         );
    self.output_filename    := if(left.output_filename     = '' ,pOutputFilename     ,left.output_filename    );
    self.output_superfile   := if(left.output_superfile    = '' ,pOutputSuperfile    ,left.output_superfile   );
    self.version            := if(left.version             = '' ,pversion            ,left.version            );
    self.cluster            := if(left.cluster             = '' ,pcluster            ,left.cluster            );
    self.start_iteration    := map(left.start_iteration     = '' and pStartIteration   = (typeof(pStartIteration  ))'' => '\'\'' ,left.start_iteration = '' => (string)pStartIteration     ,left.start_iteration    );
    self.max_iterations     := map(left.max_iterations      = '' and pNumMaxIterations = (typeof(pNumMaxIterations))'' => '\'\'' ,left.max_iterations  = '' => (string)pNumMaxIterations   ,left.max_iterations     );
    #IF(#TEXT(pNumMinIterations) = '')
    self.min_iterations     := left.min_iterations;
    #ELSE
    self.min_iterations     := map(left.min_iterations      = '' and (unsigned)pNumMinIterations = 0 => '\'\'' ,left.min_iterations  = '' => (string)pNumMinIterations   ,left.min_iterations     );
    #END
    self.set_results        := if(left.set_results         = []             ,pSetResults                ,left.set_results               );
    self.stop_condition     := if(left.stop_condition      = ''             ,pStopCondition             ,left.stop_condition            );
    self.named_calculations := if(left.named_calculations  = []             ,pSetNameCalculations       ,left.named_calculations        );
    self.esp                := if(left.esp                 = ''             ,pESP                       ,left.esp                       );
    self.forcerun           := if(left.forcerun     = true or pForceRun     = true  ,true                       ,false                          );
    self.forceskip          := if(left.forceskip    = true or pForceSkip    = true  ,true                       ,false                          );
    self.compile_only       := if(left.compile_only = true or pCompileOnly  = true  ,true                       ,false                          );
    self.ecl_query := 
        '#workunit(\'name\',\'--WorkMan.mac_Work-- ' + self.build_name + ', ' + self.version + ', ' + self.start_iteration + '\');\n'
      + 'WorkMan.mac_Work(\n'
      + '   \'' + ecltext + '\'\n'
      + '  ,\'' + if( left.version             = ''  ,pversion            ,left.version            ) + '\'\n'
      + '  ,\'' + if( left.cluster             = ''  ,pcluster            ,left.cluster            ) + '\'\n'
      + '  ,'   + map(left.start_iteration     = '' and pStartIteration   = (typeof(pStartIteration  ))'' => '\'\'' ,left.start_iteration = '' => (string)pStartIteration     ,left.start_iteration    ) + '\n'
      + '  ,'   + map(left.max_iterations      = '' and pNumMaxIterations = (typeof(pNumMaxIterations))'' => '\'\'' ,left.max_iterations  = '' => (string)pNumMaxIterations   ,left.max_iterations     ) + '\n'
      #IF(#TEXT(pNumMinIterations) = '')
      + '  ,'   + left.min_iterations + '\n'
      #ELSE
      + '  ,'   + map(left.min_iterations      = '' and (unsigned)pNumMinIterations = 0 => '\'\'' ,left.min_iterations  = '' => (string)pNumMinIterations   ,left.min_iterations     ) + '\n'
      #END
      + '  ,\'' + if( left.output_filename     = '' ,pOutputFilename              ,left.output_filename           ) + '\'\n'
      + '  ,\'' + if( left.output_superfile    = '' ,pOutputSuperfile             ,left.output_superfile          ) + '\'\n'
      + '  ,'   + if( left.set_results         = [] ,#TEXT(pSetResults)           ,WorkMan.set2string(left.set_results)        ) +   '\n'
      + '  ,\'' + if( left.stop_condition      = '' ,pStopCondition               ,left.stop_condition            ) + '\'\n'
      + '  ,'   + if( left.named_calculations  = [] ,#TEXT(pSetNameCalculations)  ,WorkMan.set2string(left.named_calculations) ) +   '\n'
      + '  ,\'' + if( left.build_name          = '' ,pBuildName                   ,left.build_name                ) + '\'\n'
      + '  ,\'' + if( left.esp                 = '' ,pESP                         ,left.esp                       ) + '\'\n'

      + '  ,\'' + pNotifyEmails                 + '\'\n'
      + '  ,\'' + pFailureEmails                + '\'\n'
      + '  ,' + if(pShouldEmail = true, 'true','false') + '\n'
      + '  ,\'' + pPollingFrequency + '\'\n'
      + '  ,' + if(left.forcerun  = true or pForceRun  = true,'true'           ,'false'           ) + '\n'
      + '  ,' + if(left.forceskip = true or pForceSkip = true,'true'           ,'false'           ) + '\n'
      + '  ,' + if(pCleanupSuper = true, 'true','false') + '\n'
      + '  ,' + pDebugValues + '\n'
      + '  ,false\n'
      + '  ,false\n'
      + '  ,' + if(left.compile_only = true or pCompileOnly = true,'true'           ,'false'           ) + '\n'
      + ');';
    self.ds_atts  := left;
    self          := [];
  ));

  ds_return := project(ds_prep,transform(recordof(left),
    self.wuid        := WorkMan.CreateWuid_Raw(left.ecl_query,WorkMan._Config.Esp2Hthor(left.esp),left.esp,,#EXPAND(pDebugValues));
    self             := left
  )) : independent;
  
  // return_result := ds_return;

  set_parallel_wuids := set(ds_return,wuid);

  return_result := WorkMan.mac_WorkMan_Multi(set_parallel_wuids,ds_return,pStartIteration,pversion,pBuildName,pOutputSuperfile,pESP,pNotifyEmails,pFailureEmails,pshouldemail, pPollingFrequency);

  #END


/*
WorkMan.mac_Workman_Test(
   myecl                                                                                              //pECL                  -- ECL code to run.
  ,'20180111b'                                                                                         //pversion              -- build date for this run.
  ,WorkMan._Config.Groupname('50')                                                                    //pcluster              -- cluster to run the iteration on.
  ,1                                                                                                 //pStartIteration       -- start iteration #.  If you blank this out(''), it will start where it left off + 1.
  ,1                                                                                                  //pNumMaxIterations     -- maximum number of iterations.  default is 1.  to specify no maximum, pass in ''.  
  ,                                                                                                  //pNumMinIterations     -- minimum number of iterations.  default is no minimum, although it will always run at least one iteration(not necessarily on restarts though).
  ,'~workman_testing::@version@::bipv2_lgid3'                                                         //pOutputFilename       -- workman output file for this build.  should be unique to your build.
  ,'~workman_testing::qa::bipv2_lgid3'                                                                //pOutputSuperfile      -- superfile you want the above output workman added to.  
  ,['MatchesPerformed','PreClusterCount']                                                             //pSetResults           -- output results to pull from the iteration wuid.  can be scalar('matchesperformed') or dataset indexed('Preclustercount[1].proxid_cnt').  
                                                                                                      //                         The dataset layout for a dataset result is not needed.  Also, unless the result is ambiguous, you can just specify the name and it will find it.
  ,''    //pStopCondition        -- optional stop condition.  when used, if this is true for a specific iteration, it will stop iterating unless it has not met the minimum number of iterations(if set).
  // ,'MatchesPerformed < (100000) or (100 - (MatchesPerformed / PreClusterCount * 100.0)) > (99.91)'    //pStopCondition        -- optional stop condition.  when used, if this is true for a specific iteration, it will stop iterating unless it has not met the minimum number of iterations(if set).
  ,[]                           //pSetNameCalculations  -- name all "calculations".  in the stop condition, anything surrounded by parentheses is considered and calculation and will be output.
  // ,['MatchesPerformed_Threshold','Pct_Convergence','Convergence_Threshold']                           //pSetNameCalculations  -- name all "calculations".  in the stop condition, anything surrounded by parentheses is considered and calculation and will be output.
  ,'bipv2_lgid3'                                                                                      //pBuildName            -- name your build
  ,pPollingFrequency := '1'                                                                           //pPollingFrequency     -- how often should the watcher check the status of the iteration?
  ,pNotifyEmails     := 'laverne.bentley@lexisnexisrisk.com'  //,kevin.wilmoth@lexisnexisrisk.com,cody.fouts@lexisnexisrisk.com'
  ,pDont_Wait := false
);

  createwatcherworkunit1 := WorkMan.CreateWuid(
     notifymultiecl
    ,watchercluster
    ,pESP
  ); 
*/

  
  
  
/*  
    return_result := apply(nothor(global(pECL,few))
      // ,WorkMan.mac_Work(
         // ecl
        // ,if(version             = '' ,pversion            ,version            )           
        // ,if(cluster             = '' ,pcluster            ,cluster            )           
        // ,if(start_iteration     = '' ,pStartIteration     ,start_iteration    ) 
        // ,if(max_iterations      = '' ,pNumMaxIterations   ,max_iterations     ) 
        // ,if(min_iterations      = '' ,pNumMinIterations   ,min_iterations     ) 
        // ,if(output_filename     = '' ,pOutputFilename     ,output_filename    ) 
        // ,if(output_superfile    = '' ,pOutputSuperfile    ,output_superfile   ) 
        // ,if(set_results         = '' ,pSetResults         ,set_results        ) 
        // ,if(stop_condition      = '' ,pStopCondition      ,stop_condition     ) 
        // ,if(named_calculations  = '' ,pSetNameCalculations,named_calculations ) 
        // ,if(build_name          = '' ,pBuildName          ,build_name         )        
        // ,if(esp                 = '' ,pESP                ,esp                )                     
        // ,pNotifyEmails    
        // ,pShouldEmail     
        // ,pPollingFrequency
        // ,if(forcerun            = '' ,pForceRun           ,forcerun           )        
        // ,if(forceskip           = '' ,pForceSkip          ,forceskip          )        
        // ,pCleanupSuper    
        // ,pDebugValues                                                                     
        // ,pDont_Wait 
        // ,pParallel
      // )    
    );
  #END
*/
// parallel(
      // output(dataset([
      // {'pECL'     ,pECL}
     // ,{'pcluster' ,pcluster}
     // ,{'pESP    ' ,pESP    }
     // ,{'pNotifyEmails    ' ,pNotifyEmails    }
     
    // ],{string stat,string statvalue}) ,named('Workman_mac_Workman'))
    // ,output(pDebugValues  ,named('Workman_mac_Workman_Debugvalues'))
    // );

  return return_result;

endmacro;


      // ,WorkMan.mac_Work(
         // ecl
        // ,if(version             = '' ,pversion            ,version            )           
        // ,if(cluster             = '' ,pcluster            ,cluster            )           
        // ,if(start_iteration     = '' ,pStartIteration     ,start_iteration    ) 
        // ,if(max_iterations      = '' ,pNumMaxIterations   ,max_iterations     ) 
        // ,if(min_iterations      = '' ,pNumMinIterations   ,min_iterations     ) 
        // ,if(output_filename     = '' ,pOutputFilename     ,output_filename    ) 
        // ,if(output_superfile    = '' ,pOutputSuperfile    ,output_superfile   ) 
        // ,if(set_results         = '' ,pSetResults         ,set_results        ) 
        // ,if(stop_condition      = '' ,pStopCondition      ,stop_condition     ) 
        // ,if(named_calculations  = '' ,pSetNameCalculations,named_calculations ) 
        // ,if(build_name          = '' ,pBuildName          ,build_name         )        
        // ,if(esp                 = '' ,pESP                ,esp                )                     
        // ,pNotifyEmails    
        // ,pShouldEmail     
        // ,pPollingFrequency
        // ,if(forcerun            = '' ,pForceRun           ,forcerun           )        
        // ,if(forceskip           = '' ,pForceSkip          ,forceskip          )        
        // ,pCleanupSuper    
        // ,pDebugValues     
        // ,pDont_Wait 
        // ,pParallel
      // )    
