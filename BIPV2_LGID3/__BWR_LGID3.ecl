buildversion  := bipv2.KeySuffix                                            ;  // -- version date
lstartIter    := ''                                                         ;  // -- leave it default blank to start where you left off.  pass in a number to start at that iteration #
lnumIters     := 7                                                          ;  // -- minimum number of iterations
lnumMaxIters  := 15                                                         ;  // -- maximum number of iterations
ldoInit       := true                                                       ;  // -- do preprocess
ldoSpec       := true                                                       ;  // -- do specificities
ldoIter       := true                                                       ;  // -- do iterations
ldoPost       := true                                                       ;  // -- do postprocess
lInputFile    := 'BIPV2_Files.files_hrchy.FILE_HRCY_BASE_LF_FULL_BUILDING'  ;  // -- input file to preprocess
lcluster      := BIPV2_Build._Constants().Groupname                         ;  // -- should be thor400_dev_eclcc on dataland, and thor400_35_eclcc on boca prod
lCompileTest  := false                                                      ;  // -- just test compile everything.
lds_debug     := 'dataset([],WsWorkunits.Layouts.DebugValues)' ; // -- use code from an origin branch optionally
// lds_debug     := 'dataset(['
                  // +' {\'Boca-branch\',\'BH-800\'                                                     }'
                  // +',{\'Boca-URL\'  ,\'https://gitlab.ins.risk.regn.net/BentleLA/PublicRecords.git\'}'
                  // +'],WsWorkunits.Layouts.DebugValues)' ;
     
#workunit('name'  ,'Lgid3 iterations -- ' + buildversion +  ' BH-XXX -- some improvement');
 
BIPV2_LGID3._proc_lgid3(
     pstartIter     := lstartIter    // -- leave it default blank to start where you left off.  pass in a number to start at that iteration #
    ,pnumMinIters   := lnumIters     // -- minimum number of iterations
    ,pnumMaxIters   := lnumMaxIters
    ,pdoInit        := ldoInit   
    ,pdoSpec        := ldoSpec   
    ,pdoIter        := ldoIter   
    ,pdoPost        := ldoPost  
    ,pInputFile     := lInputFile
    ,pversion       := buildversion
    ,pcluster       := lcluster
    ,pCompileTest   := lCompileTest
    ,pds_debug      := lds_debug
);