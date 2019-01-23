IMPORT ut,RoxieKeyBuild,AutoKeyB2,PRTE,_control, PRTE2_PAW, paw, strata,PRTE2_Common;

EXPORT proc_build_keys(string filedate) := FUNCTION

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_paw_bdid,
		Constants.KeyName_paw + '@version@::bdid',
		Constants.KeyName_paw + filedate + '::bdid', build_key_paw_bdid);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_paw_companyname_domain,
	Constants.KeyName_paw + '@version@::companyname_domain',
	Constants.KeyName_paw + filedate + '::companyname_domain', build_key_paw_companyname_domain);
	  
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_paw_contactid,
	Constants.KeyName_paw + '@version@::contactid',
	Constants.KeyName_paw + filedate + '::contactid', build_key_paw_contactid);
	
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_did,
	Constants.KeyName_paw + '@version@::did',
	Constants.KeyName_paw + filedate + '::did', build_key_paw_did);
 	
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.Key_LinkIds.Key,
	Constants.KeyName_paw + '@version@::linkids',
	Constants.KeyName_paw + filedate + '::linkids', build_key_paw_linkids);
	
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_did_fcra,
	Constants.KeyName_paw + '@version@::did_fcra',
	Constants.KeyName_paw + filedate + '::did_fcra', build_key_paw_did_fcra);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_paw + '@version@::bdid', 
	Constants.KeyName_paw + filedate + '::bdid',
	move_built_key_paw_bdid);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_paw + '@version@::companyname_domain', 
	Constants.KeyName_paw + filedate + '::companyname_domain',
	move_built_key_paw_companyname_domain);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_paw + '@version@::contactid', 
	Constants.KeyName_paw + filedate + '::contactid',
	move_built_key_paw_contactid);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_paw + '@version@::did', 
	Constants.KeyName_paw + filedate + '::did',
	move_built_key_paw_did);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_paw + '@version@::linkids', 
	Constants.KeyName_paw + filedate + '::linkids',
	move_built_key_paw_linkids);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_paw + '@version@::did_fcra', 
	Constants.KeyName_paw + filedate + '::did_fcra',
	move_built_key_paw_did_fcra);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_paw + '@version@::bdid', 
	'Q', 
	move_qa_key_paw_bdid);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_paw + '@version@::companyname_domain', 
	'Q', 
	move_qa_key_paw_companyname_domain);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_paw + '@version@::contactid', 
	'Q', 
	move_qa_key_paw_contactid);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_paw + '@version@::did', 
	'Q', 
	move_qa_key_paw_did);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_paw + '@version@::linkids', 
	'Q', 
	move_qa_key_paw_linkids);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_paw + '@version@::did_fcra', 
	'Q', 
	move_qa_key_paw_did_fcra);
     infile := file_SearchAutokey(Files.file_Employment_Out);
	AutoKeyB2.MAC_Build (infile,
						person_name.fname,person_name.mname,person_name.lname,
						ssn,
						zero,
						phone,
						person_addr.prim_name,person_addr.prim_range,person_addr.st,person_addr.v_city_name,person_addr.zip5,person_addr.sec_range,
						zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,
						DID,
						COMPANY_name,
						companY_fein,
						company_phone,
						Bus_addr.prim_name,Bus_addr.prim_range,Bus_addr.st,Bus_addr.p_city_name,Bus_addr.zip5,Bus_addr.sec_range,
						bdid,
						Constants.ak_keyname,
						Constants.ak_logical(filedate),
						outaction,false,
						constants.skip_set,true,constants.ak_typestr,
						true,,,contact_id,true) ;
						

	AutoKeyB2.MAC_AcceptSK_to_QA(constants.ak_keyname, mymove,, constants.skip_set) 

	retval := 	sequential(outaction,mymove); 
	
	
	cnt_paw_did_fcra := OUTPUT(strata.macf_pops(PRTE2_paw.keys.key_did_fcra,,,,,,FALSE,
														['company_department','company_fein','dead_flag','dppa_state','title']),
														 named('cnt_paw_did_fcra'));


//---------- making DOPS optional and only in PROD build -------------------------------
	is_running_in_prod 	:= PRTE2_Common.Constants.is_running_in_prod;
	NoUpdate 						:= OUTPUT('Skipping DOPS update because we are not in PROD'); 
	updatedops   		 		:= PRTE.UpdateVersion('PAWV2Keys', filedate,_control.MyInfo.EmailAddressNormal,'B','N','N'); 
	updatedops_fcra  		:= PRTE.UpdateVersion('FCRA_PAWV2Keys',filedate,_control.MyInfo.EmailAddressNormal,'B','F','N');
	PerformUpdateOrNot	:= IF(is_running_in_prod,parallel(updatedops,updatedops_fcra),NoUpdate);

	// -- EMAIL ROXIE KEY COMPLETION NOTIFICATION  


	RETURN 		sequential(			build_key_paw_bdid, 
			build_key_paw_companyname_domain, 
			build_key_paw_contactid, 
			build_key_paw_did, 
			build_key_paw_linkids, 
			build_key_paw_did_fcra, 
			move_built_key_paw_bdid, 
			move_built_key_paw_companyname_domain, 
			move_built_key_paw_contactid, 
			move_built_key_paw_did, 
			move_built_key_paw_linkids, 
			move_built_key_paw_did_fcra, 
			move_qa_key_paw_bdid, 
			move_qa_key_paw_companyname_domain, 
			move_qa_key_paw_contactid, 
			move_qa_key_paw_did, 
			move_qa_key_paw_linkids, 
			move_qa_key_paw_did_fcra, retval,
			cnt_paw_did_fcra,
			PerformUpdateOrNot
		);

END;
