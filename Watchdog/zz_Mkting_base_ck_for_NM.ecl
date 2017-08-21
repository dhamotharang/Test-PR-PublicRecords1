import watchdog,ut,header,VersionControl,_control,marketing_best; 


//check is not needed as marketing best adddress will change even record count are same b/c of utility

/*
send_email_norun := fileservices.SendEmail('akayttala@seisint.com,skasavajjala@seisint.com','No New files for New Movers','');
send_email_run := fileservices.SendEmail('akayttala@seisint.com,skasavajjala@seisint.com','Marketing base is built, New files available for New Movers build ','');

Marketing_base_change:= if(VersionControl.fAreRecordCountsEqual('~thor_data400::base::watchdog_best_marketing',
'~thor_data400::base::watchdog_best_marketing_father') = false , 'YES','NO'); 
*/
base_logical_name := '~'+FileServices.SuperFileContents('~thor_data400::base::watchdog_best_marketing')[1].name ;
father_logical_name := '~'+FileServices.SuperFileContents('~thor_data400::base::watchdog_best_marketing_father')[1].name ;

Watchdog.MAC_proc_build_despray_newmovers(ut.GetDate,result);

export Mkting_base_ck_for_NM := sequential(
 
FileServices.Copy(base_logical_name, 'thor400_84', base_logical_name+'.NM_in',,,,,true,,),
FileServices.ClearSuperFile( '~thor_data400::in::NewMOvers'),
fileservices.AddSuperFile('~thor_data400::in::NewMOvers',base_logical_name+'.NM_in'),

FileServices.Copy(father_logical_name, 'thor400_84', father_logical_name+'.NM_prev_in',,,,,true,,),
FileServices.ClearSuperFile('~thor_data400::in::NewMOvers_father'),
fileservices.AddSuperFile('~thor_data400::in::NewMOvers_father',father_logical_name+'.NM_prev_in'),
result); 