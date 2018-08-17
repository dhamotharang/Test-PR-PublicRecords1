﻿/* ************************************************************************************************************************
see also:  CustomerTest_X_CommBusCaseResearch.Layouts_Boca

I did not just name this Layouts because we need to determine the exact Layout that Linda's data is ingested as...
It looks like PRTE2_BIPV2_BusHeader.BH_Init_Final "calls" PRTE2_Business_Header.BH_Init so I *THINK* our base file would 
need to be sitting there in that layout.
************************************************************************************************************************ */

EXPORT Layouts_Early := MODULE

		// just whatever you have or can infer from your data... the rest is blank.
		Export PREP_FOR_BIPV2_Layout :=RECORD

				// LINKING AND ID FIELDS
				string source;						// CCLUE, CCREDIT, CADPF
				string sourceUniqBusID;		// Just create a counter per source (EG: CustomerTest_Common_Dev.MAC_add_JoinIdx)
				// The first two fields MUST be the same for multiple records for one business.  (so we can handle multi-address or multi-contacts)
				
				// Please fill in any business identifying information you can find.  If you find another field let me know and we can add it.
				string9 	duns_number;
				string 		bdid;
				string9 	fein;

				// Again, all fields ... just whatever you have or can infer from your data... the rest is blank.
				// General Business details
				string120 company_name;
				string250 dba_name;
				string10 	company_phone;
				string1 	phone_type;
				unsigned4 company_incorporation_date;
				string8 	company_sic_code1;
				string6 	company_naics_code1;
				string80 	company_url;
				string1 	iscorp;								// if known 

				// For businesses with multiple addresses, create multiple records, one address per record
				string 		inAddressLine1;
				string 		inCity;
				string 		inState;
				string 		inZip5;

				// if your data has first/last dates...
				string 		dt_first_seen;
				string 		dt_last_seen;
				string 		dt_vendor_first_reported;
				string 		dt_vendor_last_reported;

				// If multiple contacts, create multiple records, one person per record
				string1 	iscontact;	//(Y or N)
				string5 	title;
				string 		fname;
				string 		mname;
				string 		lname;
				string 		name_suffix;
				string 		name_score;
				string50 	contact_job_title;
				unsigned4 dt_first_seen_contact;
				unsigned4 dt_last_seen_contact;
				unsigned6 contact_did;					// LEXID, if they are in IHDR.
				string9 	contact_ssn;
				unsigned4 contact_dob;
				string60 	contact_email;
				string10 	contact_phone;
		END;
		
