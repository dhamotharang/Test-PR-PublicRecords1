import did_add, risk_indicators, autokeyb2, ut, zz_cemtemp, standard, ut, doxie, autokey,AutoKeyI, RoxieKeyBuild,doxie,RoxieKeyBuild,DayBatchEda,EDA_VIA_XML,risk_indicators,doxie_cbrs,relocations;

/* 
		Build time is 6 hours - 3 hours to read and re-distribute from 10 to 400 nodes and 3 hours to produce keys with 3.4+B records
		param_version - for versioning that is different than what the version currently is on logs thor for the base file. example is when trying to
										create a B version. else, this process will create a version based on what the base file version is on logs thor.
*/

export ProcBuildKeys(string param_version = '') := function

wuname := 'Daily Inquiry Tracking Keys';

#OPTION('allowedClusters', 'thor400_84,thor400_92,thor400_72')
#OPTION('AllowAutoSwitchQueue', true)
#WORKUNIT('priority','high')
#WORKUNIT('name', wuname)

s(string inT) := (unsigned)stringlib.stringfind(inT, '::', 3) + 2;
e(string inT) := (unsigned)stringlib.stringfind(inT, '::', 4) - 1;

nm_current_version := fileservices.superfilecontents('~thor_data400::key::inquiry_table::address_qa')[1].name;
prod_key_version := nm_current_version[s(nm_current_version)..e(nm_current_version)];

cert_key_version := did_add.get_EnvVariable('inquiry_build_version','http://roxiestaging.br.seisint.com:9876');
cert_update_key_version := did_add.get_EnvVariable('inquiry_update_build_version','http://roxiestaging.br.seisint.com:9876');

logs_version := dataset(ut.foreign_logs + '~thor10_11::out::inquiry::processedfiles', recordof(workunitservices.WorkunitFilesRead(workunit)), thor, opt)
																				(name = 'build version')[1].cluster : independent;

rundate := if(param_version = '', logs_version, param_version) : independent;

iscurrent := prod_key_version >= rundate or rundate = cert_key_version : independent;

running := count(workunitservices.WorkunitList('','','','','','','','','','','',true,false)(job = wuname and state in ['running','queued'])) > 0;
																				
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////// BUILD KEYS

/* // Full File */
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Inquiry_AccLogs.Key_Inquiry_Address,'~thor_data400::key::inquiry_table::address','~thor_data400::key::inquiry::'+rundate+'::address',bk_addr);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Inquiry_AccLogs.Key_Inquiry_DID,'~thor_data400::key::inquiry_table::did','~thor_data400::key::inquiry::'+rundate+'::did',bk_did);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Inquiry_AccLogs.Key_Inquiry_Phone,'~thor_data400::key::inquiry_table::phone','~thor_data400::key::inquiry::'+rundate+'::phone',bk_phone);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Inquiry_AccLogs.Key_Inquiry_SSN,'~thor_data400::key::inquiry_table::ssn','~thor_data400::key::inquiry::'+rundate+'::ssn',bk_ssn);
// RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Risk_Indicators.Key_Inquiry_Table_DID,'~thor_data400::key::inquiry_table_did','~thor_data400::key::inquiry_table::'+rundate+'::did',bk_did_old);

/* // Updates Only */
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Inquiry_AccLogs.Key_Inquiry_Address_Update,'~thor_data400::key::inquiry_table::@version@::address_update','~thor_data400::key::inquiry::'+rundate+'::address_Update',bk_addru);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Inquiry_AccLogs.Key_Inquiry_DID_Update,'~thor_data400::key::inquiry_table::@version@::did_update','~thor_data400::key::inquiry::'+rundate+'::did_Update',bk_didu);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Inquiry_AccLogs.Key_Inquiry_Phone_Update,'~thor_data400::key::inquiry_table::@version@::phone_update','~thor_data400::key::inquiry::'+rundate+'::phone_Update',bk_phoneu);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Inquiry_AccLogs.Key_Inquiry_SSN_Update,'~thor_data400::key::inquiry_table::@version@::ssn_update','~thor_data400::key::inquiry::'+rundate+'::ssn_Update',bk_ssnu);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Risk_Indicators.Key_Inquiry_Table_DID,'~thor_data400::key::inquiry_table_did','~thor_data400::key::inquiry_table::'+rundate+'::did',bk_did_old);

////////////////////////////////// MOVE KEYS to BUILT

