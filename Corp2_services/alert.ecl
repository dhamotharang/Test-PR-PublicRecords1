import doxie, Alerts;

export alert := MODULE

	shared unsigned1 version := 1;
	
	// shorter names
	shared layout_hashval := alerts.layouts.layout_hashval;
	// shared layout_hash := alerts.layouts.layout_hash;

 // layout_hashval calcBkDebtorNameHashes(layouts.layout_name l) := TRANSFORM
		// SELF.hashval := HASH64(l.fname,l.lname,l.mname,l.cname);
	// END;

 // layout_hashval calcBkDebtorAddrHashes(layouts.layout_address l) := TRANSFORM
		// SELF.hashval := HASH64(l.prim_range,l.predir,l.prim_name,l.addr_suffix,l.postdir,l.sec_range,l.v_city_name,l.st,l.zip);
	// END;

	layout_hashval calcCorpHistHashes(layout_corp_search l) := TRANSFORM
		SELF.hashval := HASH64(l.corp_legal_name,l.corp_ln_name_type_desc,l.corp_address1_line1,
		              l.corp_address1_line2,l.corp_address1_line3,l.corp_address1_line4,
									l.corp_address1_line5,l.corp_address1_line6,l.corp_phone10,
									l.corp_status_desc,/*l.corp_standing*/l.corp_ra_name,l.corp_ra_address_line1,
									l.corp_ra_address_line2,l.corp_ra_address_line3,l.corp_ra_address_line4,
									l.corp_ra_address_line5,l.corp_ra_address_line6/*l.corp_ra_phone10*/);
	END;
	
	export unsigned8 calcHashval(layout_corp2_search_rollup_final l) := FUNCTION
  	// using case_number in lieu of orig_case_number
		RETURN SUM(PROJECT(l.corp_hist, calcCorpHistHashes(LEFT)), hashval);
	END;
	
	Alerts.mac_setupAlerts(layout_corp2_search_rollup_final, calcHashval, version)
	
END;