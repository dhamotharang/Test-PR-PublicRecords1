import BIPV2_ProxID,BIPV2,tools,bipv2_build;
export proc_proxid(
   pstartiter
  ,pnumiters 
  ,pversion         = 'BIPV2.KeySuffix'
  ,pDOTFile         = '\'BIPV2_Files.files_dotid().DS_BASE\''
  ,pdopatch         = 'true'
  ,pcluster         = 'BIPV2_Build._Constants().Groupname'
  ,pDotFilename     = '' //'BIPV2_Files.files_dotid().FILE_BASE'  //by default it will start where it left off
  ,pdoSpecs         = 'true'
  ,pUniqueOut       = '\'Proxid\''
  ,pMatchThreshold  = 'BIPV2_ProxID.Config.MatchThreshold'
  ,pForceFile       = 'false'  //force the pDotFilename to be used?
) :=
functionmacro
  import BIPV2_Proxid;
  
  return BIPV2_Proxid._proc_Multiple_Iterations(
     pstartiter
    ,pnumiters 
    ,pversion     
    ,pDOTFile     
    ,pdopatch      
    ,pcluster     
    ,pDotFilename 
    ,pdoSpecs
    ,pUniqueOut
    ,pMatchThreshold
    ,pForceFile
  );
endmacro;
