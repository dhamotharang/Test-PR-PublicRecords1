/*
  When testing, you might want to turn off certain aspects of this build
  do that here:
    BIPV2_ProxID._Constants

*/
// BIPV2_Build.proc_proxid(
BIPV2_ProxID._proc_Multiple_Iterations(
   pstartiter       := 354   
  ,pnumiters        := 1   
  ,pversion         := BIPV2.KeySuffix
  ,pDOTFile         := 'BIPV2_Files.files_dotid().DS_BASE'                 
  ,pcluster         := BIPV2_Build._Constants().Groupname
  ,pDotFilename     := '' //'BIPV2_Files.files_dotid().FILE      
  ,pdoSpecs         := true
  ,pUniqueOut       := 'Proxid'
  ,pMatchThreshold  := BIPV2_ProxID.Config.MatchThreshold  
);