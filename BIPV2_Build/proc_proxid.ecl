import BIPV2_ProxID,BIPV2,tools,bipv2_build;
export proc_proxid(
   pstartiter
  ,pnumiters 
  ,pversion         = 'BIPV2.KeySuffix'
  ,pDOTFile         = '\'BIPV2_Files.files_dotid().DS_BASE\''
  ,pcluster         = 'BIPV2_Build._Constants().Groupname'
  ,pDotFilename     = '' //'BIPV2_Files.files_dotid().FILE_BASE'  //by default it will start where it left off
  ,pdoSpecs         = 'true'
  ,pUniqueOut       = '\'Proxid\''
  ,pMatchThreshold  = 'BIPV2_ProxID.Config.MatchThreshold'
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
    ,pdoSpecs
    ,pUniqueOut
    ,pMatchThreshold
  );
endmacro;
