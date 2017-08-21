import strata;

export Strata_Stats(

	 dataset(layouts.base							)	pBaseFile					= files().base.built
	,string															pfileversion			= 'using'
	,boolean														pUseOtherEnviron	= _Constants().isdataland
	,dataset(Layouts.Input.Sprayed		)	pSprayedFile			= Files(pfileversion,pUseOtherEnviron).Input.logical
	,dataset(Layouts.Input.SprayedOLD	)	pSprayedOldFile		= Files(pfileversion,pUseOtherEnviron).InputOld.logical
	,dataset(Layouts.Input.Sprayed		)	pPrepSprayedFile	= Prep_File(pfileversion,pUseOtherEnviron,pSprayedFile,pSprayedOldFile)	//because comes in diff layout sometimes

) :=
module

	Strata.mac_Pops		(pPrepSprayedFile	,dInputNoGrouping															);
	Strata.mac_Uniques(pPrepSprayedFile	,dUniqueInputNoGrouping												);
	Strata.mac_Pops		(pBaseFile				,dNoGrouping																	);
	Strata.mac_Pops		(pBaseFile				,dCleanAddressState				,'Clean_address.st'	);
	Strata.mac_Uniques(pBaseFile				,dUniqueNoGrouping														);
	Strata.mac_Uniques(pBaseFile				,dUniqueCleanAddressState	,'Clean_address.st'	);

end;