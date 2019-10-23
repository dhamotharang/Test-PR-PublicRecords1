IMPORT strata;

EXPORT Strata_Stats(
	 DATASET(Equifax_Business_Data.layouts.base)	         pBaseFile				= Equifax_Business_Data.Files().base.built
	,STRING															         pfileversion		  = 'using'
	,BOOLEAN														         pUseOtherEnviron = Equifax_Business_Data._Constants().isdataland
	,DATASET(Equifax_Business_Data.Layouts.Sprayed_Input) pSprayedFile     = Equifax_Business_Data.Files(pfileversion,pUseOtherEnviron).Input.logical

) := MODULE

	Strata.mac_Pops		(pSprayedFile	,dInputNoGrouping	            );
	Strata.mac_Uniques(pSprayedFile	,dUniqueInputNoGrouping       );
	Strata.mac_Pops		(pBaseFile		,dNoGrouping					        );
	Strata.mac_Pops		(pBaseFile		,dCleanAddressState	     ,'st');
	Strata.mac_Uniques(pBaseFile		,dUniqueNoGrouping	          );
	Strata.mac_Uniques(pBaseFile		,dUniqueCleanAddressState,'st');

END;