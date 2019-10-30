IMPORT ut,RoxieKeyBuild,AutoKeyB2,PRTE,_control, PRTE2_Infutor;

EXPORT proc_build_keys(string filedate) := FUNCTION

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.Key_Header_Infutor_Knowx,
	'~prte::key::header.adl.infutor.knowx_@version@',
	'~prte::key::header::' + filedate + '::adl.infutor.knowx', build_key_header_adl_infutor_knowx);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_header_teaser_did,
	'~prte::key::header.teaser_did_@version@',
	'~prte::key::header::' + filedate + '::teaser_did', build_key_header_teaser_did);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_header_teaser_search,
	'~prte::key::header.teaser_search_@version@',
	'~prte::key::header::' + filedate + '::teaser_search', build_key_header_teaser_search);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_infutorbest_did,
	'~prte::key::infutor::best.did_@version@',
	'~prte::key::infutor::' + filedate + '::best.did', build_key_infutorbest_did);

RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::header.adl.infutor.knowx_@version@', 
	'~prte::key::header::' + filedate + '::adl.infutor.knowx',
	move_built_key_header_adl_infutor_knowx);

RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::header.teaser_did_@version@', 
	'~prte::key::header::' + filedate + '::teaser_did',
	move_built_key_header_teaser_did);

RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::header.teaser_search_@version@', 
	'~prte::key::header::' + filedate + '::teaser_search',
	move_built_key_header_teaser_search);
	
RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::infutor::best.did_@version@', 
	'~prte::key::infutor::' + filedate + '::best.did',
	move_built_key_infutorbest_did);

RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::header.adl.infutor.knowx_@version@', 
	'Q', 
	move_qa_key_header_adl_infutor_knowx);

RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::header.teaser_did_@version@', 
	'Q', 
	move_qa_key_header_teaser_did);

RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::header.teaser_search_@version@', 
	'Q', 
	move_qa_key_header_teaser_search);

RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::infutor::best.did_@version@', 
	'Q', 
	move_qa_key_infutorbest_did);





//updatedops   		 := PRTE.UpdateVersion('InfutorKeys', filedate,_control.MyInfo.EmailAddressNormal,'B','N','N'); 

RETURN 		sequential(			
			build_key_header_adl_infutor_knowx, 
			build_key_header_teaser_did, 
			build_key_header_teaser_search, 
			build_key_infutorbest_did, 
			move_built_key_header_adl_infutor_knowx, 
			move_built_key_header_teaser_did, 
			move_built_key_header_teaser_search, 
			move_built_key_infutorbest_did, 
			move_qa_key_header_adl_infutor_knowx, 
			move_qa_key_header_teaser_did, 
			move_qa_key_header_teaser_search, 
			move_qa_key_infutorbest_did 
			// ,parallel(updatedops,updatedops_fcra) 
																							);

END;
