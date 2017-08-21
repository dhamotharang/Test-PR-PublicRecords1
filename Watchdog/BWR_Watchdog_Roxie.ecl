import ut,lib_keylib,lib_fileservices,RoxieKeybuild,Suppress,_control,header;
#workunit('name','Watchdog Doxie key build');

leMailTarget := 'dataops@seisint.com';

// Get filedate from the watchdog check file

fd := dataset('~thor_data400::in::watchdog_check',{string8 fdate},thor);

string8 filedate := fd[1].fdate : stored('filedate');


fSendMail(string pSubject, string pBody)
 := fileservices.sendemail(leMailTarget,pSubject,pBody);

Roxiekeybuild.MAC_SK_BuildProcess_Local(watchdog.Key_Prep_Watchdog_GLB,'~thor_data400::key::watchdog::'+filedate+'::best.did','~thor_data400::key::watchdog_best.did',first_key,2);
RoxieKeybuild.MAC_SK_BuildProcess_Local(watchdog.Key_Prep_Watchdog_nonglb,'~thor_data400::key::watchdog::'+filedate+'::nonglb.did','~thor_data400::key::watchdog_nonglb.did',second_key,2);
Roxiekeybuild.MAC_SK_BuildProcess_Local(watchdog.Key_Prep_Best_SSN,'~thor_data400::key::watchdog::'+filedate+'::best.ssn','~thor_data400::key::watchdog_best.ssn',third_key,2);
Roxiekeybuild.MAC_SK_BuildProcess_v2_Local(Suppress.Key_SSN_Bad,'~thor_data400::key::ssn_bads','~thor_data400::key::watchdog::'+filedate+'::ssn_bads',ssn_bad_key,true);
Roxiekeybuild.MAC_SK_BuildProcess_Local(Watchdog.key_watchdog_glb_nonblank,'~thor_data400::key::watchdog::'+filedate+'::best.did_nonblank','~thor_data400::key::watchdog_best.did_nonblank',sixth_key,2);
Roxiekeybuild.MAC_SK_BuildProcess_Local(Watchdog.key_watchdog_nonglb_nonblank,'~thor_data400::key::watchdog::'+filedate+'::nonglb.did_nonblank','~thor_data400::key::watchdog_nonglb.did_nonblank',seventh_key,2);
Roxiekeybuild.MAC_SK_BuildProcess_Local(Watchdog.key_watchdog_teaser,'~thor_data400::key::watchdog::'+filedate+'::nonglb.teaser','~thor_data400::key::watchdog_nonglb.teaser',eighth_key,2);
Roxiekeybuild.MAC_SK_BuildProcess_Local(Header.Key_Teaser_search,'~thor_data400::key::watchdog::'+filedate+'::nonglb.teaser_search','~thor_data400::key::watchdog_nonglb.teaser_search',k9,2);
Roxiekeybuild.MAC_SK_BuildProcess_Local(Header.Key_Teaser_did,'~thor_data400::key::watchdog::'+filedate+'::nonglb.teaser_did','~thor_data400::key::watchdog_nonglb.teaser_did',k10,2);

build_keys := parallel(first_key,second_key,third_key,ssn_bad_key,sixth_key,seventh_key);

Roxiekeybuild.Mac_SK_Move_To_Built('~thor_data400::key::watchdog::'+filedate+'::best.did','~thor_data400::key::watchdog_best.did',mv1,2);
RoxieKeybuild.Mac_SK_Move_To_Built('~thor_data400::key::watchdog::'+filedate+'::nonglb.did','~thor_data400::key::watchdog_nonglb.did',mv2,2);
Roxiekeybuild.Mac_SK_Move_To_Built('~thor_data400::key::watchdog::'+filedate+'::best.ssn','~thor_data400::key::watchdog_best.ssn',mv3,2);
Roxiekeybuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::ssn_bads','~thor_data400::key::watchdog::'+filedate+'::ssn_bads',mv5);
Roxiekeybuild.Mac_SK_Move_To_Built('~thor_data400::key::watchdog::'+filedate+'::best.did_nonblank','~thor_data400::key::watchdog_best.did_nonblank',mv6,2);
Roxiekeybuild.Mac_SK_Move_To_Built('~thor_data400::key::watchdog::'+filedate+'::nonglb.did_nonblank','~thor_data400::key::watchdog_nonglb.did_nonblank',mv7,2);
Roxiekeybuild.Mac_SK_Move_To_Built('~thor_data400::key::watchdog::'+filedate+'::nonglb.teaser','~thor_data400::key::watchdog_nonglb.teaser',mv8,2);
Roxiekeybuild.Mac_SK_Move_To_Built('~thor_data400::key::watchdog::'+filedate+'::nonglb.teaser_search','~thor_data400::key::watchdog_nonglb.teaser_search',mv9,2);
Roxiekeybuild.Mac_SK_Move_To_Built('~thor_data400::key::watchdog::'+filedate+'::nonglb.teaser_did','~thor_data400::key::watchdog_nonglb.teaser_did',mv10,2);

