import roxiekeybuild, ut;

export  Proc_Build_Keys(string Pversion) := function
	
	//Build the bdid key    
	//Parms: Key_BDID file,Superfile,Logicalfile,output file
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(NaturalDisaster_Readiness.Key_BDID,
																						'~thor_data400::key::NaturalDisaster_Readiness::@version@::bdid',
																						'~thor_data400::key::NaturalDisaster_Readiness::'+Pversion+'::bdid',
																						build_bdid_key);

	//Build the linkids key    
	//Parms: Key_linkids file,Superfile,Logicalfile,output file
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(NaturalDisaster_Readiness.Key_LinkIDs.Key,
																						'~thor_data400::key::NaturalDisaster_Readiness::@version@::linkids',
																						'~thor_data400::key::NaturalDisaster_Readiness::'+Pversion+'::linkids',
																						 build_linkids_key);
											   
	//Move bdid key to Built
	//Parms: Superfile,Logicalfile,output file
    RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::NaturalDisaster_Readiness::@version@::bdid',
																					'~thor_data400::key::NaturalDisaster_Readiness::'+Pversion+'::bdid',
																					mv_bdid_key_to_built); 
																					
	//Move linkids key to Built
	//Parms: Superfile,Logicalfile,output file
    RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::NaturalDisaster_Readiness::@version@::linkids',
																					'~thor_data400::key::NaturalDisaster_Readiness::'+Pversion+'::linkids',
																					mv_linkids_key_to_built); 																					
																					
	//Move bdid key to QA
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::NaturalDisaster_Readiness::@version@::bdid', 'Q', mv_bdid_key_to_qa);

	//Move linkids key to QA
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::NaturalDisaster_Readiness::@version@::linkids', 'Q', mv_linkids_key_to_qa);										  										   
  
	NDR_Keys := sequential(
													parallel(build_bdid_key,
																	 build_linkids_key),
													parallel(mv_bdid_key_to_built,
																	 mv_linkids_key_to_built),
													parallel(mv_bdid_key_to_qa,
																	 mv_linkids_key_to_qa)
												 );
								            
	return NDR_Keys;
	end;
								            
