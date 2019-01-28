import advo,Risk_Indicators,Standard,ut,PhonesFeedback_Services,iesp,paw_services, AddressFeedback_Services, Royalty, progressive_phone;

export Layout_Rollup := MODULE

shared high_tnt := 100; // default high value; lowest is best
shared high_valid_ssn := 100; // default high value; lowest is best

export NameRec := RECORD
	Standard.Name.title;
	Standard.Name.fname;
	Standard.Name.mname;
	Standard.Name.lname;
	Standard.Name.name_suffix;
END;

export PhoneRec := RECORD
	doxie.Layout_Phones.match_type;
	doxie.Layout_Phones.gong_score;
	STRING10 phone;
	unsigned2 fdn_phone_ind := 0; // Added for FDN project
	doxie.Layout_Phones.timezone;
	doxie.Layout_Phones.listed;
	doxie.Layout_Phones.bdid;
	doxie.Layout_Phones.did;
	doxie.Layout_Phones.listing_type_res;
	doxie.Layout_Phones.listing_type_bus;
	doxie.Layout_Phones.listing_type_gov;
	doxie.Layout_Phones.listing_type_cell;
	doxie.Layout_Phones.new_type;
	doxie.Layout_Phones.carrier;
	doxie.Layout_Phones.carrier_city;
	doxie.Layout_Phones.carrier_state;
	doxie.Layout_Phones.PhoneType; 
	doxie.Layout_Phones.phone_first_seen; 
	doxie.Layout_Phones.phone_last_seen; 
	doxie.Layout_Phones.listed_name; // MAXLENGTH defined inside
	doxie.Layout_Phones.caption_text; // MAXLENGTH defined inside
  DATASET(Risk_Indicators.Layout_Desc) hri_phone {MAXCOUNT(doxie.rollup_limits.phone_hris)};
	END;

export PhoneRec_seq := RECORD // Added for the FDN project
	unsigned2 seq;
	unsigned2 addrRec_seq;
	unsigned2 phoneRec_seq;
	PhoneRec;
  boolean fdn_waf_contrib_data    := false;
  boolean fdn_results_found       := false;
  boolean fdn_indicators_returned := false; // Added for bug 196447
end;

export PhoneRec_feedback := RECORD
	PhoneRec;
	DATASET(PhonesFeedback_Services.Layouts.feedback_report) Feedback {MAXCOUNT(1)};
END;

shared AddrCommon := RECORD
doxie.Layout_HeaderFileSearch.tnt;
  doxie.Layout_HeaderFileSearch.first_seen;
	doxie.Layout_HeaderFileSearch.last_seen;
	doxie.Layout_HeaderFileSearch.predir;
	doxie.Layout_HeaderFileSearch.prim_range;
	doxie.Layout_HeaderFileSearch.prim_name;
	doxie.Layout_HeaderFileSearch.suffix;
	doxie.Layout_HeaderFileSearch.postdir;
	doxie.Layout_HeaderFileSearch.unit_desig;
	doxie.Layout_HeaderFileSearch.sec_range;
	doxie.Layout_HeaderFileSearch.city_name;
	doxie.Layout_HeaderFileSearch.st;
	doxie.Layout_HeaderFileSearch.zip;
	doxie.Layout_HeaderFileSearch.zip4;
	doxie.Layout_HeaderFileSearch.county;
	doxie.Layout_HeaderFileSearch.geo_blk;
	doxie.Layout_HeaderFileSearch.county_name;
	string5  census_age := '';
	string9  census_income := '';
	string9  census_home_value := '';
	string5  census_education := '';
	doxie.Layout_HeaderFileSearch.dt_vendor_first_reported;
	doxie.Layout_HeaderFileSearch.dt_vendor_last_reported; 
	unsigned2 fdn_addr_ind := 0; // Added for FDN project

	// added this reference for IRB customization project and if boolean is true to
	// signify to only some particular ESPs/downstream  that want this functionality
	// to hardcode 'current'
	// in output in GUI instead of using value in 'dt_last_seen' field
	doxie.Layout_HeaderFileSearch.isCurrent;
END;
																		

