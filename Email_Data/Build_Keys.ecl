import roxiekeybuild,autokey,doxie,strata,dops,DOPSGrowthCheck;

export Build_Keys (filedate) := function

// build index files
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(email_data.key_did, 
																					'~thor_200::key::email_data::@version@::did',  
																					'~thor_200::key::email_data::'+(string)filedate+'::did',       
																					email_data_did_key);
																					
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(email_data.key_did2, 
																					'~thor_200::key::email_data::@version@::did2',  
																					'~thor_200::key::email_data::'+(string)filedate+'::did2',       
																					email_data_did2_key);
																			 
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(email_data.key_email_address, 
																					 '~thor_200::key::email_data::@version@::email_addresses',  
																					 '~thor_200::key::email_data::'+(string)filedate+'::email_addresses', 
																					 email_data_email_address_key);
																					 
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(email_data.key_email_address2, 
																					 '~thor_200::key::email_data::@version@::email_addresses2',  
																					 '~thor_200::key::email_data::'+(string)filedate+'::email_addresses2', 
																					 email_data_email_address2_key);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Email_Data.Key_Did_FCRA,'~thor_200::key::email_data::fcra::@version@::did' ,'~thor_200::key::email_data::fcra::'+(string)filedate + '::did',fcra_key);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Email_Data.Key_Did2_FCRA,'~thor_200::key::email_data::fcra::@version@::did2' ,'~thor_200::key::email_data::fcra::'+(string)filedate + '::did2',fcra_did2_key);

// Move keys to build
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_200::key::email_data::@version@::did'
																			,'~thor_200::key::email_data::'+(string)filedate+'::did'
																			,mv_email_data_did_key);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_200::key::email_data::@version@::did2'
																			,'~thor_200::key::email_data::'+(string)filedate+'::did2'
																			,mv_email_data_did2_key);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_200::key::email_data::@version@::email_addresses'
																			,'~thor_200::key::email_data::'+filedate+'::email_addresses'
																			,mv_email_data_email_address_key);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_200::key::email_data::@version@::email_addresses2'
																			,'~thor_200::key::email_data::'+filedate+'::email_addresses2'
																			,mv_email_data_email_address2_key);

Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_200::key::email_data::fcra::@version@::did'    ,'~thor_200::key::email_data::fcra::'+(string)filedate + '::did',mv_fcra_key);

Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_200::key::email_data::fcra::@version@::did2'    ,'~thor_200::key::email_data::fcra::'+(string)filedate + '::did2',mv_fcra_did2_key);

// Move keys to QA
RoxieKeyBuild.MAC_SK_Move_v2('~thor_200::key::email_data::@version@::did', 'Q', mv_email_data_did_key_qa);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_200::key::email_data::@version@::did2', 'Q', mv_email_data_did2_key_qa);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_200::key::email_data::@version@::email_addresses', 'Q', mv_email_data_email_address_key_qa);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_200::key::email_data::@version@::email_addresses2', 'Q', mv_email_data_email_address2_key_qa);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_200::key::email_data::fcra::@version@::did', 'Q', mv_email_data_fcra_did_key_qa);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_200::key::email_data::fcra::@version@::did2', 'Q', mv_email_data_fcra_did2_key_qa);

build_keys := sequential(email_data_did_key,
                         // email_data_did2_key,
												 email_data_email_address_key,
												 // email_data_email_address2_key,
												 fcra_key,
												 // fcra_did2_key,
												 mv_email_data_did_key,
												 // mv_email_data_did2_key,
												 mv_email_data_email_address_key,
												 // mv_email_data_email_address2_key,
												 mv_fcra_key,
												 // mv_fcra_did2_key,
												 mv_email_data_did_key_qa,
												 // mv_email_data_did2_key_qa,
												 mv_email_data_email_address_key_qa,
												 // mv_email_data_email_address2_key_qa,
												 mv_email_data_fcra_did_key_qa,
												 // mv_email_data_fcra_did2_key_qa
												 );

build_autokeys := build_autokey((string) filedate);

