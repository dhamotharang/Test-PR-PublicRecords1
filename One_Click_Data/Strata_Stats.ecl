import strata,Statistics;

export Strata_Stats(

	 dataset(layouts.base)	pInput		= files().base.built

) :=
module

	Statistics.mac_Strata_Pops(pInput,dNoGrouping																	);
	Statistics.mac_Strata_Pops(pInput,dhomeaddressState	,'Clean_home_address.st'	);
	Statistics.mac_Strata_Pops(pInput,dworkaddressState	,'Clean_work_address.st'	);

end;