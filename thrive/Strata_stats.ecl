import strata,Statistics;

export Strata_Stats(

	 dataset(layouts.base)	pInput		= Files().Base.Built

) :=
module

	Statistics.mac_Strata_Pops(pInput,dNoGrouping													);
	Statistics.mac_Strata_Pops(pInput,dSource	,'src'	);
end;