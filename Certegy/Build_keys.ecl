import roxiekeybuild,doxie,_control;
export Build_keys(string filedate) := function

// build index files
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(	key_certegy_did
											,'~thor_data400::key::certegy::@version@::did'
											,'~thor_data400::key::certegy::'+filedate+'::did'
											,certegy_did_key);

// Move keys to build
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(	'~thor_data400::key::certegy::@version@::did'
										,'~thor_data400::key::certegy::'+filedate+'::did'
										,mv_certegy_did_key);

// Move keys to QA
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::certegy::@version@::did', 'Q', mv_certegy_did_key_qa);


//Upate Roxie Page
UpdateRoxiePage := RoxieKeybuild.updateversion('CertegyKeys', filedate, _control.MyInfo.EmailAddressNotify,,'N');

build_keys := sequential(certegy_did_key
						 ,mv_certegy_did_key
						 ,mv_certegy_did_key_qa
						 ,UpdateRoxiePage
						): success(Certegy.Send_Email(filedate).KeySuccess), failure(Certegy.Send_Email(filedate).KeyFailure);						 
						 

						 
return build_keys;
end;
