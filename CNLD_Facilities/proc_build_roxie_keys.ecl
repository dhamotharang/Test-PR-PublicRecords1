IMPORT RoxieKeyBuild, ut;

EXPORT proc_build_roxie_keys(STRING filedate) := FUNCTION
	
	// Build the bdid key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(CNLD_Facilities.key_BDID,
											                       '~thor_data400::key::cnldfacilities::@version@::BDID',
											                       '~thor_data400::key::cnldfacilities::' + filedate + '::BDID',
											                       build_bdid_key);
	// Build the LinkIDs key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(CNLD_Facilities.key_LinkIDs.key,
											                       '~thor_data400::key::cnldfacilities::@version@::LinkIDs',
											                       '~thor_data400::key::cnldfacilities::' + filedate + '::LinkIDs',
											                       build_LinkIDs_key);
	// Build the dea key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(CNLD_Facilities.key_dea,
											                       '~thor_data400::key::cnldfacilities::@version@::DEA',
											                       '~thor_data400::key::cnldfacilities::' + filedate + '::DEA',
											                       build_dea_key);
	// Build the fein key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(CNLD_Facilities.key_fein,
											                       '~thor_data400::key::cnldfacilities::@version@::FEIN',
											                       '~thor_data400::key::cnldfacilities::' + filedate + '::FEIN',
											                       build_fein_key);

// Build the gennum key... this is the payload key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(CNLD_Facilities.key_gennum,
											                       '~thor_data400::key::cnldfacilities::@version@::GENNUM',
											                       '~thor_data400::key::cnldfacilities::' + filedate + '::GENNUM',
											                       build_gennum_key);
	
	// Build the license key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(CNLD_Facilities.key_license_nbr,
											                       '~thor_data400::key::cnldfacilities::@version@::LICENSE_NBR',
											                       '~thor_data400::key::cnldfacilities::' + filedate + '::LICENSE_NBR',
											                       build_license_key);
	// Build the ncpdp key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(CNLD_Facilities.key_ncpdp,
											                       '~thor_data400::key::cnldfacilities::@version@::NCPDP',
											                       '~thor_data400::key::cnldfacilities::' + filedate + '::NCPDP',
											                       build_ncpdp_key);
	// Build the npi key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(CNLD_Facilities.key_npi,
											                       '~thor_data400::key::cnldfacilities::@version@::NPI',
											                       '~thor_data400::key::cnldfacilities::' + filedate + '::NPI',
											                       build_npi_key);

	// Build the zipcode key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(CNLD_Facilities.key_zipcode,
											                       '~thor_data400::key::cnldfacilities::@version@::ZIPCODE',
											                       '~thor_data400::key::cnldfacilities::' + filedate + '::ZIPCODE',
											                       build_zipcode_key);
	
//-------------------------------------------------------------------------------------------------

	// Move bdid key to Built
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::cnldfacilities::@version@::BDID',
										                    '~thor_data400::key::cnldfacilities::' + filedate + '::BDID',
										                    mv_bdid_key_to_built);
	// Move LinkIDs key to Built
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::cnldfacilities::@version@::LinkIDs',
										                    '~thor_data400::key::cnldfacilities::' + filedate + '::LinkIDs',
										                    mv_LinkIDs_key_to_built);
	// Move dea key to Built
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::cnldfacilities::@version@::DEA',
										                     '~thor_data400::key::cnldfacilities::' + filedate + '::DEA',
										                     mv_dea_key_to_built);

	// Move fein key to Built
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::cnldfacilities::@version@::FEIN',
										                    '~thor_data400::key::cnldfacilities::' + filedate + '::FEIN',
										                    mv_fein_key_to_built);

	// Move gennum key to Built
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::cnldfacilities::@version@::GENNUM',
										                    '~thor_data400::key::cnldfacilities::' + filedate + '::GENNUM',
										                    mv_gennum_key_to_built);


	// Move license key to Built
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::cnldfacilities::@version@::LICENSE_NBR',
										                    '~thor_data400::key::cnldfacilities::' + filedate + '::LICENSE_NBR',
										                    mv_license_key_to_built);

	// Move ncpdp key to Built
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::cnldfacilities::@version@::NCPDP',
										                    '~thor_data400::key::cnldfacilities::' + filedate + '::NCPDP',
										                    mv_ncpdp_key_to_built);	
	
	// Move npi key to Built
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::cnldfacilities::@version@::NPI',
										                    '~thor_data400::key::cnldfacilities::' + filedate + '::NPI',
										                    mv_npi_key_to_built);

// Move zipcode key to Built
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::cnldfacilities::@version@::ZIPCODE',
										                    '~thor_data400::key::cnldfacilities::' + filedate + '::ZIPCODE',
										                    mv_zipcode_key_to_built);
	
//-------------------------------------------------------------------------------------------------

	// Move bdid key to QA
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::cnldfacilities::@version@::BDID', 'Q', mv_bdid_key_to_qa);
	
	// Move LinkIDs key to QA
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::cnldfacilities::@version@::LinkIDs', 'Q', mv_LinkIDs_key_to_qa);

	// Move dea key to QA
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::cnldfacilities::@version@::DEA', 'Q', mv_dea_key_to_qa);

	// Move fein key to QA
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::cnldfacilities::@version@::FEIN', 'Q', mv_fein_key_to_qa);
	
	// Move gennum key to QA
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::cnldfacilities::@version@::GENNUM', 'Q', mv_gennum_key_to_qa);
	
	// Move license key to QA
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::cnldfacilities::@version@::LICENSE_NBR', 'Q', mv_license_key_to_qa);

	// Move ncpdp key to QA
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::cnldfacilities::@version@::NCPDP', 'Q', mv_ncpdp_key_to_qa);

	// Move npi key to QA
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::cnldfacilities::@version@::NPI', 'Q', mv_npi_key_to_qa);

	// Move zipcode key to QA
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::cnldfacilities::@version@::ZIPCODE', 'Q', mv_zipcode_key_to_qa);


//-------------------------------------------------------------------------------------------------

  Keys := SEQUENTIAL(PARALLEL(build_bdid_key,
															build_LinkIDs_key,
															build_dea_key,
															build_fein_key,
															build_gennum_key,
															build_license_key,
															build_ncpdp_key,
															build_npi_key,
															build_zipcode_key),
										 PARALLEL(mv_bdid_key_to_built,
															mv_LinkIDs_key_to_built,
															mv_dea_key_to_built,
															mv_fein_key_to_built,
															mv_gennum_key_to_built,
															mv_license_key_to_built,
															mv_ncpdp_key_to_built,
															mv_npi_key_to_built,
															mv_zipcode_key_to_built),
										 PARALLEL(mv_bdid_key_to_qa,
															mv_LinkIDs_key_to_qa,
															mv_dea_key_to_qa,
															mv_fein_key_to_qa,
															mv_gennum_key_to_qa,
															mv_license_key_to_qa,
															mv_ncpdp_key_to_qa,
															mv_npi_key_to_qa,
															mv_zipcode_key_to_qa));

	RETURN Keys;
END;