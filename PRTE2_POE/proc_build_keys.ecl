IMPORT ut,RoxieKeyBuild,AutoKeyB2,PRTE,_control, PRTE2_POE;

EXPORT proc_build_keys(string filedate) := FUNCTION

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.key_poe_did,
	constants.KeyName_poe + '@version@::did',
	constants.KeyName_poe + filedate + '::did', build_key_poe_did);

 RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_poe_source_hierarchy,
 constants.KeyName_poe + '@version@::source_hierarchy',
	constants.KeyName_poe + filedate + '::source_hierarchy', build_key_poe_source_hierarchy);

RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::poe::@version@::did', 
	constants.KeyName_poe + filedate + '::did',
	move_built_key_poe_did);

 RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::poe::@version@::source_hierarchy', 
	constants.KeyName_poe + filedate + '::source_hierarchy',
	 move_built_key_poe_source_hierarchy);

RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_poe + '@version@::did', 
	'Q', 
	move_qa_key_poe_did);

 RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::poe::@version@::source_hierarchy', 
 'Q', 
 move_qa_key_poe_source_hierarchy);


RETURN 		sequential(build_key_poe_did, 
			build_key_poe_source_hierarchy, 
			move_built_key_poe_did, 
			move_built_key_poe_source_hierarchy, 
			move_qa_key_poe_did, 
			move_qa_key_poe_source_hierarchy); 
																						
END;
