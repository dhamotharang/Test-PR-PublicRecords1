#workunit('name','Weekly FCRA Inquiry Tracking Keys');
#OPTION('multiplePersistInstances',false)
#stored('did_add_force','thor');
import  did_add, risk_indicators, autokeyb2, ut, zz_cemtemp, standard, ut, doxie, autokey,AutoKeyI, RoxieKeyBuild,doxie,RoxieKeyBuild,DayBatchEda,EDA_VIA_XML,risk_indicators,doxie_cbrs,relocations;

/* 
		Build time is 6 hours - 3 hours to read and re-distribute from 10 to 400 nodes and 3 hours to produce keys with 3.4+B records
		param_version - for versioning that is different than what the version currently is on logs thor for the base file. example is when trying to
										create a B version. else, this process will create a version based on what the base file version is on logs thor.
*/

export ProcBuildFCRAKeys(string param_version = '', boolean redid = true) := function


s(string inT) := (unsigned)stringlib.stringfind(inT, '::', 4) + 2;
e(string inT) := (unsigned)stringlib.stringfind(inT, '::', 5) - 1;

nm_current_version := nothor(fileservices.superfilecontents('~thor_data400::key::inquiry_table::fcra::address_qa')[1].name);
prod_key_version  := nm_current_version[s(nm_current_version)..e(nm_current_version)];

// cert_key_version := stringlib.stringfindreplace(did_add.get_EnvVariable('fcra_inquiry_build_version','http://certfcraroxievip.sc.seisint.com:9856'), 'Default', ''); //needs to give cert, not prod

logs_version := dataset(ut.foreign_fcra_logs + 'fcra_logs_thor::out::inquiry::processedfiles', recordof(workunitservices.WorkunitFilesRead(workunit)), thor, opt)
																				(name = 'build version')[1].cluster : independent;
																	
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

rundate := if(param_version = '', logs_version, param_version) : independent;

// iscurrent := prod_key_version >= rundate or rundate = cert_key_version : independent;

RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Inquiry_AccLogs.Key_FCRA_Address,'~thor_data400::key::inquiry_table::fcra::address','~thor_data400::key::inquiry::fcra::'+rundate+'::address',bk_addr);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Inquiry_AccLogs.Key_FCRA_DID,'~thor_data400::key::inquiry_table::fcra::did','~thor_data400::key::inquiry::fcra::'+rundate+'::did',bk_did);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Inquiry_AccLogs.Key_FCRA_Phone,'~thor_data400::key::inquiry_table::fcra::phone','~thor_data400::key::inquiry::fcra::'+rundate+'::phone',bk_phone);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Inquiry_AccLogs.Key_FCRA_SSN,'~thor_data400::key::inquiry_table::fcra::ssn','~thor_data400::key::inquiry::fcra::'+rundate+'::ssn',bk_ssn);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Inquiry_AccLogs.Key_FCRA_Billgroups_DID,'~thor_data400::key::inquiry_table::fcra::@version@::billgroups_did','~thor_data400::key::inquiry::fcra::'+rundate+'::billgroups_did',bk_bgroup);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(inquiry_Acclogs.Key_Inquiry_industry_use_vertical(true),'~thor_data400::key::inquiry_table::fcra::industry_use_vertical','~thor_data400::key::inquiry_table::fcra::'+rundate+'::industry_use_vertical',bk_industry_vertical);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(inquiry_Acclogs.Key_Inquiry_industry_use_vertical_login(true),'~thor_data400::key::inquiry_table::fcra::industry_use_vertical_login','~thor_data400::key::inquiry_table::fcra::'+rundate+'::industry_use_vertical',bk_industry_vertical_login);

RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::inquiry::fcra::'+rundate+'::address','~thor_data400::key::inquiry_table::fcra::address',mv_addr,3);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::inquiry::fcra::'+rundate+'::did','~thor_data400::key::inquiry_table::fcra::did',mv_did,3);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::inquiry::fcra::'+rundate+'::phone','~thor_data400::key::inquiry_table::fcra::phone',mv_phone,3);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::inquiry::fcra::'+rundate+'::ssn','~thor_data400::key::inquiry_table::fcra::ssn',mv_ssn,3);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::inquiry_table::fcra::@version@::billgroups_did','~thor_data400::key::inquiry::fcra::'+rundate+'::billgroups_did',mv_bgroup,3);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::inquiry_table::fcra::'+rundate+'::industry_use_vertical','~thor_data400::key::inquiry_table::fcra::industry_use_vertical',mv_industry_vertical,3);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::inquiry_table::fcra::'+rundate+'::industry_use_vertical_login','~thor_data400::key::inquiry_table::fcra::industry_use_vertical',mv_industry_vertical_login,3);

ut.MAC_SK_Move_v2('~thor_data400::key::inquiry_table::fcra::address','Q',mv2qa_addr);
ut.MAC_SK_Move_v2('~thor_data400::key::inquiry_table::fcra::did','Q',mv2qa_did);
ut.MAC_SK_Move_v2('~thor_data400::key::inquiry_table::fcra::phone','Q',mv2qa_phone);
ut.MAC_SK_Move_v2('~thor_data400::key::inquiry_table::fcra::ssn','Q',mv2qa_ssn);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::inquiry_table::fcra::@version@::billgroups_did','Q',mv2qa_bgroup);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::inquiry_table::fcra::industry_use_vertical','Q',mv2qa_industry_vertical);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::inquiry_table::fcra::industry_use_vertical_login','Q',mv2qa_industry_vertical_login);

BuildKeys := sequential(
                output(dataset([{ut.GetDate}],{string8 filedate}),,'~thor::inquiry_fcra_key_build',overwrite),
								if(redid, inquiry_acclogs.File_FCRA_Inquiry_BaseSourced.create_appends); //creates the re-dided base file lookup
									 parallel(bk_addr, bk_did, bk_phone, bk_ssn, bk_bgroup,bk_industry_vertical,bk_industry_vertical_login); // update ids and build keys
									 parallel(mv_addr, mv_did, mv_phone, mv_ssn, mv_bgroup,mv_industry_vertical,mv_industry_vertical_login);
									 parallel(mv2qa_addr, mv2qa_did, mv2qa_phone, mv2qa_ssn, mv2qa_bgroup,mv2qa_industry_vertical,mv2qa_industry_vertical_login);
								   RoxieKeybuild.updateversion('FCRA_InquiryTableKeys',rundate,'john.freibaum@lexisnexisrisk.com, Fernando.Incarnacao@lexisnexisrisk.com, Sudhir.Kasavajjala@lexisnexisrisk.com, Darren.Knowles@lexisnexisrisk.com',,'F');
			 					 Inquiry_AccLogs.STRATA_FCRA_Inquiry_weekly(rundate);
									 output(choosen(sort(inquiry_acclogs.File_FCRA_Inquiry_BaseSourced.file(source = 'BANKO' and person_q.appended_adl > 0 and bus_intel.industry not in ['','BLANK','UNASSIGNED']), -search_info.datetime), 1000), named('Sample_Banko_Records')),
									 output(choosen(sort(inquiry_acclogs.File_FCRA_Inquiry_BaseSourced.file(source = 'BATCH' and person_q.appended_adl > 0 and bus_intel.industry not in ['','BLANK','UNASSIGNED']), -search_info.datetime), 1000), named('Sample_Batch_Records')),
									 output(choosen(sort(inquiry_acclogs.File_FCRA_Inquiry_BaseSourced.file(source = 'RISKWISE' and person_q.appended_adl > 0 and bus_intel.industry not in ['','BLANK','UNASSIGNED']), -search_info.datetime), 1000), named('Sample_Riskwise_Records')),
									 FileServices.Deletelogicalfile('~thor::inquiry_fcra_key_build')
									 )
										 :  FAILURE(FileServices.SendEmail('john.freibaum@lexisnexisrisk.com, Fernando.Incarnacao@lexisnexisrisk.com, Sudhir.Kasavajjala@lexisnexisrisk.com, Darren.Knowles@lexisnexisrisk.com', 'FCRA Weekly Inquiry Table Keys Failure ' + logs_version, thorlib.wuid() + ' on Boca Prod\n' + FAILMESSAGE))
;		

return buildkeys;

end;
