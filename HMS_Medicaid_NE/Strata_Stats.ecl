import strata,Statistics,HMS_Medicaid_Common;

export Strata_Stats := module

	EXPORT Medicaid_NE(
	 dataset(HMS_Medicaid_Common.layouts.base_NE)	pInput		= HMS_Medicaid_NE.Files().Base.Built) := module
				Statistics.mac_Strata_Pops(pInput,dNoGrouping);
		end; // surescripts module
end; // Strata_Stats module