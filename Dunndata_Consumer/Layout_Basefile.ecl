IMPORT Address, BIPV2;
EXPORT Layout_Basefile := RECORD

		UNSIGNED4	dt_first_seen;
		UNSIGNED4	dt_last_seen;
		UNSIGNED4	dt_vendor_first_reported;
		UNSIGNED4	dt_vendor_last_reported;
		STRING8		process_date;
		STRING1		history_flag:='';
		STRING2		src:='';
		
		UNSIGNED6	did:=0;
		UNSIGNED1	did_score:=0;
		UNSIGNED6	bdid:=0;
		UNSIGNED1	bdid_score:=0;
		STRING9 	append_ssn;
		STRING9 	append_fein;
		STRING15	append_income;
		STRING50	append_occupation;
		STRING40	append_education;
		STRING40	append_religion;
		STRING20 	append_dwell;
		STRING60	append_ethnicity1;
		STRING30	append_ethnicity2;
		STRING50	append_language;
		
		Layout_Infile.Raw_Part1;		
		STRING1		clean_name_type:='';
		STRING5		clean_title:='';
		STRING20	clean_fname:='';
		STRING20	clean_mname:='';
		STRING20	clean_lname:='';
		STRING5		clean_suffix:='';
		STRING180	clean_cname:='';
		UNSIGNED8	rawaid	 :=	0;
		Address.Layout_Clean182_fips;
		
		Layout_Infile.Raw_Part2;
		
		BIPV2.IDlayouts.l_xlink_ids;	//	Added for BIP project
		STRING100	persistent_record_id;
		UNSIGNED8 rcid;
		//New fields added for CCPA
		unsigned4 GlobalSourceId;
		unsigned8 SourceSpecificRecordId;

END;