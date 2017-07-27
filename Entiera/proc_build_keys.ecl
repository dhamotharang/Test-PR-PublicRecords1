import roxiekeybuild,autokey,doxie,entiera;

export proc_build_keys(string filedate) := function

// Using new standard for naming files
// build index files
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(entiera.key_entiera_did, 
																					'~thor_200::key::entiera::@version@::did',  
																					'~thor_200::key::entiera::'+filedate+'::did',       
																					entiera_did_key);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(entiera.key_entiera_household_id, 
																					 '~thor_200::key::entiera::@version@::household_id',  
																					 '~thor_200::key::entiera::'+filedate+'::household_id', 
																					 entiera_household_id_key);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(entiera.key_entiera_individual_id, 
																					 '~thor_200::key::entiera::@version@::individual_id',  
																					 '~thor_200::key::entiera::'+filedate+'::individual_id', 
																					 entiera_individual_id_key);
																					 
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(entiera.key_entiera_email_addresses, 
																					 '~thor_200::key::entiera::@version@::email_addresses',  
																					 '~thor_200::key::entiera::'+filedate+'::email_addresses', 
																					 entiera_email_address_key);




// Move keys to build
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_200::key::entiera::@version@::did'
																			,'~thor_200::key::entiera::'+filedate+'::did'
																			,mv_entiera_did_key);


RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_200::key::entiera::@version@::household_id'
																			,'~thor_200::key::entiera::'+filedate+'::household_id'
																			,mv_entiera_household_id_key);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_200::key::entiera::@version@::individual_id'
																			,'~thor_200::key::entiera::'+filedate+'::individual_id'
																			,mv_entiera_individual_id_key);


RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_200::key::entiera::@version@::email_addresses'
																			,'~thor_200::key::entiera::'+filedate+'::email_addresses'
																			,mv_entiera_email_address_key);



// Move keys to QA
RoxieKeyBuild.MAC_SK_Move_v2('~thor_200::key::entiera::@version@::did', 'Q', mv_entiera_did_key_qa);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_200::key::entiera::@version@::household_id', 'Q', mv_entiera_household_id_key_qa);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_200::key::entiera::@version@::individual_id', 'Q', mv_entiera_individual_id_key_qa);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_200::key::entiera::@version@::email_addresses', 'Q', mv_entiera_email_address_key_qa);


build_keys := sequential(entiera_did_key,
												 entiera_household_id_key,
												 entiera_individual_id_key,
												 entiera_email_address_key,
												 mv_entiera_did_key,
												 mv_entiera_household_id_key,
												 mv_entiera_individual_id_key,
												 mv_entiera_email_address_key,
												 mv_entiera_did_key_qa,
												 mv_entiera_household_id_key_qa,
												 mv_entiera_individual_id_key_qa,
												 mv_entiera_email_address_key_qa
												 );

build_autokeys := entiera.proc_build_autokey(filedate);

// Move autokeys to QA
RoxieKeyBuild.MAC_SK_Move_v2('~thor_200::key::entiera::autokey::@version@::payload', 'Q', mv_autokey_payload);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_200::key::entiera::autokey::@version@::ssn2','Q',mv_autokey_ssn);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_200::key::entiera::autokey::@version@::Name','Q',mv_autokey_name);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_200::key::entiera::autokey::@version@::Address','Q',mv_autokey_addr);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_200::key::entiera::autokey::@version@::StName','Q',mv_autokey_stnam);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_200::key::entiera::autokey::@version@::CityStName','Q',mv_autokey_city);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_200::key::entiera::autokey::@version@::Zip','Q',mv_autokey_zip);


return sequential(sequential(build_autokeys,mv_autokey_payload,build_keys),
									parallel(mv_autokey_ssn,
													 mv_autokey_name,
													 mv_autokey_addr,
													 mv_autokey_stnam,
													 mv_autokey_city,
													 mv_autokey_zip) );

end;
