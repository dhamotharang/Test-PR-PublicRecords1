import header, PRTE2;
EXPORT Layouts := module

	EXPORT layout_counts := RECORD
	   unsigned2 ssn_ct;
	   unsigned2 ssn_ct_c6;
	   unsigned2 did_ct;
	   unsigned2 did_ct_c6;
	END;

	layout_avm := record
		string5 fips_code;
		string7 geo_blk;
		string1 land_use;
		string8 recording_date;
		string4 assessed_value_year;
		string11 sales_price;  
		string11 assessed_total_value;
		string11 market_total_value;
		integer price_index_valuation;
		integer tax_assessment_valuation;
		integer hedonic_valuation;
		integer automated_valuation;
		integer confidence_score;
	end;

//Append CCPA fields
	export layout_addr_risk := record
		string10 prim_range;
		string2 predir;
		string28 prim_name;
		string4 suffix;
		string2 postdir;
		string8 sec_range;
		string5 zip;
		layout_counts combo;
		layout_counts eq;
		layout_counts en;
		layout_counts tn;
		layout_avm;
		PRTE2.Layouts.DEFLT_CPA;
	end;

	EXPORT common_adl_risk := RECORD
	   unsigned1 addr_ct;
	   unsigned1 addr_ct_last30days;
	   unsigned1 addr_ct_last90days;
	   unsigned1 addr_ct_c6;
	   unsigned1 addr_ct_last1year;
	   unsigned1 addr_ct_last2years;
	   unsigned1 addr_ct_last3years;
	   unsigned1 addr_ct_last5years;
	   unsigned1 addr_ct_last10years;
	   unsigned1 addr_ct_last15years;
	   unsigned1 ssn_ct;
	   unsigned1 ssn_ct_c6;
	   unsigned1 ssn_ct_s18;
	   unsigned1 lname_ct;
	   unsigned1 lname_ct30;
	   unsigned1 lname_ct90;
	   unsigned1 lname_ct180;
	   unsigned1 lname_ct12;
	   unsigned1 lname_ct24;
	   unsigned1 lname_ct36;
	   unsigned1 lname_ct60;
	   string20 newest_lname;
	   string20 newest_lname2;
	   unsigned3 newest_lname_dt_first_seen;
	   unsigned2 dl_addrs_per_adl;
	   unsigned2 vo_addrs_per_adl;
	   unsigned2 pl_addrs_per_adl;
	   unsigned2 invalid_ssns_per_adl;
	   unsigned2 invalid_ssns_per_adl_created_6months;
	   unsigned2 invalid_addrs_per_adl;
	   unsigned2 invalid_addrs_per_adl_created_6months;
	   unsigned1 stability;
	   unsigned4 reported_dob;
	   string2 reported_dob_src;
	   integer8 inferred_age;
	   unsigned4 reported_dob_no_dppa;
	   string2 reported_dob_src_no_dppa;
	   integer8 inferred_age_no_dppa;
	  END;

	EXPORT lname_var := RECORD
	    string20 fname;
	    string20 lname;
	    unsigned3 first_seen;
	    unsigned3 last_seen;
	   END;
	   
	common_rec := RECORD
		unsigned3 header_first_seen;
		unsigned3 header_last_seen;
		INTEGER headerCount;
		INTEGER EqCount;
		INTEGER EnCount;
		INTEGER TnCount;
		INTEGER TuCount;
		INTEGER SrcCount;
		INTEGER DidCount;
		INTEGER DidCount_c6;//  number of dids created in the last 6 months
		integer didcount_multiple_use; // ADLs per SSN that have more than just 1 record with that SSN
		integer addr_ct_multiple_use; //  addresses per SSN that have multiple records
		integer lname_ct;
		integer lname_ct_c6;
		integer addr_ct;  // number of addresses associated with that SSN
		integer addr_ct_c6;  // number of addresses newly associated with that ssn within the last 6 months	
		INTEGER BestCount;
		INTEGER RecentCount;
		unsigned6 BestDid;
		lname_var lname1;
		lname_var lname2;
		lname_var lname3;
		lname_var lname4;
		boolean isDeceased;
		unsigned dt_first_deceased;
		unsigned decs_dob;
		string5 decs_zip_lastres;
		string5 decs_zip_lastpayment;
		string20 decs_last;
		string20 decs_first;
		unsigned6 deathDid;
	END;
	
