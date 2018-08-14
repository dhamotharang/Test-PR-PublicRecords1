import PRTE_CSV, RoxieKeyBuild, UT;

export FAA_Promote_Keys	(string pVersion
												,boolean pUseOtherEnvironment = false
												) := module

// NON-FCRA FAA Keys - Move to Built		
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(PRTE_CSV.FAA_Keyfilenames(,pUseOtherEnvironment).FAA_Keys_NonFCRA.aircraft_info.old,  PRTE_CSV.FAA_Keyfilenames(pVersion,pUseOtherEnvironment).FAA_Keys_NonFCRA.aircraft_info.old,  aircraft_info_mv_2built);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(PRTE_CSV.FAA_Keyfilenames(,pUseOtherEnvironment).FAA_Keys_NonFCRA.engine_info.old,	PRTE_CSV.FAA_Keyfilenames(pVersion,pUseOtherEnvironment).FAA_Keys_NonFCRA.engine_info.old,  engine_info_mv_2built);	
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(PRTE_CSV.FAA_Keyfilenames(,pUseOtherEnvironment).FAA_Keys_NonFCRA.aircraft_id.old,	PRTE_CSV.FAA_Keyfilenames(pVersion,pUseOtherEnvironment).FAA_Keys_NonFCRA.aircraft_id.old,  aircraft_id_mv_2built);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(PRTE_CSV.FAA_Keyfilenames(,pUseOtherEnvironment).FAA_Keys_NonFCRA.aircraft_reg_bdid.old,	PRTE_CSV.FAA_Keyfilenames(pVersion,pUseOtherEnvironment).FAA_Keys_NonFCRA.aircraft_reg_bdid.old,  aircraft_reg_bdid_mv_2built);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(PRTE_CSV.FAA_Keyfilenames(,pUseOtherEnvironment).FAA_Keys_NonFCRA.aircraft_reg_did.old,	 PRTE_CSV.FAA_Keyfilenames(pVersion,pUseOtherEnvironment).FAA_Keys_NonFCRA.aircraft_reg_did.old,  aircraft_reg_did_mv_2built);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(PRTE_CSV.FAA_Keyfilenames(,pUseOtherEnvironment).FAA_Keys_NonFCRA.aircraft_reg_nnum.old,	PRTE_CSV.FAA_Keyfilenames(pVersion,pUseOtherEnvironment).FAA_Keys_NonFCRA.aircraft_reg_nnum.old,  aircraft_reg_nnum_mv_2built);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(PRTE_CSV.FAA_Keyfilenames(,pUseOtherEnvironment).FAA_Keys_NonFCRA.airmen_certs.old,	 PRTE_CSV.FAA_Keyfilenames(pVersion,pUseOtherEnvironment).FAA_Keys_NonFCRA.airmen_certs.old,  airmen_certs_mv_2built);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(PRTE_CSV.FAA_Keyfilenames(,pUseOtherEnvironment).FAA_Keys_NonFCRA.airmen_did.old,	 PRTE_CSV.FAA_Keyfilenames(pVersion,pUseOtherEnvironment).FAA_Keys_NonFCRA.airmen_did.old,  airmen_did_mv_2built);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(PRTE_CSV.FAA_Keyfilenames(,pUseOtherEnvironment).FAA_Keys_NonFCRA.airmen_id.old,	PRTE_CSV.FAA_Keyfilenames(pVersion,pUseOtherEnvironment).FAA_Keys_NonFCRA.airmen_id.old,  airmen_id_mv_2built);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(PRTE_CSV.FAA_Keyfilenames(,pUseOtherEnvironment).FAA_Keys_NonFCRA.airmen_rid.old,	 PRTE_CSV.FAA_Keyfilenames(pVersion,pUseOtherEnvironment).FAA_Keys_NonFCRA.airmen_rid.old,  airmen_rid_mv_2built);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(PRTE_CSV.FAA_Keyfilenames(,pUseOtherEnvironment).FAA_Keys_NonFCRA.aircraft_linkids.old,  PRTE_CSV.FAA_Keyfilenames(pVersion,pUseOtherEnvironment).FAA_Keys_NonFCRA.aircraft_linkids.old,  aircraft_linkids_mv_2built);

	export promote_nonfcra_keys_to_built := parallel(aircraft_info_mv_2built
																									,engine_info_mv_2built
																									,aircraft_id_mv_2built
																									,aircraft_reg_bdid_mv_2built
																									,aircraft_reg_did_mv_2built
																									,aircraft_reg_nnum_mv_2built																									
																									,airmen_certs_mv_2built
																									,airmen_did_mv_2built
																									,airmen_id_mv_2built
																									,airmen_rid_mv_2built
																									,aircraft_linkids_mv_2built
																									);

