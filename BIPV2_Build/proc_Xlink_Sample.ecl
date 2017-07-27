import BIPV2_Testing,wk_ut,tools,bipv2_build;

EXPORT proc_Xlink_Sample(pversion = 'BIPV2.KeySuffix') := 
functionmacro

  eclsample		:= '#workunit(\'name\',\'BIPV2 Xlink Sample @version@\');\n#workunit(\'protect\' ,true);\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'priority\',\'high\');\n' + 'BIPV2_Testing.proc_Xlink_Sample(\'@version@\');';
  cluster     := BIPV2_Build._Constants().Groupname;
  
  kickXlinkSample	  := wk_ut.mac_ChainWuids(eclsample,1,1,pversion,,cluster,pOutputEcl := false,pUniqueOutput := 'XlinkSample',pNotifyEmails := BIPV2_Build.mod_email.emailList
  ,pOutputFilename   := '~bipv2_build::' + pversion + '::workunit_history::proc_Xlink_Sample'
  ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
  );
  
  return kickXlinkSample;

endmacro;