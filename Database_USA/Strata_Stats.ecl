IMPORT strata;

EXPORT Strata_Stats(
	 DATASET(Database_USA.layouts.base)	       	 	pBaseFile					= Database_USA.Files().base.built
	,STRING															       		pfileversion			= 'using'
	,BOOLEAN														      		pUseOtherEnviron	= Database_USA._Constants().isdataland
	,DATASET(Database_USA.Layouts.Sprayed_Input) 	pSprayedFile			= Database_USA.Files(pfileversion,pUseOtherEnviron).Input.logical

) := MODULE

	Strata.mac_Pops		(pSprayedFile	,dInputNoGrouping	            );
	Strata.mac_Uniques(pSprayedFile	,dUniqueInputNoGrouping       );
	Strata.mac_Pops		(pBaseFile		,dNoGrouping					        );
	Strata.mac_Pops		(pBaseFile		,dCleanAddressState	     ,'phy_st');
	Strata.mac_Uniques(pBaseFile		,dUniqueNoGrouping	          );

END;