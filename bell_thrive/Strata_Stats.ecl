import strata,tools;
export Strata_Stats(

	 dataset(Layouts.Input.Sprayed		)	pSprayedFile		= files().input.using
	,dataset(layouts.base							)	pBaseFile				= files().base.built

) :=
module

	Strata.mac_Pops		(pSprayedFile	,dInputNoGrouping				);
	Strata.mac_Uniques(pSprayedFile	,dUniquesInputNoGrouping);
	Strata.mac_Pops		(pBaseFile		,dBaseNoGrouping				);
	Strata.mac_Uniques(pBaseFile		,dUniquesBaseNoGrouping	);

end;
