import strata,Statistics;

export Strata_Stats := module

	EXPORT surescripts(
	 dataset(layouts.base)	pInput		= Files().Base.Built) := module
				Statistics.mac_Strata_Pops(pInput,dNoGrouping);
		end; // surescripts module
end; // Strata_Stats module