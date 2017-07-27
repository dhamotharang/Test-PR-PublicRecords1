IMPORT doxie, AutoHeaderV2, Standard, iesp, Risk_Indicators, doxie;

EXPORT layouts := MODULE

EXPORT _dl := RECORD //driver license number & driver license state
	doxie.Layout_DLStateInfo - [earliest_lic_issue_date,latest_expiration_date];
END;

EXPORT in_layout := RECORD
	AutoHeaderV2.layouts.lib_search;
	_dl; //DRIVER LICENSE
END;

EXPORT layout_cleaner := RECORD // layout for cleaner, modified to support Driver License
	AutoHeaderV2.layouts.search;
	_dl tdl;
END;

EXPORT NameRec := RECORD // Name Record
	Standard.Name.title;
	Standard.Name.fname;
	Standard.Name.mname;
	Standard.Name.lname;
	Standard.Name.name_suffix;
END;

EXPORT SsnRec := RECORD // SSN Record
	doxie.Layout_HeaderFileSearch.ssn;
	doxie.Layout_HeaderFileSearch.valid_ssn;
	unsigned4 ssn_issue_early_fulldate;
	unsigned4 ssn_issue_last_fulldate;
	string50  ssn_issue_state;
END;

EXPORT DobRec := RECORD // DOB Record
	doxie.Layout_HeaderFileSearch.dob;
END;

EXPORT PhoneRec := RECORD // Phone Record
	doxie.Layout_presentation.phone;
	doxie.Layout_Phones.listed_name;
END;

EXPORT AddrRec := RECORD // Address Record
	doxie.Layout_HeaderFileSearch.prim_range;
	doxie.Layout_HeaderFileSearch.prim_name;
	doxie.Layout_HeaderFileSearch.predir;
	doxie.Layout_HeaderFileSearch.suffix;
	doxie.Layout_HeaderFileSearch.postdir;
	doxie.Layout_HeaderFileSearch.unit_desig;
	doxie.Layout_HeaderFileSearch.sec_range;
	doxie.Layout_HeaderFileSearch.city_name;
	doxie.Layout_HeaderFileSearch.st;
	doxie.Layout_HeaderFileSearch.zip;
	doxie.Layout_HeaderFileSearch.zip4;
	doxie.Layout_HeaderFileSearch.county_name;
	doxie.Layout_HeaderFileSearch.geo_blk;
	doxie.Layout_presentation.dt_first_seen;
	doxie.Layout_presentation.dt_last_seen;
	doxie.Layout_presentation.dt_nonglb_last_seen;
	 DATASET(Risk_Indicators.Layout_Desc) hri_address;
END;

EXPORT NameRec_penalty := RECORD
	NameRec;
	UNSIGNED2 penalty_name;
END;

EXPORT SSNRec_penalty := RECORD
	SSNRec;
	UNSIGNED2 penalty_ssn;
END;

EXPORT DOBRec_penalty := RECORD
	DOBRec;
	UNSIGNED2 penalty_dob;
END;

EXPORT AddrRec_penalty := RECORD
	AddrRec;
	UNSIGNED2 penalty_addr;
END;

EXPORT PhoneRec_penalty := RECORD
	PhoneRec;
	UNSIGNED2 penalty_phone;
END;

// TODO: We will rmeoved more fields once the reponse and request finalized?
EXPORT slimrec := RECORD
  doxie.layout_header_records.penalt;
	RECORDOF(doxie.key_header) - [s_did, rid, pflag1,pflag2,pflag3, rec_type, vendor_id, cbsa, jflag1,jflag2,jflag3, rawaid,persistent_record_id];
	doxie.layout_header_records.includedByHHID;
	doxie.layout_header_records.timezone;
	doxie.Layout_presentation.glb;
	doxie.Layout_presentation.dppa;
	unsigned4 ssn_issue_early_fulldate;
	unsigned4 ssn_issue_last_fulldate;
	BOOLEAN ssn_valid_issue;
	string32 ssn_issue_state;
	DATASET(Risk_Indicators.Layout_Desc) hri_address := dataset ([], Risk_Indicators.Layout_Desc);
  integer fetch_code := 0;
END;
		
EXPORT headerRecordEx := RECORD
  doxie.layout_presentation;
	unsigned4 ssn_issue_early_fulldate;
	unsigned4 ssn_issue_last_fulldate;
	BOOLEAN ssn_valid_issue;
	string50 ssn_issue_state;
END;


END;