import strata,Statistics;

export Strata_Stats	:= module

	export facility_sanctions(
			dataset(layouts.base.facility_sanctions)	pInput		= Files().facility_sanctions_base.Built) := module
					Statistics.mac_Strata_Pops(pInput,dNoGrouping													);
	end;
end;
	
	