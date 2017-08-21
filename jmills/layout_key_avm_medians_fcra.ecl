EXPORT layout_key_avm_medians_fcra := RECORD
  string12 fips_geo_12;
  string8 history_date;
  integer8 median_valuation;
	//DATASET(layout_median_history_slim) history{maxcount(avm_v2__layouts__max_history)};
	string8 history_history_date;
  string50 history_median_valuation;
  //unsigned8 __internal_fpos__;
	END;
