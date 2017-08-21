IMPORT Strata;

EXPORT Strata_Stats(
	 DATASET(Layout_FCC_base_bip_AID	)	pBaseFile					= FCC.File_FCC_base_bip_AID
	,DATASET(Layout_FCC_Licenses_in		)	pSprayedFile			= FCC.File_FCC_licenses_in	
) := MODULE

	Strata.mac_Pops		(pSprayedFile			,dInputNoGrouping															);
	Strata.mac_Uniques(pSprayedFile			,dUniqueInputNoGrouping												);
	Strata.mac_Pops		(pBaseFile				,dLicenseesState				   ,'licensees_state'	);
	Strata.mac_Uniques(pBaseFile				,dUniqueLicenseesState	   ,'licensees_state'	); 

END;