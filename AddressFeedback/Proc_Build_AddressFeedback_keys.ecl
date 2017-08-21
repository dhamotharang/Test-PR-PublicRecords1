 Import roxiekeybuild, ut;

Export Proc_Build_AddressFeedback_keys(string filedate) := function
	
	//Build the Phone key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Key_AddressFeedback,
											   '~thor_data400::key::AddressFeedback::@version@::Address',
											   '~thor_data400::key::AddressFeedback::'+filedate+'::Address',
											   build_Address_key);
											   
	//Move Phone key to Built
    RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::AddressFeedback::@version@::Address',
										  '~thor_data400::key::AddressFeedback::'+filedate+'::Address',
										  mv_Address_key_to_built);     											   
	//Move PHONE key to QA
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::AddressFeedback::@version@::Address', 'Q', mv_Address_key_to_qa);
										  										   
    build_AddressFeedback_Keys := sequential(build_Address_key,
										    mv_Address_key_to_built,	
											mv_Address_key_to_qa);
								            
	return build_AddressFeedback_Keys;
	end;