buildversion  := '20200403d_TEST_COMPILE_EMAIL_ALL_PEOPLE3'                                            ;  // -- version date
lstartIter    := 720                                                         ;  // -- leave it default blank to start where you left off.  pass in a number to start at that iteration #
lnumIters     := 1                                                          ;  // -- minimum number of iterations
lnumMaxIters  := 1                                                          ;  // -- maximum number of iterations
ldoInit       := true                                                       ;  // -- do preprocess
ldoSpec       := true                                                       ;  // -- do specificities
ldoIter       := true                                                       ;  // -- do iterations
ldoPost       := true                                                       ;  // -- do postprocess
lInputFile    := 'BIPV2_Files.files_hrchy.FILE_HRCY_BASE_LF_FULL_BUILDING'  ;  // -- input file to preprocess
lcluster      := BIPV2_Build._Constants().Groupname                         ;  // -- should be thor400_dev_eclcc on dataland, and thor400_35_eclcc on boca prod
lCompileTest  := true                                                       ;  // -- just test compile everything.
lEmailList    := 'laverne.bentley@lexisnexisrisk.com'                       ;  // -- email list
// lEmailList    := BIPV2_Build.mod_email.emailList                            ;  // -- email list

// lds_debug     := 'dataset([],WsWorkunits.Layouts.DebugValues)' ; // -- use code from an origin branch optionally
lds_debug     := 'dataset(['
                  +' {\'Boca-branch\',\'BH-828\'                                                     }'
                  +',{\'Boca-URL\'  ,\'https://gitlab.ins.risk.regn.net/BentleLA/PublicRecords.git\'}'
                  +'],WsWorkunits.Layouts.DebugValues)' 
                  ;
     
#workunit('name'  ,'Lgid3 iterations -- ' + buildversion +  ' BH-828 -- analyze using fein only match in lgid3');
 
BIPV2_LGID3._proc_lgid3(
     lstartIter    // -- leave it default blank to start where you left off.  pass in a number to start at that iteration #
    ,lnumIters     // -- minimum number of iterations
    ,ldoInit   
    ,ldoSpec   
    ,ldoIter   
    ,ldoPost  
    ,buildversion
    ,lInputFile
    ,lnumMaxIters
    ,lcluster
    ,lCompileTest
    ,lEmailList
    ,lds_debug
);

    // ,lEmailList
