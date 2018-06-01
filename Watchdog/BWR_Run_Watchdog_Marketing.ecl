/* delete thor_data400::in::watchdog_check2 before starting a new weekly run */

import watchdog,ut,RoxieKeyBuild;

#workunit('name','Yogurt:Watchdog-marketing');
#workunit('priority','hight');

#stored ('watchtype', 'marketing'); 
boolean isnewheader := false; // set this to true/false after running Watchdog.is_new_header

string_rec := record
  string8 fdate;
end;
d := dataset([{ut.GetDate}],string_rec);
//string8 filedt := d[1].fdate : stored('filedt');

wchk := if(fileservices.fileexists('~thor_data400::in::watchdog_check2'),
	output('Watchdog check file2 exists'),
	output(d,,'~thor_data400::in::watchdog_check2'));

fd := dataset('~thor_data400::in::watchdog_check2',{string8 fdate},thor);
string8 filedate := fd[1].fdate : stored('filedate');

set_inputs := output('Setting input files...') : success(watchdog.Input_set);

send_bad_email := fileservices.SendEmail('michael.gould@lexisnexisrisk.com,skasavajjala@seisint.com','Watchdog-marketing Build FAILED','');
send_email := fileservices.SendEmail('michael.gould@lexisnexisrisk.com,skasavajjala@seisint.com','Watchdog-marketing Build FINISHED','');
updatedops          := RoxieKeyBuild.updateversion('MarketingHeaderKeys',filedate,'michael.gould@lexisnexis.com,skasavajjala@seisint.com',,'N');


sequential(wchk,set_inputs,watchdog.BWR_Best(isnewheader),watchdog.BWR_BestMarketingEnhanced,watchdog.BWR_Delta,watchdog.input_clear,watchdog.BWR_Watchdog_Roxie_Marketing,watchdog.BWR_Run_Watchdog_Marketing_stats,send_email,updatedops) : FAILURE(send_bad_email);
