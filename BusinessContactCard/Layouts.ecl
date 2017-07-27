IMPORT iesp, BIPV2, doxie_cbrs, Moxie_phonesplus_Server, Watchdog;

EXPORT Layouts := MODULE
	EXPORT rec_ids_in := RECORD
		STRING30 acctno := '';
		UNSIGNED6 bdid := 0;
		UNSIGNED6 group_id := 0;
		BIPV2.IDlayouts.l_xlink_ids;
	END;
	
	EXPORT rec_ids_did_in := RECORD
		rec_ids_in;
		UNSIGNED6 did      :=  0;
	END;
	
	EXPORT rec_corp := RECORD
		rec_ids_in;
		string60  corp_status_desc;
		string8	  corp_status_date;
	END;
	
	EXPORT rec_contact := record
		rec_ids_in;
		unsigned6 did := 0;        // DID from Headers
		unsigned4 dt_first_seen;   // From contact info if available
		unsigned4 dt_last_seen;    // From contact infor if available
		string2   source;          // Source file type
		string1   record_type;     // 'C' = Current, 'H' = Historical
		string1   from_hdr := 'N'; // 'Y' if contact is from address 
		qstring35 company_title;   // Title of Contact at Company if available
		qstring35 company_department := '';
		qstring5  title;
		qstring20 fname;
		qstring20 mname;
		qstring20 lname;
		qstring5  name_suffix;
		string1   name_score;
		qstring10 prim_range;
		string2   predir;
		qstring28 prim_name;
		qstring4  addr_suffix;
		string2   postdir;
		qstring5  unit_desig;
		qstring8  sec_range;
		qstring25 city;
		string2   state;
		unsigned3 zip;
		unsigned2 zip4;
		string3   county;
		qstring10 geo_lat;
		qstring11 geo_long;
		unsigned6 phone;
		string60 email_address;
		string9 ssn := '';
		// qstring34 company_source_group := ''; // Source group
		// qstring120 company_name;
		// qstring10 company_prim_range;
		// string2   company_predir;
		// qstring28 company_prim_name;
		// qstring4  company_addr_suffix;
		// string2   company_postdir;
		// qstring5  company_unit_desig;
		// qstring8  company_sec_range;
		// qstring25 company_city;
		// string2   company_state;
		// unsigned3 company_zip;
		// unsigned2 company_zip4;
		// unsigned6 company_phone;
		// unsigned4 company_fein := 0;
		UNSIGNED2 title_rank;
		BOOLEAN is_exec;
	end;
	
	EXPORT rec_phones := RECORD
		STRING15  phone           := '';
		UNSIGNED6 phone_source_id := 0;
	END;
	
	EXPORT rec_phone_variations := RECORD
		rec_ids_in;
		DATASET(rec_phones) phones {MAXCOUNT(iesp.constants.BR.MaxPhones)};
	END;
	
	EXPORT rec_phone_variations_normalized := RECORD
		rec_ids_in;
		STRING15  phone           := '';
		UNSIGNED6 phone_source_id := 0;
	END;
	
	EXPORT rec_company_best := RECORD
		rec_ids_in;
		rec_ids_in AND NOT acctno parent_ids;
		RECORDOF(doxie_cbrs.fn_best_information) AND NOT bdid;
		STRING60 corp_status_desc := '';
	END;	
	
	EXPORT rec_gong_records_acctno := RECORD
		rec_ids_in;
		Watchdog.Layout_Gong_DID AND NOT group_id;
		STRING18 county_name := '';
		STRING4 TimeZone     := '';
	END;
	
	EXPORT rec_phonesplus_acctno := RECORD
		rec_ids_in;
		Moxie_phonesplus_Server.Layout_batch_did.w_timezone AND NOT Feedback;
	END;
	
	EXPORT rec_BCCReport_acctno := RECORD
		STRING30 acctno := '';
		iesp.businesscontactcardreport.t_BCCReport;
	END;

	EXPORT rec_BCCSubject_acctno := RECORD
		STRING30 acctno := '';
		iesp.businesscontactcardreport.t_BCCSubject;
	END;

	EXPORT rec_BCCParent_acctno := RECORD
		rec_ids_in;
		iesp.businesscontactcardreport.t_BCCParent;
	END;
	
	EXPORT rec_BCCExecs_acctno := RECORD
		rec_ids_in;
		iesp.businesscontactcardreport.t_BCCExecs;
		UNSIGNED2 title_rank := 0;
	END;

	EXPORT rec_BCCPhoneInfoWithFeedback_acctno := RECORD // i.e. EDA/Gong
		rec_ids_did_in;
		iesp.businesscontactcardreport.t_BCCPhoneInfoWithFeedback;
	END;
	
	EXPORT rec_BCCPhonesPlusRecordWithFeedback_acctno := RECORD
		rec_ids_did_in;
		iesp.businesscontactcardreport.t_BCCPhonesPlusRecordWithFeedback;
	END;

END;