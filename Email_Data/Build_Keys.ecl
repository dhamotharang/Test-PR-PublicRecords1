import roxiekeybuild,autokey,doxie;

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


return sequential(sequential(build_autokeys,mv_autokey_payload,build_keys),
									parallel(mv_autokey_ssn,
													 mv_autokey_name,
													 mv_autokey_addr,
													 mv_autokey_stnam,
													 mv_autokey_city,
													 mv_autokey_zip) );

end;