import strata,Statistics;

export Strata_Stats	:= module

	export CsrCredential(
			dataset(layouts.csrcredential_base)	pInput		= Files().csrcredential_base.Built) := module
					Statistics.mac_Strata_Pops(pInput,dNoGrouping													);
	end;
	
	
end;