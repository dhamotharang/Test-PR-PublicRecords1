import roxiekeybuild,doxie;
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

build_keys := sequential(certegy_did_key
						 ,mv_certegy_did_key
						 ,mv_certegy_did_key_qa
						 );
return build_keys;
end;
