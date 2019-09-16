import did_add, risk_indicators, autokeyb2, ut, Data_Services, zz_cemtemp, standard, ut, doxie, autokey,AutoKeyI, RoxieKeyBuild,doxie,RoxieKeyBuild,DayBatchEda,EDA_VIA_XML,risk_indicators,doxie_cbrs,relocations;

#WORKUNIT('name','Inquiry Tracking Daily Updates');
#WORKUNIT('priority','high');

/* 
 
3 Parameters
Param Version	- Manually set key version instead of looking for it on Logs Thor
Update Only		- Boolean, Only create update keys (W20111019-103119)
History Only	- Boolean, Only create historical keys (W20111019-105638)

*/

export ProcBuildKeys(string param_version = '', boolean updateonly = false, boolean historyonly = false) := function

history_logs_version := dataset(Data_Services.foreign_logs + 'thor100_21::out::inquiry::processedfiles_history', recordof(workunitservices.WorkunitFilesRead(workunit)), thor, opt)
																				(name = 'history build version')[1].cluster;
																				
logs_version := dataset(Data_Services.foreign_logs + 'thor100_21::out::inquiry::processedfiles', recordof(workunitservices.WorkunitFilesRead(workunit)), thor, opt)
																				(name = 'build version')[1].cluster;

rundate := map(param_version <> '' => param_version,
							 logs_version <> '' => logs_version, 
							 ut.GetDate) : independent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////// BUILD KEYS
 
/* // Updates Only */
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Inquiry_AccLogs.Key_Inquiry_Address_Update,'~thor_data400::key::inquiry_table::@version@::address_update','~thor_data400::key::inquiry::'+rundate+'::address_Update',bk_addru);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Inquiry_AccLogs.Key_Inquiry_transaction_id_update,'~thor_data400::key::inquiry_table::@version@::transaction_id_update','~thor_data400::key::inquiry::'+rundate+'::transaction_id_update',bk_trans);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Inquiry_AccLogs.Key_Inquiry_DID_Update,'~thor_data400::key::inquiry_table::@version@::did_update','~thor_data400::key::inquiry::'+rundate+'::did_Update',bk_didu);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Inquiry_AccLogs.Key_Inquiry_Phone_Update,'~thor_data400::key::inquiry_table::@version@::phone_update','~thor_data400::key::inquiry::'+rundate+'::phone_Update',bk_phoneu);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Inquiry_AccLogs.Key_Inquiry_SSN_Update,'~thor_data400::key::inquiry_table::@version@::ssn_update','~thor_data400::key::inquiry::'+rundate+'::ssn_Update',bk_ssnu);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Inquiry_AccLogs.Key_Inquiry_Email_Update,'~thor_data400::key::inquiry_table::@version@::email_update','~thor_data400::key::inquiry::'+rundate+'::email_update',bk_emailu);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Inquiry_AccLogs.Key_Inquiry_name_Update,'~thor_data400::key::inquiry_table::@version@::name_update','~thor_data400::key::inquiry::'+rundate+'::name_Update',bk_nameu);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Inquiry_AccLogs.Key_Inquiry_IPaddr_Update,'~thor_data400::key::inquiry_table::@version@::IPaddr_update','~thor_data400::key::inquiry::'+rundate+'::IPaddr_update',bk_IPaddru);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Inquiry_AccLogs.Key_Inquiry_LinkIds_Update.key,'~thor_data400::key::inquiry_table::@version@::LinkIds_update','~thor_data400::key::inquiry::'+rundate+'::LinkIds_update',bk_LinkIdsu);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Risk_Indicators.Key_Inquiry_Table_DID,'~thor_data400::key::inquiry_table_did','~thor_data400::key::inquiry_table::'+rundate+'::did',bk_did_old);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(inquiry_Acclogs.Key_Inquiry_industry_use_vertical(),'~thor_data400::key::inquiry_table::industry_use_vertical','~thor_data400::key::inquiry_table::'+rundate+'::industry_use_vertical',bk_industry_veritcal);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(inquiry_Acclogs.key_lookup_function_desc,'~thor_data400::key::inquiry_table::lookup_function_desc','~thor_data400::key::inquiry_table::'+rundate+'::lookup_function_desc',bk_function_desc);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Inquiry_AccLogs.Key_Inquiry_FEIN_Update,'~thor_data400::key::inquiry_table::@version@::fein_update','~thor_data400::key::inquiry::'+rundate+'::fein_Update',bk_feinu);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(inquiry_Acclogs.Key_Inquiry_industry_use_vertical_login(),'~thor_data400::key::inquiry_table::industry_use_vertical_login','~thor_data400::key::inquiry_table::'+rundate+'::industry_use_vertical_login',bk_industry_vertical_login);
////////////////////////////////// MOVE KEYS to BUILT

