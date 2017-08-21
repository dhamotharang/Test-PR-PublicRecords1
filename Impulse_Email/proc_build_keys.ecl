import ut, roxiekeybuild, _control;

export proc_build_Keys(string version_date) := function

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Impulse_Email.Key_Impulse_DID,'~thor_data400::key::impulse_email::@version@::did','~thor_data400::key::impulse_email::'+version_date+'::did',Key_did);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Impulse_Email.Key_Impulse_DID_FCRA,'~thor_data400::key::impulse_email::fcra::@version@::did','~thor_data400::key::impulse_email::fcra::'+version_date+'::did',Key_did_fcra);
	
	Keys := parallel(Key_did, Key_did_fcra);
	
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::impulse_email::@version@::did', '~thor_data400::key::impulse_email::'+version_date+'::did',mv1,Qa);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::impulse_email::fcra::@version@::did', '~thor_data400::key::impulse_email::fcra::'+version_date+'::did',mv2,Qa);
	
	Move_keys := parallel(mv1, mv2);
	
	RoxieKeyBuild.MAC_SK_Move_V2('~thor_data400::key::impulse_email::@version@::did','Q',toq1,2);
	RoxieKeyBuild.MAC_SK_Move_V2('~thor_data400::key::impulse_email::fcra::@version@::did','Q',toq2,2);
	
	To_qa := parallel(toq1,toq2);
	
	//Update Roxie Page with Key Version
	UpdateRoxiePage := sequential(RoxieKeybuild.updateversion('ImpulseEmailKeys', version_date, _control.MyInfo.EmailAddressNotify,,'N')
											,RoxieKeybuild.updateversion('FCRA_ImpulseEmailKeys', version_date, _control.MyInfo.EmailAddressNotify,,'F'));

	
	buildKey :=sequential(Keys,
												Move_keys,
												to_qa,
												UpdateRoxiePage);	

	return buildKey ;

end;