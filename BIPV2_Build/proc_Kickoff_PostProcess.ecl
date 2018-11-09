import BIPV2_Testing,wk_ut,tools;

EXPORT proc_Kickoff_PostProcess(
   pversion               
  //booleans to control what runs in the build.  These allow for fine control over build without sandboxing.
  ,pSkipDOTSpecsPost      = 'false'
  ,pSkipSeleRelSpecsPost  = 'false'
  ,pUniqueOutput          = '\'\''
  ,pOutputEcl             = 'false'
) := 
functionmacro

  ecl		  := '#workunit(\'name\',\'BIPV2_Build.proc_Build_PostProcess @version@ ' + pUniqueOutput + '\');\n#workunit(\'priority\',\'high\');\n' 
  // + 'output(\'<a href="http://' + wk_ut._Constants.LocalEsp + ':8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + workunit + '#/stub/Summary">Parent Workunit</a>\' ,named(\'Parent_Wuid__html\'));\n'
  + 'BIPV2_Build.proc_Build_PostProcess(\'@version@\'\n'
  + ',@pSkipDOTSpecsPost@\n'         
  + ',@pSkipSeleRelSpecsPost@\n' 
  + ');';
  import _control;
  cluster := _Control.Config.LocalHthor;// tools.fun_Groupname('20',false);
  
  fbool(boolean pinput) := if(pinput = true,'true','false');
  
  ecl1    := regexreplace('@version@'               ,ecl  ,pversion                     ,nocase);
  ecl2    := regexreplace('@pSkipDOTSpecsPost@'     ,ecl1 ,fbool(pSkipDOTSpecsPost     ),nocase);
  ecl3    := regexreplace('@pSkipSeleRelSpecsPost@' ,ecl2 ,fbool(pSkipSeleRelSpecsPost ),nocase);
                                                            
  kickWuid	  := wk_ut.CreateWuid(ecl3,cluster);
  
  return if(pOutputEcl = false  ,kickWuid  ,ecl3);

endmacro;
