import BIPV2_Files,tools,BIPV2,bipv2_build;

EXPORT proc_proxid_underlinks(
   pversion         = 'BIPV2.KeySuffix'
  ,pcluster         = 'BIPV2_Build._Constants().Groupname'
  ,pEmailList       = 'BIPV2_Build.mod_email.emailList'     // -- for testing, make sure to put in your email address to receive the emails
  ,pCompileTest     = 'false'
  ,pdoParallel      = 'true'
) :=
functionmacro
  
  import workman,tools,bipv2,BIPV2_Build;
  
  version           := pversion                         ;
  cluster           := pcluster                         ;
  
  ecl_text :=    '#workunit(\'name\',\'BIPV2_ProxID._Underlinks @version@\');\n\n'
              + '#workunit(\'priority\',\'high\');\n'
              + 'BIPV2_ProxID._Underlinks(\'@version@\',pMatchRegex := \'\',pJustSingletons := true);'
              ;
                     
  kickbuild := Workman.mac_WorkMan(ecl_text ,version,cluster,1         ,1        ,pBuildName := 'Proxid_Underlinks',pNotifyEmails := pEmailList
      ,pOutputFilename   := '~bipv2_build::' + version + '::workunit_history::BIPV2_ProxID._Underlinks'
      ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
      ,pCompileOnly      := pCompileTest
      ,pDont_Wait        := pdoParallel
  );

  return kickbuild;
  

endmacro;
