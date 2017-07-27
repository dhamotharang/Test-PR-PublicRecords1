import BIPV2_Testing,wk_ut,tools,bipv2_build;
EXPORT proc_segmentation(pversion = 'BIPV2.KeySuffix') := 
functionmacro
  eclsample		:= '#workunit(\'name\',\'BIPV2_PostProcess.proc_segmentation @version@\');\n#workunit(\'protect\' ,true);\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'priority\',\'high\');\n' 
               + 'BIPV2_PostProcess.proc_segmentation(\'@version@\',pPopulateStatus := false).run;';
  cluster     := BIPV2_Build._Constants().Groupname;
  
  kickXlinkSample	  := wk_ut.mac_ChainWuids(eclsample,1,1,pversion,,cluster,pOutputEcl := false,pUniqueOutput := 'SegmentationStats',pNotifyEmails := BIPV2_Build.mod_email.emailList + ',lucinda.sibille@lexisnexis.com'
  ,pOutputFilename   := '~bipv2_build::' + pversion + '::workunit_history::proc_segmentation'
  ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
  );
  
  return kickXlinkSample;
endmacro;
