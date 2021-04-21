IMPORT doxie, header, iesp, models, Standard;

EXPORT layouts := MODULE

	shared ifr := iesp.identityfraudreport;
  head := doxie.layout_presentation; // ~doxie.layout_header_records

  // slim header; yet it includes new fields for counting and bureau indicator
  export slim_header := record
    head.did;
    head.rid;
    head.src;
    head.dt_first_seen;
    head.dt_last_seen;
    head.dt_vendor_last_reported;
    head.dt_vendor_first_reported;
    head.phone;
    head.ssn;
    head.dob;
    head.title;
    head.fname;
    head.mname;
    head.lname;
    head.name_suffix;
    head.prim_range;
    head.predir;
    head.prim_name;
    head.suffix;
    head.postdir;
    head.unit_desig;
    head.sec_range;
    head.city_name;
    head.st;
    head.zip;
    head.zip4;
    head.county;
    head.valid_ssn;
    head.valid_dob;
    head.hhid;
    head.county_name;
    typeof (header.key_nlr_payload.not_in_bureau) not_in_bureau := 0;
    // these fields are to keep records' counts (by whatever means) and source "type" (again, whatever that means)
    integer2 count := 0;
    string32 _type := '';
  end;

// ... also could be taken from header:
// penalt, pflag1, pflag2, pflag3, dt_vendor_last_reported, dt_vendor_first_reported, dt_nonglb_last_seen
//? rec_type
// vendor_id,geo_blk, cbsa, tnt, jflag1,jflag2,jflag3,
// dod, death_code // I'll take it from best
// lookup_did, num_compares,
// TODO: find out what phones should I use.
// listing_type_res, listing_type_bus, listing_type_gov, listing_type_cell, new_type,
// carrier, carrier_city, carrier_state, PhoneType, phone_first_seen, phone_last_seen, caption_text,
// bdid,linked_did,includedByHHID,timezone,listed_timezone,publish_code,listed_name_prefix,listed_name_first,
// listed_name_middle,listed_name_last,listed_name_suffix,
// boolean glb, boolean dppa

  // for static table which contains all indicators possible in IdentityFraud report
  export ri_map := record
    unsigned8 code;
    unsigned1 color_code;
    integer rank;
    string description {maxlength (512)};
    string provider {maxlength (32)} := ''; //here's only one, but can be used to keep, say, comma separated list.
  end;

  // a set of ESDL-compliant layouts, but I need DID for linking
  export did_did_rec := record (ifr.t_IFRLinkId)
    slim_header.did; // taphtalogy, but easier to use
		dataset(ifr.t_RiskIndices) RiskIndices;
		ifr.t_TotalSearchCounts TotalSearchCounts;
  end;

  export ssn_did_rec := record (ifr.t_IFRSSN)
    slim_header.did;
  end;

  export names_did_rec := record (ifr.t_IFRName)
    slim_header.did;
  end;

  export address_did_rec := record (ifr.t_IFRAddress)
    slim_header.did;
  end;

  export phone_did_rec := record (ifr.t_IFRPhone)
    slim_header.did;
  end;

  export phones_roll_rec := record
    unsigned6 did;
	  dataset(ifr.t_IFRPhone) PhoneInfo {MAXCOUNT(100)}; // TODO:
  end;

  // for use in "no longer reported" arythmetics
  export bureau_indicator := record
    slim_header.not_in_bureau;
  end;

	// fraud point indices layout
	export	fraud_attributes	:=
	record
		unsigned6																																		did;
		string9																																			ssn;
		typeof(Models.Layout_FraudAttributes.Version2.IdentityRecentUpdate)					IdentityRecentUpdate;
		typeof(Models.Layout_FraudAttributes.Version2.VariationAddrStability)				VariationAddrStability;
		typeof(Models.Layout_FraudAttributes.Version2.VariationPhoneCount)					VariationPhoneCount;
		typeof(Models.Layout_FraudAttributes.Version2.VariationSearchSSNCount)			VariationSearchSSNCount;
		typeof(Models.Layout_FraudAttributes.Version2.VariationSearchAddrCount)			VariationSearchAddrCount;
		typeof(Models.Layout_FraudAttributes.Version2.VariationSearchPhoneCount)		VariationSearchPhoneCount;
		typeof(Models.Layout_FraudAttributes.Version2.SearchCountYear)							SearchCountYear;
		typeof(Models.Layout_FraudAttributes.Version2.SearchCountMonth)							SearchCountMonth;
		typeof(Models.Layout_FraudAttributes.Version2.SearchCountWeek)							SearchCountWeek;
		typeof(Models.Layout_FraudAttributes.Version2.SearchCountDay)								SearchCountDay;
		typeof(Models.Layout_FraudAttributes.Version2.DivAddrSuspIdentityCountNew)	DivAddrSuspIdentityCountNew;
		typeof(Models.Layout_FraudAttributes.Version2.SearchSSNSearchCountYear)			SearchSSNSearchCountYear;
		typeof(Models.Layout_FraudAttributes.Version2.SearchSSNSearchCountMonth)		SearchSSNSearchCountMonth;
		typeof(Models.Layout_FraudAttributes.Version2.SearchSSNSearchCountWeek)			SearchSSNSearchCountWeek;
		typeof(Models.Layout_FraudAttributes.Version2.SearchSSNSearchCountDay)			SearchSSNSearchCountDay;
		typeof(Models.Layout_FraudAttributes.Version2.IdentityRiskLevel)						IdentityRiskLevel;
		typeof(Models.Layout_FraudAttributes.Version2.SourceRiskLevel)							SourceRiskLevel;
		typeof(Models.Layout_FraudAttributes.Version2.SearchVelocityRiskLevel)			VelocityRiskLevel;
		Standard.Name;
		Standard.Addr;
	end;

	export	id_fraud_attributes	:=
	record
		unsigned6	did;
		string9		ssn;
		Standard.Name;
		Standard.Addr;
		boolean		IdentityRecentUpdate;
		boolean		VariationAddrStability;
		boolean		VariationPhoneCount;
		boolean		VariationSearchSSNCount;
		boolean		VariationSearchAddrCount;
		boolean		VariationSearchPhoneCount;
		boolean		SearchCountYear;
		boolean		SearchCountMonth;
		boolean		SearchCountWeek;
		boolean		SearchCountDay;
		boolean		DivAddrSuspIdentityCountNew;
		boolean		SearchSSNSearchCountYear;
		boolean		SearchSSNSearchCountMonth;
		boolean		SearchSSNSearchCountWeek;
		boolean		SearchSSNSearchCountDay;
		typeof(Models.Layout_FraudAttributes.Version2.SearchCountYear)					TotalSearchCountYear;
		typeof(Models.Layout_FraudAttributes.Version2.SearchCountMonth)					TotalSearchCountMonth;
		typeof(Models.Layout_FraudAttributes.Version2.SearchCountWeek)					TotalSearchCountWeek;
		typeof(Models.Layout_FraudAttributes.Version2.SearchCountDay)						TotalSearchCountDay;
		typeof(Models.Layout_FraudAttributes.Version2.IdentityRiskLevel)				IdentityRiskLevel;
		typeof(Models.Layout_FraudAttributes.Version2.SourceRiskLevel)					SourceRiskLevel;
		typeof(Models.Layout_FraudAttributes.Version2.SearchVelocityRiskLevel)	VelocityRiskLevel;
	end;

	// Email layout
	export	email_rec	:=
	record(ifr.t_IFREmail)
		unsigned6	did;
		string2		src;
		string32	_type;
		boolean		royalty;
		string8		date_first_seen;
		string8		date_last_seen;
	end;

	export	email_did_rec	:=
	record
		email_rec	-	[date_first_seen,date_last_seen];
	end;
END;
