export BWR_Watchdog_Roxie_Marketing ( string filedate)  := function
import watchdog, ut,lib_keylib,lib_fileservices,RoxieKeybuild,Suppress;

//fileservices.createsuperfile('~thor_data400::key::watchdog_marketing.did_built');
//fileservices.createsuperfile('~thor_data400::key::watchdog_marketing.did_delete');
//fileservices.createsuperfile('~thor_data400::key::watchdog_marketing.did_father');
//fileservices.createsuperfile('~thor_data400::key::watchdog_marketing.did_prod');
//fileservices.createsuperfile('~thor_data400::key::watchdog_marketing.did_qa');

#workunit('name','Watchdog-marketing key build');

#stored ('watchtype', 'marketing'); 

leMailTarget := 'rvanheusen@seisint.com';





fSendMail(string pSubject, string pBody)
 := fileservices.sendemail(leMailTarget,pSubject,pBody);

Roxiekeybuild.MAC_SK_BuildProcess_Local(watchdog.Key_Prep_Watchdog_marketing(false),'~thor_data400::key::watchdog::'+filedate+'::marketing.did','~thor_data400::key::watchdog_marketing.did',first_key,2);
Roxiekeybuild.MAC_SK_BuildProcess_Local(watchdog.Key_Prep_Watchdog_marketing(true),'~thor_data400::key::watchdog::'+filedate+'::marketing_noneq.did','~thor_data400::key::watchdog_marketing_noneq.did',second_key,2);
build_keys := parallel(first_key,second_key);

Roxiekeybuild.Mac_SK_Move_To_Built('~thor_data400::key::watchdog::'+filedate+'::marketing.did','~thor_data400::key::watchdog_marketing.did',mv1,2);
Roxiekeybuild.Mac_SK_Move_To_Built('~thor_data400::key::watchdog::'+filedate+'::marketing_noneq.did','~thor_data400::key::watchdog_marketing_noneq.did',mv2,2);
move_to_built := parallel(mv1,mv2);

ut.MAC_SK_Move('~thor_data400::key::watchdog_marketing.did','Q',move1);
ut.MAC_SK_Move('~thor_data400::key::watchdog_marketing_noneq.did','Q',move2);
move_keys := parallel(move1,move2);
/*
rec := record
 string8 watch;
end;

d := dataset([{'watchdog'}],rec);

temp_file := output(d,,'~thor_data400::temp::for_watchdog_dkc',overwrite);

file_despray := lib_fileservices.FileServices.Despray('~thor_data400::temp::for_watchdog_dkc','192.168.0.39','/export/home/avenkata/watchdog/watchdog_flag',,,,TRUE);
*/
file_remove := sequential(
				lib_fileservices.FileServices.DeleteLogicalFile('~thor_data400::in::watchdog_check2'));
	

email_success := fileservices.sendemail(
										'roxiebuilds@seisint.com;skasavajjala@seisint.com;',
										'Watchdog Marketing Weekly KeyBuild FINISHED - ' + filedate,
										'Key(s): thor_data400::key::watchdog_marketing.did_qa(thor_data400::key::watchdog::'+filedate+'::marketing.did)\n' + 
										'Key(s): thor_data400::key::watchdog_marketing_noneq.did_qa(thor_data400::key::watchdog::'+filedate+'::marketing_noneq.did)\n' + 
										'	   has been built and deployed to QA.'
										);

email_failure := fileservices.sendemail(
										'skasavajjala@seisint.com;roxiebuilds@seisint.com',
										'Watchdog Weekly Marketing KeyBuild FAILED - ' + filedate,
										failmessage
										);

	
								
return sequential(build_keys,move_to_built,move_keys,email_success);
end;
