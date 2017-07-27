import BIPV2_Testing,wk_ut,tools;

EXPORT proc_CDW_Files(pversion = 'BIPV2.KeySuffix') := 
functionmacro

  eclsample		:= '#workunit(\'name\',\'BIPV2_Build.Build_CDW_Files @version@\');\n#workunit(\'priority\',\'high\');\n#workunit(\'priority\',\'high\');\n#OPTION(\'multiplePersistInstances\',FALSE);\n' + 'BIPV2_Build.Build_CDW_Files(\'@version@\');';
  cluster     := BIPV2_Build._Constants().Groupname;
  
  kickBuild	  := wk_ut.mac_ChainWuids(eclsample,1,1,pversion,,cluster,pOutputEcl := false,pUniqueOutput := 'Build_CDW_Files',pNotifyEmails := BIPV2_Build.mod_email.emailList + ',behnoosh.behmaram@lexisnexis.com'
  ,pOutputFilename   := '~bipv2_build::' + pversion + '::workunit_history::Build_CDW_Files'
  ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
  );
  
  return kickBuild;

endmacro;