//Append CCPA fields
	export final_rec := RECORD
		STRING9 ssn;
		unsigned3 official_first_seen;
		unsigned3 official_last_seen;
		boolean isValidFormat;
		boolean isSequenceValid;
		boolean isBankrupt := false; // If using FCRA, hardcode to FALSE as Corrections File is not being taken into account.
		unsigned dt_first_bankrupt := 0;	// If using FCRA, hardcode to 0 as Corrections File is not being taken into account.
		STRING2 issue_state;
		common_rec combo;
		common_rec eq;
		common_rec en;
		common_rec tn;
		PRTE2.Layouts.DEFLT_CPA;
	END;

	common_rec := RECORD
		unsigned3 header_first_seen;
		unsigned3 header_last_seen;
		INTEGER headerCount;
		INTEGER EqCount;
		INTEGER EnCount;
		INTEGER TnCount;
		INTEGER TuCount;
		INTEGER SrcCount;
		INTEGER DidCount;
		INTEGER DidCount_c6;//  number of dids created in the last 6 months
		INTEGER DidCount_s18; // number of dids seen in the last 18 months
		integer addr_ct;  // number of addresses associated with that SSN
		integer addr_ct_c6;  // number of addresses newly associated with that ssn within the last 6 months
		INTEGER BestCount;
		INTEGER RecentCount;
		unsigned6 BestDid;
		lname_var lname1;
		lname_var lname2;
		lname_var lname3;
		lname_var lname4;
	END;

//Append CCPA fields
	export final_rec_v4 := RECORD
		STRING9 ssn;
		unsigned3 official_first_seen;
		unsigned3 official_last_seen;
		boolean isValidFormat;
		boolean isSequenceValid;
		boolean isBankrupt := false; // If using FCRA, hardcode to FALSE as Corrections File is not being taken into account.
		unsigned dt_first_bankrupt := 0;	// If using FCRA, hardcode to 0 as Corrections File is not being taken into account.
		boolean isDeceased;
		unsigned dt_first_deceased;
		unsigned decs_dob;
		string5 decs_zip_lastres;
		string5 decs_zip_lastpayment;
		string20 decs_last;
		string20 decs_first;
		STRING2 issue_state;
		common_rec combo;
		common_rec eq;
		common_rec en;
		common_rec tn;
		PRTE2.Layouts.DEFLT_CPA;
	END;


	EXPORT phones_base_layout := record
		string10 phone10;
		string10 prim_range;
		string28 prim_name;
		string5  zip;
		string20 name_first;
		string20 name_last;
		string2  src;
	end;
	
	export inRec := RECORD
		STRING60 ssn;
		STRING1 lf;
	END;
	export common_rec_v4_2 := RECORD
		STRING9 ssn;
		unsigned3 header_first_seen;
		unsigned3 header_last_seen;
		INTEGER headerCount;//
		INTEGER EqCount;//
		INTEGER EnCount;
		INTEGER TnCount;//
		INTEGER TuCount;//
		INTEGER SrcCount;//
		INTEGER DidCount;//
		INTEGER DidCount_c6;
		integer didcount_multiple_use; // ADLs per SSN that have more than just 1 record with that SSN
		integer addr_ct_multiple_use; //  addresses per SSN that have multiple records
		integer lname_ct;
		integer lname_ct_c6;
		integer addr_ct;  // number of addresses associated with that SSN
		integer addr_ct_c6;  // number of addresses newly associated with that ssn within the last 6 months
		INTEGER BestCount;//
		INTEGER RecentCount;  // has a DID that's been seen within the past 18 months	
		unsigned6 BestDid;
		lname_var lname1;
		lname_var lname2;
		lname_var lname3;
		lname_var lname4;
		boolean isDeceased;
		unsigned dt_first_deceased;
		unsigned decs_dob;
		string5 decs_zip_lastres;
		string5 decs_zip_lastpayment;
		string20 decs_last;
		string20 decs_first;
		unsigned6 deathDid := 0;
	END;

	export asl := record
		unsigned6 did;
		unsigned1 addr_ct;
		unsigned1 addr_ct_last30days;
		unsigned1 addr_ct_last90days;
		unsigned1 addr_ct_c6;
		unsigned1 addr_ct_last1year;
		unsigned1 addr_ct_last2years;
		unsigned1 addr_ct_last3years;
		unsigned1 addr_ct_last5years;
		unsigned1 addr_ct_last10years;
		unsigned1 addr_ct_last15years;
		unsigned1 ssn_ct;
		unsigned1 ssn_ct_c6;
		unsigned1 ssn_ct_s18;
		unsigned1 lname_ct;
		unsigned1 lname_ct30;
		unsigned1 lname_ct90;
		unsigned1 lname_ct180;
		unsigned1 lname_ct12;
		unsigned1 lname_ct24;
		unsigned1 lname_ct36;
		unsigned1 lname_ct60;
		string20 newest_lname;
		string20 newest_lname2;
		unsigned3 newest_lname_dt_first_seen;
		unsigned2 dl_addrs_per_adl;
		unsigned2 vo_addrs_per_adl;
		unsigned2 pl_addrs_per_adl;
		unsigned2 invalid_ssns_per_adl;  
		unsigned2 invalid_ssns_per_adl_created_6months;  
		unsigned2 invalid_addrs_per_adl;  
		unsigned2 invalid_addrs_per_adl_created_6months;
	end;

	export invalid_slim := RECORD
		unsigned6 did;
		unsigned2 invalid_ssns_per_adl;  
		unsigned2 invalid_ssns_per_adl_created_6months; 
	END;
	
	export risk_adl := record
		asl;	
		unsigned1 stability;
		unsigned4 reported_dob;
		string2 reported_dob_src;
		integer inferred_age;
		unsigned4 reported_dob_no_dppa;
		string2 reported_dob_src_no_dppa;
		integer inferred_age_no_dppa;
	end;	
	
	export resultrec := RECORD
		unsigned6 did;
		integer stability;
	END;
	
