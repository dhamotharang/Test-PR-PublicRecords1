import ut,lib_keylib,lib_fileservices,RoxieKeybuild,Orbit3,Suppress,_control,header,Watchdog_V2;

leMailTarget := 'dataops@seisint.com;michael.gould@lexisnexisrisk.com';

// Get filedate from the watchdog check file

fd := dataset('~thor_data400::in::watchdog_check',{string8 fdate},thor);


string_rec := record
  string8 fdate;
end;

d1 := dataset([{ut.GetDate}],string_rec);

wchk := map(fileservices.fileexists('~thor_data400::in::watchdog_check') and FileServices.VerifyFile( '~thor_data400::in::watchdog_check',true) = 'OK' => 
	                                                                                                                   Sequential(FileServices.DeleteLogicalFile('~thor_data400::in::watchdog_check'),
	                                                                                                                      output(d1,,'~thor_data400::in::watchdog_check')),
					
										 
							                                                                         output(d1,,'~thor_data400::in::watchdog_check',overwrite)
							);
							

string8 filedate := fd[1].fdate : stored('filedate');
fSendMail(string pSubject, string pBody)
 := fileservices.sendemail(leMailTarget,pSubject,pBody);

Roxiekeybuild.MAC_SK_BuildProcess_Local(watchdog.Key_Prep_Watchdog_GLB(),'~thor_data400::key::watchdog::'+filedate+'::best.did','~thor_data400::key::watchdog_best.did',first_key,2);
Roxiekeybuild.MAC_SK_BuildProcess_Local(watchdog.Key_Prep_Watchdog_GLB(true),'~thor_data400::key::watchdog::'+filedate+'::best_nonutil.did','~thor_data400::key::watchdog_best_nonutil.did',firstDotOne_key,2);
RoxieKeybuild.MAC_SK_BuildProcess_Local(watchdog.Key_Prep_Watchdog_nonglb(false),'~thor_data400::key::watchdog::'+filedate+'::nonglb.did','~thor_data400::key::watchdog_nonglb.did',second_key,2);
RoxieKeybuild.MAC_SK_BuildProcess_Local(watchdog.Key_Prep_Watchdog_nonglb(true),'~thor_data400::key::watchdog::'+filedate+'::nonglb_noneq.did','~thor_data400::key::watchdog_nonglb_noneq.did',secondDotOne_key,2);
Roxiekeybuild.MAC_SK_BuildProcess_Local(watchdog.Key_Prep_Best_SSN,'~thor_data400::key::watchdog::'+filedate+'::best.ssn','~thor_data400::key::watchdog_best.ssn',third_key,2);
Roxiekeybuild.MAC_SK_BuildProcess_v2_Local(Suppress.Key_SSN_Bad,'~thor_data400::key::ssn_bads','~thor_data400::key::watchdog::'+filedate+'::ssn_bads',ssn_bad_key,true);
Roxiekeybuild.MAC_SK_BuildProcess_Local(Watchdog.key_watchdog_glb_nonblank,'~thor_data400::key::watchdog::'+filedate+'::best.did_nonblank','~thor_data400::key::watchdog_best.did_nonblank',sixth_key,2);
Roxiekeybuild.MAC_SK_BuildProcess_Local(Watchdog.key_Prep_Watchdog_glb_nonutil_nonblank(true),'~thor_data400::key::watchdog::'+filedate+'::best_nonutil.did_nonblank','~thor_data400::key::watchdog_best_nonutil.did_nonblank',sixthDotOne_key,2);
Roxiekeybuild.MAC_SK_BuildProcess_Local(Watchdog.key_Prep_Watchdog_nonglb_nonblank(false),'~thor_data400::key::watchdog::'+filedate+'::nonglb.did_nonblank','~thor_data400::key::watchdog_nonglb.did_nonblank',seventh_key,2);
Roxiekeybuild.MAC_SK_BuildProcess_Local(Watchdog.key_Prep_Watchdog_nonglb_nonblank(true),'~thor_data400::key::watchdog::'+filedate+'::nonglb_noneq.did_nonblank','~thor_data400::key::watchdog_nonglb_noneq.did_nonblank',seventhDotOne_key,2);
Roxiekeybuild.MAC_SK_BuildProcess_Local(Watchdog.Key_Prep_Watchdog_teaser(false),'~thor_data400::key::watchdog::'+filedate+'::nonglb.teaser','~thor_data400::key::watchdog_nonglb.teaser',eighth_key,2);
Roxiekeybuild.MAC_SK_BuildProcess_Local(Watchdog.Key_Prep_Watchdog_teaser(true),'~thor_data400::key::watchdog::'+filedate+'::nonglb_noneq.teaser','~thor_data400::key::watchdog_nonglb_noneq.teaser',eighthDotOne_key,2);
//Roxiekeybuild.MAC_SK_BuildProcess_Local(Header.Key_Teaser_search,'~thor_data400::key::watchdog::'+filedate+'::nonglb.teaser_search','~thor_data400::key::watchdog_nonglb.teaser_search',k9,2);
//Roxiekeybuild.MAC_SK_BuildProcess_Local(Header.Key_Teaser_did,'~thor_data400::key::watchdog::'+filedate+'::nonglb.teaser_did','~thor_data400::key::watchdog_nonglb.teaser_did',k10,2);
Roxiekeybuild.MAC_SK_BuildProcess_Local(Watchdog.Key_Watchdog_GLB_nonExperian,'~thor_data400::key::watchdog::'+filedate+'::best_nonen.did','~thor_data400::key::watchdog_best_nonen.did',ninth_key,2);
Roxiekeybuild.MAC_SK_BuildProcess_Local(Watchdog.Key_Watchdog_GLB_nonExperian_nonblank,'~thor_data400::key::watchdog::'+filedate+'::best_nonen.did_nonblank','~thor_data400::key::watchdog_best_nonen.did_nonblank',tenth_key,2);
Roxiekeybuild.MAC_SK_BuildProcess_Local(Watchdog.Key_Watchdog_GLB_nonExperian_nonEquifax,'~thor_data400::key::watchdog::'+filedate+'::best_nonen_noneq.did','~thor_data400::key::watchdog_best_nonen_noneq.did',eleven_key,2);
Roxiekeybuild.MAC_SK_BuildProcess_Local(Watchdog.Key_Watchdog_GLB_nonExperian_nonEquifax_nonblank,'~thor_data400::key::watchdog::'+filedate+'::best_nonen_noneq.did_nonblank','~thor_data400::key::watchdog_best_nonen_noneq.did_nonblank',twleve_key,2);
Roxiekeybuild.MAC_SK_BuildProcess_Local(Watchdog.Key_Watchdog_GLB_nonEquifax,'~thor_data400::key::watchdog::'+filedate+'::best_noneq.did','~thor_data400::key::watchdog_best_noneq.did',thirteen_key,2);
Roxiekeybuild.MAC_SK_BuildProcess_Local(Watchdog.Key_Watchdog_GLB_nonEquifax_nonblank,'~thor_data400::key::watchdog::'+filedate+'::best_noneq.did_nonblank','~thor_data400::key::watchdog_best_noneq.did_nonblank',fouteen_key,2);
Roxiekeybuild.MAC_SK_BuildProcess_v2_Local(header.key_ADL_segmentation,'~thor_data400::key::adl_segmentation', '~thor_data400::key::header::' + filedate + '::adl_segmentation',fifteen_key);
Roxiekeybuild.MAC_SK_BuildProcess_v2_Local(Watchdog.Key_Best_Name_City_State,'~thor_data400::key::watchdog_best.name_city_st','~thor_data400::key::watchdog::'+filedate + '::best.name_city_st', sixteen_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Watchdog.Key_Supplemental,'~thor_data400::key::watchdog_best_supplemental::did','~thor_data400::key::watchdog::'+filedate+'::best_supplemental::did',seventeen_key);


