import strata, Statistics, Org_Mast;

export Strata_Stats := module

	export Organization(
			dataset(layouts.organization_base)	pInput		= Files().organization_base.Built) := module
					Statistics.mac_Strata_Pops(pInput,dNoGrouping													);
	end;
	export Affiliations(
			dataset(layouts.affiliations_base)	pInput		= Files().affiliations_base.Built) := module
					Statistics.mac_Strata_Pops(pInput,dNoGrouping													);
	end;

end;