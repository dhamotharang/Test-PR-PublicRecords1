import roxiekeybuild, ut;

export proc_build_phonesFeedback_keys(string filedate) := function
	
	//Build the Phone key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Key_PhonesFeedback_PHONE,
											   '~thor_data400::key::phonesFeedback::@version@::PHONE',
											   '~thor_data400::key::phonesFeedback::'+filedate+'::PHONE',
											   build_phone_key);
											   
	//Move Phone key to Built
    RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::phonesFeedback::@version@::phone',
										  '~thor_data400::key::phonesFeedback::'+filedate+'::phone',
										  mv_phone_key_to_built);     											   
	//Move PHONE key to QA
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::phonesFeedback::@version@::phone', 'Q', mv_phone_key_to_qa);
										  										   
    build_PhonesFeedback_Keys := sequential(parallel(build_phone_key),
										    parallel(mv_phone_key_to_built),	
											parallel(mv_phone_key_to_qa));
								            
	return build_PhonesFeedback_Keys;
	end;