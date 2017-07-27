import roxiekeybuild,autokey,doxie;

export proc_build_all_keys(string filedate) := function
/*
This uses the ATF and Entiera Module build_keys as a template.
Keys built here are:
       did, 
			 bookings_id(booking_sid with bookings record as payload)
			 charges_id(booking_sid,charge_seq with charges record as payload)
			 and all AUTOKEYS ie 
			  payload,
				name,address,citystname,stname,ssn and zip
*/
// Using new standard for naming files
// build index files
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(key_appriss_did, 
																					 '~thor_200::key::appriss::@version@::did',  
																					 '~thor_200::key::appriss::'+filedate+'::did',       
																					 appriss_did_key);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(key_bookings_record, 
																					 '~thor_200::key::appriss::@version@::bookings_id',  
																					 '~thor_200::key::appriss::'+filedate+'::bookings_id', 
																					 appriss_bookings_id_key);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(key_charges_record, 
																					 '~thor_200::key::appriss::@version@::charges_id',  
																					 '~thor_200::key::appriss::'+filedate+'::charges_id', 
																					 appriss_charges_id_key);
											
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Key_prep_DL, 
																					 '~thor_200::key::appriss::@version@::dl',  
																					 '~thor_200::key::appriss::'+filedate+'::dl', 
																					 appriss_DL_key);		
																					 
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Key_prep_fbi, 
																					 '~thor_200::key::appriss::@version@::fbi',  
																					 '~thor_200::key::appriss::'+filedate+'::fbi', 
																					 appriss_fbi_key);	

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Key_prep_state_id, 
																					 '~thor_200::key::appriss::@version@::state_id',  
																					 '~thor_200::key::appriss::'+filedate+'::state_id', 
																					 appriss_state_id_key);
																					 
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Key_prep_gang, 
																					 '~thor_200::key::appriss::@version@::gang',  
																					 '~thor_200::key::appriss::'+filedate+'::gang', 
																					 appriss_gang_key);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Key_prep_demographic, 
																					 '~thor_200::key::appriss::@version@::demographic',  
																					 '~thor_200::key::appriss::'+filedate+'::demographic', 
																					 appriss_demographic_key);
																					 
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Key_prep_Agencyori_StateCd, 
																					 '~thor_200::key::appriss::@version@::AgencyStateCd',  
																					 '~thor_200::key::appriss::'+filedate+'::AgencyStateCd', 
																					 appriss_AgencyStateCd_key);																					 

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Key_prep_ap_ssn, 
																					 '~thor_200::key::appriss::@version@::ap_ssn',  
																					 '~thor_200::key::appriss::'+filedate+'::ap_ssn', 
																					 appriss_ap_ssn_key);																						 
// Move keys to built
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_200::key::appriss::@version@::did'
																			,'~thor_200::key::appriss::'+filedate+'::did'
																			,mv_appriss_did_key);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_200::key::appriss::@version@::bookings_id'
																			,'~thor_200::key::appriss::'+filedate+'::bookings_id'
																			,mv_appriss_bookings_id_key);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_200::key::appriss::@version@::charges_id'
																			,'~thor_200::key::appriss::'+filedate+'::charges_id'
																			,mv_appriss_charges_id_key);
																			
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_200::key::appriss::@version@::dl',  
																			'~thor_200::key::appriss::'+filedate+'::dl', 
																			 mv_appriss_DL_key);		
																					 
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_200::key::appriss::@version@::fbi',  
																			'~thor_200::key::appriss::'+filedate+'::fbi', 
																			 mv_appriss_fbi_key);		
																			
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_200::key::appriss::@version@::state_id',  
																			'~thor_200::key::appriss::'+filedate+'::state_id', 
																			 mv_appriss_state_id_key);																			
																					 
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_200::key::appriss::@version@::gang',  
																			'~thor_200::key::appriss::'+filedate+'::gang', 
																			 mv_appriss_gang_key);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_200::key::appriss::@version@::demographic',  
																			'~thor_200::key::appriss::'+filedate+'::demographic', 
																			 mv_appriss_demographic_key);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_200::key::appriss::@version@::AgencyStateCd',  
																			'~thor_200::key::appriss::'+filedate+'::AgencyStateCd', 
																			 mv_appriss_AgencyStateCd_key);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_200::key::appriss::@version@::ap_ssn',  
																			'~thor_200::key::appriss::'+filedate+'::ap_ssn', 
																			 mv_appriss_ap_ssn_key);
