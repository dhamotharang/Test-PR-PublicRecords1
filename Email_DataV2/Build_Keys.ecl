IMPORT dx_Email, roxiekeybuild, autokey, doxie, strata, dops, DOPSGrowthCheck;

EXPORT Build_Keys (filedate) := FUNCTION

// build index files
RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_email.Key_Did(),																//index
																					Email_DataV2.Files.DID_File,															//dataset
																					'~thor_200::key::email_datav2::@version@::did', 					//superfile 
																					'~thor_200::key::email_datav2::'+(string)filedate+'::did', //key logical file      
																					email_data_did_key);
																					
RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_email.Key_Email_Address,
																					 Email_DataV2.Files.Email_Address_File, 
																					 '~thor_200::key::email_datav2::@version@::email_addresses',  
																					 '~thor_200::key::email_datav2::'+(string)filedate+'::email_addresses', 
																					 email_data_email_address_key);
																					
RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_email.Key_email_payload(),
																					 Email_DataV2.Files.Email_Base,
																					 '~thor_200::key::email_dataV2::@version@::payload',  
																					 '~thor_200::key::email_dataV2::'+(string)filedate+'::payload', 
																					 email_data_payload_key);

RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_email.Key_Did(TRUE),
																					 Email_dataV2.Files.DID_FCRA,
																					 '~thor_200::key::email_datav2::fcra::@version@::did',
																					 '~thor_200::key::email_datav2::fcra::'+(string)filedate + '::did',
																					 fcra_did_key);

RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_email.Key_email_payload(TRUE),
																					 Email_DataV2.Files.DID_FCRA,
																					 '~thor_200::key::email_dataV2::fcra::@version@::payload',
																					 '~thor_200::key::email_dataV2::fcra::'+(string)filedate + '::payload',
																					 fcra_payload_key);


// Move keys to build
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_200::key::email_datav2::@version@::did'
																			,'~thor_200::key::email_datav2::'+(string)filedate+'::did'
																			,mv_email_data_did_key);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_200::key::email_datav2::@version@::email_addresses'
																			,'~thor_200::key::email_datav2::'+filedate+'::email_addresses'
																			,mv_email_data_email_address_key);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_200::key::email_dataV2::@version@::payload'
																			,'~thor_200::key::email_dataV2::'+filedate+'::payload'
																			,mv_email_data_payload_key);

Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_200::key::email_datav2::fcra::@version@::did'    ,'~thor_200::key::email_datav2::fcra::'+(string)filedate + '::did',mv_fcra_did_key);

Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_200::key::email_dataV2::fcra::@version@::payload', '~thor_200::key::email_dataV2::fcra::'+(string)filedate + '::payload',mv_fcra_payload_key);


// Move keys to QA
RoxieKeyBuild.MAC_SK_Move_v2('~thor_200::key::email_dataV2::@version@::did', 'Q', mv_email_data_did_key_qa);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_200::key::email_dataV2::@version@::email_addresses', 'Q', mv_email_data_email_address_key_qa);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_200::key::email_dataV2::@version@::payload', 'Q', mv_email_data_payload_key_qa);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_200::key::email_dataV2::fcra::@version@::did', 'Q', mv_email_data_fcra_did_key_qa);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_200::key::email_dataV2::fcra::@version@::linkids', 'Q', mv_fcra_payload_key_qa);

build_keys := sequential(email_data_did_key,
												 email_data_email_address_key,
												 email_data_payload_key,
												 fcra_did_key,
												 fcra_payload_key,
												 mv_email_data_did_key,
												 mv_email_data_email_address_key,
												 mv_email_data_payload_key,
												 mv_fcra_did_key,
												 mv_fcra_payload_key,
												 mv_email_data_did_key_qa,
												 mv_email_data_email_address_key_qa,
												 mv_email_data_payload_key_qa,
												 mv_email_data_fcra_did_key_qa,
												 mv_fcra_payload_key_qa
												 );

build_autokeys := build_autokey((string) filedate);

