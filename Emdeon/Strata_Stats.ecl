IMPORT strata,Statistics;

EXPORT Strata_Stats	:= MODULE

	EXPORT CRecord(
			DATASET(Emdeon.Layouts.Base.C_Record)	pInput		= Files().claims_base.Built) := MODULE
					Statistics.mac_Strata_Pops(pInput,dNoGrouping);
	END;
	
	EXPORT DRecord(
			DATASET(Emdeon.Layouts.Base.D_Record)	pInput		= Files().detail_base.Built) := MODULE
					Statistics.mac_Strata_Pops(pInput,dNoGrouping);
	END;
	
	EXPORT SRecord(
			DATASET(Emdeon.Layouts.Base.S_Record)	pInput		= Files().splits_base.Built) := MODULE
					Statistics.mac_Strata_Pops(pInput,dNoGrouping);
	END;
	
END;