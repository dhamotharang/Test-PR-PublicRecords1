import BIPV2_LGID3,BIPV2,tools,bipv2_build,WsWorkunits;

export proc_lgid3(
   pstartIter     = '\'\''                                // -- leave it default blank to start where you left off.  pass in a number to start at that iteration #
  ,pnumMinIters   = '7'                                   // -- minimum number of iterations
  ,pdoInit        = 'true'                                // -- do preprocess
  ,pdoSpec        = 'true'                                // -- do specificities
  ,pdoIter        = 'true'                                // -- do iteration(s)
  ,pdoPost        = 'true'                                // -- do postprocess
  ,pversion       = 'bipv2.KeySuffix'                     // -- build version
  ,pInputFile     = '\'BIPV2_Files.files_hrchy.FILE_HRCY_BASE_LF_FULL_BUILDING\'' // -- input file to preprocess
  ,pnumMaxIters   = '15'                                  // -- maximum number of iterations
  ,pcluster       = 'BIPV2_Build._Constants().Groupname'  // -- thor to run on
  ,pCompileTest   = 'false'                               // -- doing a compile test?
  ,pEmailList     = 'BIPV2_Build.mod_email.emailList'                             // -- for testing, make sure to put in your email address to receive the emails
  ,pds_debug      = '\'dataset([],WsWorkunits.Layouts.DebugValues)\''
) :=
functionmacro
  
  import BIPV2_LGID3,BIPV2,tools,bipv2_build;
  
  return BIPV2_LGID3._proc_lgid3(
     pstartIter    
    ,pnumMinIters  
    ,pdoInit       
    ,pdoSpec       
    ,pdoIter       
    ,pdoPost       
    ,pversion  
    ,pInputFile
    ,pnumMaxIters  
    ,pcluster      
    ,pCompileTest
    ,pEmailList
    ,pds_debug
  );

endmacro;
