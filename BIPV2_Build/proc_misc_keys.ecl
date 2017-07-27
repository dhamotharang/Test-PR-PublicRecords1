import TopBusiness_BIPV2;

import BIPV2_Testing,wk_ut,tools,bipv2_build;

EXPORT proc_misc_keys(pversion = 'BIPV2.KeySuffix') := 
functionmacro

  eclsample		:= '#workunit(\'name\',\'BIPV2_Build.Build_misc_keys @version@\');\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'priority\',\'high\');\n' + 'BIPV2_Build.Build_misc_keys(\'@version@\',false).buildall;';
  cluster     := BIPV2_Build._Constants().Groupname;
  
  kickBuild	  := wk_ut.mac_ChainWuids(eclsample,1,1,pversion,,cluster,pOutputEcl := false,pUniqueOutput := 'BuildMiscKeys',pNotifyEmails := BIPV2_Build.mod_email.emailList
      ,pOutputFilename   := '~bipv2_build::' + pversion + '::workunit_history::proc_misc_keys'
      ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
  );
  
  return kickBuild;

endmacro;

