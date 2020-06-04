import BIPV2_Testing,wk_ut,tools,bipv2_build;

EXPORT proc_Clean_Commonbase(pversion = 'BIPV2.KeySuffix') := 
functionmacro

  eclsample		:= '#workunit(\'name\',\'BIPV2_Build.Build_Clean_Commonbase @version@\');\n#workunit(\'priority\',\'high\');\n#OPTION(\'multiplePersistInstances\',FALSE);\n' + 'BIPV2_Build.Build_Clean_Commonbase(\'@version@\');';
  cluster     := BIPV2_Build._Constants().Groupname;
  
  kickBuild	  := wk_ut.mac_ChainWuids(eclsample,1,1,pversion,,cluster,pOutputEcl := false,pUniqueOutput := 'BuildCleanCommonBase',pNotifyEmails := BIPV2_Build.mod_email.emailList
  ,pOutputFilename   := '~bipv2_build::' + pversion + '::workunit_history::Build_Clean_Commonbase'
  ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
  );
  
  return kickBuild;

endmacro;