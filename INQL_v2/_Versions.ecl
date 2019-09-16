Import STD, data_services, did_add, dops;

EXPORT _Versions := Module;

shared appd_weekly_base_version_regexp 		:= '([0-9]{8}[a-z]?_reappend)';
shared version_regexp 										:= '([0-9]{8}[a-z]?)';

EXPORT dops_fcra_keys_prod   							:= dops.Getbuildversion('FCRA_InquiryTableKeys','B','F','P','prod');
EXPORT dops_fcra_keys_certQA							:= dops.Getbuildversion('FCRA_InquiryTableKeys','B','F','C','prod');

EXPORT dops_nonfcra_update_keys_prod			:= dops.Getbuildversion('InquiryTableUpdateKeys','B','N','P','prod');
EXPORT dops_nonfcra_update_keys_certQA		:= dops.Getbuildversion('InquiryTableUpdateKeys','B','N','C','prod');

EXPORT dops_nonfcra_keys_prod							:= dops.Getbuildversion('InquiryTableKeys','B','N','P','prod');
EXPORT dops_nonfcra_keys_certQA						:= dops.Getbuildversion('InquiryTableKeys','B','N','C','prod');

shared nonfcra_appd_weekly_base_file 			:= nothor(fileservices.superfilecontents(Data_Services.foreign_prod+'thor_data400::out::inquiry_tracking::weekly_historical')[1].name);
EXPORT nonfcra_appd_weekly_base 					:= STD.Str.FindReplace(regexfind(appd_weekly_base_version_regexp, nonfcra_appd_weekly_base_file,1),'_reappend','');

shared nonfcra_cur_history_base_file			:= nothor(fileservices.superfilecontents(INQL_v2.Filenames(,pFCRA:=false, pDaily:=false).INQL_Base.QA)[1].name);
EXPORT nonfcra_history_base 							:= regexfind(version_regexp, nonfcra_cur_history_base_file,1);
		
shared nonfcra_did_key_file 							:= nothor(fileservices.superfilecontents(Inql_V2.Keynames(isUpdate:=false,isFCRA:=false).DID.QA)[1].name);
EXPORT thor_nonfcra_keys  								:= regexfind(version_regexp, nonfcra_did_key_file,1);	

shared nonfcra_daily_base_file						:= sort(nothor(fileservices.superfilecontents(INQL_v2.Filenames(,pFCRA:=false, pDaily:=true).INQL_Base.QA)),-name)[1].name;
EXPORT nonfcra_daily_base 								:= regexfind(version_regexp, nonfcra_daily_base_file,1);	

EXPORT nonfcra_daily_base_files						:= nothor(fileservices.superfilecontents(INQL_v2.Filenames(,pFCRA:=false, pDaily:=true).INQL_Base.QA));

shared nonfcra_did_update_key_file 				:= nothor(fileservices.superfilecontents(Inql_V2.Keynames(isUpdate:=true,isFCRA:=false).DID.QA))[1].name;
EXPORT thor_nonfcra_update_keys 					:= regexfind(version_regexp, nonfcra_did_update_key_file,1);	

shared fcra_daily_base_file								:= sort(nothor(fileservices.superfilecontents(INQL_v2.Filenames(,pFCRA:=true, pDaily:=true).INQL_Base.QA)),-name)[1].name;
EXPORT fcra_daily_base 										:= regexfind(version_regexp, fcra_daily_base_file,1);	

shared fcra_history_base_file							:= sort(nothor(fileservices.superfilecontents(INQL_v2.Filenames(,pFCRA:=true, pDaily:=false).INQL_Base.QA)),-name)[1].name;
EXPORT fcra_history_base									:= regexfind(version_regexp, fcra_history_base_file,1);	

shared fcra_did_key_file 									:= nothor(fileservices.superfilecontents(Inql_V2.Keynames(isUpdate:=false,isFCRA:=true).DID.QA))[1].name;
EXPORT thor_fcra_keys 										:= regexfind(version_regexp, fcra_did_key_file,1);

shared nonfcra_last_accurint_file					:= sort(nothor(fileservices.superfilecontents(INQL_v2.Superfile_List(false).accurint_bldg)),-name)[1].name;
Export nonfcra_last_accurint_processed		:= regexfind(version_regexp, nonfcra_last_accurint_file,1);	

shared fcra_last_accurint_file						:= sort(nothor(fileservices.superfilecontents(INQL_v2.Superfile_List(true).accurint_bldg)),-name)[1].name;
Export fcra_last_accurint_processed		  	:= regexfind(version_regexp, nonfcra_last_accurint_file,1);	

shared nonfcra_next_batch_file					  := sort(nothor(fileservices.superfilecontents(INQL_v2.Superfile_List(false).batch_bldg)),-name)[1].name;
Export nonfcra_next_daily_base 						:= regexfind(version_regexp, nonfcra_next_batch_file,1);	

shared fcra_next_batch_file					  		:= sort(nothor(fileservices.superfilecontents(INQL_v2.Superfile_List(true).batch_bldg)),-name)[1].name;
Export fcra_next_daily_base 							:= regexfind(version_regexp, fcra_next_batch_file,1);	


shared GetActiveWU (string wuname =''):= function
				 valid_state := ['','unknown','submitted', 'compiling','compiled','blocked','running','wait'];
				 d := sort(nothor(WorkunitServices.WorkunitList('',NAMED jobname:=wuname))(wuid <> thorlib.wuid() and state in valid_state), -wuid):independent;
				 return d[1].wuid;
END;

export 	FCRA_Daily_Base_Build_ActiveWU 			:= GetActiveWU(INQL_v2._Constants.FCRA_DAILY_BLD_SCHEDULERNAME + ' BASE*');

export 	FCRA_Weekly_Base_Build_ActiveWU 		:= GetActiveWU(INQL_v2._Constants.FCRA_WEEKLY_BLD_SCHEDULERNAME + ' BASE*');

export 	NonFCRA_Daily_Base_Build_ActiveWU 	:= GetActiveWU(INQL_v2._Constants.NON_FCRA_DAILY_BLD_SCHEDULERNAME + ' BASE*');

export 	NonFCRA_Weekly_Base_Build_ActiveWU 	:= GetActiveWU(INQL_v2._Constants.NON_FCRA_WEEKLY_BLD_SCHEDULERNAME + ' BASE*');

export 	FCRA_Weekly_Keys_Build_ActiveWU   	:= GetActiveWU(INQL_v2._Constants.FCRA_DAILY_BLD_SCHEDULERNAME + ' KEYS*');

export 	NonFCRA_Weekly_Keys_Build_ActiveWU  := GetActiveWU(INQL_v2._Constants.NON_FCRA_WEEKLY_BLD_SCHEDULERNAME + ' KEYS*');

export 	NonFCRA_Daily_Keys_Build_ActiveWU  	:= GetActiveWU(INQL_v2._Constants.NON_FCRA_DAILY_BLD_SCHEDULERNAME + ' KEYS*');
	

end;