IMPORT ut,RoxieKeyBuild,AutoKeyB2,PRTE,_control;

EXPORT proc_build_slimsort(string filedate) := FUNCTION

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( Keys_Slimsort.key_did_ssn_glb,
		'~prte::key::did_ssn_glb_@version@',
		Constants.KEY_PREFIX_SLIMSORT + filedate + '::did_ssn_glb', build_key_did_ssn_glb);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( Keys_Slimsort.key_did_ssn_nonglb_nonutil,
		'~prte::key::did_ssn_nonglb_nonutil_@version@',
		Constants.KEY_PREFIX_SLIMSORT + filedate + '::did_ssn_nonglb_nonutil', build_key_did_ssn_nonglb_nonutil);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( Keys_Slimsort.key_did_ssn_nonglb,
		'~prte::key::did_ssn_nonglb_@version@',
		Constants.KEY_PREFIX_SLIMSORT + filedate + '::did_ssn_nonglb', build_key_did_ssn_nonglb);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( Keys_Slimsort.key_did_ssn_nonutil,
		'~prte::key::did_ssn_nonutil_@version@',
		Constants.KEY_PREFIX_SLIMSORT + filedate + '::did_ssn_nonutil', build_key_did_ssn_nonutil);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( Keys_Slimsort.key_headerssn4_zip_yob_fi,
		'~prte::key::header::ssn4_zip_yob_fi_@version@',
		Constants.KEY_PREFIX + filedate + '::ssn4_zip_yob_fi', build_key_headerssn4_zip_yob_fi);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( Keys_Slimsort.key_hhid,
		'~prte::key::hhid_@version@',
		Constants.KEY_PREFIX + filedate + '::hhid', build_key_hhid);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::did_ssn_glb_@version@', 
		Constants.KEY_PREFIX_SLIMSORT + filedate + '::did_ssn_glb',
		move_built_key_did_ssn_glb);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::did_ssn_nonglb_nonutil_@version@', 
		Constants.KEY_PREFIX_SLIMSORT + filedate + '::did_ssn_nonglb_nonutil',
		move_built_key_did_ssn_nonglb_nonutil);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::did_ssn_nonglb_@version@', 
		Constants.KEY_PREFIX_SLIMSORT + filedate + '::did_ssn_nonglb',
		move_built_key_did_ssn_nonglb);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::did_ssn_nonutil_@version@', 
		Constants.KEY_PREFIX_SLIMSORT + filedate + '::did_ssn_nonutil',
		move_built_key_did_ssn_nonutil);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::header::ssn4_zip_yob_fi_@version@', 
		Constants.KEY_PREFIX + filedate + '::ssn4_zip_yob_fi',
		move_built_key_headerssn4_zip_yob_fi);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::hhid_@version@', 
		Constants.KEY_PREFIX + filedate + '::hhid',
		move_built_key_hhid);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::did_ssn_glb_@version@', 
		'Q', 
		move_qa_key_did_ssn_glb,2);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::did_ssn_nonglb_nonutil_@version@', 
		'Q', 
		move_qa_key_did_ssn_nonglb_nonutil,2);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::did_ssn_nonglb_@version@', 
		'Q', 
		move_qa_key_did_ssn_nonglb,2);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::did_ssn_nonutil_@version@', 
		'Q', 
		move_qa_key_did_ssn_nonutil,2);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::header::ssn4_zip_yob_fi_@version@', 
		'Q', 
		move_qa_key_headerssn4_zip_yob_fi,2);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::hhid_@version@', 
		'Q', 
		move_qa_key_hhid,2);


	// -- EMAIL ROXIE KEY COMPLETION NOTIFICATION  

	//updatedops   		 := PRTE.UpdateVersion('PersonSlimsortKeys ', filedate,_control.MyInfo.EmailAddressNormal,'B','N','N'); 

	RETURN 		sequential(	build_key_did_ssn_glb, 
												build_key_did_ssn_nonglb_nonutil, 
												build_key_did_ssn_nonglb, 
												build_key_did_ssn_nonutil, 
												build_key_headerssn4_zip_yob_fi, 
												build_key_hhid, 
												move_built_key_did_ssn_glb, 
												move_built_key_did_ssn_nonglb_nonutil, 
												move_built_key_did_ssn_nonglb, 
												move_built_key_did_ssn_nonutil, 
												move_built_key_headerssn4_zip_yob_fi, 
												move_built_key_hhid, 
												move_qa_key_did_ssn_glb, 
												move_qa_key_did_ssn_nonglb_nonutil, 
												move_qa_key_did_ssn_nonglb, 
												move_qa_key_did_ssn_nonutil, 
												move_qa_key_headerssn4_zip_yob_fi, 
												move_qa_key_hhid 
																						
																								);

END;
