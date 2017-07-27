import ut,lib_keylib,lib_fileservices;
#workunit('name','Watchdog Doxie key build');

leMailTarget := 'dataops@seisint.com';

fSendMail(string pSubject, string pBody)
 := fileservices.sendemail(leMailTarget,pSubject,pBody);

ut.MAC_SK_BuildProcess(watchdog.Key_Prep_Watchdog_GLB,'~thor_data400::key::watchdog_best.did','~thor_data400::key::watchdog_best.did',first_key,2);
ut.MAC_SK_BuildProcess(watchdog.Key_Prep_Watchdog_nonglb,'~thor_data400::key::watchdog_nonglb.did','~thor_data400::key::watchdog_nonglb.did',second_key,2);
ut.MAC_SK_BuildProcess(watchdog.Key_Prep_Best_SSN,'~thor_data400::key::watchdog_best.ssn','~thor_data400::key::watchdog_best.ssn',third_key,2);
ut.MAC_SK_BuildProcess(watchdog.Key_Watchdog_Delta,'~thor_data400::key::watchdog_delta.did','~thor_data400::key::watchdog_delta.did',fourth_key,2);

build_keys := parallel(first_key,second_key,third_key,fourth_key);

ut.MAC_SK_Move('~thor_data400::key::watchdog_best.did','Q',move1);
ut.mac_sk_move('~thor_data400::key::watchdog_nonglb.did','Q',move2);
ut.MAC_SK_Move('~thor_data400::key::watchdog_best.ssn','Q',move3);
ut.MAC_SK_Move('~thor_data400::key::watchdog_delta.did','Q',move4);

move_keys := parallel(move1,move2,move3,move4);

rec := record
 string8 watch;
end;

d := dataset([{'watchdog'}],rec);

temp_file := output(d,,'~thor_data400::temp::for_watchdog_dkc',overwrite);

file_despray := lib_fileservices.FileServices.Despray('~thor_data400::temp::for_watchdog_dkc','192.168.0.39','/export/home/avenkata/watchdog/watchdog_flag',,,,TRUE);

file_remove := lib_fileservices.FileServices.DeleteLogicalFile('~thor_data400::temp::for_watchdog_dkc');


sequential(build_keys,move_keys,temp_file,fSendMail('WATCHDOG_KEYS_COMPLETE','Watchdog keys complete on prod400'),file_despray,file_remove);