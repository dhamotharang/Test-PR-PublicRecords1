Import STD, data_services, did_add, dops;

EXPORT _Versions := Module;

shared appd_weekly_base_version_regexp 		            := '([0-9]{8}[a-z]?_reappend)';
shared version_regexp 									:= '([0-9]{8}[a-z]?)';


EXPORT dops_fcra_keys_prod   							:= dops.Getbuildversion('FCRA_InquiryTableKeys','B','F','P','prod');
EXPORT dops_fcra_keys_certQA							:= dops.Getbuildversion('FCRA_InquiryTableKeys','B','F','C','prod');
EXPORT dops_fcra_keys_thor  							:= dops.Getbuildversion('FCRA_InquiryTableKeys','B','F','T','prod');

//Update dataset keys versions
SHARED dops_get_nonfcra_update_release_history          := DOPS.GetReleaseHistory('B','N','InquiryTableUpdateKeys','prod');
EXPORT dops_nonfcra_update_keys_prod			        := dops.Getbuildversion('InquiryTableUpdateKeys','B','N','P','prod');
EXPORT dops_nonfcra_update_keys_certQA		            := dops.Getbuildversion('InquiryTableUpdateKeys','B','N','C','prod');
EXPORT dops_nonfcra_update_keys_thor	  	            := dops.Getbuildversion('InquiryTableUpdateKeys','B','N','T','prod');

shared dops_versions_table                              := dops_get_nonfcra_update_release_history(certversion < dops_nonfcra_update_keys_prod);	
EXPORT dops_nonfcra_update_keys_father                  := dops_versions_table[1].certversion;

//Delta dataset keys versions
SHARED dops_get_nonfcra_delta_keys_prod_releases_history     := DOPS.GetLatestBuildVersions('InquiryTableDeltaKeys','B','N','P',0)(updateflag='D');
SHARED dops_get_nonfcra_delta_keys_qa_releases_history       := DOPS.GetLatestBuildVersions('InquiryTableDeltaKeys','B','N','Q',0)(updateflag='D');
EXPORT dops_nonfcra_delta_keys_prod                          := dops_get_nonfcra_delta_keys_prod_releases_history[1].buildversion;
EXPORT dops_nonfcra_delta_keys_certQA                        := dops_get_nonfcra_delta_keys_qa_releases_history[1].buildversion;

SHARED dops_get_nonfcra_full_replace_prod_releases_history   := DOPS.GetLatestBuildVersions('InquiryTableDeltaKeys','B','N','P',0)(updateflag='F');
SHARED dops_get_nonfcra_full_replace_qa_releases_history     := DOPS.GetLatestBuildVersions('InquiryTableDeltaKeys','B','N','Q',0)(updateflag='F');
EXPORT dops_nonfcra_full_replace_prod                        := dops_get_nonfcra_full_replace_prod_releases_history[1].buildversion;
EXPORT dops_nonfcra_full_replace_certQA                      := dops_get_nonfcra_full_replace_qa_releases_history[1].buildversion;


EXPORT dops_nonfcra_keys_prod							:= dops.Getbuildversion('InquiryTableKeys','B','N','P','prod');
EXPORT dops_nonfcra_keys_certQA						    := dops.Getbuildversion('InquiryTableKeys','B','N','C','prod');
EXPORT dops_nonfcra_keys_thor							:= dops.Getbuildversion('InquiryTableKeys','B','N','T','prod');

shared nonfcra_appd_weekly_base_file 			        := nothor(fileservices.superfilecontents(Data_Services.foreign_prod+'thor_data400::out::inquiry_tracking::weekly_historical')[1].name);
EXPORT nonfcra_appd_weekly_base 					    := STD.Str.FindReplace(regexfind(appd_weekly_base_version_regexp, nonfcra_appd_weekly_base_file,1),'_reappend','');

shared nonfcra_cur_history_base_file			        := nothor(fileservices.superfilecontents(INQL_v2.Filenames(,pFCRA:=false, pDaily:=false).INQL_Base.QA)[1].name);
EXPORT nonfcra_history_base 							:= regexfind(version_regexp, nonfcra_cur_history_base_file,1);