/* 				// ???? NOT SURE ---------------- ASKING Linda
   				string1 cnp_hasnumber;			
   				string250 cnp_name;
   				string30 cnp_number;
   				string10 cnp_store_number;
   				string10 cnp_btype;
   				string1 cnp_component_code;
   				string20 cnp_lowv;
   				boolean cnp_translated;
   				integer4 cnp_classid;
   				// ???? NOT SURE ---------------- ASKING Linda
*/

				


		Export BIPV2_CommonBase_Layout :=RECORD
				unsigned6 rcid;
				string2 source;
				string9 ingest_status;
				unsigned6 dotid;
				unsigned6 empid;
				unsigned6 powid;
				unsigned6 proxid;
				unsigned6 seleid;
				unsigned6 lgid3;
				unsigned6 orgid;
				unsigned6 ultid;
				unsigned6 vanity_owner_did;
				unsigned8 cnt_rcid_per_dotid;
				unsigned8 cnt_dot_per_proxid;
				unsigned8 cnt_prox_per_lgid3;
				unsigned8 cnt_prox_per_powid;
				unsigned8 cnt_dot_per_empid;
				boolean has_lgid;
				boolean is_sele_level;
				boolean is_org_level;
				boolean is_ult_level;
				unsigned6 parent_proxid;
				unsigned6 sele_proxid;
				unsigned6 org_proxid;
				unsigned6 ultimate_proxid;
				unsigned2 levels_from_top;
				unsigned3 nodes_below;
				unsigned3 nodes_total;
				string1 sele_gold;
				string1 ult_seg;
				string1 org_seg;
				string1 sele_seg;
				string1 prox_seg;
				string1 pow_seg;
				string1 ult_prob;
				string1 org_prob;
				string1 sele_prob;
				string1 prox_prob;
				string1 pow_prob;
				string1 iscontact;
				string5 title;
				string20 fname;
				string20 mname;
				string20 lname;
				string5 name_suffix;
				string3 name_score;
				string1 iscorp;
				string120 company_name;
				string50 company_name_type_raw;
				string50 company_name_type_derived;
				string1 cnp_hasnumber;
				string250 cnp_name;
				string30 cnp_number;
				string10 cnp_store_number;
				string10 cnp_btype;
				string1 cnp_component_code;
				string20 cnp_lowv;
				boolean cnp_translated;
				integer4 cnp_classid;
				unsigned8 company_rawaid;
				unsigned8 company_aceaid;
				string10 prim_range;
				string10 prim_range_derived;
				string2 predir;
				string28 prim_name;
				string28 prim_name_derived;
				string4 addr_suffix;
				string2 postdir;
				string10 unit_desig;
				string8 sec_range;
				string25 p_city_name;
				string25 v_city_name;
				string2 st;
				string5 zip;
				string4 zip4;
				string4 cart;
				string1 cr_sort_sz;
				string4 lot;
				string1 lot_order;
				string2 dbpc;
				string1 chk_digit;
				string2 rec_type;
				string2 fips_state;
				string3 fips_county;
				string10 geo_lat;
				string11 geo_long;
				string4 msa;
				string7 geo_blk;
				string1 geo_match;
				string4 err_stat;
				string250 corp_legal_name;
				string250 dba_name;
				string9 active_duns_number;
				string9 hist_duns_number;
				string9 deleted_key;
				string9 deleted_fein;
				string9 active_enterprise_number;
				string9 hist_enterprise_number;
				string9 ebr_file_number;
				string30 active_domestic_corp_key;
				string30 hist_domestic_corp_key;
				string30 foreign_corp_key;
				string30 unk_corp_key;
				unsigned4 dt_first_seen;
				unsigned4 dt_last_seen;
				unsigned4 dt_vendor_first_reported;
				unsigned4 dt_vendor_last_reported;
				unsigned6 company_bdid;
				string50 company_address_type_raw;
				string9 company_fein;
				string1 best_fein_indicator;
				string10 company_phone;
				string1 phone_type;
				string60 company_org_structure_raw;
				unsigned4 company_incorporation_date;
				string8 company_sic_code1;
				string8 company_sic_code2;
				string8 company_sic_code3;
				string8 company_sic_code4;
				string8 company_sic_code5;
				string6 company_naics_code1;
				string6 company_naics_code2;
				string6 company_naics_code3;
				string6 company_naics_code4;
				string6 company_naics_code5;
				string6 company_ticker;
				string6 company_ticker_exchange;
				string1 company_foreign_domestic;
				string80 company_url;
				string2 company_inc_state;
				string32 company_charter_number;
				unsigned4 company_filing_date;
				unsigned4 company_status_date;
				unsigned4 company_foreign_date;
				unsigned4 event_filing_date;
				string50 company_name_status_raw;
				string50 company_status_raw;
				unsigned4 dt_first_seen_company_name;
				unsigned4 dt_last_seen_company_name;
				unsigned4 dt_first_seen_company_address;
				unsigned4 dt_last_seen_company_address;
				string34 vl_id;
				boolean current;
				unsigned8 source_record_id;
				unsigned2 phone_score;
				string9 duns_number;
				string100 source_docid;
				unsigned4 dt_first_seen_contact;
				unsigned4 dt_last_seen_contact;
				unsigned6 contact_did;
				string50 contact_type_raw;
				string50 contact_job_title_raw;
				string9 contact_ssn;
				unsigned4 contact_dob;
				string30 contact_status_raw;
				string60 contact_email;
				string30 contact_email_username;
				string30 contact_email_domain;
				string10 contact_phone;
				string1 from_hdr;
				string35 company_department;
				string50 company_address_type_derived;
				string60 company_org_structure_derived;
				string50 company_name_status_derived;
				string50 company_status_derived;
				string1 proxid_status_private;
				string1 powid_status_private;
				string1 seleid_status_private;
				string1 orgid_status_private;
				string1 ultid_status_private;
				string1 proxid_status_public;
				string1 powid_status_public;
				string1 seleid_status_public;
				string1 orgid_status_public;
				string1 ultid_status_public;
				string50 contact_type_derived;
				string50 contact_job_title_derived;
				string30 contact_status_derived;
				string1 address_type_derived;
				boolean is_vanity_name_derived;
		END;



END;