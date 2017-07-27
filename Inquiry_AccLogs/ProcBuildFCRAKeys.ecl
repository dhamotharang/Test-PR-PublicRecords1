import  did_add, risk_indicators, autokeyb2, ut, zz_cemtemp, standard, ut, doxie, autokey,AutoKeyI, RoxieKeyBuild,doxie,RoxieKeyBuild,DayBatchEda,EDA_VIA_XML,risk_indicators,doxie_cbrs,relocations;

/* 
		Build time is 6 hours - 3 hours to read and re-distribute from 10 to 400 nodes and 3 hours to produce keys with 3.4+B records
		param_version - for versioning that is different than what the version currently is on logs thor for the base file. example is when trying to
										create a B version. else, this process will create a version based on what the base file version is on logs thor.
*/

export ProcBuildFCRAKeys(string param_version = '') := function

#workunit('name','Weekly Build Inquiry Table FCRA Keys')

#OPTION('allowedClusters', 'thor400_84,thor400_92')
#OPTION('AllowAutoSwitchQueue', true)

#WORKUNIT('protect',true)
#WORKUNIT('priority','high')

s(string inT) := (unsigned)stringlib.stringfind(inT, '::', 4) + 2;
e(string inT) := (unsigned)stringlib.stringfind(inT, '::', 5) - 1;

nm_current_version := fileservices.superfilecontents('~thor_data400::key::inquiry_table::fcra::address_qa')[1].name;
prod_key_version := nm_current_version[s(nm_current_version)..e(nm_current_version)];

cert_key_version := stringlib.stringfindreplace(did_add.get_EnvVariable('fcra_inquiry_build_version','http://certfcraroxievip.sc.seisint.com:9876'), 'Default', ''); //needs to give cert, not prod

logs_version := dataset(ut.foreign_fcra_logs + 'thor10_231::out::inquiry::processedfiles', recordof(workunitservices.WorkunitFilesRead(workunit)), thor, opt)
																				(name = 'build version')[1].cluster : global;
																	
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

rundate := if(param_version = '', logs_version, param_version) : global;

iscurrent := prod_key_version >= rundate or rundate = cert_key_version : global;

RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Inquiry_AccLogs.Key_FCRA_Address,'~thor_data400::key::inquiry_table::fcra::address','~thor_data400::key::inquiry::fcra::'+rundate+'::address',bk_addr);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Inquiry_AccLogs.Key_FCRA_DID,'~thor_data400::key::inquiry_table::fcra::did','~thor_data400::key::inquiry::fcra::'+rundate+'::did',bk_did);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Inquiry_AccLogs.Key_FCRA_Phone,'~thor_data400::key::inquiry_table::fcra::phone','~thor_data400::key::inquiry::fcra::'+rundate+'::phone',bk_phone);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Inquiry_AccLogs.Key_FCRA_SSN,'~thor_data400::key::inquiry_table::fcra::ssn','~thor_data400::key::inquiry::fcra::'+rundate+'::ssn',bk_ssn);

RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::inquiry::fcra::'+rundate+'::address','~thor_data400::key::inquiry_table::fcra::address',mv_addr,3);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::inquiry::fcra::'+rundate+'::did','~thor_data400::key::inquiry_table::fcra::did',mv_did,3);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::inquiry::fcra::'+rundate+'::phone','~thor_data400::key::inquiry_table::fcra::phone',mv_phone,3);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::inquiry::fcra::'+rundate+'::ssn','~thor_data400::key::inquiry_table::fcra::ssn',mv_ssn,3);

ut.MAC_SK_Move_v2('~thor_data400::key::inquiry_table::fcra::address','Q',mv2qa_addr);
ut.MAC_SK_Move_v2('~thor_data400::key::inquiry_table::fcra::did','Q',mv2qa_did);
ut.MAC_SK_Move_v2('~thor_data400::key::inquiry_table::fcra::phone','Q',mv2qa_phone);
ut.MAC_SK_Move_v2('~thor_data400::key::inquiry_table::fcra::ssn','Q',mv2qa_ssn);

BuildKeys := sequential(
		output(cert_key_version, named('Existing_Cert_Version'));
		output(logs_version, named('FCRA_Logs_Base_Version'));
		if(~iscurrent, 
										sequential(
										 parallel(bk_addr, bk_did, bk_phone, bk_ssn);
										 parallel(mv_addr, mv_did, mv_phone, mv_ssn);
										 parallel(mv2qa_addr, mv2qa_did, mv2qa_phone, mv2qa_ssn);
										 RoxieKeybuild.updateversion('FCRA_InquiryTableKeys',rundate,'cecelie.guyton@lexisnexis.com')))
										 ) 
										 :  FAILURE(FileServices.SendEmail('cecelie.guyton@lexisnexis.com', 'InquiryTableKeys Failure ' + logs_version, thorlib.wuid() + '\n' + FAILMESSAGE))
;		

return buildkeys;

end;
