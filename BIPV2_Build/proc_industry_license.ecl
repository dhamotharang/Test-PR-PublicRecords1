import TopBusiness_BIPV2;

import BIPV2_Testing,wk_ut,tools,bipv2_build;

EXPORT proc_industry_license(pversion = 'BIPV2.KeySuffix') := 
functionmacro

  eclsample		:= '#workunit(\'name\',\'TopBusiness_BIPV2.Build_All @version@\');\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'priority\',\'high\');\n' + 'TopBusiness_BIPV2.Build_All(\'@version@\',,,false     );';
  cluster     := BIPV2_Build._Constants().Groupname;
  
  kickBuild	  := wk_ut.mac_ChainWuids(eclsample,1,1,pversion,,cluster,pOutputEcl := false,pUniqueOutput := 'TopBusinessBuild',pNotifyEmails := BIPV2_Build.mod_email.emailList
      ,pOutputFilename   := '~bipv2_build::' + pversion + '::workunit_history::proc_industry_license'
      ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
  );
  
  return kickBuild;

endmacro;