build_keys := parallel(first_key,firstDotOne_key,second_key,third_key,ssn_bad_key,sixth_key,sixthDotOne_key,seventh_key,ninth_key,tenth_key,eleven_key,twleve_key,thirteen_key,fouteen_key,fifteen_key,sixteen_key,seventeen_key,secondDotOne_key,seventhDotOne_key);

Roxiekeybuild.Mac_SK_Move_To_Built('~thor_data400::key::watchdog::'+filedate+'::best.did','~thor_data400::key::watchdog_best.did',mv1,2);
Roxiekeybuild.Mac_SK_Move_To_Built('~thor_data400::key::watchdog::'+filedate+'::best_nonutil.did','~thor_data400::key::watchdog_best_nonutil.did',mv1_1,2);
RoxieKeybuild.Mac_SK_Move_To_Built('~thor_data400::key::watchdog::'+filedate+'::nonglb.did','~thor_data400::key::watchdog_nonglb.did',mv2,2);
RoxieKeybuild.Mac_SK_Move_To_Built('~thor_data400::key::watchdog::'+filedate+'::nonglb_noneq.did','~thor_data400::key::watchdog_nonglb_noneq.did',mv2_1,2);
Roxiekeybuild.Mac_SK_Move_To_Built('~thor_data400::key::watchdog::'+filedate+'::best.ssn','~thor_data400::key::watchdog_best.ssn',mv3,2);
Roxiekeybuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::ssn_bads','~thor_data400::key::watchdog::'+filedate+'::ssn_bads',mv5);
Roxiekeybuild.Mac_SK_Move_To_Built('~thor_data400::key::watchdog::'+filedate+'::best.did_nonblank','~thor_data400::key::watchdog_best.did_nonblank',mv6,2);
Roxiekeybuild.Mac_SK_Move_To_Built('~thor_data400::key::watchdog::'+filedate+'::best_nonutil.did_nonblank','~thor_data400::key::watchdog_best_nonutil.did_nonblank',mv6_1,2);
Roxiekeybuild.Mac_SK_Move_To_Built('~thor_data400::key::watchdog::'+filedate+'::nonglb.did_nonblank','~thor_data400::key::watchdog_nonglb.did_nonblank',mv7,2);
Roxiekeybuild.Mac_SK_Move_To_Built('~thor_data400::key::watchdog::'+filedate+'::nonglb_noneq.did_nonblank','~thor_data400::key::watchdog_nonglb_noneq.did_nonblank',mv7_1,2);
Roxiekeybuild.Mac_SK_Move_To_Built('~thor_data400::key::watchdog::'+filedate+'::nonglb.teaser','~thor_data400::key::watchdog_nonglb.teaser',mv8,2);
Roxiekeybuild.Mac_SK_Move_To_Built('~thor_data400::key::watchdog::'+filedate+'::nonglb_noneq.teaser','~thor_data400::key::watchdog_nonglb_noneq.teaser',mv8_1,2);
//Roxiekeybuild.Mac_SK_Move_To_Built('~thor_data400::key::watchdog::'+filedate+'::nonglb.teaser_search','~thor_data400::key::watchdog_nonglb.teaser_search',mv9,2);
//Roxiekeybuild.Mac_SK_Move_To_Built('~thor_data400::key::watchdog::'+filedate+'::nonglb.teaser_did','~thor_data400::key::watchdog_nonglb.teaser_did',mv10,2);
Roxiekeybuild.Mac_SK_Move_To_Built('~thor_data400::key::watchdog::'+filedate+'::best_nonen.did','~thor_data400::key::watchdog_best_nonen.did',mv11,2);
Roxiekeybuild.Mac_SK_Move_To_Built('~thor_data400::key::watchdog::'+filedate+'::best_nonen.did_nonblank','~thor_data400::key::watchdog_best_nonen.did_nonblank',mv12,2);
Roxiekeybuild.Mac_SK_Move_To_Built('~thor_data400::key::watchdog::'+filedate+'::best_nonen_noneq.did','~thor_data400::key::watchdog_best_nonen_noneq.did',mv13,2);
Roxiekeybuild.Mac_SK_Move_To_Built('~thor_data400::key::watchdog::'+filedate+'::best_nonen_noneq.did_nonblank','~thor_data400::key::watchdog_best_nonen_noneq.did_nonblank',mv14,2);
Roxiekeybuild.Mac_SK_Move_To_Built('~thor_data400::key::watchdog::'+filedate+'::best_noneq.did','~thor_data400::key::watchdog_best_noneq.did',mv15,2);
Roxiekeybuild.Mac_SK_Move_To_Built('~thor_data400::key::watchdog::'+filedate+'::best_noneq.did_nonblank','~thor_data400::key::watchdog_best_noneq.did_nonblank',mv16,2);
Roxiekeybuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::adl_segmentation','~thor_data400::key::header::' + filedate + '::adl_segmentation',mv17);
Roxiekeybuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::watchdog_best.name_city_st','~thor_data400::key::watchdog::'+filedate+'::best.name_city_st', mv18);
RoxieKeyBuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::watchdog_best_supplemental::did','~thor_data400::key::watchdog::'+filedate+'::best_supplemental::did',mv19);

