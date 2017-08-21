import roxiekeybuild, ut;

export proc_build_phonesFeedback_keys(string filedate) := function
	
//Build Phone,DID and Address Keys

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Key_PhonesFeedback_PHONE,
											   '~thor_data400::key::phonesFeedback::@version@::PHONE',
											   '~thor_data400::key::phonesFeedback::'+filedate+'::PHONE',
											   build_phone_key);
												 

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Key_PhonesFeedback_DID,
											   '~thor_data400::key::phonesFeedback::@version@::DID',
											   '~thor_data400::key::phonesFeedback::'+filedate+'::DID',
											   build_did_key);
												 
	
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Key_PhonesFeedback_Address,
											   '~thor_data400::key::phonesFeedback::@version@::address',
											   '~thor_data400::key::phonesFeedback::'+filedate+'::address',
											   build_address_key);
											   
//Move keys to Built
    RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::phonesFeedback::@version@::phone',
										  '~thor_data400::key::phonesFeedback::'+filedate+'::phone',
										  mv_phone_key_to_built);  
											
											
	
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::phonesFeedback::@version@::DID',
										  '~thor_data400::key::phonesFeedback::'+filedate+'::DID',
										  mv_did_key_to_built); 
											
	
		RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::phonesFeedback::@version@::address',
										  '~thor_data400::key::phonesFeedback::'+filedate+'::address',
										  mv_address_key_to_built);
	
	//Move keys to QA
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::phonesFeedback::@version@::phone', 'Q', mv_phone_key_to_qa);
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::phonesFeedback::@version@::DID', 'Q', mv_did_key_to_qa);
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::phonesFeedback::@version@::address', 'Q', mv_address_key_to_qa);
										  										   
    build_PhonesFeedback_Keys := sequential(parallel(build_phone_key,build_did_key,build_address_key),
										                        parallel(mv_phone_key_to_built,mv_did_key_to_built,mv_address_key_to_built),
																						parallel(mv_phone_key_to_qa,mv_did_key_to_qa,mv_address_key_to_qa));
								            
	return build_PhonesFeedback_Keys;
	end;