import ut,lib_keylib,lib_fileservices,RoxieKeybuild,Suppress,_control;
#workunit('name','Watchdog NON EN EQ key build');

leMailTarget := 'dataops@seisint.com';

// Get filedate from the watchdog check file

fd := dataset('~thor_data400::in::watchdog_check',{string8 fdate},thor);

string8 filedate := fd[1].fdate : stored('filedate');


fSendMail(string pSubject, string pBody)
 := fileservices.sendemail(leMailTarget,pSubject,pBody);
 
Roxiekeybuild.MAC_SK_BuildProcess_Local(Watchdog.Key_Watchdog_GLB_nonExperian_nonEquifax,'~thor_data400::key::watchdog::'+filedate+'::best_nonen_noneq.did','~thor_data400::key::watchdog_best_nonen_noneq.did',first_key,2);
Roxiekeybuild.MAC_SK_BuildProcess_Local(Watchdog.Key_Watchdog_GLB_nonExperian_nonEquifax_nonblank,'~thor_data400::key::watchdog::'+filedate+'::best_nonen_noneq.did_nonblank','~thor_data400::key::watchdog_best_nonen_noneq.did_nonblank',second_key,2);

Roxiekeybuild.Mac_SK_Move_To_Built('~thor_data400::key::watchdog::'+filedate+'::best_nonen_noneq.did','~thor_data400::key::watchdog_best_nonen_noneq.did',mv1,2);
Roxiekeybuild.Mac_SK_Move_To_Built('~thor_data400::key::watchdog::'+filedate+'::best_nonen_noneq.did_nonblank','~thor_data400::key::watchdog_best_nonen_noneq.did_nonblank',mv2,2);

ut.MAC_SK_Move('~thor_data400::key::watchdog_best_nonen_noneq.did','Q',move1);
ut.MAC_SK_Move('~thor_data400::key::watchdog_best_nonen_noneq.did_nonblank','Q',move2);


file_remove := sequential(lib_fileservices.FileServices.DeleteLogicalFile('~thor_data400::in::watchdog_check'),
			   lib_fileservices.FileServices.DeleteLogicalFile('~thor400_84::out::watchdog_filtered_header_nonen_noneq'));

email_success := fileservices.sendemail(
										'roxiebuilds@seisint.com;skasavajjala@seisint.com;akayttala@seisint.com',
										'Watchdog Weekly NON EN KeyBuild FINISHED - ' + filedate,
										'Key(s): 1)thor_data400::key::watchdog_nonen_noneq.did_qa(thor_data400::key::watchdog::'+filedate+'::best_nonen_noneq.did)\n' + 
										'        2) thor_data400::key::watchdog_best_nonen_noneq.did_nonblank_qa(thor_data400::key::watchdog::'+filedate+'::best_nonen_noneq.did_nonblank)\n' + 
										'	   has been built and deployed to QA.'
										);

email_failure := fileservices.sendemail(
										'skasavajjala@seisint.com;roxiebuilds@seisint.com;aherzberg@seisint.com',
										'Watchdog Weekly non en KeyBuild FAILED - ' + filedate,
										failmessage
										);

	
								
export BWR_Watchdog_Roxie_Non_EN_EQ := sequential(first_key,second_key,mv1,mv2,move1,move2,file_remove,email_success) :
			failure(email_failure);