import strata;

export Strata_Population_Stats(

	 dataset(layouts.base							)	pBaseFile					= files().base.built

) :=
module

	Strata.mac_Pops		(pBaseFile				,dNoGrouping																	);
	Strata.mac_Pops		(pBaseFile				,dCleanAddressState				,'Clean_address.st'	);

end;