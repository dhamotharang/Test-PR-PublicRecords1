import strata;

export Strata_Stats(

	 dataset(layouts.base)	pInput		= files().base.built

) :=
module

	Strata.mac_Pops(pInput,dNoGrouping													);
	Strata.mac_Pops(pInput,dSubjectState	,'subject_address.st'	);
	Strata.mac_Pops(pInput,dSource				,'source'							);

end;