// Move autokeys to QA
RoxieKeyBuild.Mac_SK_Move_V2('~thor_200::key::email_datav2::autokey::@version@::ssn2','Q',mv_autokey_ssn);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_200::key::email_datav2::autokey::@version@::Name','Q',mv_autokey_name);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_200::key::email_datav2::autokey::@version@::Address','Q',mv_autokey_addr);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_200::key::email_datav2::autokey::@version@::StName','Q',mv_autokey_stnam);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_200::key::email_datav2::autokey::@version@::CityStName','Q',mv_autokey_city);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_200::key::email_datav2::autokey::@version@::Zip','Q',mv_autokey_zip);

//Persistence and growth checks for FCRA keys.  Before strata.macf_pops to avoid conflict with globally scoped variable
/*file_date := (string)filedate; //required because filedate isn't declared as string
GetDops:=dops.GetDeployedDatasets('P','B','F');
OnlyEmailData:=GetDops(datasetname='FCRA_EmailDataV2Keys');
father_filedate := OnlyEmailData[1].buildversion;
set of string key_Email_Data_InputSet:=['did','clean_email','append_email_username','append_domain','append_domain_type','append_domain_root','append_domain_ext','append_is_tld_state','append_is_tld_generic','append_is_tld_country','append_is_valid_domain_ext','email_src','orig_pmghousehold_id','orig_pmgindividual_id','orig_first_name','orig_last_name','orig_address','orig_city','orig_state','orig_zip','orig_zip4','orig_email','orig_ip','orig_login_date','orig_site','orig_e360_id','orig_teramedia_id','orig_phone','orig_ssn','orig_dob','did_score','did_type','is_did_prop','hhid','append_rawaid','clean_phone','clean_ssn','clean_dob','process_date','activecode','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','current_rec,'orig_CompanyName','cln_CompanyName','CompanyTitle','rules'];
set of string key_Email_Persistence_Data_InputSet:=['orig_pmghousehold_id','orig_pmgindividual_id','orig_first_name','orig_last_name','orig_address','orig_city','orig_state','orig_zip','orig_zip4','clean_email','orig_site','orig_e360_id','orig_teramedia_id','activecode','email_src'];
DeltaCommands:=sequential(
DOPSGrowthCheck.CalculateStats('FCRA_EmailDataV2Keys','dx_email.Key_email_payload(TRUE)','key_Email_DataV2','~thor_200::key::email_dataV2::fcra::' + file_date + '::payload','payload','email_rec_key','','','','',file_date,father_filedate),
DOPSGrowthCheck.DeltaCommand('~thor_200::key::email_dataV2::fcra::' + file_date + '::payload','~thor_200::key::email_dataV2::fcra::' + father_filedate + '::payload','FCRA_EmailDataKeys','key_Email_Data','dx_email.Key_email_payload(TRUE)','email_rec_key',file_date,father_filedate,key_Email_Data_InputSet),
DOPSGrowthCheck.ChangesByField('~thor_200::key::email_dataV2::fcra::' + file_date + '::payload','~thor_200::key::email_dataV2::fcra::' + father_filedate + '::payload','FCRA_EmailDataKeys','key_Email_Data','dx_email.Key_email_payload(TRUE)','email_rec_key','',file_date,father_filedate),
DopsGrowthCheck.PersistenceCheck('~thor_200::key::email_dataV2::fcra::' + file_date + '::payload','~thor_200::key::email_dataV2::fcra::' + father_filedate + '::payload','FCRA_EmailDataKeys','key_Email_Data','dx_email.Key_email_payload(TRUE)','email_rec_key',key_Email_Persistence_Data_InputSet,key_Email_Persistence_Data_InputSet,file_date,father_filedate)
);

// DF-21686 Show counts of blanked out fields in thor_200::key::email_datav2::fcra::qa::payload
cnt_email_data_payload_key_fcra := OUTPUT(strata.macf_pops((dx_email.Key_email_payload(TRUE),,,,,,FALSE,['orig_ip']));
*/


return sequential(sequential(build_autokeys,build_keys),
									parallel(mv_autokey_ssn,
													 mv_autokey_name,
													 mv_autokey_addr,
													 mv_autokey_stnam,
													 mv_autokey_city,
													 mv_autokey_zip)
									// ,cnt_email_data_payload_key_fcra
									// ,DeltaCommands
									);

end;