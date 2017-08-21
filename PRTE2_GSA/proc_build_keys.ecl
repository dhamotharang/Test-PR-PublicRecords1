IMPORT ut,RoxieKeyBuild,AutoKeyB2,PRTE,_control, PRTE2_GSA, PRTE2_Common	;

EXPORT proc_build_keys(string filedate, boolean skipDOPS=FALSE, string emailTo='') := FUNCTION

	is_running_in_prod 			:= PRTE2_Common.Constants.is_running_in_prod;
	doDOPS 					:= is_running_in_prod AND NOT skipDOPS;
		
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_gsa_bdid,
		Constants.KeyName_gsa + '@version@::bdid',
		Constants.KeyName_gsa + filedate + '::bdid', build_key_gsa_bdid);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_gsa_did,
		Constants.KeyName_gsa + '@version@::did',
		Constants.KeyName_gsa + filedate + '::did', build_key_gsa_did);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_gsa_gsa_id,
		Constants.KeyName_gsa + '@version@::gsa_id',
		Constants.KeyName_gsa + filedate + '::gsa_id', build_key_gsa_gsa_id);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.Key_GSA_LinkIDs.Key,
		Constants.KeyName_gsa + '@version@::linkids',
		Constants.KeyName_gsa + filedate + '::linkids', build_key_gsa_linkids);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_gsa_lnpid,
		Constants.KeyName_gsa + '@version@::lnpid',
		Constants.KeyName_gsa + filedate + '::lnpid', build_key_gsa_lnpid);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_gsa + '@version@::bdid', 
		Constants.KeyName_gsa + filedate + '::bdid',
		move_built_key_gsa_bdid);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_gsa + '@version@::did', 
		Constants.KeyName_gsa + filedate + '::did',
		move_built_key_gsa_did);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_gsa + '@version@::gsa_id', 
		Constants.KeyName_gsa + filedate + '::gsa_id',
		move_built_key_gsa_gsa_id);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_gsa + '@version@::linkids', 
		Constants.KeyName_gsa + filedate + '::linkids',
		move_built_key_gsa_linkids);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_gsa + '@version@::lnpid', 
		Constants.KeyName_gsa + filedate + '::lnpid',
		move_built_key_gsa_lnpid);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_gsa + '@version@::bdid', 
		'Q', 
		move_qa_key_gsa_bdid);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_gsa + '@version@::did', 
		'Q', 
		move_qa_key_gsa_did);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_gsa + '@version@::gsa_id', 
		'Q', 
		move_qa_key_gsa_gsa_id);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_gsa + '@version@::linkids', 
		'Q', 
		move_qa_key_gsa_linkids);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_gsa + '@version@::lnpid', 
		'Q', 
		move_qa_key_gsa_lnpid);

	AutoKeyB2.MAC_Build (files.autokey_file,
					fname,mname,lname,
					blank,
					zero,
					zero,
					prim_name, prim_range, st, v_city_name, zip5, sec_range,
					zero,  //inStates
					zero,zero,zero,   //lname 1-3
					zero,zero,zero,   //city  1-3
					zero,zero,zero,   //rel fname 1-3
					zero,  //lookups				 
					did,
					//peron above, business below
					name,
					zero,  //fein, tax-id
					zero,  //phone
					prim_name, prim_range, st, v_city_name, zip5, sec_range,
					bdid,
					Constants.ak_keyname,
					Constants.ak_logical(filedate),
					outaction,false,
					constants.skip_set,true,constants.ak_typestr,
					true,,,zero);

	AutoKeyB2.MAC_AcceptSK_to_QA(constants.ak_keyname, mymove,, constants.skip_set) 

	retval := 	sequential(outaction,mymove); 

	//---------- making DOPS optional and only in PROD build -------------------------------
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD'); 
	updatedops					:=	PRTE.UpdateVersion('GSAKeys', filedate, notifyEmail,'B','N','N');
	
	PerformUpdateOrNot	:= IF(doDOPS,PARALLEL(updatedops),NoUpdate);



	RETURN 		sequential(			
				build_key_gsa_bdid, 
				build_key_gsa_did, 
				build_key_gsa_gsa_id, 
				build_key_gsa_linkids, 
				build_key_gsa_lnpid, 
				move_built_key_gsa_bdid, 
				move_built_key_gsa_did, 
				move_built_key_gsa_gsa_id, 
				move_built_key_gsa_linkids, 
				move_built_key_gsa_lnpid, 
				move_qa_key_gsa_bdid, 
				move_qa_key_gsa_did, 
				move_qa_key_gsa_gsa_id, 
				move_qa_key_gsa_linkids, 
				move_qa_key_gsa_lnpid, retval );

END;
