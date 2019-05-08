import doxie, bankruptcyv2, risk_indicators, ut, PhonesFeedback_Services,AddressFeedback_Services;
export Layouts := MODULE
	
	export bkInfo := RECORD
	  bankruptcyv2.layout_bankruptcy_main.layout_bankruptcy_main_filing.tmsid;
    bankruptcyv2.layout_bankruptcy_main.layout_bankruptcy_main_filing.court_code;
    bankruptcyv2.layout_bankruptcy_main.layout_bankruptcy_main_filing.court_name;
    bankruptcyv2.layout_bankruptcy_main.layout_bankruptcy_main_filing.case_number;
    string10 filing_type_ex;    // exploded value for orig_filing_type
    bankruptcyv2.layout_bankruptcy_main.layout_bankruptcy_main_filing.record_type;
    bankruptcyv2.layout_bankruptcy_main.layout_bankruptcy_main_filing.date_filed;
    bankruptcyv2.layout_bankruptcy_main.layout_bankruptcy_main_filing.disposed_date;
	END;
	
	export HFS_wide := record(doxie.Layout_HeaderFileSearch)
		dataset(doxie.Layout_Rollup.RidRec) rids {maxcount(ut.limits.HEADER_PER_DID)} := dataset([],doxie.Layout_Rollup.RidRec);
	end;
	
	export headerRecord := RECORD(HFS_wide)
		unsigned4 ssn_issue_early_fulldate := 0;
		unsigned4 ssn_issue_last_fulldate := 0;
		string5 ssn_valid_issue := '';
		string50 ssn_issue_state := '';
	END;
		
	export headerRecordBK := RECORD(headerRecord)
		bkInfo;
	END;

	export headerRecordExt := RECORD(headerRecordBK)
		dataset(PhonesFeedback_Services.Layouts.feedback_report) phone_feedback; 
		dataset(AddressFeedback_Services.Layouts.feedback_report) address_feedback; 
		// Added 7 new indicators for the FDN project
		unsigned2 fdn_did_ind   := 0;
		unsigned2 fdn_addr_ind  := 0;
		unsigned2 fdn_ssn_ind   := 0;
	  unsigned2 fdn_phone_ind := 0;
	  unsigned2 fdn_listed_phone_ind := 0;
    boolean fdn_waf_contrib_data := false;
    boolean fdn_results_found    := false;
    boolean fdn_inds_returned    := false; // Added for bug 196447
	end;

  // Added for the FND project
	EXPORT rec_headerRecordExt_seq := RECORD
	  unsigned3 seq; 
    headerRecordExt;
  END;

  // Added for the FND project
	EXPORT rec_layout_phones_seq := RECORD
	  unsigned3 seq; 
	  unsigned2 phoneRec_seq;
    doxie.Layout_Phones;
		boolean fdn_waf_contrib_data := false;
    boolean fdn_results_found    := false;
	  boolean fdn_inds_returned    := false; // Added for bug 196447
  END;

	export NameRec := RECORD
		doxie.Layout_HeaderFileSearch.title;
		doxie.Layout_HeaderFileSearch.fname;
		doxie.Layout_HeaderFileSearch.mname;
		doxie.Layout_HeaderFileSearch.lname;
		doxie.Layout_HeaderFileSearch.name_suffix;
	END;
	
	export AddrRec := RECORD
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
	  doxie.Layout_HeaderFileSearch.hri_address;
		dataset(AddressFeedback_Services.Layouts.feedback_report) address_feedback; 
	END;

	export SsnRec := RECORD
		doxie.Layout_HeaderFileSearch.ssn;
		doxie.Layout_HeaderFileSearch.valid_ssn;
		unsigned4 ssn_issue_early_fulldate := 0;
		unsigned4 ssn_issue_last_fulldate := 0;
		string5 ssn_valid_issue := '';
		string50 ssn_issue_state := '';
		doxie.Layout_HeaderFileSearch.hri_ssn;
		// Added for the FDN project
		unsigned2 fdn_ssn_ind        := 0;
 	  boolean fdn_waf_contrib_data := false;
    boolean fdn_results_found    := false;
    boolean fdn_inds_returned    := false; // Added for bug 196447
	END;	
	
  // Added for the FND project
	EXPORT rec_ssnRec_seq := RECORD
	  unsigned3 seq; 
    unsigned2 ssnrec_seq;
    ssnRec;
  END;
	
	export DlRec := RECORD
		doxie.Layout_DLStateInfo;
	END;	

	export DlRecPlusDid := RECORD
		doxie.Layout_HeaderFileSearch.did;
		doxie.Layout_DLStateInfo;
	END;	

	export DlRecDataset := RECORD
		doxie.Layout_HeaderFileSearch.did;
		dataset(doxie.Layout_DLStateInfo) dls;
	END;	

	export DatesRec := RECORD
		doxie.Layout_HeaderFileSearch.dob;
		doxie.Layout_HeaderFileSearch.age;
		doxie.Layout_HeaderFileSearch.dod;
		doxie.Layout_HeaderFileSearch.IsLimitedAccessDMF;
		doxie.Layout_HeaderFileSearch.dead_age;
		doxie.Layout_HeaderFileSearch.death_code;
		doxie.Layout_HeaderFileSearch.deceased;
	END;

	export PhonesRec := RECORD(doxie.layout_phones)
	  boolean fdn_waf_contrib_data := false; // FDN project addition
    boolean fdn_results_found    := false; // FDN project addition
    boolean fdn_inds_returned    := false; // Added for bug 196447
	END;
	
	export PhonesRecWithFeedback := record(PhonesRec)
			dataset(PhonesFeedback_Services.Layouts.feedback_report) feedback;
	end;	

	export RidRec := RECORD
		doxie.Layout_HeaderFileSearch.rid;
		doxie.Layout_HeaderFileSearch.src;
		unsigned6 docCnt := 1;
	END;

	export rollupRecord := RECORD
		doxie.Layout_HeaderFileSearch.penalt;
		doxie.Layout_HeaderFileSearch.did;
		AddrRec;
		DATASET(NameRec) names {MAXCOUNT(constants.max_names)};
		DATASET(SsnRec) ssns {MAXCOUNT(constants.max_ssns)};
		DATASET(DatesRec) dates {MAXCOUNT(constants.max_dates)};
		DATASET(PhonesRec) phones {MAXCOUNT(constants.max_phones)};
		DATASET(RidRec) rids {MAXCOUNT(constants.max_rids)};
		Dataset(DlRec) dls {MAXCOUNT(constants.max_dls)};
		doxie.layout_lookups.xcount;
		bkInfo;
		// Added 4 new FDN indicators
		unsigned2 fdn_did_ind   := 0;
		unsigned2 fdn_addr_ind  := 0;
		boolean fdn_waf_contrib_data := false;
    boolean fdn_results_found    := false;
    boolean fdn_inds_returned    := false; // Added for bug 196447
	END;

  // Added for the FND project
	EXPORT rec_rollupRecord_seq := RECORD
	  unsigned3 seq; // for matching to when the input info is passed back to calling routine
    rollupRecord;
  END;
  
END;