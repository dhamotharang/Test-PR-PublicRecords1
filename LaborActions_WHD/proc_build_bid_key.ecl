import roxiekeybuild, ut, LaborActions_WHD;

export  proc_build_bid_key(string Pversion) := function
	
	//Build the bid key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(LaborActions_WHD.Key_bid,
																						'~thor_data400::key::LaborActions_WHD::@version@::bid',
																						'~thor_data400::key::LaborActions_WHD::'+Pversion+'::bid',
																						build_bid_key);
											   
	//Move bid key to Built
    RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::LaborActions_WHD::@version@::bid',
																					'~thor_data400::key::LaborActions_WHD::'+Pversion+'::bid',
																					mv_bid_key_to_built); 
																					
	//Move bid key to QA
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::LaborActions_WHD::@version@::bid', 'Q', mv_bid_key_to_qa);
										  										   
   bid_Key := sequential(build_bid_key,
													mv_bid_key_to_built,	
													mv_bid_key_to_qa);
								            
	return bid_Key;
	end;