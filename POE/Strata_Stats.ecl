import strata,Statistics;

export Strata_Stats(

	 dataset(layouts.base)	pInput		= files().base.built

) :=
module

	Statistics.mac_Strata_Pops(pInput,dNoGrouping													);
	Statistics.mac_Strata_Pops(pInput,dSubjectState	,'subject_address.st'	);
	Statistics.mac_Strata_Pops(pInput,dSource				,'source'							);

end;