// FCRA FAA Keys - Move to Built	
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(PRTE_CSV.FAA_Keyfilenames(,pUseOtherEnvironment).FAA_Keys_FCRA.aircraftreg_did.old,  PRTE_CSV.FAA_Keyfilenames(pVersion,pUseOtherEnvironment).FAA_Keys_FCRA.aircraftreg_did.old,  fcra_aircraftreg_did_mv_2built);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(PRTE_CSV.FAA_Keyfilenames(,pUseOtherEnvironment).FAA_Keys_FCRA.aircraft_info.old,	PRTE_CSV.FAA_Keyfilenames(pVersion,pUseOtherEnvironment).FAA_Keys_FCRA.aircraft_info.old,  fcra_aircraft_info_mv_2built);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(PRTE_CSV.FAA_Keyfilenames(,pUseOtherEnvironment).FAA_Keys_FCRA.aircraft_id.old,  PRTE_CSV.FAA_Keyfilenames(pVersion,pUseOtherEnvironment).FAA_Keys_FCRA.aircraft_id.old,  fcra_aircraft_id_mv_2built);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(PRTE_CSV.FAA_Keyfilenames(,pUseOtherEnvironment).FAA_Keys_FCRA.aircraft_reg_did.old,	 PRTE_CSV.FAA_Keyfilenames(pVersion,pUseOtherEnvironment).FAA_Keys_FCRA.aircraft_reg_did.old,  fcra_aircraft_reg_did_mv_2built);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(PRTE_CSV.FAA_Keyfilenames(,pUseOtherEnvironment).FAA_Keys_FCRA.engine_info.old,	PRTE_CSV.FAA_Keyfilenames(pVersion,pUseOtherEnvironment).FAA_Keys_FCRA.engine_info.old,  fcra_engine_info_mv_2built);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(PRTE_CSV.FAA_Keyfilenames(,pUseOtherEnvironment).FAA_Keys_FCRA.airmen_did.old,	 PRTE_CSV.FAA_Keyfilenames(pVersion,pUseOtherEnvironment).FAA_Keys_FCRA.airmen_did.old,  fcra_airmen_did_mv_2built);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(PRTE_CSV.FAA_Keyfilenames(,pUseOtherEnvironment).FAA_Keys_FCRA.airmen_rid.old,	 PRTE_CSV.FAA_Keyfilenames(pVersion,pUseOtherEnvironment).FAA_Keys_FCRA.airmen_rid.old,  fcra_airmen_rid_mv_2built);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(PRTE_CSV.FAA_Keyfilenames(,pUseOtherEnvironment).FAA_Keys_FCRA.airmen_certs.old,  PRTE_CSV.FAA_Keyfilenames(pVersion,pUseOtherEnvironment).FAA_Keys_FCRA.airmen_certs.old,  fcra_airmen_certs_mv_2built);
	
	export promote_fcra_keys_to_built 	 := parallel(fcra_aircraftreg_did_mv_2built
																									,fcra_aircraft_info_mv_2built
																									,fcra_aircraft_id_mv_2built
																									,fcra_aircraft_reg_did_mv_2built
																									,fcra_engine_info_mv_2built
																									,fcra_airmen_did_mv_2built																									
																									,fcra_airmen_rid_mv_2built
																									,fcra_airmen_certs_mv_2built
																									);
	
