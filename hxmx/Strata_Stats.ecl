IMPORT strata,Statistics;

EXPORT Strata_Stats	:= MODULE

	EXPORT HX(
			DATASET(HXMX.Layouts.Base.hx_record)	pInput		= Files().hx_base.Built) := MODULE
					Statistics.mac_Strata_Pops(pInput,dNoGrouping);
	END;
	
	EXPORT MX(
			DATASET(HXMX.Layouts.Base.mx_record)	pInput		= Files().mx_base.Built) := MODULE
					Statistics.mac_Strata_Pops(pInput,dNoGrouping);
	END;
	
END;