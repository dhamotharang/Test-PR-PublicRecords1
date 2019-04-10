import BIPV2_ProxID,BIPV2,tools,bipv2_build;
export proc_proxid(
   pstartiter       = '\'\''
  ,pnumiters        = '3'
  ,pversion         = 'BIPV2.KeySuffix'
  ,pDOTFile         = '\'BIPV2_Files.files_dotid().DS_BASE\''
  ,pcluster         = 'BIPV2_Build._Constants().Groupname'
  ,pDotFilename     = '' //'BIPV2_Files.files_dotid().FILE_BASE'  //by default it will start where it left off
  ,pdoPreprocess    = 'true'
  ,pdoSpecs         = 'true'
  ,pdoIter          = 'true'
  ,pdoPostProcess   = 'true'
  ,pUniqueOut       = '\'Proxid\''
  ,pMatchThreshold  = 'BIPV2_ProxID.Config.MatchThreshold'
  ,pEmailList       = 'BIPV2_ProxID._Constants().EmailList'     // -- for testing, make sure to put in your email address to receive the emails
  ,pCompileTest     = 'false'
) :=
functionmacro
  import BIPV2_Proxid,bipv2_proxid_mj6;
  
  return BIPV2_Proxid._proc_Multiple_Iterations(
     pstartiter
    ,pnumiters 
    ,pversion     
    ,pDOTFile     
    ,pcluster     
    ,pDotFilename 
    ,pdoPreprocess 
    ,pdoSpecs      
    ,pdoIter       
    ,pdoPostProcess
    ,pUniqueOut
    ,pMatchThreshold
    ,pEmailList  
    ,pCompileTest
  );
endmacro;
