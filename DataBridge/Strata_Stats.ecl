IMPORT strata;

EXPORT Strata_Stats(
	 DATASET(DataBridge.layouts.base)	         pBaseFile				= DataBridge.Files().base.built
	,STRING															       pfileversion		  = 'using'
	,BOOLEAN														       pUseOtherEnviron = DataBridge._Constants().isdataland
	,DATASET(DataBridge.Layouts.Sprayed_Input) pSprayedFile     = DataBridge.Files(pfileversion,pUseOtherEnviron).Input.logical

) := MODULE

	Strata.mac_Pops		(pSprayedFile	,dInputNoGrouping	            );
	Strata.mac_Uniques(pSprayedFile	,dUniqueInputNoGrouping       );
	Strata.mac_Pops		(pBaseFile		,dNoGrouping					        );
	Strata.mac_Pops		(pBaseFile		,dCleanAddressState	     ,'st');
	Strata.mac_Uniques(pBaseFile		,dUniqueNoGrouping	          );
	Strata.mac_Uniques(pBaseFile		,dUniqueCleanAddressState,'st');

END;