// new for shell 5.3 for Correlation Keys	
export  common_layout := record
	string2 src;
	unsigned dt_first_seen;
	unsigned dt_last_seen;
	unsigned record_count;
end;

export ssn_name_summary := record
	qstring9   ssn;
	qstring20  lname;
	qstring20  fname;
	dataset(common_layout) summary {MAXCOUNT(constants.max_source_summary)};
end;

export ssn_addr_summary := record
	qstring9   ssn;
	qstring28  prim_name;
	qstring10  prim_range;
	qstring5   zip;
	dataset(common_layout) summary {MAXCOUNT(constants.max_source_summary)};
end;


export ssn_phone_summary := record
	qstring9  ssn;
	qstring10 phone;
	dataset(common_layout) summary {MAXCOUNT(constants.max_source_summary)};
end;

export ssn_dob_summary := record
	qstring9 ssn;
	integer4 dob;
	dataset(common_layout) summary {MAXCOUNT(constants.max_source_summary)};
end;

export addr_name_summary := record
	qstring28 prim_name;
	qstring10 prim_range;
	qstring5  zip;
	qstring20 lname;
	qstring20 fname;
	dataset(common_layout) summary {MAXCOUNT(constants.max_source_summary)};
end;

export addr_dob_summary := record
	qstring28  prim_name;
	qstring10  prim_range;
	qstring5   zip;
	integer4   dob;
	dataset(common_layout) summary {MAXCOUNT(constants.max_source_summary)};
end;

export name_dob_summary := record
	qstring20 lname;
	qstring20 fname;
	integer4  dob;
	dataset(common_layout) summary {MAXCOUNT(constants.max_source_summary)};
end;

export phone_addr_summary := record
	string10  phone10; 
	string28  prim_name;
	string10  prim_range;
	string5  	zip;
	dataset(common_layout) summary {MAXCOUNT(constants.max_source_summary)};
end;

export phone_lname_summary := record
	string10 phone10;
	string20 name_last;
	dataset(common_layout) summary {MAXCOUNT(constants.max_source_summary)};
end;

export phone_dob_summary := record
	qstring10 phone;
	integer4  dob;
	dataset(common_layout) summary {MAXCOUNT(constants.max_source_summary)};
end;

EXPORT phones_base_layout2 := record
		string10 phone10;
		string10 prim_range;
		string28 prim_name;
		string5  zip;
		string20 name_first;
		string20 name_last;
		string2  src;
		unsigned dt_first_seen;
		unsigned dt_last_seen;
	end;

END;