Import STD, data_services;

EXPORT fnGetCurrentVersion := Module;

shared appd_weekly_base_version_regexp 		:= '([0-9]{8}[a-z]?_reappend)';
shared version_regexp 										:= '([0-9]{8}[a-z]?)';

shared nonfcra_appd_weekly_base_file 			:= nothor(fileservices.superfilecontents(Data_Services.foreign_prod+'thor_data400::out::inquiry_tracking::weekly_historical')[1].name);
EXPORT nonfcra_appd_weekly_base_version 	:= STD.Str.FindReplace(regexfind(appd_weekly_base_version_regexp, nonfcra_appd_weekly_base_file,1),'_reappend','');

shared nonfcra_cur_weekly_base_file				:= nothor(fileservices.superfilecontents(Data_Services.foreign_logs+'thor100_21::out::inquiry_tracking::weekly_historical')[1].name);
EXPORT nonfcra_weekly_base_version 				:= regexfind(version_regexp, nonfcra_cur_weekly_base_file,1);
		
shared nonfcra_did_weekly_key_file 				:= nothor(fileservices.superfilecontents(Data_Services.foreign_prod+'thor_data400::key::inquiry_table::did_qa')[1].name);
EXPORT nonfcra_weekly_key_version 				:= regexfind(version_regexp, nonfcra_did_weekly_key_file,1);	

shared nonfcra_daily_base_file						:= sort(nothor(fileservices.superfilecontents(Data_Services.foreign_logs+'thor100_21::base::accurint_acclogs_common')),-name)[1].name;
EXPORT nonfcra_daily_base_version 				:= regexfind(version_regexp, nonfcra_daily_base_file,1);	

shared nonfcra_did_daily_key_file 				:= nothor(fileservices.superfilecontents(Data_Services.foreign_prod+'thor_data400::key::inquiry_table::qa::did_update'))[1].name;
EXPORT nonfcra_daily_key_version 					:= regexfind(version_regexp, nonfcra_did_daily_key_file,1);	

shared fcra_base_file											:= sort(nothor(fileservices.superfilecontents(Data_Services.foreign_fcra_logs+'thor10_231::base::accurint_acclogs_common')),-name)[1].name;
EXPORT fcra_base_version 									:= regexfind(version_regexp, fcra_base_file,1);	

shared fcra_did_key_file 									:= nothor(fileservices.superfilecontents(Data_Services.foreign_prod+'thor_data400::key::inquiry_table::fcra::did_qa'))[1].name;
EXPORT fcra_key_version 									:= regexfind(version_regexp, fcra_did_key_file,1);	

end;