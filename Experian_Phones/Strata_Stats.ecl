import strata,Statistics;

export Strata_Stats(

	 dataset(layouts.base)	pInput		= files.base

) :=
module

	Statistics.mac_Strata_Pops(pInput,dNoGrouping													);
	Statistics.mac_Strata_Pops(pInput,dPhonePos	,'Phone_Pos'	);
	Statistics.mac_Strata_Pops(pInput,dPhoneType ,'Phone_type'							);
	Statistics.mac_Strata_Pops(pInput,dPhoneSrc	,'Phone_source'							);
end;