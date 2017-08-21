IMPORT ut,RoxieKeyBuild,AutoKeyB2,PRTE,_control, PRTE2_Person_Header_Lookups;

EXPORT proc_build_keys(string filedate) := FUNCTION

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_header_lookups_v2,
		'~prte::key::header_lookups_v2_@version@',
		'~prte::key::header::' + filedate + '::lookups_v2', build_key_header_lookups_v2);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::header_lookups_v2_@version@', 
		'~prte::key::header::' + filedate + '::lookups_v2',
		move_built_key_header_lookups_v2);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::header_lookups_v2_@version@', 
		'Q', 
		move_qa_key_header_lookups_v2);

	RETURN 		sequential(			build_key_header_lookups_v2, 
														move_built_key_header_lookups_v2, 
														move_qa_key_header_lookups_v2 );

END;
