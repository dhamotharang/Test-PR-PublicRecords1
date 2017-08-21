import strata,Statistics;

export Strata_Stats	:= module

	export StateLicense(
			dataset(layouts.statelicense_base)	pInput		= Files().statelicense_base.Built) := module
					Statistics.mac_Strata_Pops(pInput,dNoGrouping													);
	end;
	
	export StateLicenseRollup(
			dataset(layouts.statelicense_base)	pInput		= Files().stlicrollup_base.Built) := module
					Statistics.mac_Strata_Pops(pInput,dNoGrouping													);
	end;
	
end;