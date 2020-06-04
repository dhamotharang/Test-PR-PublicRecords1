IMPORT ut,RoxieKeyBuild,AutoKeyB2,PRTE,_control, PRTE2_RiskTable,PRTE2_Common;

EXPORT proc_build_keys(string filedate) := FUNCTION

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_address_table_v4,
		'~prte::key::death_master::@version@::address_table_v4',
		'~prte::key::death_master::' + filedate + '::address_table_v4', build_key_death_master_address_table_v4);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_addr_name,
		'~prte::key::death_master::@version@::addr_name',
		'~prte::key::death_master::' + filedate + '::addr_name', build_key_death_master_addr_name);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_adl_risk_table_v4(false),
		'~prte::key::death_master::@version@::adl_risk_table_v4',
		'~prte::key::death_master::' + filedate + '::adl_risk_table_v4', build_key_death_master_adl_risk_table_v4);
		
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_adl_risk_table_v4(true),
		'~prte::key::death_master::fcra::@version@::adl_risk_table_v4_filtered',
		'~prte::key::death_master::fcra::' + filedate + '::adl_risk_table_v4_filtered', build_key_death_masterfcra_adl_risk_table_v4_filtered);


	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_phone_addr,
		'~prte::key::death_master::@version@::phone_addr',
		'~prte::key::death_master::' + filedate + '::phone_addr', build_key_death_master_phone_addr);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_phone_lname,
		'~prte::key::death_master::@version@::phone_lname',
		'~prte::key::death_master::' + filedate + '::phone_lname', build_key_death_master_phone_lname);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_ssn_addr,
		'~prte::key::death_master::@version@::ssn_addr',
		'~prte::key::death_master::' + filedate + '::ssn_addr', build_key_death_master_ssn_addr);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_ssn_name,
		'~prte::key::death_master::@version@::ssn_name',
		'~prte::key::death_master::' + filedate + '::ssn_name', build_key_death_master_ssn_name);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_ssn_table_v4_2,
		'~prte::key::death_master::@version@::ssn_table_v4_2',
		'~prte::key::death_master::' + filedate + '::ssn_table_v4_2', build_key_death_master_ssn_table_v4_2);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_ssn_table_v4_filtered,
		'~prte::key::death_master::fcra::@version@::ssn_table_v4_filtered',
		'~prte::key::death_master::fcra::' + filedate + '::ssn_table_v4_filtered', build_key_death_masterfcra_ssn_table_v4_filtered);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_suspicious_identities,
		'~prte::key::death_master::@version@::suspicious_identities',
		'~prte::key::death_master::' + filedate + '::suspicious_identities', build_key_death_master_suspicious_identities);


// start of 10 new keys for shell 5.3
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Keys.key_ssn_name_summary,
		'~prte::key::death_master::@version@::ssn_name_summary', 
		'~prte::key::death_master::' + filedate + '::ssn_name_summary',a16);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Keys.key_ssn_addr_summary,
		'~prte::key::death_master::@version@::ssn_addr_summary', 
		'~prte::key::death_master::' + filedate + '::ssn_addr_summary',a17);
											
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Keys.key_ssn_dob_summary,
		'~prte::key::death_master::@version@::ssn_dob_summary', 
		'~prte::key::death_master::' + filedate + '::ssn_dob_summary',a18);	
	
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Keys.key_ssn_phone_summary,
		'~prte::key::death_master::@version@::ssn_phone_summary', 
		'~prte::key::death_master::' + filedate + '::ssn_phone_summary',a19);	

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Keys.key_phone_dob_summary,
		'~prte::key::death_master::@version@::phone_dob_summary', 
		'~prte::key::death_master::' + filedate + '::phone_dob_summary',a20);	

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Keys.key_addr_name_summary,
		'~prte::key::death_master::@version@::addr_name_summary', 
		'~prte::key::death_master::' + filedate + '::addr_name_summary',a21);	

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Keys.key_addr_dob_summary,
		'~prte::key::death_master::@version@::addr_dob_summary', 
		'~prte::key::death_master::' + filedate + '::addr_dob_summary',a22);	
											
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Keys.key_name_dob_summary,
		'~prte::key::death_master::@version@::name_dob_summary', 
		'~prte::key::death_master::' + filedate + '::name_dob_summary',a23);	
											
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Keys.key_phone_addr_summary,
		'~prte::key::death_master::@version@::phone_addr_summary', 
		'~prte::key::death_master::' + filedate + '::phone_addr_summary',a24);	

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Keys.key_phone_lname_summary,
		'~prte::key::death_master::@version@::phone_lname_summary', 
		'~prte::key::death_master::' + filedate + '::phone_lname_summary',a25);												

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Keys.key_phone_addr_header_summary,
		'~prte::key::death_master::@version@::phone_addr_header_summary', 
		'~prte::key::death_master::' + filedate + '::phone_addr_header_summary',a26);	

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Keys.key_phone_lname_header_summary,
		'~prte::key::death_master::@version@::phone_lname_header_summary', 
		'~prte::key::death_master::' + filedate + '::phone_lname_header_summary',a27);	
											