// NON-FCRA FAA Keys - Move to QA
	UT.mac_sk_move(PRTE_CSV.FAA_Keyfilenames(,pUseOtherEnvironment).FAA_Keys_NonFCRA.aircraft_info.old, 'Q',  aircraft_info_mv_2qa);
	UT.mac_sk_move(PRTE_CSV.FAA_Keyfilenames(,pUseOtherEnvironment).FAA_Keys_NonFCRA.engine_info.old,	'Q',  engine_info_mv_2qa);
	UT.mac_sk_move(PRTE_CSV.FAA_Keyfilenames(,pUseOtherEnvironment).FAA_Keys_NonFCRA.aircraft_id.old,	'Q',  aircraft_id_mv_2qa);
	UT.mac_sk_move(PRTE_CSV.FAA_Keyfilenames(,pUseOtherEnvironment).FAA_Keys_NonFCRA.aircraft_reg_bdid.old,	'Q',  aircraft_reg_bdid_mv_2qa);
	UT.mac_sk_move(PRTE_CSV.FAA_Keyfilenames(,pUseOtherEnvironment).FAA_Keys_NonFCRA.aircraft_reg_did.old, 'Q',  aircraft_reg_did_mv_2qa);
	UT.mac_sk_move(PRTE_CSV.FAA_Keyfilenames(,pUseOtherEnvironment).FAA_Keys_NonFCRA.aircraft_reg_nnum.old,	'Q',  aircraft_reg_nnum_mv_2qa);
	UT.mac_sk_move(PRTE_CSV.FAA_Keyfilenames(,pUseOtherEnvironment).FAA_Keys_NonFCRA.airmen_certs.old,	'Q',  airmen_certs_mv_2qa);
	UT.mac_sk_move(PRTE_CSV.FAA_Keyfilenames(,pUseOtherEnvironment).FAA_Keys_NonFCRA.airmen_did.old,	'Q',  airmen_did_mv_2qa);
	UT.mac_sk_move(PRTE_CSV.FAA_Keyfilenames(,pUseOtherEnvironment).FAA_Keys_NonFCRA.airmen_id.old,	'Q',  airmen_id_mv_2qa);
	UT.mac_sk_move(PRTE_CSV.FAA_Keyfilenames(,pUseOtherEnvironment).FAA_Keys_NonFCRA.airmen_rid.old,	'Q', airmen_rid_mv_2qa);
	UT.mac_sk_move(PRTE_CSV.FAA_Keyfilenames(,pUseOtherEnvironment).FAA_Keys_NonFCRA.aircraft_linkids.old, 'Q',  aircraft_linkids_mv_2qa);

	export promote_nonfcra_keys_to_qa		 := parallel(aircraft_info_mv_2qa
																									,engine_info_mv_2qa
																									,aircraft_id_mv_2qa
																									,aircraft_reg_bdid_mv_2qa
																									,aircraft_reg_did_mv_2qa
																									,aircraft_reg_nnum_mv_2qa																									
																									,airmen_certs_mv_2qa
																									,airmen_did_mv_2qa
																									,airmen_id_mv_2qa
																									,airmen_rid_mv_2qa
																									,aircraft_linkids_mv_2qa
																									);
	
// FCRA FAA Keys - Move to QA		
	UT.mac_sk_move(PRTE_CSV.FAA_Keyfilenames(,pUseOtherEnvironment).FAA_Keys_FCRA.aircraftreg_did.old,  'Q',  fcra_aircraftreg_did_mv_2qa);
	UT.mac_sk_move(PRTE_CSV.FAA_Keyfilenames(,pUseOtherEnvironment).FAA_Keys_FCRA.aircraft_info.old,	'Q',  fcra_aircraft_info_mv_2qa);
	UT.mac_sk_move(PRTE_CSV.FAA_Keyfilenames(,pUseOtherEnvironment).FAA_Keys_FCRA.aircraft_id.old,  'Q', fcra_aircraft_id_mv_2qa);
	UT.mac_sk_move(PRTE_CSV.FAA_Keyfilenames(,pUseOtherEnvironment).FAA_Keys_FCRA.aircraft_reg_did.old,	 'Q',  fcra_aircraft_reg_did_mv_2qa);
	UT.mac_sk_move(PRTE_CSV.FAA_Keyfilenames(,pUseOtherEnvironment).FAA_Keys_FCRA.engine_info.old,	'Q',  fcra_engine_info_mv_2qa);
	UT.mac_sk_move(PRTE_CSV.FAA_Keyfilenames(,pUseOtherEnvironment).FAA_Keys_FCRA.airmen_did.old,	 'Q',  fcra_airmen_did_mv_2qa);
	UT.mac_sk_move(PRTE_CSV.FAA_Keyfilenames(,pUseOtherEnvironment).FAA_Keys_FCRA.airmen_rid.old,	 'Q',  fcra_airmen_rid_mv_2qa);
	UT.mac_sk_move(PRTE_CSV.FAA_Keyfilenames(,pUseOtherEnvironment).FAA_Keys_FCRA.airmen_certs.old,  'Q',  fcra_airmen_certs_mv_2qa);
	
	export promote_fcra_keys_to_qa		 	 := parallel(fcra_aircraftreg_did_mv_2qa
																									,fcra_aircraft_info_mv_2qa
																									,fcra_aircraft_id_mv_2qa
																									,fcra_aircraft_reg_did_mv_2qa
																									,fcra_engine_info_mv_2qa
																									,fcra_airmen_did_mv_2qa																									
																									,fcra_airmen_rid_mv_2qa
																									,fcra_airmen_certs_mv_2qa
																									);
																									
	export promote_all								 	 := sequential(
																											parallel(promote_nonfcra_keys_to_built
																															,promote_fcra_keys_to_built
																															),
																											parallel(promote_nonfcra_keys_to_qa																			
																															,promote_fcra_keys_to_qa
																															)
																										);
end: DEPRECATED('Use PRTE2_FAA.Proc_Build_keys instead.');
;