//make sure code for bwr_build_all is up-to-date, then run this.

import bipv2,wk_ut,_control,bipv2_build;

pversion    := BIPV2.KeySuffix                                      ;
eclcodepre  := wk_ut.get_Attribute_Text('BIPV2_Build.BWR_Build_All');
cluster     := wk_ut._Constants.localhthor                          ;
OutputEcl   := false                                                ;
emails      := BIPV2_Build.mod_email.emailList                      ;

fbool(boolean pinput) := if(pinput = true,'true','false');
// -- add parent wuid link
eclcode     := eclcodepre
              ;

kickeclcode := 'kickBuild := wk_ut.mac_ChainWuids(' + eclcode + ',1,1,\'' + pversion + '\',,\'' + cluster + '\',pOutputEcl := ' + fbool(OutputEcl) + ',pUniqueOutput := \'BIPV2_FULL_BUILD\',pNotifyEmails := \'' + emails + '\'\n'
+ '    ,pOutputFilename   := \'~bipv2_build::@version@::workunit_history::proc_build_all\'\n'
+ '    ,pOutputSuperfile  := \'~bipv2_build::qa::workunit_history\'\n' 
+ '    ,pSummaryFilename  := \'~bipv2_build::@version@::summary_report::proc_build_all\'\n'
+ '    ,pSummarySuperfile := \'~bipv2_build::qa::summary_report::proc_build_all\'\n'                                                 
+ ');\n'
+ 'kickBuild;'
;

kick_Wuid	  := wk_ut.CreateWuid(kickeclcode,cluster);
wuid_link   := '<a href="http://' + wk_ut._Constants.LocalEsp + ':8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + kick_Wuid + '#/stub/Summary">Child Workunit</a>';

output(kick_Wuid  ,named('Child_Wuid'       ));
output(wuid_link  ,named('Child_Wuid__html' ));
