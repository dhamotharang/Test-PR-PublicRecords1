IMPORT RoxieKeyBuild, ut;

EXPORT Proc_Build_RoxieKeys(STRING Pversion) := FUNCTION
	
	// Build the bdid key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(NCPDP.key_BDID,
											                       '~thor_data400::key::NCPDP::@version@::BDID',
											                       '~thor_data400::key::NCPDP::' + Pversion + '::BDID',
											                       build_bdid_key);

	// Build the dea key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(NCPDP.key_DEA,
											                       '~thor_data400::key::NCPDP::@version@::DEA',
											                       '~thor_data400::key::NCPDP::' + Pversion + '::DEA',
											                       build_dea_key);

	// Build the did key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(NCPDP.key_DID,
											                       '~thor_data400::key::NCPDP::@version@::DID',
											                       '~thor_data400::key::NCPDP::' + Pversion + '::DID',
											                       build_did_key);

	// Build the fein key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(NCPDP.key_FEIN,
											                       '~thor_data400::key::NCPDP::@version@::FEIN',
											                       '~thor_data400::key::NCPDP::' + Pversion + '::FEIN',
											                       build_fein_key);

	// Build the linkids key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(NCPDP.key_LINKIDS.key,
											                       '~thor_data400::key::NCPDP::@version@::LINKIDS',
											                       '~thor_data400::key::NCPDP::' + Pversion + '::LINKIDS',
											                       build_linkids_key);

	// Build the npi key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(NCPDP.key_NPI,
											                       '~thor_data400::key::NCPDP::@version@::NPI',
											                       '~thor_data400::key::NCPDP::' + Pversion + '::NPI',
											                       build_npi_key);

	// Build the provider id key... this is the payload key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(NCPDP.key_ProviderID,
											                       '~thor_data400::key::NCPDP::@version@::NCPDP_ID',
											                       '~thor_data400::key::NCPDP::' + Pversion + '::NCPDP_ID',
											                       build_provider_id_key);

	// Build the state license number and physical state key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(NCPDP.key_SLN_State,
											                       '~thor_data400::key::NCPDP::@version@::SLN_State',
											                       '~thor_data400::key::NCPDP::' + Pversion + '::SLN_State',
											                       build_sln_state_key);
	// Build the lnpid key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(NCPDP.key_LNpid,
											                       '~thor_data400::key::NCPDP::@version@::LNpid',
											                       '~thor_data400::key::NCPDP::' + Pversion + '::LNpid',
											                       build_lnpid_key);


//-------------------------------------------------------------------------------------------------

	// Move bdid key to Built
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::NCPDP::@version@::BDID',
										                    '~thor_data400::key::NCPDP::' + Pversion + '::BDID',
										                    mv_bdid_key_to_built);

	// Move dea key to Built
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::NCPDP::@version@::DEA',
										                     '~thor_data400::key::NCPDP::' + Pversion + '::DEA',
										                     mv_dea_key_to_built);

	// Move did key to Built
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::NCPDP::@version@::DID',
										                    '~thor_data400::key::NCPDP::' + Pversion + '::DID',
										                    mv_did_key_to_built);

	// Move fein key to Built
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::NCPDP::@version@::FEIN',
										                    '~thor_data400::key::NCPDP::' + Pversion + '::FEIN',
										                    mv_fein_key_to_built);

	// Move linkids key to Built
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::NCPDP::@version@::LINKIDS',
										                    '~thor_data400::key::NCPDP::' + Pversion + '::LINKIDS',
										                    mv_linkids_key_to_built);
	// Move npi key to Built
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::NCPDP::@version@::NPI',
										                    '~thor_data400::key::NCPDP::' + Pversion + '::NPI',
										                    mv_npi_key_to_built);

	// Move provider id key to Built
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::NCPDP::@version@::NCPDP_ID',
										                    '~thor_data400::key::NCPDP::' + Pversion + '::NCPDP_ID',
										                    mv_provider_id_key_to_built);

	// Move sln state key to Built
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::NCPDP::@version@::SLN_State',
										                    '~thor_data400::key::NCPDP::' + Pversion + '::SLN_State',
										                    mv_sln_state_key_to_built);
	
	// Move lnpid key to Built
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::NCPDP::@version@::lnpid',
										                    '~thor_data400::key::NCPDP::' + Pversion + '::lnpid',
										                    mv_lnpid_key_to_built);


//-------------------------------------------------------------------------------------------------

	// Move bdid key to QA
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::NCPDP::@version@::BDID', 'Q', mv_bdid_key_to_qa);

	// Move dea key to QA
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::NCPDP::@version@::DEA', 'Q', mv_dea_key_to_qa);

	// Move did key to QA
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::NCPDP::@version@::DID', 'Q', mv_did_key_to_qa);

	// Move fein key to QA
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::NCPDP::@version@::FEIN', 'Q', mv_fein_key_to_qa);

	// Move linkids key to QA
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::NCPDP::@version@::LINKIDS', 'Q', mv_linkids_key_to_qa);

	// Move npi key to QA
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::NCPDP::@version@::NPI', 'Q', mv_npi_key_to_qa);

	// Move provider id key to QA
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::NCPDP::@version@::NCPDP_ID', 'Q', mv_provider_id_key_to_qa);

	// Move sln state key to QA
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::NCPDP::@version@::SLN_State', 'Q', mv_sln_state_key_to_qa);

	// Move lnpid key to QA
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::NCPDP::@version@::lnpid', 'Q', mv_lnpid_key_to_qa);


//-------------------------------------------------------------------------------------------------

  Keys := SEQUENTIAL(PARALLEL(build_bdid_key,
															build_dea_key,
															build_did_key,
															build_fein_key,
															build_linkids_key,
															build_npi_key,
															build_provider_id_key,
															build_sln_state_key,
															build_lnpid_key),
										 PARALLEL(mv_bdid_key_to_built,
															mv_dea_key_to_built,
															mv_did_key_to_built,
															mv_fein_key_to_built,
															mv_linkids_key_to_built,															
															mv_npi_key_to_built,
															mv_provider_id_key_to_built,
															mv_sln_state_key_to_built, 
															mv_lnpid_key_to_built),
										 PARALLEL(mv_bdid_key_to_qa,
															mv_dea_key_to_qa,
															mv_did_key_to_qa,
															mv_fein_key_to_qa,
															mv_linkids_key_to_qa,
															mv_npi_key_to_qa,
															mv_provider_id_key_to_qa,
															mv_sln_state_key_to_qa,
															mv_lnpid_key_to_qa));

	RETURN Keys;
END;