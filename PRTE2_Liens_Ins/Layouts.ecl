// PRTE2_Liens_Ins.Layouts

IMPORT PRTE2_Liens, LiensV2, BIPV2;

EXPORT Layouts := MODULE


			/* ********************************************************************************************
					NOTE: BELOW - decided to not use the 
							LiensV2.layout_liens_main_module.layout_liens_main and not filing_status;
			    We'd rather have our CSV Base layout not alter without warning if they change their layout 
				******************************************************************************************** */
					
			EXPORT BaseMain_in_raw := RECORD
					string50 tmsid;
					string50 rmsid;
					string process_date;
					string record_code;
					string date_vendor_removed;
					string filing_jurisdiction;
					string filing_state;
					string20 orig_filing_number;
					string orig_filing_type;
					string orig_filing_date;
					string orig_filing_time;
					string case_number;
					string20 filing_number;
					string filing_type_desc;
					string filing_date;
					string filing_time;
					string vendor_entry_date;
					string judge;
					string case_title;
					string filing_book;
					string filing_page;
					string release_date;
					string amount;
					string eviction;
					string satisifaction_type;
					string judg_satisfied_date;
					string judg_vacated_date;
					string tax_code;
					string irs_serial_number;
					string effective_date;
					string lapse_date;
					string accident_date;
					string sherrif_indc;
					string expiration_date;
					string agency;
					string agency_city;
					string agency_state;
					string agency_county;
					string legal_lot;
					string legal_block;
					string legal_borough;
					string certificate_number;
					boolean bcbflag;
					unsigned8 persistent_record_id;
					string filing_status;
					string filing_status_desc;
					string10 cust_test_data_type;
					string1 age_data_flag;
					string15 ln_product_tie;
					string15 ln_product_notes;
			END;

			EXPORT BaseMain_in_rawV2 := RECORD
					string50 tmsid;
					string50 rmsid;
					string process_date;
					string record_code;
					string date_vendor_removed;
					string filing_jurisdiction;
					string filing_state;
					string20 orig_filing_number;
					string orig_filing_type;
					string orig_filing_date;
					string orig_filing_time;
					string case_number;
					string20 filing_number;
					string filing_type_desc;
					string filing_date;
					string filing_time;
					string vendor_entry_date;
					string judge;
					string case_title;
					string filing_book;
					string filing_page;
					string release_date;
					string amount;
					string eviction;
					string satisifaction_type;
					string judg_satisfied_date;
					string judg_vacated_date;
					string tax_code;
					string irs_serial_number;
					string effective_date;
					string lapse_date;
					string accident_date;
					string sherrif_indc;
					string expiration_date;
					string agency;
					string agency_city;
					string agency_state;
					string agency_county;
					string legal_lot;
					string legal_block;
					string legal_borough;
					string certificate_number;
					boolean bcbflag;
					unsigned8 persistent_record_id;
					string filing_status;
					string filing_status_desc;
					string10 cust_test_data_type;
					string1 age_data_flag;
					string15 ln_product_tie;
					string15 ln_product_notes;
					string bug_num;
					string cust_name;
					string courtID;
					string filing_typ_code;
			END;			

			// Names have been changed so those fields just move as needed between the two formats.
			EXPORT Alpha_Common := RECORD
					string12 did;							// switched to unsigned to match final Boca file and make transforms easier
					STRING xSponsor:='';			// send to cust_name 
					STRING xbug_num:='';
					STRING xAmbest:='';
					STRING5 title;			// renamed to keep the Boca field
					STRING20 fname;			// renamed to keep the Boca field
					STRING20 mname;			// renamed to keep the Boca field
					STRING20 lname;				// renamed to keep the Boca field
					STRING5 name_suffix;			// renamed to keep the Boca field
					// NOTE: Need to build listed_name from first+middle+last above.
					STRING link_dob:='';					// renamed to keep the Boca field
					STRING9 SSN;					// renamed to keep the Boca field
					STRING1 xGender:='';
					STRING orig_address1;				// renamed to keep the Boca field
					STRING orig_city;
					STRING orig_state;
					STRING orig_zip5;
					STRING orig_zip4:='';
					STRING xDLState:='';
					STRING xDLN:='';
			END;

			EXPORT Baseparty_inOLD := RECORD
					LiensV2.layout_liens_party and not persistent_record_id;
					string9 app_SSN := '';
					string9 app_tax_id := '';
					BIPV2.IDlayouts.l_key_ids;
					unsigned8 persistent_record_id := 0 ;
					string	fp;
					STRING10	CUST_TEST_DATA_TYPE := '';
					STRING1		AGE_DATA_FLAG := '';
					STRING15	LN_PRODUCT_TIE := '';
					STRING15	LN_PRODUCT_NOTES := '';	
			END;
			EXPORT Baseparty_in_Required := RECORD
					LiensV2.layout_liens_party and not persistent_record_id;
					string9 app_SSN := '';
					string9 app_tax_id := '';
					BIPV2.IDlayouts.l_key_ids;
					unsigned8 persistent_record_id := 0 ;
					string	fp;
					STRING10	CUST_TEST_DATA_TYPE := '';
					STRING1		AGE_DATA_FLAG := '';
					STRING15	LN_PRODUCT_TIE := '';
					STRING15	LN_PRODUCT_NOTES := '';	
					STRING bug_num;
					STRING cust_name;
					STRING link_dob;
					STRING link_ssn;
					STRING link_inc_date;
					STRING link_fein;					
			END;

			EXPORT Baseparty_in := RECORD
					Alpha_Common OR Baseparty_in_Required;
			END;
			
			// Do we need to bother with this????
			// EXPORT BaseStatus_in 	:= PRTE2_Liens.Layouts.BaseStatus_in;

			//Base Key files
			EXPORT Boca_main_base 	:= PRTE2_Liens.Layouts.main_base_ext;
			EXPORT Boca_party_base 	:= PRTE2_Liens.Layouts.party_base_ext;
			//LinkIDs key layout
			EXPORT LinkIDSKey			:= PRTE2_Liens.Layouts.LinkIDSKey;
			
			// Do we need to bother with this????
			// EXPORT status_base 		:= BaseStatus_in;
			
			EXPORT layout_filing_status := LiensV2.layout_liens_main_module.layout_filing_status;
			
END;
