IMPORT strata,OPM;

EXPORT Strata_Stats(
	 DATASET(OPM.layouts.base)	         pBaseFile				= OPM.Files().base.built
	,STRING															 pfileversion		  = 'using'
	,BOOLEAN														 pUseOtherEnviron = OPM._Constants().isdataland
	,DATASET(OPM.Layouts.Sprayed_Input) pSprayedFile      = OPM.Files(pfileversion,pUseOtherEnviron).Input.logical

) := MODULE

	Strata.mac_Pops		(pSprayedFile	,dInputNoGrouping	            );
	Strata.mac_Uniques(pSprayedFile	,dUniqueInputNoGrouping       );
	Strata.mac_Pops		(pBaseFile		,dNoGrouping					        );
	Strata.mac_Pops		(pBaseFile		,dCleanAddressState	     ,'st');
	Strata.mac_Uniques(pBaseFile		,dUniqueNoGrouping	          );

END;