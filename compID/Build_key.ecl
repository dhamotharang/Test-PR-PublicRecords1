import roxiekeybuild,doxie;

export Build_key(string filedate) := function

// build index files
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(	Key_best_compID_DID
											,'~thor_data400::key::compID::@version@::did' 
											,'~thor_data400::key::compID::'+filedate+'::did'    
											,did_key);

// Move keys to build
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(	'~thor_data400::key::compID::@version@::did'
										,'~thor_data400::key::compID::'+filedate+'::did'
										,mv_did_key);

// Move keys to QA
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::compID::@version@::did','Q', mv_did_key_qa);

return sequential(did_key, mv_did_key, mv_did_key_qa);

end;