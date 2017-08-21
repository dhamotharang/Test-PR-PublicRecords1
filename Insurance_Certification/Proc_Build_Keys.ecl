import doxie, roxiekeybuild, ut, Insurance_Certification, Tools, VersionControl;

export  Proc_Build_Keys(string Pversion) := function

	//Build the bdid key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(
												Insurance_Certification.Key_BDID,
												'~thor_data400::key::Insurance_Certification::@version@::bdid',
												'~thor_data400::key::Insurance_Certification::'+Pversion+'::bdid',
												build_bdid_key);
												
	//Build the did key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(
												Insurance_Certification.Key_DID,
												'~thor_data400::key::Insurance_Certification::@version@::did',
												'~thor_data400::key::Insurance_Certification::'+Pversion+'::did',
												build_did_key);												

	//Build linkids key
	VersionControl.macBuildNewLogicalKeyWithName(insurance_certification.Key_LinkIds.Key,	insurance_certification.keynames(pversion,false,_Constants().name).LinkIds.New, build_LinkIds_key);	
	
	//Build the unique key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(
												Insurance_Certification.Key_UniqueCert,
												'~thor_data400::key::Insurance_Certification::@version@::certification::unique',
												'~thor_data400::key::Insurance_Certification::'+Pversion+'::certification::unique',
												build_unique_key);	

	//Build the uniquepol key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(
												Insurance_Certification.Key_UniquePol,
												'~thor_data400::key::Insurance_Certification::@version@::policy::unique',
												'~thor_data400::key::Insurance_Certification::'+Pversion+'::policy::unique',
												build_uniquepol_key);
	
	//Move bdid key to Built
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
											'~thor_data400::key::Insurance_Certification::@version@::bdid',
											'~thor_data400::key::Insurance_Certification::'+Pversion+'::bdid',
											mv_bdid_key_to_built); 
	
	//Move did key to Built
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
												'~thor_data400::key::Insurance_Certification::@version@::did',
												'~thor_data400::key::Insurance_Certification::'+Pversion+'::did',
												mv_did_key_to_built); 

	//Move linkids key to Built
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
												'~thor_data400::key::insurance_certification::@version@::linkids',
												'~thor_data400::key::Insurance_Certification::'+Pversion+'::linkids',
												mv_linkids_key_to_built); 
										
	//Move unique key to Built
    RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
												'~thor_data400::key::Insurance_Certification::@version@::certification::unique',
												'~thor_data400::key::Insurance_Certification::'+Pversion+'::certification::unique',
												mv_unique_key_to_built); 

	//Move uniquepol key to Built
    RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
												'~thor_data400::key::Insurance_Certification::@version@::policy::unique',
												'~thor_data400::key::Insurance_Certification::'+Pversion+'::policy::unique',
												mv_uniquepol_key_to_built); 
	
	//Move bdid key to QA
	RoxieKeyBuild.MAC_SK_Move_v2(
											'~thor_data400::key::Insurance_Certification::@version@::bdid',
											'Q', mv_bdid_key_to_qa);
										  										   
	//Move did key to QA
	RoxieKeyBuild.MAC_SK_Move_v2(
												'~thor_data400::key::Insurance_Certification::@version@::did',
												'Q', mv_did_key_to_qa);																						 

	//Move linkids key to QA
	RoxieKeyBuild.MAC_SK_Move_v2(
												'~thor_data400::key::Insurance_Certification::@version@::linkids',
												'Q', mv_linkids_key_to_qa);	

	//Move unique key to QA
	RoxieKeyBuild.MAC_SK_Move_v2(
												'~thor_data400::key::Insurance_Certification::@version@::certification::unique',
												'Q', mv_unique_key_to_qa);
												
	//Move uniquepol key to QA
	RoxieKeyBuild.MAC_SK_Move_v2(
												'~thor_data400::key::Insurance_Certification::@version@::policy::unique',
												'Q', mv_uniquepol_key_to_qa);
														
   Build_Keys := parallel
								 (sequential(build_bdid_key,
														mv_bdid_key_to_built,
														mv_bdid_key_to_qa),														
								 sequential(build_did_key,
														mv_did_key_to_built,
														mv_did_key_to_qa),
								 sequential(build_LinkIds_key,
														mv_linkids_key_to_built,
														mv_linkids_key_to_qa),
								 sequential(build_unique_key,
														mv_unique_key_to_built,
														mv_unique_key_to_qa),
								 sequential(build_uniquepol_key,														
														mv_uniquepol_key_to_built,														
														mv_uniquepol_key_to_qa)
								 );
																		            
	return Build_Keys;
	end;