import BIPV2,BIPV2_Strata;
import BIPV2_Testing,wk_ut,tools,_control,bipv2_build;

EXPORT proc_overlinking_samples(
   pversion     = 'BIPV2.KeySuffix'
) := 
functionmacro

  eclcode		:= '#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'name\',\'BIPV2_Tools.Output_Overlinking_Samples @version@\');\n#workunit(\'priority\',\'high\');\n' + 'BIPV2_Tools.Output_Overlinking_Samples(\'@version@\');';
  cluster   := BIPV2_Build._Constants().Groupname;
  
  kickBuild := wk_ut.mac_ChainWuids(eclcode,1,1,pversion,,cluster,pOutputEcl := false,pUniqueOutput := 'BIPV2_Overlinking',pNotifyEmails := BIPV2_Build.mod_email.emailList
  ,pOutputFilename   := '~bipv2_build::' + pversion + '::workunit_history::Output_Overlinking_Samples'
  ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
  );
  
  return kickBuild;

endmacro;