//Move Non-FCRA Key build	
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::death_master::@version@::address_table_v4', 
		'~prte::key::death_master::' + filedate + '::address_table_v4',
		move_built_key_death_master_address_table_v4);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::death_master::@version@::addr_name', 
		'~prte::key::death_master::' + filedate + '::addr_name',
		move_built_key_death_master_addr_name);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::death_master::@version@::adl_risk_table_v4', 
		'~prte::key::death_master::' + filedate + '::adl_risk_table_v4',
		move_built_key_death_master_adl_risk_table_v4);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::death_master::@version@::phone_addr', 
		'~prte::key::death_master::' + filedate + '::phone_addr',
		move_built_key_death_master_phone_addr);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::death_master::@version@::phone_lname', 
		'~prte::key::death_master::' + filedate + '::phone_lname',
		move_built_key_death_master_phone_lname);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::death_master::@version@::ssn_addr', 
		'~prte::key::death_master::' + filedate + '::ssn_addr',
		move_built_key_death_master_ssn_addr);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::death_master::@version@::ssn_name', 
		'~prte::key::death_master::' + filedate + '::ssn_name',
		move_built_key_death_master_ssn_name);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::death_master::@version@::ssn_table_v4_2', 
		'~prte::key::death_master::' + filedate + '::ssn_table_v4_2',
		move_built_key_death_master_ssn_table_v4_2);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::death_master::@version@::suspicious_identities', 
		'~prte::key::death_master::' + filedate + '::suspicious_identities',
		move_built_key_death_master_suspicious_identities);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::death_master::fcra::@version@::adl_risk_table_v4_filtered', 
		'~prte::key::death_master::fcra::' + filedate + '::adl_risk_table_v4_filtered',
		move_built_key_death_masterfcra_adl_risk_table_v4_filtered);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::death_master::fcra::@version@::ssn_table_v4_filtered', 
		'~prte::key::death_master::fcra::' + filedate + '::ssn_table_v4_filtered',
		move_built_key_death_masterfcra_ssn_table_v4_filtered);


	RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~prte::key::death_master::@version@::ssn_name_summary', 
										  '~prte::key::death_master::'+filedate+'::ssn_name_summary',b16);
											
	RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~prte::key::death_master::@version@::ssn_addr_summary', 
										  '~prte::key::death_master::'+filedate+'::ssn_addr_summary',b17);
											
	RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~prte::key::death_master::@version@::ssn_dob_summary', 
										  '~prte::key::death_master::'+filedate+'::ssn_dob_summary',b18);
											
	RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~prte::key::death_master::@version@::ssn_phone_summary', 
										  '~prte::key::death_master::'+filedate+'::ssn_phone_summary',b19);
											
	RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~prte::key::death_master::@version@::phone_dob_summary', 
										  '~prte::key::death_master::'+filedate+'::phone_dob_summary',b20);
											
	RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~prte::key::death_master::@version@::addr_name_summary', 
										  '~prte::key::death_master::'+filedate+'::addr_name_summary',b21);
											
	RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~prte::key::death_master::@version@::addr_dob_summary', 
										  '~prte::key::death_master::'+filedate+'::addr_dob_summary',b22);
											
	RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~prte::key::death_master::@version@::name_dob_summary', 
										  '~prte::key::death_master::'+filedate+'::name_dob_summary',b23);
											
	RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~prte::key::death_master::@version@::phone_addr_summary', 
										  '~prte::key::death_master::'+filedate+'::phone_addr_summary',b24);
											
	RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~prte::key::death_master::@version@::phone_lname_summary', 
										  '~prte::key::death_master::'+filedate+'::phone_lname_summary',b25);

	RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~prte::key::death_master::@version@::phone_addr_header_summary', 
										  '~prte::key::death_master::'+filedate+'::phone_addr_header_summary',b26);
											
	RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~prte::key::death_master::@version@::phone_lname_header_summary', 
										  '~prte::key::death_master::'+filedate+'::phone_lname_header_summary',b27);




