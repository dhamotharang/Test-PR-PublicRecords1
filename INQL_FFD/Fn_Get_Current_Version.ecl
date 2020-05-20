Import STD, data_services, did_add, dops;

// Get the current version of keys, base and input files
EXPORT fn_Get_Current_Version := Module;

shared version_regexp 										:= '([0-9]{8}[a-z]?)';

shared fcra_full_keys_dops_prod_lgfile 		:= dops.GetKeysByDataset('FCRA_InquiryHistoryKeys','B','F','P')
																																	(updateFlag='F' and superkey='thor_data::key::inquiryhistory::fcra::qa::lexid')[1].logicalkey;
EXPORT fcra_full_keys_dops_prod						:= regexfind(version_regexp,fcra_full_keys_dops_prod_lgfile,1);

shared fcra_full_keys_dops_certQA_lgfile  := dops.GetKeysByDataset('FCRA_InquiryHistoryKeys','B','F','Q')
																																	(updateFlag='F' and superkey='thor_data::key::inquiryhistory::fcra::qa::lexid')[1].logicalkey;
EXPORT fcra_full_keys_dops_certQA					:= regexfind(version_regexp,fcra_full_keys_dops_certQA_lgfile,1);

shared fcra_keys_dops_prod_lgfile 				:= dops.GetKeysByDataset('FCRA_InquiryHistoryKeys','B','F','P')
																																	(updateFlag='DR' and superkey='thor_data::key::inquiryhistory::fcra::qa::lexid')[1].logicalkey;
EXPORT fcra_keys_dops_prod								:= regexfind(version_regexp,fcra_keys_dops_prod_lgfile,1);

shared fcra_keys_dops_certQA_lgfile  			:= dops.GetKeysByDataset('FCRA_InquiryHistoryKeys','B','F','Q')
																																	(updateFlag='DR' and superkey='thor_data::key::inquiryhistory::fcra::qa::lexid')[1].logicalkey;
EXPORT fcra_keys_dops_certQA							:= regexfind(version_regexp,fcra_keys_dops_certQA_lgfile,1);

shared fcra_daily_base_file								:= sort(nothor(fileservices.superfilecontents(Inql_FFD.Filenames().Base.QA)),-name)[1].name;
EXPORT fcra_daily_base 										:= regexfind(version_regexp, fcra_daily_base_file,1);	

shared fcra_weekly_base_file							:= sort(nothor(fileservices.superfilecontents(Inql_FFD.Filenames(false).Base.QA)),-name)[1].name;
EXPORT fcra_weekly_base 									:= regexfind(version_regexp, fcra_weekly_base_file,1);	

shared fcra_did_key_file 									:= nothor(fileservices.GetSuperFileSubName(Inql_FFD.Keynames().Lexid.QA, 2));
EXPORT fcra_keys										  		:= regexfind(version_regexp, fcra_did_key_file,1);

shared fcra_did_full_key_file 						:= nothor(fileservices.GetSuperFileSubName(Inql_FFD.Keynames().Lexid.QA, 1));
EXPORT fcra_full_keys										  := regexfind(version_regexp, fcra_did_full_key_file,1);

shared fcra_input_file 										:= sort(nothor(fileservices.superfilecontents(Inql_FFD.Filenames().InputBuilding)),-name)[1].name;
EXPORT fcra_input													:= regexfind(version_regexp, fcra_input_file,1);	

EXPORT fcra_last_key_dops_prod            := if(fcra_keys_dops_prod > fcra_full_keys_dops_prod, fcra_keys_dops_prod, fcra_full_keys_dops_prod);

end;