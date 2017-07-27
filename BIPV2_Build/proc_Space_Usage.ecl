import BIPV2;
import BIPV2_Testing,wk_ut,tools,_control,bipv2_build;

EXPORT proc_Space_Usage(
   pversion     = 'BIPV2.KeySuffix'
  ,pType        = '0'                 //1 = 'begin 2 = end 3 = postcleanup'
) := 
functionmacro

  ecl		  := '#workunit(\'name\',\'BIPV2_Build.Build_Space_Usage @version@\');\n' + 'BIPV2_Build.Build_Space_Usage(\'' + pversion + '\',pType := ' + (string)pType + ')';
  cluster := BIPV2_Build._Constants().Groupname;
  
  kickBuild := wk_ut.mac_ChainWuids(ecl,1,1,pversion,,cluster,pOutputEcl := false,pUniqueOutput := 'BIPV2_Build_Space_Usage' + (string)pType,pNotifyEmails := BIPV2_Build.mod_email.emailList
  ,pOutputFilename   := '~bipv2_build::' + pversion + '::workunit_history::proc_Space_Usage'
  ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
  );
  
  return kickBuild;

endmacro;