import doxie, Alerts;

export alert := MODULE

	shared unsigned1 version := 1;
	
	// shorter names
	shared layout_hashval := alerts.layouts.layout_hashval;
	shared layout_hash := alerts.layouts.layout_hash;

  layout_hashval calcPartyNameHashes(layouts.parties.orig l) := TRANSFORM
		SELF.hashval := HASH64(l.orig_name);
	END;
	
  layout_hashval calcPartyHashes(layouts.parties.pparty l) := TRANSFORM
		SELF.hashval := HASH64(l.party_type,l.prim_range,l.predir,l.prim_name,l.suffix,l.postdir,
													 l.sec_range,l.p_city_name,l.v_city_name,l.st,l.zip) +
													 SUM(PROJECT(l.orig_names,calcPartyNameHashes(LEFT)), hashval); 
	END;

  layout_hashval calcAssessmentHashes(layouts.assess.result.narrow l) := TRANSFORM
		SELF.hashval := HASH64(l.apna_or_pin_number);
	END;

	
  layout_hashval calcDeedHashes(layouts.deeds.result.narrow2 l) := TRANSFORM
		SELF.hashval := HASH64(l.apnt_or_pin_number);
	END;


	export unsigned8 calcHashval(recordof(layouts.out_narrow) l) := FUNCTION
		RETURN SUM(PROJECT(l.deeds, calcDeedHashes(LEFT)), hashval) + 
					 SUM(PROJECT(l.assessments, calcAssessmentHashes(LEFT)),hashval) +
					 // only take Borrower, Owner, Seller, and Prop types
					 SUM(PROJECT(l.parties(party_type IN ['B','P','O','S']), calcPartyHashes(LEFT)),hashval);
	END;
	
	Alerts.mac_setupAlerts(layouts.out_narrow, calcHashval, version)
	
END;