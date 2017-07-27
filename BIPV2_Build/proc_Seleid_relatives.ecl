import BIPV2;
import BIPV2_Testing,wk_ut,tools,_control,bipv2_build;

EXPORT proc_Seleid_relatives(
   pversion     = 'BIPV2.KeySuffix'
  ,pdoSpecs     = 'true'
  ,pdoIters     = 'true'
  ,pPromote2QA  = 'false'
  ,pcluster     = 'BIPV2_Build._Constants().Groupname'

) := 
functionmacro

  // ecl		  := '#workunit(\'name\',\'BIPV2_Seleid_Relative.Proc_build  @version@\');\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'priority\',\'high\');\n' + 'BIPV2_Seleid_Relative.Proc_build(\'@version@\',,@pPromote2QA@);';
  // cluster := tools.fun_Groupname('20',false);
  // ecl2    := regexreplace('@pPromote2QA@',ecl,#TEXT(pPromote2QA),nocase);
  
  // kickBuild := wk_ut.mac_ChainWuids(ecl2,1,1,pversion,,cluster,pOutputEcl := false,pUniqueOutput := 'BIPV2_Seleid_Relative',pNotifyEmails := _control.MyInfo.EmailAddressNotify + ';aleida.lima@lexisnexis.com'
  // ,pOutputFilename   := '~bipv2_build::' + pversion + '::workunit_history::proc_Seleid_relatives'
  // ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
  // );
  
  return BIPV2_Seleid_Relative._Proc_Iterate(pversion,pdoSpecs,pdoIters,pcluster);

endmacro;