move_to_built := parallel(mv1,mv2,mv3,mv5,mv6,mv7);


ut.MAC_SK_Move('~thor_data400::key::watchdog_best.did','Q',move1);
ut.mac_sk_move('~thor_data400::key::watchdog_nonglb.did','Q',move2);
ut.MAC_SK_Move('~thor_data400::key::watchdog_best.ssn','Q',move3);
ut.MAC_SK_Move_v2('~thor_data400::key::ssn_bads','Q',move5);
ut.MAC_SK_Move('~thor_data400::key::watchdog_best.did_nonblank','Q',move6);
ut.MAC_SK_Move('~thor_data400::key::watchdog_nonglb.did_nonblank','Q',move7);
ut.MAC_SK_Move('~thor_data400::key::watchdog_nonglb.teaser','Q',move8);
ut.MAC_SK_Move('~thor_data400::key::watchdog_nonglb.teaser_search','Q',move9);
ut.MAC_SK_Move('~thor_data400::key::watchdog_nonglb.teaser_did','Q',move10);

move_keys := parallel(move1,move2,move3,move5,move6,move7);

rec := record
 string8 watch;
end;

d := dataset([{'watchdog'}],rec);

temp_file := output(d,,'~thor_data400::temp::for_watchdog_dkc',overwrite);

file_despray := lib_fileservices.FileServices.Despray('~thor_data400::temp::for_watchdog_dkc',_Control.IPAddress.edata12,'/export/home/avenkata/watchdog/watchdog_flag',,,,TRUE);

file_remove := sequential(
				lib_fileservices.FileServices.DeleteLogicalFile('~thor_data400::temp::for_watchdog_dkc'),
				//lib_fileservices.FileServices.DeleteLogicalFile('~thor_data400::in::watchdog_check'),
				lib_fileservices.FileServices.DeleteLogicalFile('~thor400_84::out::watchdog_filtered_header'),
				lib_fileservices.FileServices.DeleteLogicalFile('~thor400_84::out::watchdog_filtered_header_nonglb')
				);


email_success := fileservices.sendemail(
										'roxiebuilds@seisint.com;sudhir.kasavajjala@lexisnexis.com',
										'Watchdog Weekly Build Succeeded - ' + filedate,
										'Keys: 1) thor_data400::key::watchdog_best.did_qa(thor_data400::key::watchdog::'+filedate+'::best.did)\n' + 
										'      2) thor_data400::key::watchdog_nonglb.did_qa(thor_data400::key::watchdog::'+filedate+'::nonglb.did)\n' +
										'      3) thor_data400::key::watchdog_best.ssn_qa(thor_data400::key::watchdog::'+filedate+'::best.ssn) \n' +
										'      4) thor_data400::key::ssn_bads_qa(thor_data400::key::watchdog::'+filedate+'::ssn_bads) \n' +
										'      5) thor_data400::key::watchdog_delta.did_qa(thor_data400::key::watchdog::'+filedate+'::delta.did) \n' +
										'      6) thor_data400::key::watchdog_best.did_nonblank_qa(thor_data400::key::watchdog::'+filedate+'::best.did_nonblank)\n' + 
										'      7) thor_data400::key::watchdog_nonglb.did_nonblank_qa(thor_data400::key::watchdog::'+filedate+'::nonglb.did_nonblank)\n' + 
										'      8) thor_data400::key::watchdog_nonglb.teaser_qa(thor_data400::key::watchdog::'+filedate+'::nonglb.teaser)\n' + 
										'	   have been built and deployed to QA.'
										);

email_failure := fileservices.sendemail(
										'roxiebuilds@seisint.com;;sudhir.kasavajjala@lexisnexis.com',
										'Watchdog Weekly Roxie Build Failed - ' + filedate,
										failmessage
										);
										
sequential(build_keys,move_to_built,move_keys
			,eighth_key,mv8,move8 // builds off seventh key and uses MOXIE out file that will be deleted
			,k9,k10,mv9,mv10,move9,move10
			,temp_file,/*fSendMail('WATCHDOG_KEYS_COMPLETE','Watchdog keys complete on prod400'),*/
			file_despray,file_remove) : 
			success(email_success),
			failure(email_failure);