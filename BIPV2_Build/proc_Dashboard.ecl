import BIPV2;
import BIPV2_Testing,wk_ut,tools,_control,bipv2_build;

EXPORT proc_Dashboard(
   pversion     = 'BIPV2.KeySuffix'
) := 
functionmacro

  ecl		  := '#workunit(\'name\',\'BIPV2_Build.Build_Dashboard @version@\');\n#workunit(\'protect\' ,true);\n' + 'BIPV2_Build.Build_Dashboard(\'' + pversion + '\');\n';
  cluster := wk_ut._constants.LocalHthor;
  
  kickBuild := wk_ut.mac_ChainWuids(ecl,1,1,pversion,,cluster,pOutputEcl := false,pUniqueOutput := 'Build_Dashboard',pNotifyEmails := BIPV2_Build.mod_email.emailList
  ,pOutputFilename   := '~bipv2_build::' + pversion + '::workunit_history::proc_Dashboard'
  ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
);
  
  return kickBuild;

endmacro;