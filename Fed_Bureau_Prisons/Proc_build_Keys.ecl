//
import roxiekeybuild,autokey,doxie;

export Proc_build_Keys (filedate) := function

// build index files
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(email_data.key_did, 
																					'~thor_200::key::email_data::@version@::did',  
																					'~thor_200::key::email_data::'+(string)filedate+'::did',       
																					build_email_data_did_key);
																					
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Email_Data.Key_Did_FCRA,
                                           '~thor_200::key::email_data::fcra::@version@::did' ,
																					 '~thor_200::key::email_data::fcra::'+(string)filedate + '::did'
																					 ,build_fcra_key);

// Move keys to built
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_200::key::email_data::@version@::did'
																			,'~thor_200::key::email_data::'+(string)filedate+'::did'
																			,mv_email_data_did_key_built);

Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_200::key::email_data::fcra::@version@::did'
                                      ,'~thor_200::key::email_data::fcra::'+(string)filedate + '::did'
																			,mv_fcra_key_built);

// Move keys to QA
RoxieKeyBuild.MAC_SK_Move_v2('~thor_200::key::email_data::@version@::did', 'Q', mv_email_data_did_key_qa);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_200::key::email_data::fcra::@version@::did', 'Q', mv_email_data_fcra_did_key_qa);


// Build autokeys
build_autokeys := build_autokey((string) filedate);

// Move autokeys to QA
RoxieKeyBuild.MAC_SK_Move_v2('~thor_200::key::email_data::autokey::@version@::payload', 'Q', mv_autokey_payload);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_200::key::email_data::autokey::@version@::ssn2','Q',mv_autokey_ssn);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_200::key::email_data::autokey::@version@::Name','Q',mv_autokey_name);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_200::key::email_data::autokey::@version@::Address','Q',mv_autokey_addr);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_200::key::email_data::autokey::@version@::StName','Q',mv_autokey_stnam);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_200::key::email_data::autokey::@version@::CityStName','Q',mv_autokey_city);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_200::key::email_data::autokey::@version@::Zip','Q',mv_autokey_zip);

return sequential(build_autokeys,
                  mv_autokey_payload
									mv_autokey_ssn,
									mv_autokey_name,
									mv_autokey_addr,
									mv_autokey_stnam,
									mv_autokey_city,
									mv_autokey_zip
									build_email_data_did_key,
									build_fcra_key,
									mv_email_data_did_key_built,
									mv_fcra_key_built,
									mv_email_data_did_key_qa,
									mv_email_data_fcra_did_key_qa
									);

end;