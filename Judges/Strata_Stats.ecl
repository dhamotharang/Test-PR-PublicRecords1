import strata;
export Strata_Stats(
	 dataset(layouts.base						)	pBaseFile			= files().base.built
	,dataset(Layouts.Input.Sprayed	)	pSprayedFile	= Files().Input.using
	,dataset(layouts.base						)	pAppendDid		= Persists().AppendIdsfAppendDid
	
) :=
module
	Strata.mac_Pops		(pSprayedFile	,dInputNoGrouping															);
	Strata.mac_Uniques(pSprayedFile	,dUniqueInputNoGrouping												);
	Strata.mac_Pops		(pBaseFile		,dNoGrouping																	);
	Strata.mac_Pops		(pBaseFile		,dCleanAddressState				,'Clean_address.st'	);
	Strata.mac_Uniques(pBaseFile		,dUniqueNoGrouping														);
	Strata.mac_Uniques(pBaseFile		,dUniqueCleanAddressState	,'Clean_address.st'	);
	Strata.mac_Pops		(pAppendDid		,dAppendDIDNoGrouping													);
end;
