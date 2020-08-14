doxie_cbrs.mac_Selection_Declare()
EXPORT Patriot_records_max(UNSIGNED1 ofac_version = 1, BOOLEAN include_ofac = FALSE, REAL global_watchlist_threshold = 0.8) :=
  CHOOSEN(doxie_cbrs.Patriot_records(ofac_version, include_ofac, global_watchlist_threshold)(Return_PatriotAct_val), Max_PatriotAct_val);
