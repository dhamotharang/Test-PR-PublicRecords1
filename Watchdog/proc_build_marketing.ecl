EXPORT proc_build_marketing :=  function

//#stored ('watchtype', 'marketing');
//changed from using #stored to just setting the variable.  Something has changed
//at the platform level so in a Sequential 2 variables called watchtype can't be 
//set at the same time.

watchtype := 'marketing';

import watchdog,ut,RoxieKeyBuild,Orbit3,Watchdog_V2;

boolean isnewheader := Watchdog.proc_Validate_NewHdr.out;


string_rec := record
  string8 fdate;
end;
d := dataset([{ut.GetDate}],string_rec);
//string8 filedt := d[1].fdate : stored('filedt');

wchk := output(d,,'~thor_data400::in::watchdog_check2',overwrite);

fdmk := dataset('~thor_data400::in::watchdog_check2',{string8 fdate},thor);
string8 filedate := fdmk[1].fdate : stored('filedate');



fd := dataset('~thor_data400::in::watchdog_check',{string8 fdate},thor);
string8 filedate_wd := fd[1].fdate : stored('filedate_wd');

set_inputs := output('Setting input files...') : success(watchdog.Input_set);

send_bad_email := fileservices.SendEmail('michael.gould@lexisnexis.com,skasavajjala@seisint.com','Watchdog-marketing Build FAILED','');
send_email := fileservices.SendEmail('michael.gould@lexisnexis.com,skasavajjala@seisint.com','Watchdog-marketing Build FINISHED','');
updatedops          := RoxieKeyBuild.updateversion('MarketingHeaderKeys',filedate,'skasavajjala@seisint.com',,'N');
create_build := Orbit3.proc_Orbit3_CreateBuild('Watchdog Marketing Best',filedate);

update_wdog := RoxieKeyBuild.updateversion('WatchdogKeys',filedate_wd,'skasavajjala@seisint.com',,'N|B');
create_build_wdog := Orbit3.proc_Orbit3_CreateBuild('Watchdog Best',filedate_wd,'N|B');


out_all := sequential(wchk,set_inputs,watchdog.BWR_Best(isnewheader),watchdog.BWR_BestMarketingEnhanced,/*watchdog.BWR_Delta,*/watchdog.input_clear,watchdog.BWR_Watchdog_Roxie_Marketing,watchdog.BWR_Run_Watchdog_Marketing_stats,Watchdog_V2.Proc_Build_Merged_Key(filedate),send_email,updatedops,update_wdog,create_build,create_build_wdog) : FAILURE(send_bad_email);

return out_all;
end;
