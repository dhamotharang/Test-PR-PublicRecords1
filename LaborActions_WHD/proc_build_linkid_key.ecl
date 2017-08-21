import roxiekeybuild, ut;

export  proc_build_linkid_key(string Pversion) := function
	
	//Build the linkids key    
	//Parms: Key_linkids file,Superfile,Logicalfile,output file
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(LaborActions_WHD.Key_LinkIDs.Key,
																						'~thor_data400::key::LaborActions_WHD::@version@::linkids',
																						'~thor_data400::key::LaborActions_WHD::'+Pversion+'::linkids',
																						 build_linkids_key);
											   
	//Move linkids key to Built
	//Parms: Superfile,Logicalfile,output file
    RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::LaborActions_WHD::@version@::linkids',
																					'~thor_data400::key::LaborActions_WHD::'+Pversion+'::linkids',
																					mv_linkids_key_to_built); 
																					
	//Move linkids key to QA
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::LaborActions_WHD::@version@::linkids', 'Q', mv_linkids_key_to_qa);
										  										   
  linkids_Key := sequential(build_linkids_key,
	 												  mv_linkids_key_to_built,	
														mv_linkids_key_to_qa);
								            
	return linkids_Key;
	end;