move_to_built := parallel(mv1,mv1_1,mv2,mv2_1,mv3,mv5,mv6,mv6_1,mv7,mv11,mv12,mv13,mv14,mv15,mv16,mv17,mv18,mv19,mv7_1);


roxiekeybuild.Mac_SK_Move('~thor_data400::key::watchdog_best.did','Q',move1);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::watchdog_best_nonutil.did','Q',move1_1);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::watchdog_nonglb.did','Q',move2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::watchdog_nonglb_noneq.did','Q',move2_1);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::watchdog_best.ssn','Q',move3);
roxiekeybuild.Mac_SK_Move_v2('~thor_data400::key::ssn_bads','Q',move5);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::watchdog_best.did_nonblank','Q',move6);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::watchdog_best_nonutil.did_nonblank','Q',move6_1);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::watchdog_nonglb.did_nonblank','Q',move7);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::watchdog_nonglb_noneq.did_nonblank','Q',move7_1);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::watchdog_nonglb.teaser','Q',move8);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::watchdog_nonglb_noneq.teaser','Q',move8_1);
//roxiekeybuild.Mac_SK_Move('~thor_data400::key::watchdog_nonglb.teaser_search','Q',move9);
//roxiekeybuild.Mac_SK_Move('~thor_data400::key::watchdog_nonglb.teaser_did','Q',move10);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::watchdog_best_nonen.did','Q',move11);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::watchdog_best_nonen.did_nonblank','Q',move12);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::watchdog_best_nonen_noneq.did','Q',move13);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::watchdog_best_nonen_noneq.did_nonblank','Q',move14);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::watchdog_best_noneq.did','Q',move15);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::watchdog_best_noneq.did_nonblank','Q',move16);
Roxiekeybuild.MAC_SK_Move_v2('~thor_data400::key::adl_segmentation','Q',move17,2);
Roxiekeybuild.MAC_SK_Move_v2('~thor_data400::key::watchdog_best.name_city_st','Q',move18,2);
Roxiekeybuild.MAC_SK_Move_v2('~thor_data400::key::watchdog_best_supplemental::did','Q',move19,2);