//Move Keys to QA
	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::death_master::@version@::address_table_v4', 
		'Q', 
		move_qa_key_death_master_address_table_v4);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::death_master::@version@::addr_name', 
		'Q', 
		move_qa_key_death_master_addr_name);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::death_master::@version@::adl_risk_table_v4', 
		'Q', 
		move_qa_key_death_master_adl_risk_table_v4);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::death_master::@version@::phone_addr', 
		'Q', 
		move_qa_key_death_master_phone_addr);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::death_master::@version@::phone_lname', 
		'Q', 
		move_qa_key_death_master_phone_lname);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::death_master::@version@::ssn_addr', 
		'Q', 
		move_qa_key_death_master_ssn_addr);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::death_master::@version@::ssn_name', 
		'Q', 
		move_qa_key_death_master_ssn_name);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::death_master::@version@::ssn_table_v4_2', 
		'Q', 
		move_qa_key_death_master_ssn_table_v4_2);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::death_master::@version@::suspicious_identities', 
		'Q', 
		move_qa_key_death_master_suspicious_identities);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::death_master::fcra::@version@::adl_risk_table_v4_filtered', 
		'Q', 
		move_qa_key_death_masterfcra_adl_risk_table_v4_filtered);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::death_master::fcra::@version@::ssn_table_v4_filtered', 
		'Q', 
		move_qa_key_death_masterfcra_ssn_table_v4_filtered);
		
	RoxieKeyBuild.Mac_SK_Move_V2('~prte::key::death_master::@version@::ssn_name_summary', 	'Q',move16, 2);
	RoxieKeyBuild.Mac_SK_Move_V2('~prte::key::death_master::@version@::ssn_addr_summary', 	'Q',move17, 2);
	RoxieKeyBuild.Mac_SK_Move_V2('~prte::key::death_master::@version@::ssn_dob_summary', 		'Q',move18, 2);
	RoxieKeyBuild.Mac_SK_Move_V2('~prte::key::death_master::@version@::ssn_phone_summary',	'Q',move19, 2);
	RoxieKeyBuild.Mac_SK_Move_V2('~prte::key::death_master::@version@::phone_dob_summary',	'Q',move20, 2);
	RoxieKeyBuild.Mac_SK_Move_V2('~prte::key::death_master::@version@::addr_name_summary',	'Q',move21, 2);
	RoxieKeyBuild.Mac_SK_Move_V2('~prte::key::death_master::@version@::addr_dob_summary', 	'Q',move22, 2);
	RoxieKeyBuild.Mac_SK_Move_V2('~prte::key::death_master::@version@::name_dob_summary', 	'Q',move23, 2);
	RoxieKeyBuild.Mac_SK_Move_V2('~prte::key::death_master::@version@::phone_addr_summary', 'Q',move24, 2);
	RoxieKeyBuild.Mac_SK_Move_V2('~prte::key::death_master::@version@::phone_lname_summary','Q',move25, 2);
	RoxieKeyBuild.Mac_SK_Move_V2('~prte::key::death_master::@version@::phone_addr_header_summary', 'Q',move26, 2);
	RoxieKeyBuild.Mac_SK_Move_V2('~prte::key::death_master::@version@::phone_lname_header_summary','Q',move27, 2);
		

// -- EMAIL ROXIE KEY COMPLETION NOTIFICATION 
	is_running_in_prod 	:= PRTE2_Common.Constants.is_running_in_prod;
	DOPS_Comment		 		:= OUTPUT('Skipping DOPS process');
	updatedops   		 		:= PRTE.UpdateVersion('RiskTableKeys', filedate,_control.MyInfo.EmailAddressNormal,'B','N','N'); 
	updatedops_fcra  		:= PRTE.UpdateVersion('FCRA_RiskTableKeys',filedate,_control.MyInfo.EmailAddressNormal,'B','F','N');


	RETURN 		sequential(	
												// build_key_death_master_address_table_v4, 
												// build_key_death_master_addr_name, 
												// build_key_death_master_adl_risk_table_v4, 
												// build_key_death_master_phone_addr, 
												// build_key_death_master_phone_lname, 
												// build_key_death_master_ssn_addr, 
												// build_key_death_master_ssn_name, 
												// build_key_death_master_ssn_table_v4_2, 
												build_key_death_master_suspicious_identities);
												// build_key_death_masterfcra_adl_risk_table_v4_filtered, 
												// build_key_death_masterfcra_ssn_table_v4_filtered, 
												// parallel(a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27),
												// move_built_key_death_master_address_table_v4, 
												// move_built_key_death_master_addr_name, 
												// move_built_key_death_master_adl_risk_table_v4, 
												// move_built_key_death_master_phone_addr, 
												// move_built_key_death_master_phone_lname, 
												// move_built_key_death_master_ssn_addr, 
												// move_built_key_death_master_ssn_name, 
												// move_built_key_death_master_ssn_table_v4_2, 
												// move_built_key_death_master_suspicious_identities, 
												// move_built_key_death_masterfcra_adl_risk_table_v4_filtered, 
												// move_built_key_death_masterfcra_ssn_table_v4_filtered,
												// parallel(b16,b17,b18,b19,b20,b21,b22,b23,b24,b25,b26,b27),
												// move_qa_key_death_master_address_table_v4, 
												// move_qa_key_death_master_addr_name, 
												// move_qa_key_death_master_adl_risk_table_v4, 
												// move_qa_key_death_master_phone_addr, 
												// move_qa_key_death_master_phone_lname, 
												// move_qa_key_death_master_ssn_addr, 
												// move_qa_key_death_master_ssn_name, 
												// move_qa_key_death_master_ssn_table_v4_2, 
												// move_qa_key_death_master_suspicious_identities, 
												// move_qa_key_death_masterfcra_adl_risk_table_v4_filtered, 
												// move_qa_key_death_masterfcra_ssn_table_v4_filtered,
												// parallel(move16,move17,move18,move19,move20,move21,move22,move23,move24,move25,move26,move27),
												// if(is_running_in_prod, parallel(updatedops,updatedops_fcra),DOPS_Comment));
																		

END;
