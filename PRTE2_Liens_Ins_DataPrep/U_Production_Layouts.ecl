﻿

EXPORT U_Production_Layouts := MODULE

// There is probably some attribute somewhere but I just grabbed this from the browser...
		SHARED layout_filing_status := RECORD,maxlength(10000)
				string filing_status;
				string filing_status_desc;
		END;

		EXPORT Prod_Main_Layout := RECORD,maxlength(32766)
				string50 tmsid;
				string50 rmsid;
				string8 process_date;
				string1 record_code;
				string8 date_vendor_removed;
				string50 filing_jurisdiction;
				string2 filing_state;
				string20 orig_filing_number;
				string50 orig_filing_type;
				string8 orig_filing_date;
				string10 orig_filing_time;
				string25 case_number;
				string20 filing_number;
				string125 filing_type_desc;
				string8 filing_date;
				string10 filing_time;
				string8 vendor_entry_date;
				string150 judge;
				string175 case_title;
				string10 filing_book;
				string10 filing_page;
				string8 release_date;
				string50 amount;
				string1 eviction;
				string75 satisifaction_type;
				string8 judg_satisfied_date;
				string8 judg_vacated_date;
				string40 tax_code;
				string200 irs_serial_number;
				string8 effective_date;
				string8 lapse_date;
				string8 accident_date;
				string1 sherrif_indc;
				string8 expiration_date;
				string150 agency;
				string20 agency_city;
				string2 agency_state;
				string40 agency_county;
				string50 legal_lot;
				string10 legal_block;
				string10 legal_borough;
				string20 certificate_number;
				DATASET(layout_filing_status) filing_status;
		 END;

		EXPORT Prod_Party_Layout := RECORD
				string50 tmsid;
				string50 rmsid;
				string1830 orig_full_debtorname;
				string700 orig_name;
				string50 orig_lname;
				string50 orig_fname;
				string50 orig_mname;
				string10 orig_suffix;
				string9 tax_id;
				string9 ssn;
				string5 title;
				string20 fname;
				string20 mname;
				string20 lname;
				string5 name_suffix;
				string3 name_score;
				string500 cname;
				string200 orig_address1;
				string200 orig_address2;
				string75 orig_city;
				string50 orig_state;
				string25 orig_zip5;
				string20 orig_zip4;
				string5 orig_county;
				string5 orig_country;
				string10 prim_range;
				string2 predir;
				string28 prim_name;
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
				string5 county;
				string10 geo_lat;
				string11 geo_long;
				string4 msa;
				string7 geo_blk;
				string1 geo_match;
				string4 err_stat;
				string20 phone;
				string2 name_type;
				string12 did;
				string12 bdid;
				string8 date_first_seen;
				string8 date_last_seen;
				string8 date_vendor_first_reported;
				string8 date_vendor_last_reported;
				string9 app_ssn;
				string9 app_tax_id;
		END;

		EXPORT Prod_Layout_MainKeyI := RECORD
			string50 tmsid;
			string50 rmsid;
		END;

		EXPORT Prod_Layout_MainKeyM := RECORD,maxlength(32766)
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
			unsigned8 persistent_record_id;
			DATASET(layout_filing_status) filing_status;
			// unsigned8 __internal_fpos__;
		 END;

		EXPORT Prod_Layout_PartyKeyI := RECORD
			string50 tmsid;
			string50 rmsid;
		END;
		
		EXPORT Prod_Layout_PartyKeyM := RECORD
			string orig_full_debtorname;
			string orig_name;
			string orig_lname;
			string orig_fname;
			string orig_mname;
			string orig_suffix;
			string9 tax_id;
			string9 ssn;
			string5 title;
			string20 fname;
			string20 mname;
			string20 lname;
			string5 name_suffix;
			string3 name_score;
			string cname;
			string orig_address1;
			string orig_address2;
			string orig_city;
			string orig_state;
			string orig_zip5;
			string orig_zip4;
			string orig_county;
			string orig_country;
			string10 prim_range;
			string2 predir;
			string28 prim_name;
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
			string5 county;
			string10 geo_lat;
			string11 geo_long;
			string4 msa;
			string7 geo_blk;
			string1 geo_match;
			string4 err_stat;
			string phone;
			string name_type;
			string12 did;
			string12 bdid;
			string8 date_first_seen;
			string8 date_last_seen;
			string8 date_vendor_first_reported;
			string8 date_vendor_last_reported;
			unsigned8 persistent_record_id;
			unsigned6 dotid;
			unsigned2 dotscore;
			unsigned2 dotweight;
			unsigned6 empid;
			unsigned2 empscore;
			unsigned2 empweight;
			unsigned6 powid;
			unsigned2 powscore;
			unsigned2 powweight;
			unsigned6 proxid;
			unsigned2 proxscore;
			unsigned2 proxweight;
			unsigned6 seleid;
			unsigned2 selescore;
			unsigned2 seleweight;
			unsigned6 orgid;
			unsigned2 orgscore;
			unsigned2 orgweight;
			unsigned6 ultid;
			unsigned2 ultscore;
			unsigned2 ultweight;
		END;

END;