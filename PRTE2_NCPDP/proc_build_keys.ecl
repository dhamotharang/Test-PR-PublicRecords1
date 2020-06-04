import RoxieKeyBuild, prte2_ncpdp, PRTE2_Common,_control,PRTE, dops, prte2, orbit3,_control; 

EXPORT proc_build_keys(string pversion, boolean skipDOPS=FALSE, string emailTo= '') := function

// Build Roxie Keys
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(prte2_ncpdp.keys.BDID, prte2_ncpdp.Constants.SuperKeyName + 'bdid', prte2_ncpdp.Constants.KEY_PREFIX + pversion + '::bdid', bdid_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(prte2_ncpdp.keys.DEA, prte2_ncpdp.Constants.SuperKeyName + 'dea', prte2_ncpdp.Constants.KEY_PREFIX + pversion + '::dea', dea_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(prte2_ncpdp.keys.DID, prte2_ncpdp.Constants.SuperKeyName + 'did', prte2_ncpdp.Constants.KEY_PREFIX + pversion + '::did', did_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(prte2_ncpdp.keys.FEIN, prte2_ncpdp.Constants.SuperKeyName + 'fein', prte2_ncpdp.Constants.KEY_PREFIX + pversion + '::fein', fein_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(prte2_ncpdp.keys.LINKIDS.key, prte2_ncpdp.Constants.SuperKeyName + 'linkids', prte2_ncpdp.Constants.KEY_PREFIX + pversion + '::linkids', linkids_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(prte2_ncpdp.keys.NPI, prte2_ncpdp.Constants.SuperKeyName + 'npi', prte2_ncpdp.Constants.KEY_PREFIX + pversion + '::npi', npi_key);

	// Build the provider id key... this is the payload key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(prte2_ncpdp.keys.ncpdp_id, prte2_ncpdp.Constants.SuperKeyName + 'ncpdp_id', prte2_ncpdp.Constants.KEY_PREFIX + pversion + '::ncpdp_id', provider_id_key);
  RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(prte2_ncpdp.keys.sln_State, prte2_ncpdp.Constants.SuperKeyName + 'SLN_State', prte2_ncpdp.Constants.KEY_PREFIX + pversion + '::SLN_State', sln_state_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(prte2_ncpdp.keys.LNpid, prte2_ncpdp.Constants.SuperKeyName + 'lnpid', prte2_ncpdp.Constants.KEY_PREFIX + pversion + '::lnpid', lnpid_key);

	build_roxie_keys := parallel(bdid_key,dea_key,did_key,fein_key,linkids_key,npi_key, 
																provider_id_key,sln_state_key,lnpid_key
																);


	// Move roxie keys to build
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2(prte2_ncpdp.Constants.SuperKeyName + 'BDID', prte2_ncpdp.Constants.KEY_PREFIX + pversion + '::BDID', mv_bdid_key);
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2(prte2_ncpdp.Constants.SuperKeyName +'DEA',   prte2_ncpdp.Constants.KEY_PREFIX + pversion + '::DEA', mv_dea_key);
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2(prte2_ncpdp.Constants.SuperKeyName + 'DID',  prte2_ncpdp.Constants.KEY_PREFIX + pversion + '::DID',  mv_did_key);
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2(prte2_ncpdp.Constants.SuperKeyName + 'FEIN', prte2_ncpdp.Constants.KEY_PREFIX + pversion + '::FEIN', mv_fein_key);
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2(prte2_ncpdp.Constants.SuperKeyName+ 'LINKIDS', prte2_ncpdp.Constants.KEY_PREFIX + pversion + '::LINKIDS', mv_linkids_key);
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2(prte2_ncpdp.Constants.SuperKeyName+ 'NPI', prte2_ncpdp.Constants.KEY_PREFIX + pversion + '::NPI', mv_npi_key);
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2(prte2_ncpdp.Constants.SuperKeyName+ 'ncpdp_ID', prte2_ncpdp.Constants.KEY_PREFIX + Pversion + '::ncpdp_ID', mv_provider_id_key);
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2(prte2_ncpdp.Constants.SuperKeyName + 'SLN_State',  prte2_ncpdp.Constants.KEY_PREFIX + Pversion + '::SLN_State', mv_sln_state_key);
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2(prte2_ncpdp.Constants.SuperKeyName+ 'lnpid', prte2_ncpdp.Constants.KEY_PREFIX + Pversion + '::lnpid', mv_lnpid_key);

	Move_keys := parallel(mv_bdid_key, mv_dea_key, mv_did_key, mv_fein_key, mv_linkids_key,
												mv_npi_key, mv_provider_id_key, mv_sln_state_key, mv_lnpid_key
												);

	// Move roxie keys to QA
	RoxieKeyBuild.MAC_SK_Move_v2(prte2_ncpdp.Constants.SuperKeyName+ 'BDID', 			'Q', mv_bdid_key_qa);
	RoxieKeyBuild.MAC_SK_Move_v2(prte2_ncpdp.Constants.SuperKeyName+ 'DEA', 			'Q', mv_dea_key_qa);
	RoxieKeyBuild.MAC_SK_Move_v2(prte2_ncpdp.Constants.SuperKeyName+ 'DID', 			'Q', mv_did_key_qa);
	RoxieKeyBuild.MAC_SK_Move_v2(prte2_ncpdp.Constants.SuperKeyName+ 'FEIN', 			'Q', mv_fein_key_qa);
	RoxieKeyBuild.MAC_SK_Move_v2(prte2_ncpdp.Constants.SuperKeyName+ 'LINKIDS', 	'Q', mv_linkids_key_qa);
	RoxieKeyBuild.MAC_SK_Move_v2(prte2_ncpdp.Constants.SuperKeyName+ 'NPI', 			'Q', mv_npi_key_qa);
	RoxieKeyBuild.MAC_SK_Move_v2(prte2_ncpdp.Constants.SuperKeyName+ 'ncpdp_ID',	'Q', mv_provider_id_key_qa);
	RoxieKeyBuild.MAC_SK_Move_v2(prte2_ncpdp.Constants.SuperKeyName+ 'SLN_State', 'Q', mv_sln_state_key_qa);
	RoxieKeyBuild.MAC_SK_Move_v2(prte2_ncpdp.Constants.SuperKeyName+ 'lnpid', 		'Q', mv_lnpid_key_qa);

	To_qa	:= parallel(mv_bdid_key_qa, mv_dea_key_qa, mv_did_key_qa, mv_fein_key_qa, mv_linkids_key_qa,
												mv_npi_key_qa, mv_provider_id_key_qa, mv_sln_state_key_qa, mv_lnpid_key_qa
												);

	//Autokeys
	autokeys_ContLegalMail 	:= prte2_ncpdp.proc_build_autokeys_ContLegalMail(pversion);
	autokeys_ContLegalPhys 	:= prte2_ncpdp.proc_build_autokeys_ContLegalPhys(pversion);
	autokeys_DBAMail 				:= prte2_ncpdp.proc_build_autokeys_DBAMail(pversion);
	autokeys_DBAPhys 				:= prte2_ncpdp.proc_build_autokeys_DBAPhys(pversion);


//---------- making DOPS optional -------------------------------
	dataset_name				:= 'NCPDPKeys';
	is_running_in_prod 	:= PRTE2_Common.Constants.is_running_in_prod;
	doDOPS 							:= is_running_in_prod AND NOT skipDOPS;
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
	updatedops					:= PRTE.UpdateVersion(dataset_name, pversion, notifyEmail,l_inloc:='B',l_inenvment:='N',l_includeboolean := 'N');
	PerformUpdateOrNot	:= IF(doDOPS,updatedops,NoUpdate);
	//----------------------------------------------------------------

	//Key Validation
	key_validation 			:=  output(dops.ValidatePRCTFileLayout(pversion, prte2.Constants.ipaddr_prod, prte2.Constants.ipaddr_roxie_nonfcra,dataset_name, 'N'), named(dataset_name+'Validation'));
	
	//Orbit Build
	create_orbit_build	:= Orbit3.proc_Orbit3_CreateBuild('PRTE - NCPDP', pVersion, 'N', true, true, false,  _control.MyInfo.EmailAddressNormal);

  Keys := SEQUENTIAL(build_roxie_keys,
										 move_keys,
										 to_qa,
										 autokeys_ContLegalMail,
										 autokeys_ContLegalPhys,
										 autokeys_DBAMail,
										 autokeys_DBAPhys,
										 PerformUpdateOrNot,
										 key_validation,
										 create_orbit_build
										 );
	RETURN Keys;

END;