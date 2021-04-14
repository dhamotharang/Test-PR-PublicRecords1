import watchdog,lib_fileservices,RoxieKeybuild,Orbit3,Std;

filedate := (STRING8)Std.Date.Today();
	
	RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Watchdog.Key_Watchdog_FCRA_nonEN,'~thor_data400::key::watchdog_best::FCRA::nonEN_did','~thor_data400::key::watchdog_best::FCRA::'+filedate+'::nonEN_DID',FCRA_nonEN_key);
  RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Watchdog.Key_Watchdog_FCRA_nonEQ,'~thor_data400::key::watchdog_best::FCRA::nonEQ_did','~thor_data400::key::watchdog_best::FCRA::'+filedate+'::nonEQ_DID',FCRA_nonEQ_key);

	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::watchdog_best::FCRA::nonEN_did','~thor_data400::key::watchdog_best::FCRA::'+filedate+'::nonEN_DID',mv_FCRA_nonEN);
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::watchdog_best::FCRA::nonEQ_did','~thor_data400::key::watchdog_best::FCRA::'+filedate+'::nonEQ_DID',mv_FCRA_nonEQ);

	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::watchdog_best::FCRA::nonEN_did','Q',mv_FCRA_nonEN_qa);
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::watchdog_best::FCRA::nonEQ_did','Q',mv_FCRA_nonEQ_qa);
	
	string email_list := 'Wenhong.Ma@lexisnexisrisk.com;Sudhir.Kasavajjala@lexisnexisrisk.com';
	
	email_success := fileservices.sendemail(
										email_list,
										'Watchdog FCRA Monthly Roxie Build Success - ' + filedate,
										'FCRA Watchdog Best Build Success.Please view workunit --'+workunit
										);


email_failure := fileservices.sendemail(
										email_list,
										'Watchdog FCRA Monthly Roxie Build Failed - ' + filedate,
										failmessage
										);
										

string dops_fcrapkg_wdog := 'FCRA_WatchdogKeys';

string env_flag := 'F';

update_version := RoxieKeyBuild.updateversion(dops_fcrapkg_wdog,filedate,'Sudhir.Kasavajjala@lexisnexisrisk.com',,env_flag);
create_build := Orbit3.proc_Orbit3_CreateBuild('FCRA Watchdog',filedate,env_flag);

//keydiff fcra
//keydiff_fcra :=  Watchdog.fGetIndexAttributes (dops_fcrapkg_wdog,'B',env_flag);


EXPORT Proc_build_FCRA_keys := sequential(parallel(FCRA_nonEN_key,FCRA_nonEQ_key),
                                          parallel(mv_FCRA_nonEN,mv_FCRA_nonEQ),
																					parallel(mv_FCRA_nonEN_qa,mv_FCRA_nonEQ_qa),
																					update_version,create_build/*,keydiff_fcra*/): 
			                                        success(email_success),
			                                         failure(email_failure); 
