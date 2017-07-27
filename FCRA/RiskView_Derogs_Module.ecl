import ut, STD;

export RiskView_Derogs_Module := module

export todaysdate := (string) STD.Date.Today();
export max_lien_count := 50;
export max_bk_count := 5;
export default_flag := 'N';
export default_amount := '';

// ran distribution stats on the values in the disposition field, and market planners selected these dispositions as "Closed", everything else to be considered "Open"
export closed_bk_dispositions := ['DISCHARGED','DISMISSED','CASE DISMISSED','CLOSED','DISPOSED','PETITION DISMISSED',
						   'TERMINATED','DISCHARGE N/A','FOR CASES ENTERED IN ERROR ONLY','COURT USED ONLY'];

export closed_lien_status := ['CLOSED','D','DELETED','DISCONTINUED','DISMISSED','DISPOSED','DISPOSED HEARING',
					  'E','EXPUNGED','FILED IN ERROR','NOT ACTIVE','RELEASE','RELEASED','REMOVED','REVOKED',
					  'S','SATISFIED','SETTLED','SPECIAL PERFORMANCE','STRIKE','VACATED','VACCATED','VOID',
					  'WITHDRAWAL','WITHDRAWN'];


export layout_derogs_summary := record
	unsigned seq;
	unsigned did;
	string1 bankrupt := default_flag;
	string1 federal_tax_lien := default_flag;
	string30 federal_tax_amount := default_amount;
	string1 state_tax_lien := default_flag;
	string30 state_tax_amount := default_amount;
	string1 county_tax_lien := default_flag;
	string30 county_tax_amount := default_amount;
	string1 child_support := default_flag;
	string30 child_support_amount := default_amount;
end;

export layout_report_address_out := record
	string10   prim_range;
	string2    predir;
	string28   prim_name;
	string4    suffix;
	string2    postdir;
	string10   unit_desig;
	string8    sec_range;
	string25   p_city_name;
	string2    st;
	string5    z5;
	string4    zip4;
	string2    rec_type;
	string5    county;
	string25   county_name := '';
end;

export bk_final := record
	string10   seq_number;
	string5    court_code;
	string7    case_number;
	string20   debtor_fname;
	string20   debtor_mname;
	string20   debtor_lname;
	string5    debtor_name_suffix;
	layout_report_address_out;
	string8	  date_filed;
	string8	  date_created;
	string50	 court_name;
	string40	 court_location;
	string20	 court_state;  // comes from mapping of court code
	string8	  case_closing_date;
	string3	  chapter;
	string12	filing_status;
	string20	 filer_type_mapped;  // comes from mapping of filer_type
	string3	  pro_se_ind;
	string8	  orig_filing_date;
	string3	  corp_flag;
	string8	  meeting_date;
	string8	  meeting_time;
	string90	 address_341;
	// string8  	disposed_date;  // removed because we're only displaying open bk, so no need for the disposed_date field
	string35	 disposition;
	string8		 converted_date;
end;

export lien_final := record
	string50 tmsid;
	string5  title					;
	string20 fname					;
	string20 mname					;
	string20 lname					;
	string5  name_suffix		;
	layout_report_address_out;
	string50 filing_jurisdiction := '';
	string25 filing_jurisdiction_name := '';
	string10 filing_state := '';
	string20 orig_filing_number := '';
	string8 orig_filing_date := '';
	string25 case_number   := '';
	string20 filing_status := '';
	string65 filing_status_desc := '';
	string20 filing_number := '';
	string30 filing_type_desc := '';
	string6 filing_book := '';
	string6 filing_page := '';
	string30 amount := '';
	string1 eviction := '';
end;

export batch_layout := record
	layout_derogs_summary;
	bk_final bankruptcy;
	lien_final liens;
	string1 hit:='N';
end;

export xml_layout := record, maxlength(35000)
	// input echo fields
	string30 accountnumber;
	STRING120 unParsedFullName;
	STRING20 firstname;
	STRING20 middlename;
	STRING20 lastname;
	STRING5  namesuffix;
	string65 addr;
	STRING25 city;
	STRING2  state;
	STRING5  zip;
	STRING9  ssn;
	STRING8  dob;
	STRING10 phone;
	
	layout_derogs_summary;
	dataset(bk_final) bankruptcy { maxcount(max_bk_count) };
	dataset(lien_final) liens { maxcount(max_lien_count) };
	string1 hit:='N';
end;

export seed_layout := record	
	string20 dataset_name;
	string30 acctNo;
	string15 fname;
	string20 lname;
	string9  zip;
	string9  ssn;
	string10 hphone;
	batch_layout;
end;

END;