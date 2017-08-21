import roxiekeybuild, ut;

export  proc_build_bdid_key(string Pversion) := function
	
	//Build the bdid key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(
												LaborActions_WHD.Key_BDID,
												'~thor_data400::key::LaborActions_WHD::@version@::bdid',
												'~thor_data400::key::LaborActions_WHD::'+Pversion+'::bdid',
												build_bdid_key);
											   
	//Move bdid key to Built
    RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
											'~thor_data400::key::LaborActions_WHD::@version@::bdid',
											'~thor_data400::key::LaborActions_WHD::'+Pversion+'::bdid',
											mv_bdid_key_to_built); 
																					
	//Move bdid key to QA
	RoxieKeyBuild.MAC_SK_Move_v2(
											'~thor_data400::key::LaborActions_WHD::@version@::bdid',
											'Q', mv_bdid_key_to_qa);
										  										   
   bdid_Key := sequential(build_bdid_key,
													mv_bdid_key_to_built,	
													mv_bdid_key_to_qa);
								            
	return bdid_Key;
	end;