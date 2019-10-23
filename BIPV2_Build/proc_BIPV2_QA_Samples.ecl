import BIPV2_Testing,workman,tools,bipv2_build,bipv2;

EXPORT proc_BIPV2_QA_Samples(
   pversion     = 'BIPV2.KeySuffix'
  ,pCompileTest = 'false'
) := 
functionmacro

  eclcode		:=    '#workunit(\'name\',\'BIPV2 QA Samples @version@\');\n'
                + '#workunit(\'priority\',\'high\');\n'
                // + '#OPTION(\'multiplePersistInstances\',FALSE);\n' 
                + 'BizLinkFull_QA.TestSettings();'
                ;
                
  cluster     := BIPV2_Build._Constants().Groupname;
  version     := pversion;
  
  kickBuild := Workman.mac_WorkMan(
     eclcode  
    ,version
    ,cluster
    ,1         
    ,1        
    ,pBuildName         := 'BizLinkFull_QA.TestSettings'
    ,pNotifyEmails      := BIPV2_Build.mod_email.emailList
    ,pOutputFilename    := '~bipv2_build::' + version + '::workunit_history::BizLinkFull_QA.TestSettings'
    ,pOutputSuperfile   := '~bipv2_build::qa::workunit_history' 
    ,pCompileOnly       := pCompileTest
  );
  
  
  return kickBuild;

endmacro;