import BIPV2;
import BIPV2_Testing,wk_ut,tools,_control,bipv2_build;

EXPORT proc_cleanup(

   pversion         = 'BIPV2.KeySuffix'
//  ,pIncBuiltDelete  = 'true'   
//  ,pDeleteThem      = 'true'   
   
) := 
functionmacro

  ecl		  := '#workunit(\'name\',\'BIPV2_Build.cleanup @version@\');\n#workunit(\'protect\' ,true);\n' + 'BIPV2_Build.cleanup(\'' + pversion + '\');\n';
  cluster := _Control.Config.LocalHthor;
  
  kickBuild := wk_ut.mac_ChainWuids(ecl,1,1,pversion,,cluster,pOutputEcl := false,pUniqueOutput := 'Proc_Cleanup',pNotifyEmails := BIPV2_Build.mod_email.emailList
  ,pOutputFilename   := '~bipv2_build::' + pversion + '::workunit_history::proc_cleanup'
  ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
);
  
  return kickBuild;

endmacro;