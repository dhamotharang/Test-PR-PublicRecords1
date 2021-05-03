import BIPV2;
import BIPV2_Testing,wk_ut,tools,_control,ut,bipv2_build;

EXPORT proc_EntityReport(
    pversion  = 'BIPV2.KeySuffix'

) := 
functionmacro

  ecl		  :=    '#workunit(\'name\',\'BIPV2_PostProcess.Build_EntityReport @version@\');\n'
              + '#workunit(\'protect\' ,true);\n' 
              + 'BIPV2_PostProcess.Build_EntityReport(\'' + pversion + '\').run;\n';
              
  cluster := BIPV2_Build._Constants().Groupname;
  
  kickBuild := wk_ut.mac_ChainWuids(ecl,1,1,pversion,,cluster,pOutputEcl := false,pUniqueOutput := 'Build_EntityReport',pNotifyEmails := BIPV2_Build.mod_email.emailList
  ,pOutputFilename   := '~bipv2_build::' + pversion + '::workunit_history::proc_EntityReport'
  ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
);
  
  return kickBuild;

endmacro;