/* // Updates Only */
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::inquiry_table::@version@::transaction_id_update','~thor_data400::key::inquiry::'+rundate+'::transaction_id_update',mv_transu,3);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::inquiry_table::@version@::address_update','~thor_data400::key::inquiry::'+rundate+'::address_Update',mv_addru,3);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::inquiry_table::@version@::did_update','~thor_data400::key::inquiry::'+rundate+'::did_Update',mv_didu,3);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::inquiry_table::@version@::phone_update','~thor_data400::key::inquiry::'+rundate+'::phone_Update',mv_phoneu,3);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::inquiry_table::@version@::ssn_update','~thor_data400::key::inquiry::'+rundate+'::ssn_Update',mv_ssnu,3);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::inquiry_table::@version@::email_update','~thor_data400::key::inquiry::'+rundate+'::email_Update',mv_emailu,3);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::inquiry_table::@version@::name_update','~thor_data400::key::inquiry::'+rundate+'::name_Update',mv_nameu,3);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::inquiry_table::@version@::IPaddr_update','~thor_data400::key::inquiry::'+rundate+'::IPaddr_Update',mv_IPaddru,3);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::inquiry_table::@version@::LinkIds_update','~thor_data400::key::inquiry::'+rundate+'::LinkIds_update',mv_LinkIdsu,3);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::inquiry_table::'+rundate+'::did','~thor_data400::key::inquiry_table_did',mv_didold,3);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::inquiry_table::'+rundate+'::industry_use_vertical','~thor_data400::key::inquiry_table::industry_use_vertical',mv_industry_vertical,3);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::inquiry_table::'+rundate+'::lookup_function_desc','~thor_data400::key::inquiry_table::lookup_function_desc',mv_function_desc,3);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::inquiry_table::@version@::fein_update','~thor_data400::key::inquiry::'+rundate+'::fein_Update',mv_feinu,3);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::inquiry_table::'+rundate+'::industry_use_vertical_login','~thor_data400::key::inquiry_table::industry_use_vertical_login',mv_industry_vertical_login,3);
////////////////////////////////// MOVE KEYS to QA

/* // Updates Only */
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::inquiry_table::@version@::address_update','Q',mv2qa_addru);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::inquiry_table::@version@::transaction_id_update','Q',mv2qa_transu);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::inquiry_table::@version@::did_update','Q',mv2qa_didu);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::inquiry_table::@version@::phone_update','Q',mv2qa_phoneu);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::inquiry_table::@version@::ssn_update','Q',mv2qa_ssnu);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::inquiry_table::@version@::email_update','Q',mv2qa_emailu);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::inquiry_table::@version@::name_update','Q',mv2qa_nameu);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::inquiry_table::@version@::IPAddr_update','Q',mv2qa_IPaddru);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::inquiry_table::@version@::LinkIds_update','Q',mv2qa_LinkIdsu);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::inquiry_table_did','Q',mv2qa_didold);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::inquiry_table::industry_use_vertical','Q',mv2qa_industry_vertical);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::inquiry_table::lookup_function_desc','Q',mv2qa_function_desc);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::inquiry_table::@version@::fein_update','Q',mv2qa_feinu);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::inquiry_table::industry_use_vertical_login','Q',mv2qa_industry_vertical_login);
processedFiles := nothor(workunitservices.WorkunitFilesRead(workunit)) + 
									dataset([{'history build version',history_logs_version,'',''}], recordof(workunitservices.WorkunitFilesRead(workunit))) +
									dataset([{'build version',logs_version,'',''}], recordof(workunitservices.WorkunitFilesRead(workunit)));

BuildKeys := 
					sequential(
					 parallel(bk_addru, bk_trans,bk_didu, bk_phoneu, bk_ssnu, bk_emailu, bk_nameu, bk_IPaddru, bk_LinkIdsu, bk_did_old,bk_industry_veritcal,bk_function_desc,bk_feinu,bk_industry_vertical_login);
					 parallel(mv_addru, mv_transu, mv_didu, mv_phoneu, mv_ssnu, mv_emailu, mv_nameu, mv_IPaddru, mv_LinkIdsu, mv_didold,mv_industry_vertical,mv_function_desc,mv_feinu,mv_industry_vertical_login);
					 parallel(mv2qa_addru,mv2qa_transu, mv2qa_didu, mv2qa_phoneu, mv2qa_ssnu, mv2qa_emailu,mv2qa_nameu, mv2qa_IPaddru, mv2qa_LinkIdsu, mv2qa_didold,mv2qa_industry_vertical,mv2qa_function_desc,mv2qa_feinu,mv2qa_industry_vertical_login);			 
					 RoxieKeybuild.updateversion('InquiryTableUpdateKeys',rundate,'john.freibaum@lexisnexisrisk.com, Fernando.Incarnacao@lexisnexisrisk.com, Sudhir.Kasavajjala@lexisnexisrisk.com, Darren.Knowles@lexisnexisrisk.com',,'N'),
					 output(choosen(sort(choosen(Inquiry_AccLogs.File_Inquiry_Base.Update(person_q.appended_adl > 0 and bus_intel.industry not in ['UNASSIGNED','BLANK','']), 1000000), -search_info.datetime), 100), named('Sample_Update_Records')),
					 output(choosen(Inquiry_AccLogs.File_Inquiry_Base.Update(person_q.email_address <> ''), 5), named('Sample_Update_Email_Records')),
					 Inquiry_AccLogs.STRATA_Inquiry_Daily_Tracking(rundate),
					output(ProcessedFiles,,'~thor100_21::out::inquiry::processedfiles', overwrite))
			 :  FAILURE(FileServices.SendEmail('john.freibaum@lexisnexisrisk.com, Fernando.Incarnacao@lexisnexisrisk.com, Sudhir.Kasavajjala@lexisnexisrisk.com, Darren.Knowles@lexisnexisrisk.com', 'NonFCRA Daily Inquiry Table Keys Failure ' + logs_version, thorlib.wuid() + ' on Boca Prod\n' + FAILMESSAGE))
;		

return buildkeys;

end;
