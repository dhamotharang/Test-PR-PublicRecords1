EXPORT layouts_bk_test := MODULE

EXPORT comments := RECORD
	string50 tmsid;
	string8 filing_date;
	string30 description;
END;

EXPORT status := RECORD
	string50 tmsid;
	string8 status_date;
	string30 status_type;
END;

EXPORT main	:= RECORD
	string50 tmsid;
	string8 process_date;
	string1 source;
	string12 id;
	string10 seq_number;
	string8 date_created;
	string8 date_modified;
	string5 court_code;
	string50 court_name;
	string40 court_location;
	string7 case_number;
	string25 orig_case_number;
	string3 chapter;
	string8 date_filed;
	string10 orig_filing_type;
	string12 filing_status;
	string3 orig_chapter;
	string8 orig_filing_date;
	string5 assets_no_asset_indicator;
	string1 filer_type;
	string1 corp_flag;
	string8 meeting_date;
	string8 meeting_time;
	string90 address_341;
	string8 claims_deadline;
	string8 complaint_deadline;
	string8 disposed_date;
	string35 disposition;
	string3 pro_se_ind;
	string35 judge_name;
	string5 judges_identification;
	string128 record_type;
	string2 filing_jurisdiction;
	string20 assets;
	string20 liabilities;
	string1 casetype;
	string1 assoccode;
	string8 date_last_seen;
	string8 date_first_seen;
	string8 date_vendor_first_reported;
	string8 date_vendor_last_reported;
	string8 converted_date;
	string8 reopen_date;
	string8 case_closing_date;
END;

END;