import BizLinkFull;
import BIPV2_Testing,wk_ut,tools;

EXPORT proc_Kickoff_Phase_2(
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
  ,pSkipOverlinking       = 'false'
  ,pSkipSeleidRelative    = 'false'
  ,pUniqueOutput          = '\'\''
  ,pOutputEcl             = 'false'
  // ,pPollingFrequency      = '\'5\''
) := 
functionmacro

  ecl		  := '#workunit(\'name\',\'BIPV2_Build.proc_Build_Phase_2 @version@ ' + pUniqueOutput + '\');\n#workunit(\'priority\',\'high\');\n' 
  // + 'output(\'<a href="http://' + wk_ut._Constants.LocalEsp + ':8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + workunit + '#/stub/Summary">Parent Workunit</a>\' ,named(\'Parent_Wuid__html\'));\n'
  + 'BIPV2_Build.proc_Build_Phase_2(\'@version@\'\n'
  + ',@pSkipXlink@\n'         
  + ',@pSkipCopyXlinkKeys@\n' 
  + ',@pSkipXlinkSample@\n'   
  + ',@pSkipWeeklyKeys@\n'    
  + ',@pSkipBest@\n'          
  + ',@pSkipIndustry@\n'      
  + ',@pSkipMisckeys@\n'      
  + ',@pSkipSegStats@\n'      
  + ',@pSkipStrata@\n'        
  + ',@pSkipOverlinking@\n'        
  + ',@pSkipSeleidRelative@\n'
  + ');';
  
  cluster := if(tools._constants.IsDataland ,'infinband_hthor'  ,'hthor');// tools.fun_Groupname('20',false);
  
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
  ecl11   := regexreplace('@pSkipOverlinking@'   ,ecl10,fbool(pSkipOverlinking   ),nocase);
  ecl12   := regexreplace('@pSkipSeleidRelative@',ecl11,fbool(pSkipSeleidRelative),nocase);
                                                            
  kickWuid	  := wk_ut.CreateWuid(ecl12,cluster);
//  kickXlink	  := wk_ut.CreateWuidNWait(ecl16,'1',pversion,cluster,,_control.MyInfo.EmailAddressNotify,,pUniqueOutput,pPollingFrequency,false);
  
  return if(pOutputEcl = false  ,kickWuid  ,ecl12);

endmacro;