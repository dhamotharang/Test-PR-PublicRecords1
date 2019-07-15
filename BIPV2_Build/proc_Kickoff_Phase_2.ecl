import BizLinkFull;
import BIPV2_Testing,wk_ut,tools,_Control,BIPV2;

EXPORT proc_Kickoff_Phase_2(
   pversion               = 'BIPV2.KeySuffix'       
  //booleans to control what runs in the build.  These allow for fine control over build without sandboxing.
  ,pSkipXlink             = 'false'
  ,pSkipCopyXlinkKeys     = 'false'
  ,pSkipXlinkValidation   = 'false'
  ,pSkipXlinkSample       = 'false'
  ,pSkipWeeklyKeys        = 'false'
  ,pSkipBest              = 'false'
  ,pSkipIndustry          = 'false'
  ,pSkipMisckeys          = 'false'
  ,pSkipQASamples         = 'false'
  ,pSkipSegStats          = 'false'
  ,pSkipStrata            = 'false'
  ,pSkipOverlinking       = 'false'
  ,pSkipSeleidRelative    = 'false'
  ,pUniqueOutput          = '\'\''
  ,pOutputEcl             = 'false'
  ,pCompileTest           = 'false'
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
  + ',@pSkipQASamples@\n'      
  + ',@pSkipSegStats@\n'      
  + ',@pSkipStrata@\n'        
  + ',@pSkipOverlinking@\n'        
  + ',@pSkipSeleidRelative@\n'
  + ',@pCompileTest@\n'
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
  ecl8    := regexreplace('@pSkipQASamples@'      ,ecl7   ,fbool(pSkipQASamples       ),nocase);
  ecl9    := regexreplace('@pSkipWeeklyKeys@'     ,ecl8   ,fbool(pSkipWeeklyKeys      ),nocase);
  ecl10   := regexreplace('@pSkipBest@'           ,ecl9   ,fbool(pSkipBest            ),nocase);
  ecl11   := regexreplace('@pSkipSegStats@'       ,ecl10  ,fbool(pSkipSegStats        ),nocase);
  ecl12   := regexreplace('@pSkipStrata@'         ,ecl11  ,fbool(pSkipStrata          ),nocase);
  ecl13   := regexreplace('@pSkipOverlinking@'    ,ecl12  ,fbool(pSkipOverlinking     ),nocase);
  ecl14   := regexreplace('@pSkipSeleidRelative@' ,ecl13  ,fbool(pSkipSeleidRelative  ),nocase);
  ecl15   := regexreplace('@pCompileTest@'        ,ecl14  ,fbool(pCompileTest         ),nocase);
                                                            
  kickWuid	  := wk_ut.CreateWuid(ecl15,cluster);
//  kickXlink	  := wk_ut.CreateWuidNWait(ecl16,'1',pversion,cluster,,_control.MyInfo.EmailAddressNotify,,pUniqueOutput,pPollingFrequency,false);
  
  return if(pOutputEcl = false  ,kickWuid  ,ecl13);

endmacro;