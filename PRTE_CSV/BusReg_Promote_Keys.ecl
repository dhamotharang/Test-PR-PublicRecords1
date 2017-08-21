IMPORT PRTE_CSV, RoxieKeyBuild, UT;

EXPORT BusReg_Promote_Keys	(STRING pVersion ,BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(PRTE_CSV.BusReg_Keyfilenames(,pUseOtherEnvironment).company_bdid.old,     PRTE_CSV.BusReg_Keyfilenames(pVersion,pUseOtherEnvironment).company_bdid.old,     company_bdid_mv_2built);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(PRTE_CSV.BusReg_Keyfilenames(,pUseOtherEnvironment).company_linkids.old,  PRTE_CSV.BusReg_Keyfilenames(pVersion,pUseOtherEnvironment).company_linkids.old,  company_linkids_mv_2built);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(PRTE_CSV.BusReg_Keyfilenames(,pUseOtherEnvironment).contact_bdid.old,     PRTE_CSV.BusReg_Keyfilenames(pVersion,pUseOtherEnvironment).contact_bdid.old,     contact_bdid_mv_2built);

	EXPORT promote_busreg_keys_to_built := PARALLEL(company_bdid_mv_2built
																									,company_linkids_mv_2built
																									,contact_bdid_mv_2built);

	export promote_all								 	 := promote_busreg_keys_to_built;																									

END;