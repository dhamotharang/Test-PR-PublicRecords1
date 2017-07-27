import BIPV2;
import BIPV2_Testing,wk_ut,tools,_control,bipv2_build;

EXPORT proc_External_Append_Testing(
   pversion     = 'BIPV2.KeySuffix'
) := 
functionmacro

  ecl		  := '#workunit(\'name\',\'BIPV2_Build.External_Append_Testing @version@\');\n#workunit(\'protect\' ,true);\n' + 'BIPV2_Build.External_Append_Testing(\'' + pversion + '\');\n';
  cluster := BIPV2_Build._Constants().Groupname;
  
  kickBuild := wk_ut.mac_ChainWuids(ecl,1,1,pversion,,cluster,pOutputEcl := false,pUniqueOutput := 'External_Append_Testing',pNotifyEmails := BIPV2_Build.mod_email.emailList
      ,pOutputFilename   := '~bipv2_build::' + pversion + '::workunit_history::proc_External_Append_Testing'
      ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
  );
  
  return kickBuild;

endmacro;