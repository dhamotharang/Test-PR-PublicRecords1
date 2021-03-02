import BIPV2_Files,tools,BIPV2,bipv2_build;

EXPORT proc_Underlink_Report(
   pversion         = 'BIPV2.KeySuffix'
  ,pCompileTest     = 'false'
  ,pcluster         = 'BIPV2_Build._Constants().Groupname'
  ,pEmailList       = 'BIPV2_Build.mod_email.emailList'     // -- for testing, make sure to put in your email address to receive the emails
  ,pdoParallel      = 'true'
) :=
functionmacro
  
  import workman,tools,bipv2,BIPV2_Build;
  
  version           := pversion                         ;
  cluster           := pcluster                         ;
  
  ecl_text :=   '#workunit(\'name\',\'BIPV2_Analysis.mod_Reports @version@\');\n\n'
              + '#workunit(\'priority\',\'high\');\n'
              + 'BIPV2_Analysis.mod_Reports(\'@version@\',\'@version@\').do_all;'
              ;
                     
  kickbuild := Workman.mac_WorkMan(ecl_text ,version,cluster,1         ,1        ,pBuildName := 'Underlink_Report',pNotifyEmails := pEmailList
      ,pOutputFilename   := '~bipv2_build::' + version + '::workunit_history::BIPV2_Analysis.mod_Reports'
      ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
      ,pCompileOnly      := pCompileTest
      ,pDont_Wait        := pdoParallel
  );

  return kickbuild;
  

endmacro;
