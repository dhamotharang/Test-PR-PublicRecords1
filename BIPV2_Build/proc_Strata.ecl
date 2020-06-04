import BIPV2,BIPV2_Strata;
import BIPV2_Testing,wk_ut,tools,_control,bipv2_build;

EXPORT proc_Strata(
   pversion     = 'BIPV2.KeySuffix'
) := 
functionmacro

  eclcode		:= 'import BIPV2_Strata;\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'name\',\'BIPV2_Strata.proc_build_all @version@\');\n#workunit(\'priority\',\'high\');\n#workunit(\'protect\' ,true);\n' + 'BIPV2_Strata.proc_build_all(\'@version@\');';
  cluster   := BIPV2_Build._Constants().Groupname;
  
  kickBuild := wk_ut.mac_ChainWuids(eclcode,1,1,pversion,,cluster,pOutputEcl := false,pUniqueOutput := 'BIPV2_Strata',pNotifyEmails := BIPV2_Build.mod_email.emailList
  ,pOutputFilename   := '~bipv2_build::' + pversion + '::workunit_history::proc_Strata'
  ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
  );
  
  return kickBuild;

endmacro;