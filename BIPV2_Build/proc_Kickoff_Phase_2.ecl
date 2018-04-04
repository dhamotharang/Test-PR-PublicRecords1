import BizLinkFull;
import BIPV2_Testing,wk_ut,tools,_Control;

EXPORT proc_Kickoff_Phase_2(
   pversion               
  //booleans to control what runs in the build.  These allow for fine control over build without sandboxing.
  ,pSkipXlink             = 'false'
  ,pSkipCopyXlinkKeys     = 'false'
  ,pSkipXlinkValidation   = 'false'
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

  import _Control;
  ecl		  := '#workunit(\'name\',\'BIPV2_Build.proc_Build_Phase_2 @version@ ' + pUniqueOutput + '\');\n#workunit(\'priority\',\'high\');\n' 
  // + 'output(\'<a href="http://' + wk_ut._Constants.LocalEsp + ':8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + workunit + '#/stub/Summary">Parent Workunit</a>\' ,named(\'Parent_Wuid__html\'));\n'
  + 'BIPV2_Build.proc_Build_Phase_2('
  + '\'@version@\'\n'
  + ',@pSkipXlink@\n'         
  + ',@pSkipCopyXlinkKeys@\n' 
  + ',@pSkipXlinkValidation@\n'   
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
  
  cluster := _Control.Config.LocalHthor;//(tools._constants.IsDataland ,'infinband_hthor'  ,'hthor');// tools.fun_Groupname('20',false);
  
  fbool(boolean pinput) := if(pinput = true,'true','false');
  
  ecl1    := regexreplace('@version@'             ,ecl    ,pversion                    ,nocase);
  ecl2    := regexreplace('@pSkipXlink@'          ,ecl1   ,fbool(pSkipXlink           ),nocase);
  ecl3    := regexreplace('@pSkipCopyXlinkKeys@'  ,ecl2   ,fbool(pSkipCopyXlinkKeys   ),nocase);
  ecl4    := regexreplace('@pSkipXlinkValidation@',ecl3   ,fbool(pSkipXlinkValidation ),nocase);
  ecl5    := regexreplace('@pSkipXlinkSample@'    ,ecl4   ,fbool(pSkipXlinkSample     ),nocase);
  ecl6    := regexreplace('@pSkipIndustry@'       ,ecl5   ,fbool(pSkipIndustry        ),nocase);
  ecl7    := regexreplace('@pSkipMisckeys@'       ,ecl6   ,fbool(pSkipMisckeys        ),nocase);
  ecl8    := regexreplace('@pSkipWeeklyKeys@'     ,ecl7   ,fbool(pSkipWeeklyKeys      ),nocase);
  ecl9    := regexreplace('@pSkipBest@'           ,ecl8   ,fbool(pSkipBest            ),nocase);
  ecl10   := regexreplace('@pSkipSegStats@'       ,ecl9   ,fbool(pSkipSegStats        ),nocase);
  ecl11   := regexreplace('@pSkipStrata@'         ,ecl10  ,fbool(pSkipStrata          ),nocase);
  ecl12   := regexreplace('@pSkipOverlinking@'    ,ecl11  ,fbool(pSkipOverlinking     ),nocase);
  ecl13   := regexreplace('@pSkipSeleidRelative@' ,ecl12  ,fbool(pSkipSeleidRelative  ),nocase);
                                                            
  kickWuid	  := wk_ut.CreateWuid(ecl13,cluster);
//  kickXlink	  := wk_ut.CreateWuidNWait(ecl16,'1',pversion,cluster,,_control.MyInfo.EmailAddressNotify,,pUniqueOutput,pPollingFrequency,false);
  
  return if(pOutputEcl = false  ,kickWuid  ,ecl13);

endmacro;