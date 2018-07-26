import BIPV2_Testing,wk_ut,tools;

EXPORT proc_Kickoff_All(
   pversion               
  //booleans to control what runs in the build.  These allow for fine control over build without sandboxing.
  ,pSkipXlink             = 'false'
  ,pSkipCopyXlinkKeys     = 'false'
  ,pSkipXlinkSample       = 'false'
  ,pSkipWeeklyKeys        = 'false'
  ,pSkipBest              = 'false'
  ,pSkipIndustry          = 'false'
  ,pSkipMisckeys          = 'false'
  ,pSkipSegStats          = 'false'
  ,pSkipStrata            = 'false'
  ,pSkipSeleidRelative    = 'false'
  ,pUniqueOutput          = '\'\''
  ,pOutputEcl             = 'false'
  // ,pPollingFrequency      = '\'5\''
) := 
functionmacro

  ecl		  := '#workunit(\'name\',\'BIPV2_Build.proc_Build_Phase_2 @version@ ' + pUniqueOutput + '\');\n#workunit(\'priority\',\'high\');\n' + 'BIPV2_Build.proc_Build_Phase_2(\'@version@\'\n'
  + ',@pSkipXlink@\n'         
  + ',@pSkipCopyXlinkKeys@\n' 
  + ',@pSkipXlinkSample@\n'   
  + ',@pSkipWeeklyKeys@\n'    
  + ',@pSkipBest@\n'          
  + ',@pSkipIndustry@\n'      
  + ',@pSkipMisckeys@\n'      
  + ',@pSkipSegStats@\n'      
  + ',@pSkipStrata@\n'        
  + ',@pSkipSeleidRelative@\n'
  + ');';
  import _control;
  cluster := _Control.Config.LocalHthor;// tools.fun_Groupname('20',false);
  
  fbool(boolean pinput) := if(pinput = true,'true','false');
  
  ecl1    := regexreplace('@version@'            ,ecl  ,pversion                  ,nocase);
  ecl2    := regexreplace('@pSkipXlink@'         ,ecl1 ,fbool(pSkipXlink         ),nocase);
  ecl3    := regexreplace('@pSkipCopyXlinkKeys@' ,ecl2 ,fbool(pSkipCopyXlinkKeys ),nocase);
  ecl4    := regexreplace('@pSkipXlinkSample@'   ,ecl3 ,fbool(pSkipXlinkSample   ),nocase);
  ecl5    := regexreplace('@pSkipIndustry@'      ,ecl4 ,fbool(pSkipIndustry      ),nocase);
  ecl6    := regexreplace('@pSkipMisckeys@'      ,ecl5 ,fbool(pSkipMisckeys      ),nocase);
  ecl7    := regexreplace('@pSkipWeeklyKeys@'    ,ecl6 ,fbool(pSkipWeeklyKeys    ),nocase);
  ecl8    := regexreplace('@pSkipBest@'          ,ecl7 ,fbool(pSkipBest          ),nocase);
  ecl9    := regexreplace('@pSkipSegStats@'      ,ecl8 ,fbool(pSkipSegStats      ),nocase);
  ecl10   := regexreplace('@pSkipStrata@'        ,ecl9 ,fbool(pSkipStrata        ),nocase);
  ecl11   := regexreplace('@pSkipSeleidRelative@',ecl10,fbool(pSkipSeleidRelative),nocase);
                                                            
  kickWuid	  := wk_ut.CreateWuid(ecl11,cluster);
//  kickXlink	  := wk_ut.CreateWuidNWait(ecl16,'1',pversion,cluster,,_control.MyInfo.EmailAddressNotify,,pUniqueOutput,pPollingFrequency,false);
  
  return if(pOutputEcl = false  ,kickWuid  ,ecl11);

endmacro;