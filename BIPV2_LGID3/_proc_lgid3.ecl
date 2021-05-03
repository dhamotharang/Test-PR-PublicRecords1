import BIPV2_Files, BIPV2, MDR, BIPV2_LGID3,ut,bipv2_build,wk_ut,tools,std,BIPV2_Tools,mdr,SALTTOOLS22,WsWorkunits;  
// Init receives a file in common layout, and narrows it for use in all iterations. We widen
// back to the common layout before promoting it to the base/father/grandfather superfiles.
l_common  := BIPV2.CommonBase.Layout;
l_base    := BIPV2_Files.files_lgid3.Layout_LGID3;

export _proc_lgid3(

   pstartIter     = '\'\''                                                        // -- leave it default blank to start where you left off.  pass in a number to start at that iteration #
  ,pnumMinIters   = '7'                                                           // -- minimum number of iterations
  ,pdoInit        = 'true'                                                        // -- do preprocess
  ,pdoSpec        = 'true'                                                        // -- do specificities
  ,pdoIter        = 'true'                                                        // -- do iteration(s)
  ,pdoPost        = 'true'                                                        // -- do postprocess
  ,pversion       = 'bipv2.KeySuffix'                                             // -- build version
  ,pInputFile     = '\'BIPV2_Files.files_hrchy.FILE_HRCY_BASE_LF_FULL_BUILDING\'' // -- input file to preprocess
  ,pnumMaxIters   = '15'                                                          // -- maximum number of iterations
  ,pcluster       = 'BIPV2_Build._Constants().Groupname'                          // -- thor to run on
  ,pCompileTest   = 'false'                                                       // -- doing a compile test?
  ,pEmailList     = 'BIPV2_Build.mod_email.emailList'                             // -- for testing, make sure to put in your email address to receive the emails
  ,pds_debug      = '\'dataset([],WsWorkunits.Layouts.DebugValues)\''             // -- use code from an origin branch optionally

) := 
functionmacro

  import wk_ut, tools,bipv2_build,Workman,WsWorkunits;
  cluster		:= pcluster;
  version		:= pversion;

  eclInit		:= 'import BIPV2_Files,BIPV2_LGID3;\n'
              +'iteration := \'@iteration@\';\n'
              +'pversion  := \'@version@\';\n'
              +'#workunit(\'name\',\'BIPV2_LGID3._Preprocess \' + pversion );\n'
              +'#workunit(\'priority\',\'high\');\n\n'
              +'#OPTION(\'multiplePersistInstances\',FALSE);\n' 
              +'BIPV2_LGID3._Preprocess(pversion,' + pInputFile + ');\n'
              ;


  eclSpec		:= 'import BIPV2_Files,BIPV2_LGID3;\n'
              +'iteration := \'@iteration@\';\n'
              +'pversion  := \'@version@\';\n'
              +'lih := BIPV2_LGID3.In_LGID3;\n\n'
              +'#OPTION(\'multiplePersistInstances\',FALSE);\n'
              +'#workunit(\'name\',\'BIPV2_LGID3._Specificities \' + pversion);\n'
              +'#workunit(\'priority\',\'high\');\n'
              +'BIPV2_LGID3._proc_Specificities(lih);\n'
              ;

  eclIter		:= 'import BIPV2_Files,BIPV2_LGID3;\n'
               +'iteration := \'@iteration@\';\n'
               +'pversion  := \'@version@\';\n'
               +'lih := BIPV2_LGID3.In_LGID3;\n\n'
               +'#OPTION(\'multiplePersistInstances\',FALSE);\n'
               +'#workunit(\'name\',\'BIPV2_LGID3 \' + pversion + \' iter \' + iteration);\n'
               +'#workunit(\'priority\',\'high\');\n'
               +'#workunit(\'protect\' ,true);\n'
               +'BIPV2_LGID3._Proc_Iterate(iteration,pversion,lih);\n'
               ;

  eclPost		:= 'import BIPV2_LGID3;\n\n'
               +'#workunit(\'name\',\'BIPV2_LGID3._Postprocess @version@\');\n\n'
               +'#workunit(\'priority\',\'high\');\n\n'
               +'#OPTION(\'multiplePersistInstances\',FALSE);\n'
               +'pversion  := \'@version@\';\n' 
               +'BIPV2_LGID3._Postprocess(pversion);'
               ;

  eclsetResults   := [ 'PreClusterCount PreClusterCount.LGID3_Cnt'        
                      ,'PostClusterCount PostClusterCount.LGID3_Cnt'       
                      ,'MatchesPerformed'      
                      ,'BasicMatchesPerformed'
                      ,'SlicesPerformed'
                      // ,'ProxidsCreatedByCleave'
                      ,'LinkBlockSplits'
                      ,'recordsrejected0'
                      ,'unlinkablerecords0'
                     ];
  StopCondition       := '(PostClusterCount / PreClusterCount * 100.0) > (99.999)';
  SetNameCalculations := ['Convergence_PCT','Convergence_Threshold'];

  kickInit	:= Workman.mac_WorkMan(eclInit,version,cluster,1,1,pBuildName := 'LGID3Init',pNotifyEmails := pEmailList
    ,pOutputFilename   := '~bipv2_build::' + version + '::workunit_history::proc_lgid3.Init'
    ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
    ,pCompileOnly      := pCompileTest
    ,pDebugValues      := pds_debug
  );
  
  kickSpec	:= Workman.mac_WorkMan(eclSpec,version,cluster,1,1,pBuildName := 'LGID3Specs',pNotifyEmails := pEmailList
    ,pOutputFilename   := '~bipv2_build::' + version + '::workunit_history::proc_lgid3.Specificities'
    ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
    ,pCompileOnly      := pCompileTest
    ,pDebugValues      := pds_debug
  );
  
  kickiters := Workman.mac_WorkMan(eclIter,version,cluster,pstartIter,pnumMaxIters,pnumMinIters
    ,pSetResults          := eclsetResults
    ,pStopCondition       := StopCondition
    ,pSetNameCalculations := SetNameCalculations
    ,pBuildName           := 'LGID3Iters'
    ,pNotifyEmails        := pEmailList
    ,pOutputFilename      := '~bipv2_build::@version@::workunit_history::proc_lgid3.iterations'
    ,pOutputSuperfile     := '~bipv2_build::qa::workunit_history' 
    ,pCompileOnly         := pCompileTest
    ,pDebugValues         := pds_debug
  );
  
  kickPost  := Workman.mac_WorkMan(eclPost,version ,cluster  ,1         ,1        ,pBuildName := 'LGID3Post',pNotifyEmails := pEmailList
    ,pOutputFilename   := '~bipv2_build::' + version + '::workunit_history::proc_lgid3.Post'
    ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
    ,pCompileOnly      := pCompileTest
    ,pDebugValues      := pds_debug
  );
  
  return sequential(
     if(pdoInit  ,kickInit )
    ,if(pdoSpec  ,kickSpec )
    ,if(pdoIter  ,kickiters)
    ,if(pdoPost  ,kickPost )
  );
endmacro;
