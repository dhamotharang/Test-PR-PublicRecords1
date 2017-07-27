import roxiekeybuild, ut;

export  proc_build_RoxieKeys(string Pversion) := function
	
//Build the bdid key
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Diversity_Certification.Key_DiversityCert_BDID,
																					 '~thor_data400::key::Diversity_Certification::@version@::bdid',
																					 '~thor_data400::key::Diversity_Certification::'+Pversion+'::bdid',
																					 build_bdid_key
																					 );
											 
											 
//Build the unique_id key
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(	Diversity_Certification.Key_UniqueID,
																						'~thor_data400::key::Diversity_Certification::@version@::UniqueID',
																						'~thor_data400::key::Diversity_Certification::'+Pversion+'::UniqueID',
																						build_unique_id_key
																					 );	
																					 
																					 
	//Build the DID key
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(	Diversity_Certification.Key_DiversityCert_DID,
																						'~thor_data400::key::Diversity_Certification::@version@::DID',
																						'~thor_data400::key::Diversity_Certification::'+Pversion+'::DID',
																						build_did_key
																					 );		
																					 
												 
//Build the LinkIds key
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(	Diversity_Certification.Key_LinkIds.key,
																						'~thor_data400::key::Diversity_Certification::@version@::LinkIds',
																						'~thor_data400::key::Diversity_Certification::'+Pversion+'::LinkIds',
																						build_LinkIds_key
																					 );
												
Keys :=  parallel  (	build_bdid_key,
											build_unique_id_key,
											build_did_key,
											build_LinkIds_key
                    );
								            
return Keys;
end;