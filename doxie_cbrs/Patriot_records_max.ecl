doxie_cbrs.mac_Selection_Declare()
export Patriot_records_max(unsigned1 ofac_version = 1, boolean include_ofac = false, real global_watchlist_threshold = 0.8) := 
	choosen(doxie_cbrs.Patriot_records(ofac_version, include_ofac, global_watchlist_threshold)(Return_PatriotAct_val), Max_PatriotAct_val);