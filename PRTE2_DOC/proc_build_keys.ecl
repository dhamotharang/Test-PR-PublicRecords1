IMPORT ut,RoxieKeyBuild,AutoKeyB2, PRTE2_DOC, PRTE,_control, doxie_build,PRTE2_Common;

EXPORT proc_build_keys(string filedate) := FUNCTION

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_criminal_offenders_did(true),
	'~prte::key::criminal_offenders::fcra::@version@::did',
	'~prte::key::criminal_offenders::fcra::' + filedate + '::did', build_key_criminal_offendersfcra_did);	

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_criminal_offenders_did(false),
	'~prte::key::corrections_offenders_public_@version@',
	'~prte::key::corrections_offenders::' + filedate + '::public', build_key_corrections_offenders_public);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_offenses_offender_key(true),
	'~prte::key::criminal_offenses::fcra::@version@::offender_key',
	'~prte::key::criminal_offenses::fcra::' + filedate + '::offender_key', build_key_criminal_offensesfcra_offender_key);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_offenses_offender_key(false),
	'~prte::key::corrections_offenses_public_@version@',
	'~prte::key::corrections_offenses::' + filedate + '::public', build_key_corrections_offenses_public);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_criminal_punishment_type(true),
	'~prte::key::criminal_punishment::fcra::@version@::offender_key.punishment_type',
	'~prte::key::criminal_punishment::fcra::' + filedate + '::offender_key.punishment_type', build_key_criminal_punishmentfcra_offender_punishment_type);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_criminal_punishment_type(false),
	'~prte::key::corrections_punishment_public_@version@',
	'~prte::key::corrections_punishment::' + filedate + '::public', build_key_corrections_punishment_public);
	
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_corrections_activity(true),
	'~prte::key::corrections::fcra::activity_public_@version@',
	'~prte::key::life_eir::fcra::' + filedate + '::court_activity', build_key_correctionsfcraactivity_public);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_corrections_activity(false),
	'~prte::key::corrections_activity_public_@version@',
	'~prte::key::corrections_activity::' + filedate + '::public', build_key_corrections_activity_public);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_correctionsfcracourt_offenses_public(true),
	'~prte::key::corrections::fcra::court_offenses_public_@version@',
	'~prte::key::life_eir::fcra::' + filedate + '::court_offenses', build_key_correctionsfcracourt_offenses_public);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_correctionsfcracourt_offenses_public(false),
	'~prte::key::corrections_court_offenses_public_@version@',
	'~prte::key::corrections_court_offenses::' + filedate + '::public', build_key_corrections_court_offenses_public);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_corrections_offenders_offenderkey(true),
	'~prte::key::corrections::fcra::offenders_offenderkey_public_@version@',
	'~prte::key::life_eir::fcra::' + filedate + '::offenders_offenderkey', build_key_correctionsfcraoffenders_offenderkey_public);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_corrections_offenders_offenderkey(false),
	'~prte::key::corrections_offenders_offenderkey_public_@version@',
	'~prte::key::corrections_offenders::' + filedate + '::offenderkey_public', build_key_corrections_offenders_offenderkey_public);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_corrections_offendersfcrabocashell_did,
	'~prte::key::corrections_offenders::fcra::bocashell_did_@version@',
	'~prte::key::corrections_offenders::fcra::' + filedate + '::bocashell_did', build_key_corrections_offendersfcrabocashell_did);
//////
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_corrections_offenders_riskbocashell_did,
	'~prte::key::corrections_offenders_risk::bocashell_did_@version@',
	'~prte::key::corrections_offenders_risk::' + filedate + '::bocashell_did', build_key_corrections_offenders_riskbocashell_did);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_offenders_fdid,
	'~prte::key::corrections_fdid_public_@version@',
	'~prte::key::corrections::' + filedate + '::fdid_public', build_key_corrections_fdid_public);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_offenders_casenumber,
	'~prte::key::corrections_offenders_casenumber_public_@version@',
	'~prte::key::corrections_offenders::' + filedate + '::casenumber_public', build_key_corrections_offenders_casenumber_public);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_offenders_docnum,
	'~prte::key::corrections_offenders_docnum_public_@version@',
	'~prte::key::corrections_offenders::' + filedate + '::docnum_public', build_key_corrections_offenders_docnum_public);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_offenders_risk_did,
	'~prte::key::corrections_offenders_risk::did_public_@version@',
	'~prte::key::corrections_offenders_risk::' + filedate + '::did', build_key_corrections_offenders_riskdid_public);

RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::criminal_offenders::fcra::@version@::did', 
	'~prte::key::criminal_offenders::fcra::' + filedate + '::did',
	move_built_key_criminal_offendersfcra_did);

RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::criminal_offenses::fcra::@version@::offender_key', 
	'~prte::key::criminal_offenses::fcra::' + filedate + '::offender_key',
	move_built_key_criminal_offensesfcra_offender_key);

RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::criminal_punishment::fcra::@version@::offender_key.punishment_type', 
	'~prte::key::criminal_punishment::fcra::' + filedate + '::offender_key.punishment_type',
	move_built_key_punishmentfcra_offender_punishment_type);

RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::corrections::fcra::activity_public_@version@', 
	'~prte::key::life_eir::fcra::' + filedate + '::court_activity',
	move_built_key_correctionsfcraactivity_public);

RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::corrections::fcra::court_offenses_public_@version@', 
	'~prte::key::life_eir::fcra::' + filedate + '::court_offenses',
	move_built_key_correctionsfcracourt_offenses_public);

RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::corrections::fcra::offenders_offenderkey_public_@version@', 
	'~prte::key::life_eir::fcra::' + filedate + '::offenders_offenderkey',
	move_built_key_correctionsfcraoffenders_offenderkey_public);

RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::corrections_offenders::fcra::bocashell_did_@version@', 
	'~prte::key::corrections_offenders::fcra::' + filedate + '::bocashell_did',
	move_built_key_corrections_offendersfcrabocashell_did);

RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::corrections_activity_public_@version@', 
	'~prte::key::corrections_activity::' + filedate + '::public',
	move_built_key_corrections_activity_public);

RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::corrections_court_offenses_public_@version@', 
	'~prte::key::corrections_court_offenses::' + filedate + '::public',
	move_built_key_corrections_court_offenses_public);

RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::corrections_fdid_public_@version@', 
	'~prte::key::corrections::' + filedate + '::fdid_public',
	move_built_key_corrections_fdid_public);

RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::corrections_offenders_casenumber_public_@version@', 
	'~prte::key::corrections_offenders::' + filedate + '::casenumber_public',
	move_built_key_corrections_offenders_casenumber_public);

RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::corrections_offenders_docnum_public_@version@', 
	'~prte::key::corrections_offenders::' + filedate + '::docnum_public',
	move_built_key_corrections_offenders_docnum_public);

RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::corrections_offenders_offenderkey_public_@version@', 
	'~prte::key::corrections_offenders::' + filedate + '::offenderkey_public',
	move_built_key_corrections_offenders_offenderkey_public);

RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::corrections_offenders_public_@version@', 
	'~prte::key::corrections_offenders::' + filedate + '::public',
	move_built_key_corrections_offenders_public);

RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::corrections_offenders_risk::bocashell_did_@version@', 
	'~prte::key::corrections_offenders_risk::' + filedate + '::bocashell_did',
	move_built_key_corrections_offenders_riskbocashell_did);

RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::corrections_offenders_risk::did_public_@version@', 
	'~prte::key::corrections_offenders_risk::' + filedate + '::did',
	move_built_key_corrections_offenders_riskdid_public);

RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::corrections_offenses_public_@version@', 
	'~prte::key::corrections_offenses::' + filedate + '::public',
	move_built_key_corrections_offenses_public);

RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::corrections_punishment_public_@version@', 
	'~prte::key::corrections_punishment::' + filedate + '::public',
	move_built_key_corrections_punishment_public);

RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::criminal_offenders::fcra::@version@::did', 
	'Q', 
	move_qa_key_criminal_offendersfcra_did);

RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::criminal_offenses::fcra::@version@::offender_key', 
	'Q', 
	move_qa_key_criminal_offensesfcra_offender_key);

RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::criminal_punishment::fcra::@version@::offender_key.punishment_type', 
	'Q', 
	move_qa_key_fcra_offender_punishment_type);

RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::corrections::fcra::activity_public_@version@', 
	'Q', 
	move_qa_key_correctionsfcraactivity_public);

RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::corrections::fcra::court_offenses_public_@version@', 
	'Q', 
	move_qa_key_correctionsfcracourt_offenses_public);

RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::corrections::fcra::offenders_offenderkey_public_@version@', 
	'Q', 
	move_qa_key_correctionsfcraoffenders_offenderkey_public);

RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::corrections_offenders::fcra::bocashell_did_@version@', 
	'Q', 
	move_qa_key_corrections_offendersfcrabocashell_did);

RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::corrections_activity_public_@version@', 
	'Q', 
	move_qa_key_corrections_activity_public);

RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::corrections_court_offenses_public_@version@', 
	'Q', 
	move_qa_key_corrections_court_offenses_public);

RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::corrections_fdid_public_@version@', 
	'Q', 
	move_qa_key_corrections_fdid_public);

RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::corrections_offenders_casenumber_public_@version@', 
	'Q', 
	move_qa_key_corrections_offenders_casenumber_public);

RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::corrections_offenders_docnum_public_@version@', 
	'Q', 
	move_qa_key_corrections_offenders_docnum_public);

RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::corrections_offenders_offenderkey_public_@version@', 
	'Q', 
	move_qa_key_corrections_offenders_offenderkey_public);

RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::corrections_offenders_public_@version@', 
	'Q', 
	move_qa_key_corrections_offenders_public);

RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::corrections_offenders_risk::bocashell_did_@version@', 
	'Q', 
	move_qa_key_corrections_offenders_riskbocashell_did);

RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::corrections_offenders_risk::did_public_@version@', 
	'Q', 
	move_qa_key_corrections_offenders_riskdid_public);

RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::corrections_offenses_public_@version@', 
	'Q', 
	move_qa_key_corrections_offenses_public);


RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::corrections_punishment_public_@version@', 
	'Q', 
	move_qa_key_corrections_punishment_public);


autokeyb2.mac_build(Files.File_offenders_autokey,fname,mname,lname,
						ssn,
						dob,
						zero,
						prim_name,prim_range,state,v_city_name,zip5,sec_range,
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
						constants.ak_keyname,
						constants.ak_logical(filedate),
						outaction,
						false,
						constants.skip_set,true,constants.ak_typestr,
						true,,,offender_key,true);


AutoKeyB2.MAC_AcceptSK_to_QA(constants.ak_keyname,mymove,,constants.skip_set);


retval := 	sequential(outaction,mymove); 

AutoKey.MAC_Build_Version(files.file_corrections_keys,fname,mname,lname,
						ssn,
						dob,
						zero,
						prim_name,prim_range,st,v_city_name,zip5,sec_range,
						zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,zero,zero,
						lookups,
						i_did,
						constants.corrections_keys_root,
						constants.corrections_keys_logicalname(filedate)
						  ,corrections_keys_outaction,FALSE,
						[]); 
autokey.MAC_AcceptSK_to_QA(constants.corrections_keys_root,autokeymove);

//---------- making DOPS optional and only in PROD build -------------------------------
	is_running_in_prod 	:= PRTE2_Common.Constants.is_running_in_prod;
	NoUpdate 						:= OUTPUT('Skipping DOPS update because we are not in PROD'); 
	updatedops   		 		:= PRTE.UpdateVersion('DOCKeys', filedate,_control.MyInfo.EmailAddressNormal,'B','N','N'); 
	updatedops_fcra  		:= PRTE.UpdateVersion('FCRA_DOCKeys',filedate,_control.MyInfo.EmailAddressNormal,'B','F','N');
	PerformUpdateOrNot	:= IF(is_running_in_prod,parallel(updatedops,updatedops_fcra),NoUpdate);

RETURN 		sequential(			build_key_criminal_offendersfcra_did, 
			build_key_criminal_offensesfcra_offender_key, 
			build_key_criminal_punishmentfcra_offender_punishment_type, 
			build_key_correctionsfcraactivity_public, 
			build_key_correctionsfcracourt_offenses_public, 
			build_key_correctionsfcraoffenders_offenderkey_public, 
			build_key_corrections_offendersfcrabocashell_did, 
			build_key_corrections_activity_public, 
			build_key_corrections_court_offenses_public, 
			build_key_corrections_fdid_public, 
			build_key_corrections_offenders_casenumber_public, 
			build_key_corrections_offenders_docnum_public, 
			build_key_corrections_offenders_offenderkey_public, 
			build_key_corrections_offenders_public, 
			build_key_corrections_offenders_riskbocashell_did, 
			build_key_corrections_offenders_riskdid_public, 
			build_key_corrections_offenses_public, 
			build_key_corrections_punishment_public, 
			move_built_key_criminal_offendersfcra_did, 
			move_built_key_criminal_offensesfcra_offender_key, 
			move_built_key_punishmentfcra_offender_punishment_type, 
			move_built_key_correctionsfcraactivity_public, 
			move_built_key_correctionsfcracourt_offenses_public, 
			move_built_key_correctionsfcraoffenders_offenderkey_public, 
			move_built_key_corrections_offendersfcrabocashell_did, 
			move_built_key_corrections_activity_public, 
			move_built_key_corrections_court_offenses_public, 
			move_built_key_corrections_fdid_public, 
			move_built_key_corrections_offenders_casenumber_public, 
			move_built_key_corrections_offenders_docnum_public, 
			move_built_key_corrections_offenders_offenderkey_public, 
			move_built_key_corrections_offenders_public, 
			move_built_key_corrections_offenders_riskbocashell_did, 
			move_built_key_corrections_offenders_riskdid_public, 
			move_built_key_corrections_offenses_public, 
			move_built_key_corrections_punishment_public, 
			move_qa_key_criminal_offendersfcra_did, 
			move_qa_key_criminal_offensesfcra_offender_key, 
			move_qa_key_fcra_offender_punishment_type, 
			move_qa_key_correctionsfcraactivity_public, 
			move_qa_key_correctionsfcracourt_offenses_public, 
			move_qa_key_correctionsfcraoffenders_offenderkey_public, 
			move_qa_key_corrections_offendersfcrabocashell_did, 
			move_qa_key_corrections_activity_public, 
			move_qa_key_corrections_court_offenses_public, 
			move_qa_key_corrections_fdid_public, 
			move_qa_key_corrections_offenders_casenumber_public, 
			move_qa_key_corrections_offenders_docnum_public, 
			move_qa_key_corrections_offenders_offenderkey_public, 
			move_qa_key_corrections_offenders_public, 
			move_qa_key_corrections_offenders_riskbocashell_did, 
			move_qa_key_corrections_offenders_riskdid_public, 
			move_qa_key_corrections_offenses_public, 
			move_qa_key_corrections_punishment_public, retval ,
			corrections_keys_outaction,autokeymove,
			proc_fcra_field_depreciation_stats,
			PerformUpdateOrNot 
			);

END;