export AddrRec := RECORD  (AddrCommon)
	DATASET(PhoneRec) phoneRecs {MAXCOUNT(doxie.rollup_limits.phones)}; // "although really 10 after dedup"... need to double check code that uses this layout
  DATASET(Risk_Indicators.Layout_Desc) hri_address {MAXCOUNT(doxie.rollup_limits.address_hris)}; // MAXLENGTH defined inside
  Advo.Layouts.Layout_CDS  address_cds;	
END;

export AddrRec_seq := RECORD // Added for the FDN project
	unsigned2 seq;
	unsigned2 addrRec_seq;
	AddrRec;
  boolean fdn_waf_contrib_data    := false;
  boolean fdn_results_found       := false;
  boolean fdn_indicators_returned := false; // Added for bug 196447
end;

export AddrRec_feedback := RECORD (AddrCommon)
	DATASET(PhoneRec_feedback) phoneRecs {MAXCOUNT(doxie.rollup_limits.phones)}; // "although really 10 after dedup"... need to double check code that uses this layout	
  DATASET(Risk_Indicators.Layout_Desc) hri_address {MAXCOUNT(doxie.rollup_limits.address_hris)}; // MAXLENGTH defined inside
  Advo.Layouts.Layout_CDS  address_cds;
	DATASET(AddressFeedback_Services.Layouts.feedback_report) address_feedback {MAXCOUNT(AddressFeedback_Services.Constants.Limits.FEEDBACK_PER_ADDRESS)};
END;

export AddrRec_feedback_ext := RECORD (AddrRec_feedback)
	unsigned6 did;
END;

export AddrRec_feedback_batch := RECORD (AddrCommon)
	// only 1 phone per address with no feedback
	PhoneRec;
  // placeholder for only 1 high risk indicator
  STRING4 hri;
	STRING150 desc;  
END;

export SsnRec := RECORD
	doxie.Layout_HeaderFileSearch.ssn;
	unsigned2 fdn_ssn_ind := 0; // Added for FDN project
  doxie.Layout_HeaderFileSearch.ssn_issue_early;
  doxie.Layout_HeaderFileSearch.ssn_issue_last;
  doxie.Layout_HeaderFileSearch.ssn_issue_place;
	doxie.Layout_HeaderFileSearch.valid_ssn;
  DATASET(Risk_Indicators.Layout_Desc) hri_ssn {MAXCOUNT(doxie.rollup_limits.ssn_hris)};
END;

export SsnRec_seq := RECORD // Added for the FDN project
  unsigned2 seq;
  unsigned2 ssnrec_seq;
	SsnRec;
	boolean fdn_waf_contrib_data    := false;
  boolean fdn_results_found       := false;
  boolean fdn_indicators_returned := false; // Added for bug 196447
end;

export DobRec := RECORD
	doxie.Layout_HeaderFileSearch.dob;
	doxie.Layout_HeaderFileSearch.age;
END;

export DodRec := RECORD
	doxie.Layout_HeaderFileSearch.dod;
	doxie.Layout_HeaderFileSearch.dead_age;
	string1 deceased := 'U';
	boolean IsLimitedAccessDMF := False;
END;

export DIDRec := RECORD
	doxie.Layout_HeaderFileSearch.did;
END;

export RidRec := RECORD
	doxie.Layout_HeaderFileSearch.rid;
	doxie.Layout_HeaderFileSearch.src;
	unsigned6 docCnt := 1;
END;


export NameRecDid := RECORD
  doxie.Layout_HeaderFileSearch.did; 
  doxie.Layout_HeaderFileSearch.penalt;
	doxie.Layout_HeaderFileSearch.num_compares;	
	NameRec n;
END;

export AddrRecDid := RECORD
  doxie.Layout_HeaderFileSearch.did;
  doxie.Layout_HeaderFileSearch.penalt;
	doxie.Layout_HeaderFileSearch.num_compares;
	unsigned1 bestTntScore := high_tnt;
	unsigned1 bestSrchedAddrTntScore := high_tnt;
	unsigned3 bestSrchedAddrDate;
  boolean fromGong := false;
	AddrRec a;
END;

export SsnRecDid := RECORD
  doxie.Layout_HeaderFileSearch.did;
  doxie.Layout_HeaderFileSearch.penalt;
	doxie.Layout_HeaderFileSearch.num_compares;	
	unsigned1 bestSrchedValidSSNScore := high_valid_ssn;
	SsnRec s;