move_keys := parallel(move1,move1_1,move2,move3,move5,move6,move6_1,move7,move11,move12,move13,move14,move15,move16,move17,move18,move19,move2_1,move7_1);

rec := record
 string8 watch;
end;

d := dataset([{'watchdog'}],rec);

temp_file := output(d,,'~thor_data400::temp::for_watchdog_dkc',overwrite);

file_despray := lib_fileservices.FileServices.Despray('~thor_data400::temp::for_watchdog_dkc',_Control.IPAddress.edata12,'/export/home/skasavaj/watchdog/watchdog_flag',,,,TRUE);

file_remove := sequential(
				lib_fileservices.FileServices.DeleteLogicalFile('~thor_data400::temp::for_watchdog_dkc'),
				//lib_fileservices.FileServices.DeleteLogicalFile('~thor_data400::in::watchdog_check'),
				lib_fileservices.FileServices.DeleteLogicalFile('~thor400_84::out::watchdog_filtered_header'),
				lib_fileservices.FileServices.DeleteLogicalFile('~thor400_84::out::watchdog_filtered_header_nonglb')
				);


email_success := fileservices.sendemail(
										'roxiebuilds@seisint.com;sudhir.kasavajjala@lexisnexis.com;michael.gould@lexisnexis.com',
										'Watchdog Weekly Build Succeeded - ' + filedate,
										'Keys:\n' +
										
										'			 1) thor_data400::key::watchdog_best.did_qa(thor_data400::key::watchdog::'+filedate+'::best.did)\n' + 
										'		 1.1) thor_data400::key::watchdog_best_nonutil.did_qa(thor_data400::key::watchdog::'+filedate+'::best_nonutil.did)\n' + 
										'      2) thor_data400::key::watchdog_nonglb.did_qa(thor_data400::key::watchdog::'+filedate+'::nonglb.did)\n' +
										
										'    2.1) thor_data400::key::watchdog_nonglb.no_EQ.did_qa(thor_data400::key::watchdog::'+filedate+'::nonglb.no_EQ.did)\n' +
										
										'      3) thor_data400::key::watchdog_best.ssn_qa(thor_data400::key::watchdog::'+filedate+'::best.ssn) \n' +
										'      4) thor_data400::key::ssn_bads_qa(thor_data400::key::watchdog::'+filedate+'::ssn_bads) \n' +
										'      5) thor_data400::key::watchdog_delta.did_qa(thor_data400::key::watchdog::'+filedate+'::delta.did) \n' +
										'      6) thor_data400::key::watchdog_best.did_nonblank_qa(thor_data400::key::watchdog::'+filedate+'::best.did_nonblank)\n' + 
										'    6.1) thor_data400::key::watchdog_best_nonutil.did_nonblank_qa(thor_data400::key::watchdog::'+filedate+'::best_nonutil.did_nonblank)\n' + 
										'      7) thor_data400::key::watchdog_nonglb.did_nonblank_qa(thor_data400::key::watchdog::'+filedate+'::nonglb.did_nonblank)\n' + 
										'      7.1) thor_data400::key::watchdog_nonglb_noneq.did_nonblank_qa(thor_data400::key::watchdog::'+filedate+'::nonglb_noneq.did_nonblank)\n' + 
										'      8) thor_data400::key::watchdog_nonglb.teaser_qa(thor_data400::key::watchdog::'+filedate+'::nonglb.teaser)\n' + 
										'      9) thor_data400::key::watchdog_best_supplemental::did_qa(thor_data400::key::watchdog::'+filedate+'::best_supplemental::did)\n' + 
										
										'	   have been built and deployed to QA.'
										);

