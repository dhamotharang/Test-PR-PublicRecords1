import BIPV2,BIPV2_Strata,bipv2_build;
import BIPV2_Testing,wk_ut,tools,_control;

EXPORT proc_Best(
   pversion     = 'BIPV2.KeySuffix'
  ,pPromote2QA  = 'true'
) := 
functionmacro

  ecl		  := '#workunit(\'name\',\'BIPV2_Best.proc_Build  @version@\');\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'priority\',\'high\');\n' + 'BIPV2_Best.proc_Build(\'@version@\',,,,,@pPromote2QA@);';
  cluster := BIPV2_Build._Constants().Groupname;
  ecl2    := regexreplace('@pPromote2QA@',ecl,#TEXT(pPromote2QA),nocase);
  
  kickBuild := wk_ut.mac_ChainWuids(ecl2,1,1,pversion,,cluster,pOutputEcl := false,pUniqueOutput := 'BIPV2_Best',pNotifyEmails := BIPV2_Build.mod_email.emailList
  ,pOutputFilename   := '~bipv2_build::' + pversion + '::workunit_history::BIPV2_Best'
  ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
);
  
  return kickBuild;

endmacro;