END;

export DobRecDid := RECORD
	doxie.Layout_HeaderFileSearch.did;
  doxie.Layout_HeaderFileSearch.penalt;
	doxie.Layout_HeaderFileSearch.num_compares;	
	DobRec d;
END;

export DodRecDid := RECORD
	doxie.Layout_HeaderFileSearch.did;
  doxie.Layout_HeaderFileSearch.penalt;
	doxie.Layout_HeaderFileSearch.num_compares;
  boolean fromDeathSrc := false;
	DodRec d;
END;

export RidRecDid := RECORD
	doxie.Layout_HeaderFileSearch.did;
	doxie.Layout_HeaderFileSearch.listed_phone;
  RidRec r;
END;

export KeyRec := RECORD
	doxie.Layout_HeaderFileSearch.did;
	unsigned2 fdn_did_ind := 0; // Added for FDN project

	doxie.Layout_HeaderFileSearch.penalt;
	doxie.Layout_HeaderFileSearch.num_compares;
	boolean includedByHHID := false;
	boolean expandedPhonePlusRecord := false;
	unsigned1 bestSrchedAddrTntScore := high_tnt;
	unsigned3 bestSrchedAddrDate := 0;
	unsigned1 bestTntScore := high_tnt; 
	unsigned1 bestSrchedValidSSNScore := high_valid_ssn;

	DATASET(NameRec) nameRecs {MAXCOUNT(doxie.rollup_limits.names)};
	boolean addrs_suppressed := false;
	DATASET(AddrRec)  addrRecs {MAXCOUNT(doxie.rollup_limits.addresses)};
	DATASET(SsnRec)   ssnRecs {MAXCOUNT(doxie.rollup_limits.ssns)};
	DATASET(DobRec)   dobRecs {MAXCOUNT(doxie.rollup_limits.dobs)};
	DATASET(DodRec)   dodRecs {MAXCOUNT(doxie.rollup_limits.dods)};
	DATASET(doxie.Layout_DLStateInfo) dlRecs;
  // added paw_v2 -- see bug: 45732
	DATASET(iesp.peopleatwork.t_PeopleAtWorkRecord) paw {xpath('PeopleAtWorks/PeopleAtWork'),MAXCOUNT(iesp.constants.BR.MaxPeopleAtWork)};
	DATASET(paw_services.PAW_OutRecsLayout) paw_v2 {MAXCOUNT(iesp.constants.BR.MaxPeopleAtWork)};
  doxie.layout_lookups.xcount;
	unsigned2 premium_phone_count := 0;
	doxie.Layout_HeaderFileSearch.hasCriminalConviction;
	doxie.Layout_HeaderFileSearch.isSexualOffender;
	doxie.Layout_HeaderFileSearch.hasCriminalImages;
	doxie.Layout_HeaderFileSearch.hasSexualOffenderImages;
	DATASET(doxie.Layout_Phones) WorkPhones {MAXCOUNT(doxie.rollup_limits.phones)};
	DATASET(doxie.Layout_Phones) RelativePhones {MAXCOUNT(doxie.rollup_limits.phones)};
	DATASET(Standard.Name) RelativeNames {MAXCOUNT(doxie.rollup_limits.relatives_names)};
	DATASET(RidRec) rids {MAXCOUNT(ut.limits.HEADER_PER_DID)};
	unsigned6 maxRid;
	unsigned3 maxDate;
  boolean fdn_waf_contrib_data    := false; // Added for FDN project
  boolean fdn_results_found       := false; // Added for FDN project
  boolean fdn_indicators_returned := false; // Added for bug 196447
END;

export KeyRec_seq_fdn := RECORD // added for FDN project
		unsigned2 seq;
		KeyRec;
end;