// Move autokeys to QA
RoxieKeyBuild.MAC_SK_Move_v2('~thor_200::key::email_data::autokey::@version@::payload', 'Q', mv_autokey_payload);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_200::key::email_data::autokey::@version@::ssn2','Q',mv_autokey_ssn);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_200::key::email_data::autokey::@version@::Name','Q',mv_autokey_name);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_200::key::email_data::autokey::@version@::Address','Q',mv_autokey_addr);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_200::key::email_data::autokey::@version@::StName','Q',mv_autokey_stnam);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_200::key::email_data::autokey::@version@::CityStName','Q',mv_autokey_city);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_200::key::email_data::autokey::@version@::Zip','Q',mv_autokey_zip);


//Persistence and growth checks for FCRA keys.  Before strata.macf_pops to avoid conflict with globally scoped variable
file_date := (string)filedate; //required because filedate isn't declared as string
GetDops:=dops.GetDeployedDatasets('P','B','F');
OnlyEmailData:=GetDops(datasetname='FCRA_EmailDataKeys');
father_filedate := OnlyEmailData[1].buildversion;
set of string key_Email_Data_InputSet:=['did','clean_email','append_email_username','append_domain','append_domain_type','append_domain_root','append_domain_ext','append_is_tld_state','append_is_tld_generic','append_is_tld_country','append_is_valid_domain_ext','email_src','rec_src_all','email_src_all','email_src_num','num_email_per_did','num_did_per_email','orig_pmghousehold_id','orig_pmgindividual_id','orig_first_name','orig_last_name','orig_address','orig_city','orig_state','orig_zip','orig_zip4','orig_email','orig_ip','orig_login_date','orig_site','orig_e360_id','orig_teramedia_id','did_score','did_type','is_did_prop','hhid','append_rawaid','best_ssn','best_dob','process_date','activecode','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','current_rec'];
set of string key_Email_Persistence_Data_InputSet:=['orig_pmghousehold_id','orig_pmgindividual_id','orig_first_name','orig_last_name','orig_address','orig_city','orig_state','orig_zip','orig_zip4','orig_email','orig_ip','orig_site','orig_e360_id','orig_teramedia_id','activecode','email_src'];
DeltaCommands:=sequential(
DOPSGrowthCheck.CalculateStats('FCRA_EmailDataKeys','email_data.key_did','key_Email_Data','~thor_200::key::email_data::fcra::' + file_date + '::did','did','email_rec_key','','','','',file_date,father_filedate),
DOPSGrowthCheck.DeltaCommand('~thor_200::key::email_data::fcra::' + file_date + '::did','~thor_200::key::email_data::fcra::' + father_filedate + '::did','FCRA_EmailDataKeys','key_Email_Data','email_data.key_did','email_rec_key',file_date,father_filedate,key_Email_Data_InputSet),
DOPSGrowthCheck.ChangesByField('~thor_200::key::email_data::fcra::' + file_date + '::did','~thor_200::key::email_data::fcra::' + father_filedate + '::did','FCRA_EmailDataKeys','key_Email_Data','email_data.key_did','email_rec_key','',file_date,father_filedate),
DopsGrowthCheck.PersistenceCheck('~thor_200::key::email_data::fcra::' + file_date + '::did','~thor_200::key::email_data::fcra::' + father_filedate + '::did','FCRA_EmailDataKeys','key_Email_Data','email_data.key_did','email_rec_key',key_Email_Persistence_Data_InputSet,key_Email_Persistence_Data_InputSet,file_date,father_filedate)
);

// DF-21686 Show counts of blanked out fields in thor_200::key::email_data::fcra::qa::did
cnt_email_data_did_key_fcra := OUTPUT(strata.macf_pops(Email_Data.Key_Did_FCRA,,,,,,FALSE,['orig_ip']));





return sequential(sequential(build_autokeys,mv_autokey_payload,build_keys),
									parallel(mv_autokey_ssn,
													 mv_autokey_name,
													 mv_autokey_addr,
													 mv_autokey_stnam,
													 mv_autokey_city,
													 mv_autokey_zip),
									cnt_email_data_did_key_fcra,
									DeltaCommands
									);

end;