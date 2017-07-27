import BIPV2,bipv2_build;

EXPORT proc_Promote2QA(

   pversion           = 'BIPV2.KeySuffix'
  ,pShouldUpdateDOPS  = 'true'
//  ,pIncBuiltDelete  = 'true'   
//  ,pDeleteThem      = 'true'   
   
) := 
functionmacro

  import wk_ut,tools,_control;

  ecl		  := '#workunit(\'name\',\'BIPV2_Build.Promote2QA @version@\');\n#workunit(\'protect\' ,true);\n#workunit(\'priority\',\'high\');\n' + 'BIPV2_Build.Promote2QA(\'' + pversion + '\',' + if(pShouldUpdateDOPS = true, 'true','false') + ');\n';
  cluster := BIPV2_Build._Constants().Groupname;
  
  kickBuild := wk_ut.mac_ChainWuids(ecl,1,1,pversion,,wk_ut._Constants.LocalHthor,pOutputEcl := false,pUniqueOutput := 'proc_Promote2QA',pNotifyEmails := BIPV2_Build.mod_email.emailList
  ,pOutputFilename   := '~bipv2_build::' + pversion + '::workunit_history::proc_Promote2QA'
  ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
);
  
  return kickBuild;

endmacro;