shared nonfcra_did_key_file 							:= nothor(fileservices.superfilecontents(Inql_V2.Keynames(isUpdate:=false,isFCRA:=false).DID.QA)[1].name);
EXPORT thor_nonfcra_keys  								:= regexfind(version_regexp, nonfcra_did_key_file,1);	

shared nonfcra_daily_base_file						    := sort(nothor(fileservices.superfilecontents(INQL_v2.Filenames(,pFCRA:=false, pDaily:=true).INQL_Base.QA)),-name)[1].name;
EXPORT nonfcra_daily_base 								:= regexfind(version_regexp, nonfcra_daily_base_file,1);	

//Full base and delta version
SHARED nonfcra_daily_base_files						    := nothor(fileservices.superfilecontents(INQL_v2.Filenames(,pFCRA:=false, pDaily:=true).INQL_Base.QA));
EXPORT nonfcra_daily_delta_base_files                   := nonfcra_daily_base_files(REGEXFIND('delta',name));
SHARED nonfcra_daily_full_base_files                    := nonfcra_daily_base_files(~REGEXFIND('delta',name));
EXPORT nonfcra_daily_full_replace_base_file_version     := std.str.splitwords(nonfcra_daily_full_base_files[1].name,'::')[6][1..8];
EXPORT nonfcra_daily_deltas_after_full_replace          := dops_get_nonfcra_delta_keys_prod_releases_history(if(buildversion<>'',buildversion,'')>nonfcra_daily_full_replace_base_file_version);


// shared nonfcra_did_update_key_file 		            := nothor(fileservices.superfilecontents(Inql_V2.Keynames(isUpdate:=true,isFCRA:=false).DID.QA))[1].name;
// EXPORT thor_nonfcra_update_keys 			   	        := regexfind(version_regexp, nonfcra_did_update_key_file,1);

// EXPORT nonfcra_did_update_key_file 		            := nothor(fileservices.superfilecontents(Inql_V2.Keynames(isUpdate:=true,isFCRA:=false).DID.QA))[1].name;
EXPORT thor_nonfcra_update_keys 				        := dops_nonfcra_update_keys_thor;

shared fcra_daily_base_file								:= sort(nothor(fileservices.superfilecontents(INQL_v2.Filenames(,pFCRA:=true, pDaily:=true).INQL_Base.QA)),-name)[1].name;
EXPORT fcra_daily_base 									:= regexfind(version_regexp, fcra_daily_base_file,1);	

shared fcra_history_base_file							:= sort(nothor(fileservices.superfilecontents(INQL_v2.Filenames(,pFCRA:=true, pDaily:=false).INQL_Base.QA)),-name)[1].name;
EXPORT fcra_history_base								:= regexfind(version_regexp, fcra_history_base_file,1);	

shared fcra_did_key_file 								:= nothor(fileservices.superfilecontents(Inql_V2.Keynames(isUpdate:=false,isFCRA:=true).DID.QA))[1].name;
EXPORT thor_fcra_keys 									:= regexfind(version_regexp, fcra_did_key_file,1);

shared nonfcra_last_accurint_file					    := sort(nothor(fileservices.superfilecontents(INQL_v2.Superfile_List(false).accurint_bldg)),-name)[1].name;
Export nonfcra_last_accurint_processed		            := regexfind(version_regexp, nonfcra_last_accurint_file,1);	

shared fcra_last_accurint_file						    := sort(nothor(fileservices.superfilecontents(INQL_v2.Superfile_List(true).accurint_bldg)),-name)[1].name;
Export fcra_last_accurint_processed		  	            := regexfind(version_regexp, nonfcra_last_accurint_file,1);	

shared nonfcra_next_batch_file					        := sort(nothor(fileservices.superfilecontents(INQL_v2.Superfile_List(false).batch_bldg)),-name)[1].name;
Export nonfcra_next_daily_base 						    := regexfind(version_regexp, nonfcra_next_batch_file,1);	