export KeyRec_feedback := RECORD
	doxie.Layout_HeaderFileSearch.did;
	unsigned2 fdn_did_ind := 0; // Added for FDN project
	doxie.Layout_HeaderFileSearch.penalt;
	doxie.Layout_HeaderFileSearch.num_compares;
	boolean includedByHHID := false;
	unsigned1 bestSrchedAddrTntScore := high_tnt;
	unsigned3 bestSrchedAddrDate := 0;
	unsigned1 bestTntScore := high_tnt; 
	unsigned1 bestSrchedValidSSNScore := high_valid_ssn;

	DATASET(NameRec) nameRecs {MAXCOUNT(doxie.rollup_limits.names)};
	boolean addrs_suppressed := false;
	DATASET(AddrRec_feedback)  addrRecs {MAXCOUNT(doxie.rollup_limits.addresses)};
	DATASET(SsnRec)   ssnRecs {MAXCOUNT(doxie.rollup_limits.ssns)};
	unsigned2 ssn_count := 0;
	DATASET(DobRec)   dobRecs {MAXCOUNT(doxie.rollup_limits.dobs)};
	DATASET(DodRec)   dodRecs {MAXCOUNT(doxie.rollup_limits.dods)};
	DATASET(doxie.Layout_DLStateInfo) dlRecs;
  // added paw_v2 -- see bug: 45732
	DATASET(iesp.peopleatwork.t_PeopleAtWorkRecord) paw {xpath('PeopleAtWorks/PeopleAtWork'),MAXCOUNT(iesp.constants.BR.MaxPeopleAtWork)};
	DATASET(paw_services.PAW_OutRecsLayout) paw_v2 {MAXCOUNT(iesp.constants.BR.MaxPeopleAtWork)};
	
  doxie.layout_lookups.xcount;
	unsigned2 premium_phone_count := 0;
	doxie.Layout_HeaderFileSearch.hasCriminalConviction;
	doxie.Layout_HeaderFileSearch.isSexualOffender;
	doxie.Layout_HeaderFileSearch.hasCriminalImages;
	doxie.Layout_HeaderFileSearch.hasSexualOffenderImages;
 
	DATASET(Layout_Phones) WorkPhones {MAXCOUNT(doxie.rollup_limits.phones)};
	DATASET(Layout_Phones) RelativePhones {MAXCOUNT(doxie.rollup_limits.phones)};
	DATASET(Standard.Name) RelativeNames {MAXCOUNT(doxie.rollup_limits.relatives_names)};
	DATASET(RidRec) rids {MAXCOUNT(ut.limits.HEADER_PER_DID)};
	unsigned2 rid_cnt;
	unsigned2 src_cnt;
	unsigned2 src_doc_cnt;
	
	unsigned6 maxRid;
	unsigned3 maxDate;

  boolean fdn_waf_contrib_data    := false; // Added for FDN project
  boolean fdn_results_found       := false; // Added for FDN project
  boolean fdn_indicators_returned := false; // Added for FDN bug 196447
	DATASET(iesp.ContactPlus.t_ContactPlusProgPhoneRecord) progressive_phones {MAXCOUNT(doxie.rollup_limits.progressivePhone)};
	unsigned2 output_seq_no;
  BOOLEAN BusinessCreditMatch  := FALSE; // added for SBFE project 
	
  END;

// special record structure to support flattened results for batch requests.
export KeyRec_feedback_batch := RECORD
  string20	acctno := '';
	STRING12 linkID;
	unsigned2 seq;
	string4 recordType;  //see doxie.fn_flatten_rollup.RECORDTYPE for values.
	unsigned2 typeSeq;
	doxie.Layout_HeaderFileSearch.penalt;
	doxie.Layout_HeaderFileSearch.num_compares;
	boolean includedByHHID := false;
	unsigned1 bestSrchedAddrTntScore := high_tnt;
	unsigned3 bestSrchedAddrDate := 0;
	unsigned1 bestTntScore := high_tnt; 
	unsigned1 bestSrchedValidSSNScore := high_valid_ssn;
	boolean addrs_suppressed := false;
	unsigned2 ssn_count := 0;
	NameRec;
	AddrRec_feedback_batch;
	SsnRec;
	DobRec;
	DodRec;
	String24 dl_num;
	String2 dl_st;
	END;
	
  EXPORT KeyRec_Seq := RECORD
		KeyRec;
		unsigned2 output_seq_no;
	END;
	
	EXPORT header_rolled := RECORD
		DATASET(KeyRec_Seq) Results;
		DATASET(Royalty.Layouts.Royalty) Royalty;
		UNSIGNED2 householdRecordsAvailable := 0;
	END;		

END;