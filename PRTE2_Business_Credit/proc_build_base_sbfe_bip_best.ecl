import BIPV2, PRTE2_BIPV2_SBFE, PRTE2_BIPV2_BusHeader, PromoteSupers;

EXPORT proc_build_base_sbfe_bip_best(string filedate) := function

// SBFE Best Key Base Files
	SHARED	dHrchyBase		:=	PROJECT(PRTE2_BIPV2_SBFE.CommonBase.DS_SBFE_CLEAN,BIPV2.CommonBase.Layout);
	SHARED	pInBase				:=	PRTE2_BIPV2_BusHeader.BIPV2_Best_In_Base(dHrchyBase).For_Proxid;
	SHARED	sInBase				:=	PRTE2_BIPV2_BusHeader.BIPV2_Best_In_Base(dHrchyBase).For_Seleid;
	SHARED	dBestSBFEFile	:=	PRTE2_BIPV2_SBFE.fn_Prep_for_Base(pInBase,sInbase,,,dHrchyBase);
	
  PromoteSupers.MAC_SF_BuildProcess(dBestSBFEFile, prte2_business_credit.constants.base_prefix + 'bip_best', best_base);	
	
	return best_base;

end;
