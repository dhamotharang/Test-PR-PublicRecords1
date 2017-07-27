import TopBusiness_BIPV2;

import BIPV2_Testing,wk_ut,tools,bipv2_build;

EXPORT proc_weekly_keys(pversion = 'BIPV2.KeySuffix',pPromote2QA = 'false') := 
functionmacro

  eclsample		:= '#workunit(\'name\',\'BIPV2_Build.build_weekly_keys @version@\');\n#workunit(\'priority\',\'high\');\n' + 'BIPV2_Build.build_weekly_keys(\'@version@\',true,@pPromote2QA@).buildall;';
  cluster     := BIPV2_Build._Constants().Groupname;
  ecl2        := regexreplace('@pPromote2QA@',eclsample,#TEXT(pPromote2QA),nocase);
  
  kickBuild	  := wk_ut.mac_ChainWuids(ecl2,1,1,pversion,,cluster,pOutputEcl := false,pUniqueOutput := 'BuildWeeklyKeys',pNotifyEmails := BIPV2_Build.mod_email.emailList
  ,pOutputFilename   := '~bipv2_build::' + pversion + '::workunit_history::proc_weekly_keys'
  ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
  );
  
  return sequential(kickBuild);

endmacro;

