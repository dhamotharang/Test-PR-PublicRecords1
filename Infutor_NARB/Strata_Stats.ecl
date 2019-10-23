IMPORT strata;

EXPORT Strata_Stats(
	 DATASET(Infutor_NARB.layouts.base)	         pBaseFile				= Infutor_NARB.Files().base.built
	,STRING															         pfileversion		  = 'using'
	,BOOLEAN														         pUseOtherEnviron = Infutor_NARB._Constants().isdataland
	,DATASET(Infutor_NARB.Layouts.Sprayed_Input) pSprayedFile     = Infutor_NARB.Files(pfileversion,pUseOtherEnviron).Input.logical

) := MODULE

	Strata.mac_Pops		(pSprayedFile	,dInputNoGrouping	            );
	Strata.mac_Uniques(pSprayedFile	,dUniqueInputNoGrouping       );
	Strata.mac_Pops		(pBaseFile		,dNoGrouping					        );
	Strata.mac_Pops		(pBaseFile		,dCleanAddressState	     ,'st');
	Strata.mac_Uniques(pBaseFile		,dUniqueNoGrouping	          );
	Strata.mac_Uniques(pBaseFile		,dUniqueCleanAddressState,'st');

END;