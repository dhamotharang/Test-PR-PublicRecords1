import BIPV2;
import BIPV2_Testing,wk_ut,tools,_control,ut,bipv2_build;

EXPORT proc_DataCard(
    pversion  = 'BIPV2.KeySuffix'

) := 
functionmacro

  ecl		  := '#workunit(\'name\',\'BIPV2_PostProcess.Build_DataCard @version@\');\n#workunit(\'protect\' ,true);\n' + 'BIPV2_PostProcess.Build_DataCard(\'' + pversion + '\').run;\n';
  cluster := _Control.Config.LocalHthor;
  
  kickBuild := wk_ut.mac_ChainWuids(ecl,1,1,pversion,,cluster,pOutputEcl := false,pUniqueOutput := 'Build_Datacard',pNotifyEmails := BIPV2_Build.mod_email.emailList
  ,pOutputFilename   := '~bipv2_build::' + pversion + '::workunit_history::proc_DataCard'
  ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
);
  
  return kickBuild;

endmacro;