// Move keys to QA
RoxieKeyBuild.MAC_SK_Move_v2('~thor_200::key::appriss::@version@::did', 'Q', mv_appriss_did_key_qa);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_200::key::appriss::@version@::bookings_id', 'Q', mv_appriss_bookings_id_key_qa);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_200::key::appriss::@version@::charges_id', 'Q', mv_appriss_charges_id_key_qa);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_200::key::appriss::@version@::dl','Q',mv_appriss_DL_key_qa);		
RoxieKeyBuild.MAC_SK_Move_v2('~thor_200::key::appriss::@version@::fbi','Q',mv_appriss_fbi_key_qa);			
RoxieKeyBuild.MAC_SK_Move_v2('~thor_200::key::appriss::@version@::state_id','Q',mv_appriss_state_id_key_qa);		
RoxieKeyBuild.MAC_SK_Move_v2('~thor_200::key::appriss::@version@::gang','Q', mv_appriss_gang_key_qa);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_200::key::appriss::@version@::demographic','Q', mv_appriss_demographic_key_qa);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_200::key::appriss::@version@::AgencyStateCd','Q', mv_appriss_AgencyStateCd_key_qa);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_200::key::appriss::@version@::ap_ssn','Q', mv_appriss_ap_ssn_key_qa);

build_keys := sequential(appriss_did_key,
                         proc_generate_bookings_payload,
												 appriss_bookings_id_key,
												 proc_generate_charges_payload,
												 appriss_charges_id_key,
												 appriss_DL_key,
												 appriss_fbi_key,
												 appriss_state_id_key,
												 appriss_gang_key,
												 appriss_demographic_key,
												 appriss_AgencyStateCd_key,
												 appriss_ap_ssn_key,
												 
												 mv_appriss_did_key,
												 mv_appriss_bookings_id_key,
												 mv_appriss_charges_id_key,
												 mv_appriss_DL_key,
												 mv_appriss_fbi_key,
												 mv_appriss_state_id_key,
                         mv_appriss_gang_key,
												 mv_appriss_demographic_key,
												 mv_appriss_AgencyStateCd_key,
                         mv_appriss_ap_ssn_key,

												 mv_appriss_did_key_qa,
												 mv_appriss_bookings_id_key_qa,
												 mv_appriss_charges_id_key_qa,
												 mv_appriss_DL_key_qa,
												 mv_appriss_fbi_key_qa,
									       mv_appriss_state_id_key_qa,
												 mv_appriss_gang_key_qa,
												 mv_appriss_demographic_key_qa,
												 mv_appriss_AgencyStateCd_key_qa,
												 mv_appriss_ap_ssn_key_qa
												 );

build_autokeys := appriss.proc_build_autokey(filedate);

// Move autokeys to QA
RoxieKeyBuild.MAC_SK_Move_v2('~thor_200::key::appriss::autokey::@version@::payload', 'Q', mv_autokey_payload);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_200::key::appriss::autokey::@version@::ssn2','Q',mv_autokey_ssn);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_200::key::appriss::autokey::@version@::Name','Q',mv_autokey_name);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_200::key::appriss::autokey::@version@::Address','Q',mv_autokey_addr);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_200::key::appriss::autokey::@version@::StName','Q',mv_autokey_stnam);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_200::key::appriss::autokey::@version@::CityStName','Q',mv_autokey_city);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_200::key::appriss::autokey::@version@::Zip','Q',mv_autokey_zip);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_200::key::appriss::autokey::@version@::phone2','Q',mv_autokey_homephone);
//RoxieKeyBuild.Mac_SK_Move_V2('~thor_200::key::appriss::autokey::@version@::phone','Q',mv_autokey_workphone);


return sequential(sequential(build_autokeys,mv_autokey_payload,build_keys),
									parallel(mv_autokey_ssn,
													 mv_autokey_name,
													 mv_autokey_addr,
													 mv_autokey_stnam,
													 mv_autokey_city,
													 mv_autokey_zip,
													 mv_autokey_homephone//,
													 //mv_autokey_workphone
													 ) );


end;