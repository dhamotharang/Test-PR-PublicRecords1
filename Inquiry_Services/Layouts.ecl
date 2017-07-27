IMPORT Inquiry_AccLogs, BIPV2, BatchShare;

EXPORT Layouts := MODULE

		EXPORT Batch_Input := RECORD
				BatchShare.Layouts.ShareAcct;
				BIPV2.IDlayouts.l_key_ids_bare;
				BatchShare.Layouts.ShareCompany - [bdid];
				BatchShare.Layouts.ShareAddress - [addr];
				STRING16  workphone;
				STRING3   mileradius;
		END;
		
		EXPORT Batch_Input_Processed := RECORD(Batch_Input)
				STRING20 orig_acctno := '';
				Batchshare.Layouts.ShareErrors;	
		END;
						
		EXPORT SearchSlim_layout := RECORD
				BatchShare.Layouts.ShareAcct;
				BIPV2.IDlayouts.l_key_ids_bare;
				UNSIGNED6 weight;
		END;
		
		EXPORT Batch_Raw_Linkid := RECORD
				STRING1 inquiry_src;
				RECORDOF(Inquiry_AccLogs.FN_Append_SBA);
		END;
			
		EXPORT Batch_Raw := RECORD
				STRING1 inquiry_src;
				BIPV2.IDlayouts.l_key_ids_bare;
				STRING25 inquiry_dateTime;
				STRING50 inquiry_transactionID;
				STRING25 inquiry_seqNum;
				STRING10 primary_market_code;
				STRING10 secondary_market_code;
				STRING10 industry_1_code;
				STRING10 industry_2_code;
				STRING25 sub_market;
				STRING10 vertical;
				STRING10 inteluse;
				STRING30 industry;
				STRING20 source;
				STRING3 fraudpoint_score;
				
				// Inquired person
				STRING20 inquired_person_fname;
				STRING20 inquired_person_mname;
				STRING20 inquired_person_lname;
				STRING5 inquired_person_name_suffix;
				UNSIGNED6 inquired_person_did;
				STRING50 inquired_person_email_address;
				STRING15 inquired_person_personal_phone;
				STRING15 inquired_person_work_phone;
				STRING10 inquired_person_dob;
				STRING20 inquired_person_dl;
				STRING20 inquired_person_dl_st;
				STRING15 inquired_person_ssn;
				STRING10 inquired_person_prim_range;
				STRING2  inquired_person_predir;
				STRING28 inquired_person_prim_name;
				STRING4  inquired_person_addr_suffix;
				STRING2  inquired_person_postdir;
				STRING10 inquired_person_unit_desig;
				STRING8  inquired_person_sec_range;
				STRING25 inquired_person_v_city_name;
				STRING2  inquired_person_st;
				STRING5  inquired_person_zip5;
				STRING4  inquired_person_zip4;
				STRING2  inquired_person_addr_rec_type;
				STRING2  inquired_person_fips_state;
				STRING3  inquired_person_fips_county;
				
				// Inquired Business
				UNSIGNED6 inquired_business_UltID;
				UNSIGNED6 inquired_business_OrgID;
				UNSIGNED6 inquired_business_SeleID;
				UNSIGNED6 inquired_business_ProxID;
				UNSIGNED6 inquired_business_PowID;
				UNSIGNED6 inquired_business_DotID;
				UNSIGNED6 inquired_business_EmpID;
				UNSIGNED6 inquired_business_bdid;
				STRING20 inquired_business_ein;
				STRING75 inquired_business_company_name;
				STRING15 inquired_business_company_phone;
				STRING20 inquired_business_charter_number;
				STRING20 inquired_business_ucc_number;
				STRING20 inquired_business_domain_name;
				STRING10 inquired_business_prim_range;
				STRING2  inquired_business_predir;
				STRING28 inquired_business_prim_name;
				STRING4  inquired_business_addr_suffix;
				STRING2  inquired_business_postdir;
				STRING10 inquired_business_unit_desig;
				STRING8  inquired_business_sec_range;
				STRING25 inquired_business_v_city_name;
				STRING2  inquired_business_st;
				STRING5  inquired_business_zip5;
				STRING4  inquired_business_zip4;
				STRING2  inquired_business_addr_rec_type;
				STRING2  inquired_business_fips_state;
				STRING3  inquired_business_fips_county;

				// Bus user 1
				STRING20 inquired_bus_user1_fname;
				STRING20 inquired_bus_user1_mname;
				STRING20 inquired_bus_user1_lname;
				STRING5 inquired_bus_user1_name_suffix;
				UNSIGNED6 inquired_bus_user1_did;
				STRING15 inquired_bus_user1_personal_phone;
				STRING10 inquired_bus_user1_dob;
				STRING20 inquired_bus_user1_dl;
				STRING20 inquired_bus_user1_dl_st;
				STRING15 inquired_bus_user1_ssn;
				STRING10 inquired_bus_user1_prim_range;
				STRING2  inquired_bus_user1_predir;
				STRING28 inquired_bus_user1_prim_name;
				STRING4  inquired_bus_user1_addr_suffix;
				STRING2  inquired_bus_user1_postdir;
				STRING10 inquired_bus_user1_unit_desig;
				STRING8  inquired_bus_user1_sec_range;
				STRING25 inquired_bus_user1_v_city_name;
				STRING2  inquired_bus_user1_st;
				STRING5  inquired_bus_user1_zip5;
				STRING4  inquired_bus_user1_zip4;
				STRING2  inquired_bus_user1_addr_rec_type;
				STRING2  inquired_bus_user1_fips_state;
				STRING3  inquired_bus_user1_fips_county;
				
				// Bus user 2
				STRING20 inquired_bus_user2_fname;
				STRING20 inquired_bus_user2_mname;
				STRING20 inquired_bus_user2_lname;
				STRING5 inquired_bus_user2_name_suffix;
				UNSIGNED6 inquired_bus_user2_did;
				STRING15 inquired_bus_user2_personal_phone;
				STRING10 inquired_bus_user2_dob;
				STRING20 inquired_bus_user2_dl;
				STRING20 inquired_bus_user2_dl_st;
				STRING15 inquired_bus_user2_ssn;
				STRING10 inquired_bus_user2_prim_range;
				STRING2  inquired_bus_user2_predir;
				STRING28 inquired_bus_user2_prim_name;
				STRING4  inquired_bus_user2_addr_suffix;
				STRING2  inquired_bus_user2_postdir;
				STRING10 inquired_bus_user2_unit_desig;
				STRING8  inquired_bus_user2_sec_range;
				STRING25 inquired_bus_user2_v_city_name;
				STRING2  inquired_bus_user2_st;
				STRING5  inquired_bus_user2_zip5;
				STRING4  inquired_bus_user2_zip4;
				STRING2  inquired_bus_user2_addr_rec_type;
				STRING2  inquired_bus_user2_fips_state;
				STRING3  inquired_bus_user2_fips_county;
				
				// Bus user 3
				STRING20 inquired_bus_user3_fname;
				STRING20 inquired_bus_user3_mname;
				STRING20 inquired_bus_user3_lname;
				STRING5 inquired_bus_user3_name_suffix;
				UNSIGNED6 inquired_bus_user3_did;
				STRING15 inquired_bus_user3_personal_phone;
				STRING10 inquired_bus_user3_dob;
				STRING20 inquired_bus_user3_dl;
				STRING20 inquired_bus_user3_dl_st;
				STRING15 inquired_bus_user3_ssn;
				STRING10 inquired_bus_user3_prim_range;
				STRING2  inquired_bus_user3_predir;
				STRING28 inquired_bus_user3_prim_name;
				STRING4  inquired_bus_user3_addr_suffix;
				STRING2  inquired_bus_user3_postdir;
				STRING10 inquired_bus_user3_unit_desig;
				STRING8  inquired_bus_user3_sec_range;
				STRING25 inquired_bus_user3_v_city_name;
				STRING2  inquired_bus_user3_st;
				STRING5  inquired_bus_user3_zip5;
				STRING4  inquired_bus_user3_zip4;
				STRING2  inquired_bus_user3_addr_rec_type;
				STRING2  inquired_bus_user3_fips_state;
				STRING3  inquired_bus_user3_fips_county;
				
				
				// Bus user 4
				STRING20 inquired_bus_user4_fname;
				STRING20 inquired_bus_user4_mname;
				STRING20 inquired_bus_user4_lname;
				STRING5 inquired_bus_user4_name_suffix;
				UNSIGNED6 inquired_bus_user4_did;
				STRING15 inquired_bus_user4_personal_phone;
				STRING10 inquired_bus_user4_dob;
				STRING20 inquired_bus_user4_dl;
				STRING20 inquired_bus_user4_dl_st;
				STRING15 inquired_bus_user4_ssn;
				STRING10 inquired_bus_user4_prim_range;
				STRING2  inquired_bus_user4_predir;
				STRING28 inquired_bus_user4_prim_name;
				STRING4  inquired_bus_user4_addr_suffix;
				STRING2  inquired_bus_user4_postdir;
				STRING10 inquired_bus_user4_unit_desig;
				STRING8  inquired_bus_user4_sec_range;
				STRING25 inquired_bus_user4_v_city_name;
				STRING2  inquired_bus_user4_st;
				STRING5  inquired_bus_user4_zip5;
				STRING4  inquired_bus_user4_zip4;
				STRING2  inquired_bus_user4_addr_rec_type;
				STRING2  inquired_bus_user4_fips_state;
				STRING3  inquired_bus_user4_fips_county;
				
				// Bus user 5
				STRING20 inquired_bus_user5_fname;
				STRING20 inquired_bus_user5_mname;
				STRING20 inquired_bus_user5_lname;
				STRING5 inquired_bus_user5_name_suffix;
				UNSIGNED6 inquired_bus_user5_did;
				STRING15 inquired_bus_user5_personal_phone;
				STRING10 inquired_bus_user5_dob;
				STRING20 inquired_bus_user5_dl;
				STRING20 inquired_bus_user5_dl_st;
				STRING15 inquired_bus_user5_ssn;
				STRING10 inquired_bus_user5_prim_range;
				STRING2  inquired_bus_user5_predir;
				STRING28 inquired_bus_user5_prim_name;
				STRING4  inquired_bus_user5_addr_suffix;
				STRING2  inquired_bus_user5_postdir;
				STRING10 inquired_bus_user5_unit_desig;
				STRING8  inquired_bus_user5_sec_range;
				STRING25 inquired_bus_user5_v_city_name;
				STRING2  inquired_bus_user5_st;
				STRING5  inquired_bus_user5_zip5;
				STRING4  inquired_bus_user5_zip4;
				STRING2  inquired_bus_user5_addr_rec_type;
				STRING2  inquired_bus_user5_fips_state;
				STRING3  inquired_bus_user5_fips_county;
				
				// Bus user 6
				STRING20 inquired_bus_user6_fname;
				STRING20 inquired_bus_user6_mname;
				STRING20 inquired_bus_user6_lname;
				STRING5 inquired_bus_user6_name_suffix;
				UNSIGNED6 inquired_bus_user6_did;
				STRING15 inquired_bus_user6_personal_phone;
				STRING10 inquired_bus_user6_dob;
				STRING20 inquired_bus_user6_dl;
				STRING20 inquired_bus_user6_dl_st;
				STRING15 inquired_bus_user6_ssn;
				STRING10 inquired_bus_user6_prim_range;
				STRING2  inquired_bus_user6_predir;
				STRING28 inquired_bus_user6_prim_name;
				STRING4  inquired_bus_user6_addr_suffix;
				STRING2  inquired_bus_user6_postdir;
				STRING10 inquired_bus_user6_unit_desig;
				STRING8  inquired_bus_user6_sec_range;
				STRING25 inquired_bus_user6_v_city_name;
				STRING2  inquired_bus_user6_st;
				STRING5  inquired_bus_user6_zip5;
				STRING4  inquired_bus_user6_zip4;
				STRING2  inquired_bus_user6_addr_rec_type;
				STRING2  inquired_bus_user6_fips_state;
				STRING3  inquired_bus_user6_fips_county;
				
				// Bus user 7
				STRING20 inquired_bus_user7_fname;
				STRING20 inquired_bus_user7_mname;
				STRING20 inquired_bus_user7_lname;
				STRING5 inquired_bus_user7_name_suffix;
				UNSIGNED6 inquired_bus_user7_did;
				STRING15 inquired_bus_user7_personal_phone;
				STRING10 inquired_bus_user7_dob;
				STRING20 inquired_bus_user7_dl;
				STRING20 inquired_bus_user7_dl_st;
				STRING15 inquired_bus_user7_ssn;
				STRING10 inquired_bus_user7_prim_range;
				STRING2  inquired_bus_user7_predir;
				STRING28 inquired_bus_user7_prim_name;
				STRING4  inquired_bus_user7_addr_suffix;
				STRING2  inquired_bus_user7_postdir;
				STRING10 inquired_bus_user7_unit_desig;
				STRING8  inquired_bus_user7_sec_range;
				STRING25 inquired_bus_user7_v_city_name;
				STRING2  inquired_bus_user7_st;
				STRING5  inquired_bus_user7_zip5;
				STRING4  inquired_bus_user7_zip4;
				STRING2  inquired_bus_user7_addr_rec_type;
				STRING2  inquired_bus_user7_fips_state;
				STRING3  inquired_bus_user7_fips_county;
				
				// Bus user 8
				STRING20 inquired_bus_user8_fname;
				STRING20 inquired_bus_user8_mname;
				STRING20 inquired_bus_user8_lname;
				STRING5 inquired_bus_user8_name_suffix;
				UNSIGNED6 inquired_bus_user8_did;
				STRING15 inquired_bus_user8_personal_phone;
				STRING10 inquired_bus_user8_dob;
				STRING20 inquired_bus_user8_dl;
				STRING20 inquired_bus_user8_dl_st;
				STRING15 inquired_bus_user8_ssn;
				STRING10 inquired_bus_user8_prim_range;
				STRING2  inquired_bus_user8_predir;
				STRING28 inquired_bus_user8_prim_name;
				STRING4  inquired_bus_user8_addr_suffix;
				STRING2  inquired_bus_user8_postdir;
				STRING10 inquired_bus_user8_unit_desig;
				STRING8  inquired_bus_user8_sec_range;
				STRING25 inquired_bus_user8_v_city_name;
				STRING2  inquired_bus_user8_st;
				STRING5  inquired_bus_user8_zip5;
				STRING4  inquired_bus_user8_zip4;
				STRING2  inquired_bus_user8_addr_rec_type;
				STRING2  inquired_bus_user8_fips_state;
				STRING3  inquired_bus_user8_fips_county;
		END;
		
		EXPORT Batch_Raw_Acct := RECORD
				BatchShare.Layouts.ShareAcct;
				UNSIGNED6 weight;
				Batch_Raw;
		END;
		
		EXPORT Batch_Output := RECORD
				BatchShare.Layouts.ShareAcct;
				Batch_Raw - [inquiry_src, UltID, OrgID, SeleID, ProxID, EmpID, PowID, DotID];
				Batchshare.Layouts.ShareErrors;
		END;
END;