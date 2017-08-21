import roxiekeybuild, ut;

export  proc_build_bdid_key(string Pversion) := function
	
	//Build the bdid key    
	//Parms: Key_BDID file,Superfile,Logicalfile,output file
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(NaturalDisaster_Readiness.Key_BDID,
																						'~thor_data400::key::NaturalDisaster_Readiness::@version@::bdid',
																						'~thor_data400::key::NaturalDisaster_Readiness::'+Pversion+'::bdid',
																						build_bdid_key);
											   
	//Move bdid key to Built
	//Parms: Superfile,Logicalfile,output file
    RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::NaturalDisaster_Readiness::@version@::bdid',
																					'~thor_data400::key::NaturalDisaster_Readiness::'+Pversion+'::bdid',
																					mv_bdid_key_to_built); 
																					
	//Move bdid key to QA
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::NaturalDisaster_Readiness::@version@::bdid', 'Q', mv_bdid_key_to_qa);
										  										   
   bdid_Key := sequential(build_bdid_key,
													mv_bdid_key_to_built,	
													mv_bdid_key_to_qa);
								            
	return bdid_Key;
	end;