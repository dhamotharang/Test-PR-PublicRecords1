import roxiekeybuild, ut, mxd_names;

export Proc_build_keys(string filedate) := function
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(	Key_Docket,
																							'~thor_data400::key::mxd_mxdocket::@version@::docket_idx',
																							'~thor_data400::key::mxd_mxdocket::'+filedate+'::docket_idx',
																							MXDocketKey);
																						 
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(	Key_DocketParty,
																							'~thor_data400::key::mxd_mxdocket::@version@::docket_party_idx',
																							'~thor_data400::key::mxd_mxdocket::'+filedate+'::docket_party_idx',
																							MXDocketPartyKey);		
																						 
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(	Key_DocketSearch,
																							'~thor_data400::key::mxd_mxdocket::@version@::docket_search_idx',
																							'~thor_data400::key::mxd_mxdocket::'+filedate+'::docket_search_idx',
																							MXDocketSearchKey);		
																						 
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(	Key_DocketMPHSearch,
																							'~thor_data400::key::mxd_mxdocket::@version@::docket_mph_search_idx',
																							'~thor_data400::key::mxd_mxdocket::'+filedate+'::docket_mph_search_idx',
																							MXDocketMPHSearchKey);	
	
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(	MXD_Names.Key_Synonym,
																							'~thor_data400::key::mxd_names::@version@::synonym_idx',
																							'~thor_data400::key::mxd_names::'+filedate+'::synonym_idx',
																							MXSynonymKey);		
																						 
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(	Key_DocketNum,
																							'~thor_data400::key::mxd_mxdocket::@version@::docket_num_idx',             
																							'~thor_data400::key::mxd_mxdocket::'+filedate+'::docket_num_idx',
																							MXDocketNumKey);																						 

	// ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
											   
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(	'~thor_data400::key::mxd_mxdocket::@version@::docket_idx',
																					'~thor_data400::key::mxd_mxdocket::'+filedate+'::docket_idx',
																					mv_MXDocketKey_to_built);  
																				
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(	'~thor_data400::key::mxd_mxdocket::@version@::docket_party_idx',
																					'~thor_data400::key::mxd_mxdocket::'+filedate+'::docket_party_idx',
																					mv_MXDocketPartyKey_to_built);  			
																				
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(	'~thor_data400::key::mxd_mxdocket::@version@::docket_search_idx',
																					'~thor_data400::key::mxd_mxdocket::'+filedate+'::docket_search_idx',
																					mv_MXDocketSearchKey_to_built);  
																				
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(	'~thor_data400::key::mxd_mxdocket::@version@::docket_mph_search_idx',
																					'~thor_data400::key::mxd_mxdocket::'+filedate+'::docket_mph_search_idx',
																					mv_MXDocketMPHSearchKey_to_built);  
	
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::mxd_names::@version@::synonym_idx',
																					'~thor_data400::key::mxd_names::'+filedate+'::synonym_idx',
																					mv_MXSynonymKey_to_built);  
																				
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::mxd_names::@version@::docket_num_idx',
																				'~thor_data400::key::mxd_names::'+filedate+'::docket_num_idx',
																					mv_MXDocketNumKey_to_built); 
																				
	// ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
																				
	RoxieKeyBuild.MAC_SK_Move_v2(	'~thor_data400::key::mxd_mxdocket::@version@::docket_idx', 
																																									'Q', mv_MXDocketKey_to_qa);
															 
	RoxieKeyBuild.MAC_SK_Move_v2(	'~thor_data400::key::mxd_mxdocket::@version@::docket_party_idx', 
																																									'Q', mv_MXDocketPartyKey_to_qa);			
															 
	RoxieKeyBuild.MAC_SK_Move_v2(	'~thor_data400::key::mxd_mxdocket::@version@::docket_search_idx', 
																																									'Q', mv_MXDocketSearchKey_to_qa);	
															 
	RoxieKeyBuild.MAC_SK_Move_v2(	'~thor_data400::key::mxd_mxdocket::@version@::docket_mph_search_idx', 
																																										'Q', mv_MXDocketMPHSearchKey_to_qa);		
															 
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::mxd_names::@version@::synonym_idx',
																																										'Q', mv_MXSynonymKey_to_qa);	
																 
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::mxd_mxdocket::@version@::docket_num_idx',
																																											'Q', mv_MXDocketNumKey_to_qa);																	 
// ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
										  										   
	build_MXD_Keys := sequential(parallel(MXDocketKey,
																							MXDocketPartyKey,
																							MXDocketSearchKey,
																							MXDocketMPHSearchKey,
																							MXSynonymKey,
																							MXDocketNumKey
																						 ),
																	parallel(mv_MXDocketKey_to_built,
																						mv_MXDocketPartyKey_to_built,
																						mv_MXDocketSearchKey_to_built,
																						mv_MXDocketMPHSearchKey_to_built,
																						mv_MXSynonymKey_to_built,
																						mv_MXDocketNumKey_to_built
																						),
																	parallel(mv_MXDocketKey_to_qa,
																						mv_MXDocketPartyKey_to_qa,
																						mv_MXDocketSearchKey_to_qa,
																						mv_MXDocketMPHSearchKey_to_qa,
																						mv_MXSynonymKey_to_qa,
																						mv_MXDocketNumKey_to_qa
																					 )
																);
	return build_MXD_Keys;
	end;