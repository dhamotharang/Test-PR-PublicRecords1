import BIPV2_Files,tools,BIPV2,bipv2_build;

EXPORT proc_Promote2QA_Dataland(
   pversion         = 'BIPV2.KeySuffix'
  ,pEmailList       = 'BIPV2_Build.mod_email.emailList'     // -- for testing, make sure to put in your email address to receive the emails
  ,pCompileTest     = 'false'
  ,pdoParallel      = 'true'
  ,pLESP            = 'wk_ut._Constants.DevEsp'
) :=
functionmacro
  
  import workman,tools,bipv2,BIPV2_Build;
  
  version           := pversion                               ;
  cluster           := wk_ut._Constants.Esp2Hthor(pLESP) ;
  
  ecl_text :=   '#workunit(\'name\',\'BIPV2_Build.Promote2QA @version@\');\n'
              + 'BIPV2_Build.Promote2QA(\n\n'
              + ' pversion         := \'@version@\'\n  '
              + ',pShouldUpdateDOPS       := false\n  '
              + ',pPerformCleanup := true'
              + ');';

  KickPromote2QADataland := Workman.mac_WorkMan(ecl_text ,version,cluster,1         ,1       ,pESP := pLESP ,pBuildName := 'Promote2QAOnDataland',pNotifyEmails := pEmailList
      ,pOutputFilename   := '~bipv2_build::' + version + '::workunit_history::Promote2QA'
      ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
      ,pCompileOnly      := pCompileTest
      ,pDont_Wait        := pdoParallel
  );

  return KickPromote2QADataland;
  

endmacro;
