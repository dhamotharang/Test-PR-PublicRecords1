IMPORT ut,RoxieKeyBuild,AutoKeyB2, prte2_VotersV2;

EXPORT proc_build_keys(string filedate) := FUNCTION

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( Keys.keys_temp(true),
  '~prte::key::voters::fcra::@version@::bocashell_voters_source_states_lookup',
  '~prte::key::votersv2::fcra::' + filedate + '::bocashell_voters_source_states_lookup', build_key_votersv2fcra_bocashell_voters_source_states_lookup);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_voters_did,
	'~prte::key::voters::@version@::did',
	'~prte::key::voters::' + filedate + '::did', build_key_voters_did);

 RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_voters_history_vtid,
 '~prte::key::voters::@version@::history_vtid',
 '~prte::key::voters::' + filedate + '::history_vtid', build_key_voters_history_vtid);

 RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_voters_vtid,
   '~prte::key::voters::@version@::vtid',
   '~prte::key::voters::' + filedate + '::vtid', build_key_voters_vtid);
	 
	 RoxieKeyBuild.MAC_SK_BuildProcess_v2_local ( Keys.keys_temp(false),
  '~prte::key::voters::@version@::bocashell_voters_source_states_lookup',
  '~prte::key::votersv2::' + filedate + '::bocashell_voters_source_states_lookup', build_key_votersv2_bocashell_voters_source_states_lookup); 

 RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::voters::fcra::@version@::bocashell_voters_source_states_lookup', 
 '~prte::key::votersv2::fcra::' + filedate + '::bocashell_voters_source_states_lookup',
 move_built_key_votersv2fcra_bocashell_voters_source_states_lookup);

RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::voters::@version@::did', 
	'~prte::key::voters::' + filedate + '::did',
	move_built_key_voters_did);

 RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::voters::@version@::history_vtid', 
 '~prte::key::voters::' + filedate + '::history_vtid',
 move_built_key_voters_history_vtid);

 RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::voters::@version@::vtid', 
 '~prte::key::voters::' + filedate + '::vtid',
   move_built_key_voters_vtid);

 RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::voters::@version@::bocashell_voters_source_states_lookup', 
 '~prte::key::votersv2::' + filedate + '::bocashell_voters_source_states_lookup',
 move_built_key_votersv2_bocashell_voters_source_states_lookup);

 RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::voters::fcra::@version@::bocashell_voters_source_states_lookup', 
 'Q', 
 move_qa_key_votersv2fcra_bocashell_voters_source_states_lookup);

RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::voters::@version@::did', 
	'Q', 
	move_qa_key_voters_did);

 RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::voters::@version@::history_vtid', 
 'Q', 
 move_qa_key_voters_history_vtid);

 RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::voters::@version@::vtid', 
 'Q', 
 move_qa_key_voters_vtid);

 RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::voters::@version@::bocashell_voters_source_states_lookup', 
 'Q', 
 move_qa_key_votersv2_bocashell_voters_source_states_lookup);

AutokeyB2.MAC_Build(Files.DS_Voters_Auto_keys,fname,mname,lname,
										ssn,
										dob,
										phone,
										prim_name, prim_range, st, p_city_name, zip, sec_range,
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
										constants.ak_logical(filedate),bld_auto_keys,false,constants.skip_set,true,,
										true,,,zero); 
										
	AutoKeyB2.MAC_AcceptSK_to_QA(constants.ak_keyname, mymove,, constants.skip_set)
	retval :=sequential(bld_auto_keys,mymove);
	
	RETURN 		sequential(	
	    build_key_votersv2fcra_bocashell_voters_source_states_lookup, 
			build_key_voters_did, 
			build_key_voters_history_vtid, 
			build_key_voters_vtid, 
			build_key_votersv2_bocashell_voters_source_states_lookup, 
			move_built_key_votersv2fcra_bocashell_voters_source_states_lookup, 
			move_built_key_voters_did, 
			move_built_key_voters_history_vtid, 
			move_built_key_voters_vtid, 
			move_built_key_votersv2_bocashell_voters_source_states_lookup, 
			move_qa_key_votersv2fcra_bocashell_voters_source_states_lookup, 
			move_qa_key_voters_did,
			move_qa_key_voters_history_vtid, 
			move_qa_key_voters_vtid,
			move_qa_key_votersv2_bocashell_voters_source_states_lookup,
			bld_auto_keys,mymove);

END;
