import strata,Statistics,HMS_Medicaid_Common;

export Strata_Stats := module

	EXPORT Medicaid_IL(
	 dataset(HMS_Medicaid_Common.layouts.base_IL)	pInput		= HMS_Medicaid_IL.Files().Base.Built) := module
				Statistics.mac_Strata_Pops(pInput,dNoGrouping);
		end; // surescripts module
end; // Strata_Stats module