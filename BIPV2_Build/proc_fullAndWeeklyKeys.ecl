//remember to add ",BIPV2_Build.proc_fullAndWeeklyKeys(pversion,false,false)" to the bottom of proc_build_all
import BIPV2;
import BIPV2_Testing,wk_ut,tools,_control,ut,bipv2_build;

EXPORT proc_fullAndWeeklyKeys(
    pversion  = 'BIPV2.KeySuffix'
	,pIsTesting      = 'false'
  ,pOverwrite      = 'false'
) := 
functionmacro

  ecl		  := '#workunit(\'name\',\'BIPV2_PostProcess.CreatestrataForAllKeys @version@\');\n#workunit(\'protect\' ,true);\n' + 'BIPV2_PostProcess.CreatestrataForAllKeys(\'' + pversion + '\',' + pIsTesting + ',' + pOverwrite + ');\n';
  cluster := _Control.Config.LocalHthor;
  
  kickBuild := wk_ut.mac_ChainWuids(ecl,1,1,pversion,,cluster,pOutputEcl := false,pUniqueOutput := 'CreatestrataForAllKeys',pNotifyEmails := BIPV2_Build.mod_email.emailList
  ,pOutputFilename   := '~bipv2_build::' + pversion + '::workunit_history::proc_fullAndWeeklyKeys'
  ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
);
  
  return kickBuild;

endmacro;