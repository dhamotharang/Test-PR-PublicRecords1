import roxiekeybuild, ut, phonesfeedback;

EXPORT Promote_Keys(string filedate, string1 BuildType) := function

	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::phonesFeedback::@version@::phone', 'Q', mv_full_phone_key_to_qa);
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::phonesFeedback::@version@::DID', 'Q', mv_full_did_key_to_qa);
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::phonesFeedback::@version@::address', 'Q', mv_full_address_key_to_qa);

	mv_phone_key_to_qa	:=	if (BuildType = 'D',
																fileServices.AddSuperFile ('~thor_data400::key::phonesFeedback::QA::phone', '~thor_data400::key::phonesFeedback::'+filedate+'::phone'),
																mv_full_phone_key_to_qa
															);

	mv_did_key_to_qa		:=	if (BuildType = 'D',
																fileServices.AddSuperFile ('~thor_data400::key::phonesFeedback::QA::DID', '~thor_data400::key::phonesFeedback::'+filedate+'::DID'),
																mv_full_DID_key_to_qa
															);
															
	mv_address_key_to_qa:=	if (BuildType = 'D',
																fileServices.AddSuperFile ('~thor_data400::key::phonesFeedback::QA::address', '~thor_data400::key::phonesFeedback::'+filedate+'::address'),
																mv_full_address_key_to_qa
															);															

  Promote_PhonesFeedback_Keys := sequential(parallel(mv_phone_key_to_qa,mv_did_key_to_qa,mv_address_key_to_qa));
								            
	return Promote_PhonesFeedback_Keys;
	
end;	