IMPORT RoxieKeyBuild, ut;

EXPORT Proc_Build_RoxieKeys(STRING Pversion) := FUNCTION
	
	// Build the DEA key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(CNLD_Practitioner.key_DEA,
											                       '~thor_data400::key::CNLD_Practitioner::@version@::DEA',
											                       '~thor_data400::key::CNLD_Practitioner::' + Pversion + '::DEA',
											                       build_dea_key);
																						 
	// Build the fein key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(CNLD_Practitioner.key_fein,
											                       '~thor_data400::key::CNLD_Practitioner::@version@::TAXID',
											                       '~thor_data400::key::CNLD_Practitioner::' + Pversion + '::TAXID',
											                       build_fein_key);
																						 
	// Build the NPI key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(CNLD_Practitioner.key_NPI,
											                       '~thor_data400::key::CNLD_Practitioner::@version@::NPI',
											                       '~thor_data400::key::CNLD_Practitioner::' + Pversion + '::NPI',
											                       build_NPI_key);
																						 
	// Build the PractitionerID key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(CNLD_Practitioner.key_PractitionerID,
											                       '~thor_data400::key::CNLD_Practitioner::@version@::PractitionerID',
											                       '~thor_data400::key::CNLD_Practitioner::' + Pversion + '::PractitionerID',
											                       build_PractitionerID_key);
																						 
	// Build the stLicNum key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(CNLD_Practitioner.key_stLicNum,
											                       '~thor_data400::key::CNLD_Practitioner::@version@::stLicNum',
											                       '~thor_data400::key::CNLD_Practitioner::' + Pversion + '::stLicNum',
											                       build_stLicNum_key);		

	// Build the UPIN key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(CNLD_Practitioner.key_UPIN,
											                       '~thor_data400::key::CNLD_Practitioner::@version@::UPIN',
											                       '~thor_data400::key::CNLD_Practitioner::' + Pversion + '::UPIN',
											                       build_UPIN_key);	
																						 
	// Build the DID key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(CNLD_Practitioner.key_DID,
											                       '~thor_data400::key::CNLD_Practitioner::@version@::DID',
											                       '~thor_data400::key::CNLD_Practitioner::' + Pversion + '::DID',
											                       build_DID_key);		
																						 
	// Build the ZIP key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(CNLD_Practitioner.key_ZIP,
											                       '~thor_data400::key::CNLD_Practitioner::@version@::ZIP',
											                       '~thor_data400::key::CNLD_Practitioner::' + Pversion + '::ZIP',
											                       build_ZIP_key);																							 

//-------------------------------------------------------------------------------------------------

	// Move DEA key to Built
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::CNLD_Practitioner::@version@::DEA',
										                    '~thor_data400::key::CNLD_Practitioner::' + Pversion + '::DEA',
										                    mv_dea_key_to_built);
																				
	// Move FEIN key to Built
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::CNLD_Practitioner::@version@::TAXID',
										                    '~thor_data400::key::CNLD_Practitioner::' + Pversion + '::TAXID',
										                    mv_FEIN_key_to_built);
																				
	// Move NPI key to Built
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::CNLD_Practitioner::@version@::NPI',
										                    '~thor_data400::key::CNLD_Practitioner::' + Pversion + '::NPI',
										                    mv_NPI_key_to_built);
																				
	// Move PractitionerID key to Built
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::CNLD_Practitioner::@version@::PractitionerID',
										                    '~thor_data400::key::CNLD_Practitioner::' + Pversion + '::PractitionerID',
										                    mv_PractitionerID_key_to_built);
																				
	// Move stLicNum key to Built
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::CNLD_Practitioner::@version@::stLicNum',
										                    '~thor_data400::key::CNLD_Practitioner::' + Pversion + '::stLicNum',
										                    mv_stLicNum_key_to_built);
																				
	// Move UPIN key to Built
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::CNLD_Practitioner::@version@::UPIN',
										                    '~thor_data400::key::CNLD_Practitioner::' + Pversion + '::UPIN',
										                    mv_UPIN_key_to_built);
																				
	// Move DID key to Built
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::CNLD_Practitioner::@version@::DID',
										                    '~thor_data400::key::CNLD_Practitioner::' + Pversion + '::DID',
										                    mv_DID_key_to_built);
																				
	// Move ZIP key to Built
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::CNLD_Practitioner::@version@::ZIP',
										                    '~thor_data400::key::CNLD_Practitioner::' + Pversion + '::ZIP',
										                    mv_ZIP_key_to_built);
																				
//-------------------------------------------------------------------------------------------------

	// Move DEA key to QA
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::CNLD_Practitioner::@version@::DEA', 'Q', mv_dea_key_to_qa);
	
	// Move FEIN key to QA
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::CNLD_Practitioner::@version@::TAXID', 'Q', mv_FEIN_key_to_qa);
	
	// Move NPI key to QA
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::CNLD_Practitioner::@version@::NPI', 'Q', mv_NPI_key_to_qa);
	
	// Move PractitionerID key to QA
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::CNLD_Practitioner::@version@::PractitionerID', 'Q', mv_PractitionerID_key_to_qa);
	
	// Move stLicNum key to QA
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::CNLD_Practitioner::@version@::stLicNum', 'Q', mv_stLicNum_key_to_qa);
	
	// Move UPIN key to QA
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::CNLD_Practitioner::@version@::UPIN', 'Q', mv_UPIN_key_to_qa);
	
	// Move DID key to QA
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::CNLD_Practitioner::@version@::DID', 'Q', mv_DID_key_to_qa);
	
	// Move ZIP key to QA
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::CNLD_Practitioner::@version@::ZIP', 'Q', mv_ZIP_key_to_qa);

//-------------------------------------------------------------------------------------------------

  Keys := SEQUENTIAL(PARALLEL(build_dea_key,
															build_fein_key,
															build_npi_key,
															build_practitionerID_key,
															build_upin_key,
															build_DID_key,
															build_ZIP_key,
															build_stlicnum_key
															),
										 PARALLEL(mv_dea_key_to_built,
															mv_FEIN_key_to_built,
															mv_NPI_key_to_built,
															mv_practitionerID_key_to_built,
															mv_UPIN_key_to_built,
															mv_DID_key_to_built,
															mv_ZIP_key_to_built,
															mv_stLicNum_key_to_built
															),
										 PARALLEL(mv_dea_key_to_qa,
															mv_FEIN_key_to_qa,
															mv_NPI_key_to_qa,
															mv_PractitionerID_key_to_qa,
															mv_stLicNum_key_to_qa,
															mv_UPIN_key_to_qa,
															mv_DID_key_to_qa,
															mv_ZIP_key_to_qa															
															)
										 );

	RETURN Keys;
END;