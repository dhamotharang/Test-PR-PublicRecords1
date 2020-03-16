/*
  When testing, you might want to turn off certain aspects of this build
  do that here:
    BIPV2_ProxID._Constants

*/
// BIPV2_Build.proc_proxid(

#workunit('name'  ,'Proxid perfect name address match exceptions -- BH-800 -- Amex underlinking in proxid');
BIPV2_ProxID._proc_Multiple_Iterations(
   pstartiter       := '604'    //default is to start where it left off
  ,pnumiters        := 1
  ,pversion         := BIPV2.KeySuffix + 'b'
  ,pDOTFile         := 'bipv2.commonbase.ds_local'
  ,pcluster         := BIPV2_Build._Constants().Groupname
  ,pDotFilename     := ''                                  //'BIPV2_Files.files_dotid.FILE_BASE' //by default it will start where it left off
  ,pdoPreprocess    := true
  ,pdoSpecs         := false
  ,pdoIter          := true
  ,pdoPostprocess   := false  //BIPV2_ProxID._Constants().RunPostProcess
  ,pUniqueOut       := 'Proxid'
  ,pMatchThreshold  := BIPV2_ProxID.Config.MatchThreshold
  ,pEmailList       := 'laverne.bentley@lexisnexisrisk.com'     // -- for testing, make sure to put in your email address to receive the emails
  ,pCompileTest     := false
  ,pdo1Iteration    := true
  ,pIsTesting       := true
  ,pds_debug        := 'dataset([{\'Boca-branch\',\'BH-800\'},{\'Boca-URL\',\'https://gitlab.ins.risk.regn.net/BentleLA/PublicRecords.git\'}],WsWorkunits.Layouts.DebugValues)'
);