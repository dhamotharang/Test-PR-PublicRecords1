import roxiekeybuild, ut;

export Proc_build_keys(string filedate) := function
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(	MXD_Professions.Key_Profession,
																							'~thor_data400::key::mxd_professions::@version@::prof_idx',
																							'~thor_data400::key::mxd_professions::'+filedate+'::prof_idx',
																							MXProfessionKey
																						 );
																						 
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(	MXD_Professions.Key_ProfSearch,
																							'~thor_data400::key::mxd_professions::@version@::prof_search_idx',
																							'~thor_data400::key::mxd_professions::'+filedate+'::prof_search_idx',
																							MXProfessionSearchKey
																						 );		
																						 
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(	MXD_Professions.Key_ProfMPHSearch,
																							'~thor_data400::key::mxd_professions::@version@::prof_mph_search_idx',
																							'~thor_data400::key::mxd_professions::'+filedate+'::prof_mph_search_idx',
																							MXProfessionMPHSearchKey
																						 );	
																						 
//--------------------------------------------------------------------------------																						 
											   
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(	'~thor_data400::key::mxd_professions::@version@::prof_idx',
																					'~thor_data400::key::mxd_professions::'+filedate+'::prof_idx',
																					mv_MXProfessionKey_to_built
																			  );  	
																				
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(	'~thor_data400::key::mxd_professions::@version@::prof_search_idx',
																					'~thor_data400::key::mxd_professions::'+filedate+'::prof_search_idx',
																					mv_MXProfessionSearchKey_to_built
																			  );  
																				
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(	'~thor_data400::key::mxd_professions::@version@::prof_mph_search_idx',
																					'~thor_data400::key::mxd_professions::'+filedate+'::prof_mph_search_idx',
																					mv_MXProfessionMPHSearchKey_to_built
																			  );  
																				
//--------------------------------------------------------------------------------
																				
	RoxieKeyBuild.MAC_SK_Move_v2(	'~thor_data400::key::mxd_professions::@version@::prof_idx', 
																'Q', 
																mv_MXProfessionKey_to_qa
															 );

	RoxieKeyBuild.MAC_SK_Move_v2(	'~thor_data400::key::mxd_professions::@version@::prof_search_idx', 
																'Q', 
																mv_MXProfessionSearchKey_to_qa
															 );	
															 
	RoxieKeyBuild.MAC_SK_Move_v2(	'~thor_data400::key::mxd_professions::@version@::prof_mph_search_idx', 
																'Q', 
																mv_MXProfessionMPHSearchKey_to_qa
															 );		
															 
//--------------------------------------------------------------------------------															 
										  										   
	build_Profession_Keys := sequential(parallel(
																								MXProfessionKey,
																								MXProfessionSearchKey,
																								MXProfessionMPHSearchKey
																							),
																			parallel(
																								mv_MXProfessionKey_to_built,
																								mv_MXProfessionSearchKey_to_built,
																								mv_MXProfessionMPHSearchKey_to_built
																							),
																			parallel(
																								mv_MXProfessionKey_to_qa,
																								mv_MXProfessionSearchKey_to_qa,
																								mv_MXProfessionMPHSearchKey_to_qa
																							)
																			);
								            
	return build_Profession_Keys;
	end;

