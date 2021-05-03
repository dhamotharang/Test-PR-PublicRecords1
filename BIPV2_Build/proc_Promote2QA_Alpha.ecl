import BIPV2_Files,tools,BIPV2,bipv2_build;

EXPORT proc_Promote2QA_Alpha(
   pversion         = 'BIPV2.KeySuffix'
  ,pcluster         = '\'hthor_prod_eclcc\''
  ,pEmailList       = 'BIPV2_Build.mod_email.emailList'     // -- for testing, make sure to put in your email address to receive the emails
  ,pCompileTest     = 'false'
  ,pdoParallel      = 'true'
  ,pLESP            = '\'alpha_prod_thor_esp.risk.regn.net\''
  ,pds_debug        = '\'dataset([],WsWorkunits.Layouts.DebugValues)\''
) :=
functionmacro
  
  import workman,tools,bipv2,BIPV2_Build;
  
  version           := pversion                         ;
  cluster           := pcluster                         ;
  
  ecl_text :=   '#workunit(\'name\',\'BIPV2_Build.Promote2QA_Alpha @version@\');\n\n'
              + '#workunit(\'priority\',\'high\');\n'
              + 'BIPV2_Build.Promote2QA_Alpha(\'@version@\');'
              ;
                     
  kickbuild := Workman.mac_WorkMan(ecl_text ,version,cluster,1         ,1       ,pESP := pLESP ,pBuildName := 'Promote2QA_Alpha',pNotifyEmails := pEmailList
      ,pOutputFilename   := '~bipv2_build::' + version + '::workunit_history::BIPV2_Build.Promote2QA_Alpha'
      ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
      ,pCompileOnly      := pCompileTest
      ,pDont_Wait        := pdoParallel
      ,pDebugValues      := pds_debug
  );

  return kickbuild;
  

endmacro;
