import roxiekeybuild, ut;

export  proc_build_RoxieKeys_BID(string Pversion) := function
	
	//Build the bid key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Diversity_Certification.Key_DiversityCert_BID,
											   '~thor_data400::key::Diversity_Certification::@version@::bid',
											   '~thor_data400::key::Diversity_Certification::'+Pversion+'::bid',
											   build_bid_key);
	//Build the unique_id_BID key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(	Diversity_Certification.Key_UniqueID_BID,
												'~thor_data400::key::Diversity_Certification::@version@::Bid::UniqueID',
												'~thor_data400::key::Diversity_Certification::'+Pversion+'::Bid::UniqueID',
														build_unique_id_bid_key	 );	
																						 
												 
	//Build the DID_BID key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(	Diversity_Certification.Key_DiversityCert_DID_BID,
												'~thor_data400::key::Diversity_Certification::@version@::Bid::DID',
												'~thor_data400::key::Diversity_Certification::'+Pversion+'::Bid::DID',
													build_did_bid_key);
																									   
	//Move bid key to Built
    RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::Diversity_Certification::@version@::bid',
										  '~thor_data400::key::Diversity_Certification::'+Pversion+'::bid',
										  mv_bid_key_to_built);
	//Move uniqueID_BID key to Built
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::Diversity_Certification::@version@::Bid::UniqueID',
										'~thor_data400::key::Diversity_Certification::'+Pversion+'::Bid::UniqueID',
												mv_unique_id_bid_key_to_built	 ); 
																				 
	//Move DID_BID key to Built
   RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::Diversity_Certification::@version@::Bid::did',
										'~thor_data400::key::Diversity_Certification::'+Pversion+'::Bid::did',
											mv_did_bid_key_to_built	);																				 
															  
	//Move bid key to QA
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::Diversity_Certification::@version@::bid', 'Q', mv_bid_key_to_qa);
	//Move uniqueID_BID key to QA
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::Diversity_Certification::@version@::Bid::uniqueID', 'Q', mv_unique_id_bid_key_to_qa);
	
	//Move DID_BID key to QA
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::Diversity_Certification::@version@::Bid::did', 'Q', mv_did_bid_key_to_qa);	
	

										  										   
   Keys := sequential(parallel(	
																build_bid_key,
																build_unique_id_bid_key,
																build_did_bid_key
															 ),
											parallel(	
																mv_bid_key_to_built,	
																mv_unique_id_bid_key_to_built,
																mv_did_bid_key_to_built
															 ),
											parallel(	
																mv_bid_key_to_qa,
																mv_unique_id_bid_key_to_qa,
																mv_did_bid_key_to_qa
															 )
											);
								            
	return Keys;
	end;