export constants := 
MODULE

	 export set_fidelity_vendor_source_flag := ['D','O'];
	 export isFidelity(string vendor_source_flag) := vendor_source_flag in set_fidelity_vendor_source_flag;

END;