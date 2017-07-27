import BIPV2_Testing,wk_ut,tools;

EXPORT proc_sele(pversion = 'BIPV2.KeySuffix') := 
functionmacro

  eclsample		:= '#workunit(\'name\',\'BIPV2_Build.build_sele @version@\');\\n#workunit(\'priority\',\'high\');\\n' + 'BIPV2_Build.build_sele().run;';
  cluster     := tools.fun_Groupname('20',false);
  
  kickBuild	  := wk_ut.mac_ChainWuids(eclsample,1,1,pversion,,cluster,pOutputEcl := false,pUniqueOutput := 'BuildSeleidBase',pNotifyEmails := _control.MyInfo.EmailAddressNotify + ';todd.leonard@lexisnexis.com');
  
  return kickBuild;

endmacro;