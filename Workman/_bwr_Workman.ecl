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

#workunit('name','Parent BIPV2 Best');
WorkMan.mac_Workman(
   myecl                                                                                              //pECL
  ,'20180504'                                                                                         //pversion
  ,WorkMan._Config.Groupname('50')                                                                 //pcluster
  ,1                                                                                                 //pStartIteration
  ,4                                                                                                   //pNumMaxIterations 
  ,3                                                                                                   //pNumMinIterations
  ,'~workman_testing::@version@::bipv2_proxid'                                                         //pOutputFilename      = '\'\''
  ,'~workman_testing::qa::bipv2_proxid'                                                                //pOutputSuperfile     = '\'\''
  ,['MatchesPerformed','PreClusterCount']                                                             //pSetResults            
  ,'MatchesPerformed < (100000) or (100 - (MatchesPerformed / PreClusterCount * 100.0)) > (99.91)'    //pStopCondition               
  ,['MatchesPerformed_Threshold','Pct_Convergence','Convergence_Threshold']                           //pSetNameCalculations
  ,'bipv2_proxid'
  ,pPollingFrequency := '1'
);

  // export parallel_ecl :=
  // record
    // string        ecl                      ;
    // string        build_name          := '';  // all defaults will take what is passed into WorkMan.mac_WorkMan
    // string        output_filename     := '';
    // string        output_superfile    := '';
    // string        version             := '';
    // string        cluster             := '';
    // string        start_iteration     := '';
    // string        max_iterations      := '';
    // string        min_iterations      := '';
    // set of string set_results         := [];
    // string        stop_condition      := '';
    // set of string named_calculations  := [];
    // string        esp                 := WorkMan._Config.LocalEsp;
    // boolean       forcerun            := false;
    // boolean       forceskip           := false;
    // boolean       compile_only        := false;
  // end;

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

myecl2 := 
  '#workunit(\'name\',\'bipv2_lgid3 @version@-@iteration@ workman test\');\n'
+ 'setpreclustercount  := [392933809 ,382870103  ,381654002  ,381326072  ,381147324];\n'
+ 'setmatchesperformed := [6265107   ,1032750    ,346601     ,192764     ,117560   ];\n'
+ 'setconvergence      := [98.406    ,99.730     ,99.909     ,99.949     ,99.969   ];\n'
+ 'output(setpreclustercount [@iteration@]  ,named(\'PreClusterCount\'));\n'
+ 'output(setmatchesperformed[@iteration@]  ,named(\'MatchesPerformed\'));\n'
+ 'output(setconvergence     [@iteration@]  ,named(\'Convergence\'));\n'
// + 'iff(@iteration@ = 2  ,fail(\'Just fail for testing\'));  '                                         
;

llversion     := '20180925h';
setresults    := ['MatchesPerformed','PreClusterCount'];
stopcondition := 'MatchesPerformed < (100000) or (100 - (MatchesPerformed / PreClusterCount * 100.0)) > (99.91)';
namedcalcs    := ['MatchesPerformed_Threshold','Pct_Convergence','Convergence_Threshold'];
runcluster    := 'hthor';//WorkMan._Config.Groupname('50');

ds_workman_prep := dataset([
   {myecl  ,'bipv2_proxid' ,'~workman_testing::@version@::bipv2_proxid'  ,'~workman_testing::qa::bipv2_proxid' ,llversion ,WorkMan._Config.Groupname('50')  ,''  ,'3' ,'' ,setresults ,stopcondition ,namedcalcs  ,WorkMan._Config.DevEsp  ,false,false,false}
  ,{myecl2 ,'bipv2_lgid3'  ,'~workman_testing::@version@::bipv2_lgid3'   ,'~workman_testing::qa::bipv2_lgid3'  ,llversion ,runcluster  ,''  ,'3' ,'' ,setresults ,stopcondition ,namedcalcs  ,WorkMan._Config.ProdEsp ,false,false,false}

],WorkMan.Layouts.parallel_ecl);

#workunit('name','Parent BIPV2 Test Iterating one on dataland, one on prod');
WorkMan.mac_Workman(
   ds_workman_prep                                                                                              //pECL
  ,llversion                                                                                         //pversion
  ,WorkMan._Config.Groupname('50')                                                                 //pcluster
  ,1                                                                                                 //pStartIteration
  ,4                                                                                                   //pNumMaxIterations 
  ,3                                                                                                   //pNumMinIterations
  ,'~workman_testing::@version@::bipv2_proxid'                                                         //pOutputFilename      = '\'\''
  ,'~workman_testing::qa::bipv2_proxid'                                                                //pOutputSuperfile     = '\'\''
  ,['MatchesPerformed','PreClusterCount']                                                             //pSetResults            
  ,'MatchesPerformed < (100000) or (100 - (MatchesPerformed / PreClusterCount * 100.0)) > (99.91)'    //pStopCondition               
  ,['MatchesPerformed_Threshold','Pct_Convergence','Convergence_Threshold']                           //pSetNameCalculations
  ,'bipv2_proxid'
  ,pPollingFrequency := '1'
  ,pCompileOnly := false
);