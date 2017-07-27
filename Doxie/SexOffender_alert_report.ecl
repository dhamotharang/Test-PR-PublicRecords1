import SexOffender, Alerts;

export SexOffender_alert_report := MODULE

	shared unsigned1 version := 1;

	// short names
	shared layout_hashval := alerts.layouts.layout_hashval;
	shared layout_hash := alerts.layouts.layout_hash;
	
  layout_hashval calcAltNameHashes(doxie.Layout_SexOffender_Name l) := TRANSFORM
		SELF.hashval := HASH64(l.name_orig); 
	END;

  layout_hashval calcOffenseHashes(doxie.Layout_Sexoffender_Offense_Decode l) := TRANSFORM
		SELF.hashval := HASH64(l.conviction_date,l.offense_date); 
	END;

  layout_hashval calcAltAddrHashes(sexoffender.Layout_Out_Alt l) := TRANSFORM
		SELF.hashval := HASH64(l.alt_prim_range,l.alt_predir,l.alt_prim_name,l.alt_postdir,l.alt_sec_range,
													 l.alt_city_name,l.alt_st,l.alt_zip); 
	END;
	
	export unsigned8 calcHashval(recordof(doxie.Layout_SexOffender_Report) l) := FUNCTION
		 RETURN HASH64(l.offender_status,l.offender_category,l.ssn,l.reg_date_1,
									 l.registration_address_1,l.registration_address_2,l.registration_address_3,
									 l.registration_address_4,l.registration_address_5,l.registration_county) +
									 SUM(PROJECT(l.name, calcAltNameHashes(LEFT)), hashval) +
									 SUM(PROJECT(l.offenses, calcOffenseHashes(LEFT)), hashval) +
									 // don't want relative addresses
									 SUM(PROJECT(l.addresses,calcAltAddrHashes(LEFT)), hashval);

	END;
	
	Alerts.mac_setupAlerts(doxie.Layout_SexOffender_Report, calcHashval, version)


END;