EXPORT proc_build_marketing :=  function

//#stored ('watchtype', 'marketing');
//changed from using #stored to just setting the variable.  Something has changed
//at the platform level so in a Sequential 2 variables called watchtype can't be 
//set at the same time.

watchtype := 'marketing';

import watchdog,ut,RoxieKeyBuild,Orbit3,Watchdog_V2,_control;

boolean isnewheader := Watchdog.proc_Validate_NewHdr.out;



fd := dataset('~thor_data400::in::watchdog_check',{string8 fdate},thor);
string8 filedate_wd := fd[1].fdate : stored('filedate_wd');

set_inputs := output('Setting input files...') : success(watchdog.Input_set);

string dops_pkg_wdog := 'WatchdogKeys';

string env_flag_nb  := 'N|B';

string email_notification := 'Sudhir.Kasavajjala@lexisnexisrisk.com';

send_bad_email := fileservices.SendEmail(email_notification,'Watchdog-marketing Build FAILED','');
send_email := fileservices.SendEmail(email_notification,'Watchdog-marketing Build FINISHED','');


update_wdog := RoxieKeyBuild.updateversion(dops_pkg_wdog,filedate_wd,email_notification,,env_flag_nb);
create_build_wdog := Orbit3.proc_Orbit3_CreateBuild('Watchdog Best',filedate_wd,env_flag_nb);

//keydiff
//DF-28374
/*
keydiff_nfcra := Watchdog.fGetIndexAttributes ( dops_pkg_wdog,'B',env_flag_n);

keydiff_marketing := Watchdog.fGetIndexAttributes (dops_pkg_mktg,'B',env_flag_n);*/


out_all := sequential(  
                        set_inputs,
                        watchdog.BWR_Best(isnewheader),
                        watchdog.BWR_BestMarketingEnhanced,
                        /*watchdog.BWR_Delta,*/
                        watchdog.input_clear,
                        watchdog.BWR_Watchdog_Roxie_Marketing(filedate_wd),
                        watchdog.BWR_Run_Watchdog_Marketing_stats,
                        Watchdog_V2.Proc_Build_Merged_Key(filedate_wd),
                        _control.fSubmitNewWorkunit('Header.Proc_Copy_To_Alpha().watchdog;','hthor_eclcc'),
                        send_email,
                        update_wdog,
                        create_build_wdog/*,
                        keydiff_nfcra,
                        keydiff_marketing*/
                        
                        ) : FAILURE(send_bad_email);

return out_all;
end;
