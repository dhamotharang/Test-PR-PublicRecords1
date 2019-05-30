import dx_FirstData,Orbit3,RoxieKeyBuild,FirstData;
EXPORT proc_build_keys (STRING	pVersion):=function

	prefix := '~thor_data400::key::FirstData::FCRA::' + pVersion + '::';
	
	name_did := prefix + 'did';

	RoxieKeybuild.MAC_build_logical(dx_FirstData.key_DID(),FirstData.data_key_did_fcra(trim(lex_id,left,right)<>''),dx_FirstData.names('').i_did_FCRA,name_did,fcra_first_data_key);
	
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(dx_FirstData.names('').i_did_FCRA,name_did,ma_fcra_first_data_key);
	
	RoxieKeyBuild.Mac_SK_Move_v3('~thor_data400::key::FirstData::FCRA::did','Q',ma_fcra_first_data_key_to_qa,pVersion);

	// create_build := Orbit3.proc_Orbit3_CreateBuild ('First Data',filedate,'F');
	
	build_fcra_keys := sequential(
																fcra_first_data_key,
																ma_fcra_first_data_key,
																ma_fcra_first_data_key_to_qa
																);
																
return build_fcra_keys;
end;