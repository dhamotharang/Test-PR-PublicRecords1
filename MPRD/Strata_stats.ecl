import strata,Statistics;

export Strata_Stats :=
module
	// export facility(
			// dataset(layouts.facility_base)	pInput		= Files().facility_base.Built) := module
					// Statistics.mac_Strata_Pops(pInput,dNoGrouping													);
	// end;
	
	export individual(
			dataset(layouts.individual_base)	pInput		= Files().individual_base.Built) := module
					Statistics.mac_Strata_Pops(pInput,dNoGrouping													);
	end;
	
	// export basc_claims(
			// dataset(layouts.basc_claims_base)	pInput		= Files().basc_claims_base.Built) := module
					// Statistics.mac_Strata_Pops(pInput,dNoGrouping													);
	// end;
	
	// export basc_cp(
			// dataset(layouts.choice_point_base)	pInput		= Files().basc_cp_base.Built) := module
					// Statistics.mac_Strata_Pops(pInput,dNoGrouping													);
	// end;
	
	// export basc_addr(
			// dataset(layouts.basc_addr_base)	pInput		= Files().basc_addr_Base.Built) := module
					// Statistics.mac_Strata_Pops(pInput,dNoGrouping													);
	// end;
	
	
end;