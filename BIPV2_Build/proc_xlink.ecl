import BizLinkFull;
import BIPV2_Testing,wk_ut,tools,bipv2_build;

EXPORT proc_xlink(
   pversion     = 'BIPV2.KeySuffix'
  ,pPromote2QA  = 'true'
) := 
functionmacro

  ecl		  := '#workunit(\'name\',\'BIPV2_Xlink @version@\');\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'priority\',\'high\');\n' + 'BizLinkFull.Proc_Build_All(\'@version@\',@pPromote2QA@);';
  cluster := BIPV2_Build._Constants().Groupname;
  ecl2    := regexreplace('@pPromote2QA@',ecl,#TEXT(pPromote2QA),nocase);
  
  kickXlink	  := wk_ut.mac_ChainWuids(ecl2,1,1,pversion,,cluster,pOutputEcl := false,pUniqueOutput := 'Xlink',pNotifyEmails := BIPV2_Build.mod_email.emailList
  ,pOutputFilename   := '~bipv2_build::' + pversion + '::workunit_history::proc_xlink'
  ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
  );
  
  return kickXlink;

endmacro;