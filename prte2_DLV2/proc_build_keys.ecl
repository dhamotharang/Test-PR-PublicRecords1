IMPORT ut,RoxieKeyBuild,AutoKeyB2, prte2_DLV2,prte,_control;

EXPORT proc_build_keys(string filedate) := FUNCTION

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_dl2_accident_dlcp_key,
	Constants.KeyName_dl2 + '@version@::accident_dlcp_key',
	Constants.KeyName_dl2  + filedate + '::accident_dlcp_key', build_key_dl2_accident_dlcp_key);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_dl2_conviction_dlcp_key,
	Constants.KeyName_dl2 + '@version@::conviction_dlcp_key',
	Constants.KeyName_dl2  + filedate + '::conviction_dlcp_key', build_key_dl2_conviction_dlcp_key);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_dl2_dl_did_public,
	Constants.KeyName_dl2 + '@version@::dl_did_public',
	Constants.KeyName_dl2  + filedate + '::did_public', build_key_dl2_dl_did_public);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_dl2_dl_number_public,
	Constants.KeyName_dl2 + '@version@::dl_number_public',
	Constants.KeyName_dl2  + filedate + '::dl_number_public', build_key_dl2_dl_number_public);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_dl2_dl_seq,
	Constants.KeyName_dl2 + '@version@::dl_seq',
	Constants.KeyName_dl2  + filedate + '::dl_seq', build_key_dl2_dl_seq);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_dl2_dr_info_dlcp_key,
	Constants.KeyName_dl2 + '@version@::dr_info_dlcp_key',
	Constants.KeyName_dl2  + filedate + '::dr_info_dlcp_key', build_key_dl2_dr_info_dlcp_key);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_dl2_suspension_dlcp_key,
	Constants.KeyName_dl2 + '@version@::suspension_dlcp_key',
	Constants.KeyName_dl2  + filedate + '::suspension_dlcp_key', build_key_dl2_suspension_dlcp_key);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.Key_DL_Indicatives,
	Constants.KeyName_dl2 + '@version@::dl_indicatives_public',
	Constants.KeyName_dl2 + filedate + '::indicatives_public', build_key_dl2_dl_indicatives_public);
	
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_dl2_fra_insur_dlcp_key,
	Constants.KeyName_dl2 + '@version@::fra_insur_dlcp_key',
	Constants.KeyName_dl2 + filedate + '::fra_insur_dlcp_key', build_key_dl2_fra_insur_dlcp_key);
	
//key_dl2_fra_insur_dlcp_key
Roxiekeybuild.MAC_SF_BuildProcess(Files.DS_Wildcard
			,'~prte::data::dl2::wildcard'
			,'~prte::data::dl2::' + filedate + '::wildcard'
			, build_key_dl2_wildcard);
	
RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_dl2 + '@version@::accident_dlcp_key', 
	Constants.KeyName_dl2  + filedate + '::accident_dlcp_key',
	move_built_key_dl2_accident_dlcp_key);

RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_dl2 + '@version@::conviction_dlcp_key', 
	Constants.KeyName_dl2  + filedate + '::conviction_dlcp_key',
	move_built_key_dl2_conviction_dlcp_key);

RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_dl2 + '@version@::dl_did_public', 
	Constants.KeyName_dl2  + filedate + '::did_public',
	move_built_key_dl2_dl_did_public);

RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_dl2 + '@version@::dl_number_public', 
	Constants.KeyName_dl2  + filedate + '::dl_number_public',
	move_built_key_dl2_dl_number_public);

RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_dl2 + '@version@::dl_seq', 
	Constants.KeyName_dl2  + filedate + '::dl_seq',
	move_built_key_dl2_dl_seq);

RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_dl2 + '@version@::dr_info_dlcp_key', 
	Constants.KeyName_dl2  + filedate + '::dr_info_dlcp_key',
	move_built_key_dl2_dr_info_dlcp_key);

RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_dl2 + '@version@::suspension_dlcp_key', 
	Constants.KeyName_dl2  + filedate + '::suspension_dlcp_key',
	move_built_key_dl2_suspension_dlcp_key);

RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_dl2 + '@version@::dl_indicatives_public', 
	Constants.KeyName_dl2 + filedate + '::indicatives_public',
	move_built_key_dl2_dl_indicatives_public);

RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_dl2 + '@version@::fra_insur_dlcp_key', 
	Constants.KeyName_dl2 + filedate + '::fra_insur_dlcp_key',
	move_built_key_dl2_fra_insur_dlcp_key);
	
RoxieKeyBuild.MAC_SK_Move_To_Built_V2( 
			'~prte::data::dl2::wildcard'
			,'~prte::data::dl2::' + filedate + '::wildcard'
			,move_built_key_dl2_wildcard);
			
RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_dl2 + '@version@::accident_dlcp_key', 
	'Q', 
	move_qa_key_dl2_accident_dlcp_key);

RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_dl2 + '@version@::conviction_dlcp_key', 
	'Q', 
	move_qa_key_dl2_conviction_dlcp_key);

RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_dl2 + '@version@::dl_did_public', 
	'Q', 
	move_qa_key_dl2_dl_did_public);

RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_dl2 + '@version@::dl_number_public', 
	'Q', 
	move_qa_key_dl2_dl_number_public);

RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_dl2 + '@version@::dl_seq', 
	'Q', 
	move_qa_key_dl2_dl_seq);

RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_dl2 + '@version@::dr_info_dlcp_key', 
	'Q', 
	move_qa_key_dl2_dr_info_dlcp_key);

RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_dl2 + '@version@::suspension_dlcp_key', 
	'Q', 
	move_qa_key_dl2_suspension_dlcp_key);

RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_dl2 + '@version@::dl_indicatives_public', 
	'Q', 
	move_qa_key_dl2_dl_indicatives_public);

RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_dl2 + '@version@::fra_insur_dlcp_key', 
	'Q', 
	move_qa_key_dl2_fra_insur_dlcp_key);
	
RoxieKeyBuild.MAC_SK_Move_v2('~prte::data::dl2::wildcard'
	,'Q', 
	move_qa_key_dl2_wildcard);
			

//YOU MUST CHANGE THE AUTOKEY INPUT PARAMETERS TO MATCH YOUR DATASET!!
AutoKeyB2.MAC_Build (files.autokey_file,
					fname,mname,lname,
					ssn,
					dob,
					zero,
					prim_name, prim_range, st, p_city_name, zip5, sec_range,
					zero,
					zero,zero,zero,
					zero,zero,zero,
					zero,zero,zero,
					zero,				 
					did,
					blank,
					zero,
					zero,
					blank,blank,blank,blank,blank,blank,
					zero,
					Constants.ak_keyname,
					Constants.ak_logical(filedate),
					outaction,false,
					constants.skip_set,true,constants.ak_typestr,true,,,
					zero,,,,,,,,true) 

AutoKeyB2.MAC_AcceptSK_to_QA(constants.ak_keyname, mymove,, constants.skip_set) 




RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.Key_DL_UberWords,
	Constants.ak_keyname+'UberWords',
	Constants.ak_logical(filedate) + 'UberWords', build_key_dl2_UberWords);

RoxieKeyBuild.MAC_SK_Move_To_Built_V2( 
	Constants.ak_keyname+'UberWords',
	Constants.ak_logical(filedate) + 'UberWords',
	move_built_UberWords);
			
RoxieKeyBuild.MAC_SK_Move_v2(
	Constants.ak_keyname+'UberWords', 
	'Q', 
	move_qa_UberWords);
	
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.Key_DL_UberRefs,
	Constants.ak_keyname +'UberRefs',
	Constants.ak_logical(filedate) + 'UberRefs', build_key_UberRefs);
	
RoxieKeyBuild.MAC_SK_Move_To_Built_V2( 
	Constants.ak_keyname+'UberRefs',
	Constants.ak_logical(filedate) + 'UberRefs',
	move_built_UberRefs);
			
RoxieKeyBuild.MAC_SK_Move_v2(Constants.ak_keyname+'UberRefs', 
	'Q', 
	move_qa_UberRefs);

updatedops   		 := PRTE.UpdateVersion('DLV2Keys',filedate,_control.MyInfo.EmailAddressNormal,'B','N','N');


RETURN 		sequential(	
			outaction,
			mymove,
			build_key_dl2_dl_indicatives_public,
			build_key_dl2_fra_insur_dlcp_key,
			build_key_dl2_accident_dlcp_key, 
			build_key_dl2_conviction_dlcp_key, 
			build_key_dl2_dl_did_public, 
			build_key_dl2_dl_number_public, 
			build_key_dl2_dl_seq, 
			build_key_dl2_dr_info_dlcp_key, 
			build_key_dl2_suspension_dlcp_key, 
			build_key_dl2_wildcard,
			build_key_dl2_UberWords,
			build_key_UberRefs,
			move_built_key_dl2_dl_indicatives_public,
			move_built_key_dl2_fra_insur_dlcp_key,
			move_built_key_dl2_accident_dlcp_key, 
			move_built_key_dl2_conviction_dlcp_key, 
			move_built_key_dl2_dl_did_public, 
			move_built_key_dl2_dl_number_public, 
			move_built_key_dl2_dl_seq, 
			move_built_key_dl2_dr_info_dlcp_key, 
			move_built_key_dl2_suspension_dlcp_key, 
			move_built_key_dl2_wildcard,
			move_built_UberWords,
			move_built_UberRefs,
			move_qa_key_dl2_accident_dlcp_key, 
			move_qa_key_dl2_conviction_dlcp_key, 
			move_qa_key_dl2_dl_did_public, 
			move_qa_key_dl2_dl_number_public, 
			move_qa_key_dl2_dl_seq, 
			move_qa_key_dl2_dr_info_dlcp_key, 
			move_qa_key_dl2_suspension_dlcp_key,
			move_qa_key_dl2_dl_indicatives_public,
			move_qa_key_dl2_fra_insur_dlcp_key,
			move_qa_key_dl2_wildcard, 
			move_qa_UberWords,
			move_qa_UberRefs,
			updatedops
			);

END;