/* // Full File */
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::inquiry::'+rundate+'::address','~thor_data400::key::inquiry_table::address',mv_addr,3);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::inquiry::'+rundate+'::did','~thor_data400::key::inquiry_table::did',mv_did,3);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::inquiry::'+rundate+'::phone','~thor_data400::key::inquiry_table::phone',mv_phone,3);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::inquiry::'+rundate+'::ssn','~thor_data400::key::inquiry_table::ssn',mv_ssn,3);
// RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::inquiry_table::'+rundate+'::did','~thor_data400::key::inquiry_table_did',mv_didold,3);

/* // Updates Only */
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::inquiry_table::@version@::address_update','~thor_data400::key::inquiry::'+rundate+'::address_Update',mv_addru,3);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::inquiry_table::@version@::did_update','~thor_data400::key::inquiry::'+rundate+'::did_Update',mv_didu,3);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::inquiry_table::@version@::phone_update','~thor_data400::key::inquiry::'+rundate+'::phone_Update',mv_phoneu,3);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::inquiry_table::@version@::ssn_update','~thor_data400::key::inquiry::'+rundate+'::ssn_Update',mv_ssnu,3);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::inquiry_table::'+rundate+'::did','~thor_data400::key::inquiry_table_did',mv_didold,3);

////////////////////////////////// MOVE KEYS to QA

/* // Full File */
ut.MAC_SK_Move_v2('~thor_data400::key::inquiry_table::address','Q',mv2qa_addr);
ut.MAC_SK_Move_v2('~thor_data400::key::inquiry_table::did','Q',mv2qa_did);
ut.MAC_SK_Move_v2('~thor_data400::key::inquiry_table::phone','Q',mv2qa_phone);
ut.MAC_SK_Move_v2('~thor_data400::key::inquiry_table::ssn','Q',mv2qa_ssn);
// ut.MAC_SK_Move_v2('~thor_data400::key::inquiry_table_did','Q',mv2qa_didold);

/* // Updates Only */
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::inquiry_table::@version@::address_update','Q',mv2qa_addru);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::inquiry_table::@version@::did_update','Q',mv2qa_didu);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::inquiry_table::@version@::phone_update','Q',mv2qa_phoneu);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::inquiry_table::@version@::ssn_update','Q',mv2qa_ssnu);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::inquiry_table_did','Q',mv2qa_didold);



new_refresh_avail := ~inquiry_acclogs.fn_ProdHist().is_new_logs_historical_on_prod : independent;

BuildKeys := 
	if(~running, 
	sequential(
			if(~inquiry_acclogs.fn_ProdHist().is_new_logs_historical_on_prod,
			sequential(inquiry_acclogs.fn_ProdHist().buildfile; // output previous MBS appended data file on prod thor only when there is a new one
				 Inquiry_AccLogs.fnMapBaseAppends().Do_Appends; // output new did'ed and bdid'ed file
				 parallel(bk_addr, bk_did, bk_phone, bk_ssn);//, bk_did_old);
				 parallel(mv_addr, mv_did, mv_phone, mv_ssn);//, mv_didold);
				 parallel(mv2qa_addr, mv2qa_did, mv2qa_phone);//, mv2qa_ssn, mv2qa_didold);				 
				 RoxieKeybuild.updateversion('InquiryTableKeys',rundate,'cecelie.guyton@lexisnexis.com,john.freibaum@lexisnexis.com'))),

		sequential(
			 parallel(bk_addru, bk_didu, bk_phoneu, bk_ssnu, bk_did_old);
			 parallel(mv_addru, mv_didu, mv_phoneu, mv_ssnu, mv_didold);
			 parallel(mv2qa_addru, mv2qa_didu, mv2qa_phoneu, mv2qa_ssnu, mv2qa_didold);				 
			 RoxieKeybuild.updateversion('InquiryTableUpdateKeys',rundate,'cecelie.guyton@lexisnexis.com,john.freibaum@lexisnexis.com')),
			
		parallel(
			output(cert_key_version, named('Cert_Archive_Key_Version')); // variable to determine if keys are current - key version on prod thor
			output(cert_update_key_version, named('Cert_Update_Key_Version')); // variable to determine if keys are current - key version on prod thor
			output(logs_version, named('Current_Base_Version_On_Logs_Thor'))) // variable to determine if keys are current - version of last created update files on Logs thor
			 ))				 
			 :  FAILURE(FileServices.SendEmail('cecelie.guyton@lexisnexis.com,john.freibaum@lexisnexis.com', 'InquiryTableKeys Failure ' + logs_version, thorlib.wuid() + '\n' + FAILMESSAGE))
;		

return buildkeys;

end;