email_failure := fileservices.sendemail(
										'roxiebuilds@seisint.com;sudhir.kasavajjala@lexisnexis.com;michael.gould@lexisnexisrisk.com',
										'Watchdog Weekly Roxie Build Failed - ' + filedate,
										failmessage
										);
										
update_version := RoxieKeyBuild.updateversion('WatchdogKeys',filedate,'michael.gould.lexisnexisrisk.com@seisint.com',,'N|B');
create_build := Orbit3.proc_Orbit3_CreateBuild('Watchdog Best',filedate,'N|B');
										
export Proc_build_Keys := sequential(wchk,build_keys,move_to_built,move_keys
			,parallel(eighth_key,eighthDotOne_key),mv8,mv8_1,move8,move8_1 // builds off seventh key and uses MOXIE out file that will be deleted
		  /*k9,k10,mv9,mv10,move9,move10*/
			// build universal key after all the other keys are built
			,Watchdog_V2.Proc_Build_Merged_Key(filedate),
			// then update DOPS
			update_version,
			create_build,
			/*,create_build,update_idops,*/
			temp_file,
			/*,fSendMail('WATCHDOG_KEYS_COMPLETE','Watchdog keys complete on prod400'),*/
		  /*file_despray,*/file_remove
			) : 
			success(email_success),
			failure(email_failure);