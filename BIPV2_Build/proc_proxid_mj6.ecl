import BIPV2_ProxID,BIPV2,tools,bipv2_build;

export proc_proxid_mj6(

   pstartiter       = '\'\''
  ,pnumiters        = '3'
  ,pversion         = 'BIPV2.KeySuffix'
  ,pdoPreprocess    = 'true'
  ,pdoSpecs         = 'true'
  ,pdoIters         = 'true'
  ,pdoPostProcess   = 'true'
  ,pcluster         = 'BIPV2_Build._Constants().Groupname'
  ,pUniqueOut       = '\'ProxidMJ6\''
  ,pDotFilename     = 'BIPV2_Proxid.filenames().base.built'                        //'BIPV2_Files.files_dotid.FILE_BASE' //by default it will start where it left off
  ,pMatchThreshold  = '\'0\''
  ,pEmailList       = 'BIPV2_Build.mod_email.emailList'     // -- for testing, make sure to put in your email address to receive the emails
  ,pCompileTest     = 'false'

) :=
functionmacro

  import BIPV2_Proxid_mj6;
  
  return BIPV2_Proxid_mj6._proc_Multiple_Iterations(

     pstartiter
    ,pnumiters 
    ,pversion       
    ,pdoPreprocess  
    ,pdoSpecs       
    ,pdoIters       
    ,pdoPostProcess 
    ,pcluster       
    ,pUniqueOut     
    ,pDotFilename   
    ,pMatchThreshold
    ,pEmailList
    ,pCompileTest
  );

endmacro;