shared fcra_next_batch_file					  		    := sort(nothor(fileservices.superfilecontents(INQL_v2.Superfile_List(true).batch_bldg)),-name)[1].name;
Export fcra_next_daily_base 							:= regexfind(version_regexp, fcra_next_batch_file,1);	



SHARED GetActiveWU(string wuname) := function

  valid_state :=['','unknown','submitted', 'compiling','compiled','blocked','running','wait'];
	d := sort(nothor(WorkunitServices.WorkunitList('',NAMED jobname:=wuname ))(wuid <> thorlib.wuid() and state in valid_state), -wuid):independent;
	active_workunit :=  exists(d);

	return d;//active_workunit;

END;

SHARED GetActiveWUState(string wuname) := function

  valid_state :=['','unknown','submitted', 'compiling','compiled','blocked','running','wait','completed'];
	d := sort(nothor(WorkunitServices.WorkunitList('',NAMED jobname:=wuname ))(wuid <> thorlib.wuid() and state in valid_state), -wuid):independent;
	active_workunit :=  exists(d);

	return d;//active_workunit;

END;

EXPORT NonFCRA_Daily_Base_Build_ActiveWU    := GetActiveWU(Inql_v2._CRON_ECL('BASE BUILD', false, true).WU_NAME+' 2*')[1].wuid;
EXPORT NonFCRA_Daily_Base_Build_State       := GetActiveWUState(Inql_v2._CRON_ECL('BASE BUILD', false, true).WU_NAME+' 2*')[1].state;

EXPORT NonFCRA_Weekly_Base_Build_ActiveWU 	:= GetActiveWU(Inql_v2._CRON_ECL('BASE BUILD', false, false).WU_NAME+' 2*')[1].wuid;
EXPORT NonFCRA_Weekly_Base_Build_State 	    := GetActiveWUState(Inql_v2._CRON_ECL('BASE BUILD', false, false).WU_NAME+' 2*')[1].state;

EXPORT NonFCRA_Daily_Keys_Build_ActiveWU    := GetActiveWU(Inql_v2._CRON_ECL('KEYS BUILD', false, true).WU_NAME+' 2*')[1].wuid;
EXPORT NonFCRA_Daily_Keys_Build_State       := GetActiveWUState(Inql_v2._CRON_ECL('KEYS BUILD', false, true).WU_NAME+' 2*')[1].state;

EXPORT NonFCRA_Weekly_Keys_Build_ActiveWU   := GetActiveWU(Inql_v2._CRON_ECL('KEYS BUILD', false, false).WU_NAME+' 2*')[1].wuid;
EXPORT NonFCRA_Weekly_Keys_Build_State      := GetActiveWUState(Inql_v2._CRON_ECL('KEYS BUILD', false, false).WU_NAME+' 2*')[1].state;

EXPORT FCRA_Daily_Base_Build_ActiveWU       := GetActiveWU(Inql_v2._CRON_ECL('BASE BUILD', true, true).WU_NAME+' 2*')[1].wuid;
EXPORT FCRA_Daily_Base_Build_State          := GetActiveWUState(Inql_v2._CRON_ECL('BASE BUILD', true, true).WU_NAME+' 2*')[1].state;

EXPORT FCRA_Weekly_Base_Build_ActiveWU 		:= GetActiveWU(Inql_v2._CRON_ECL('BASE BUILD', true, false).WU_NAME+' 2*')[1].wuid;
EXPORT FCRA_Weekly_Base_Build_State   		:= GetActiveWUState(Inql_v2._CRON_ECL('BASE BUILD', true, false).WU_NAME+' 2*')[1].state;

EXPORT FCRA_Weekly_Keys_Build_ActiveWU    	:= GetActiveWU(Inql_v2._CRON_ECL('KEYS BUILD', true, false).WU_NAME+' 2*')[1].wuid;
EXPORT FCRA_Weekly_Keys_Build_State    	    := GetActiveWUState(Inql_v2._CRON_ECL('KEYS BUILD', true, false).WU_NAME+' 2*')[1].state;

END;



