/* ***********************************************************************************
NOTE: Because Boca Header build is so Critical - I'm keeping any surplus stuff out of the 
standards "Files" and "Layouts" attributes and none of the rest of this U_* stuff needs to 
be migrated to PROD THOR.  That keeps our portion of the BHDR code in production as small 
as possible.  I did these that hit an error real quickly - there may be more in the Files
Attribute that can also come over here as well, but Layouts is pretty small now.
*********************************************************************************** */

IMPORT prte_csv, PRTE2_LNProperty;


EXPORT Layouts := MODULE

	EXPORT Header_Missing_MHDR_Layout := RECORD
		STRING isOK;
		Layouts.Expanded_Main_Header_Layout;
	END;

	EXPORT Minimum_Common_Header_Layout := RECORD
			STRING  Tmp_Source := '';
			unsigned6 DID := 0;
			STRING  lname := '';
			STRING  fname := '';
			STRING  mname := '';
			STRING  SSN := '';
			STRING  dob := '';
			STRING  address := '';
			STRING  apt := '';
			STRING  city := '';
			STRING  st := '';
			STRING  zip := '';
	END;
	
	// taken from PRTE_CSV.Header.rthor_data400__key__header__data same except I added error_stat
	SHARED audit_key_header_data	:= RECORD
			unsigned6 s_did;
			unsigned6 did;
			unsigned6 rid;
			string1 pflag1;
			string1 pflag2;
			string1 pflag3;
			string2 src;
			unsigned3 dt_first_seen;
			unsigned3 dt_last_seen;
			unsigned3 dt_vendor_last_reported;
			unsigned3 dt_vendor_first_reported;
			unsigned3 dt_nonglb_last_seen;
			string1 rec_type;
			qstring18 vendor_id;
			qstring10 phone;
			qstring9 ssn;
			integer4 dob;
			qstring5 title;
			qstring20 fname;
			qstring20 mname;
			qstring20 lname;
			qstring5 name_suffix;
			qstring10 prim_range;
			string2 predir;
			qstring28 prim_name;
			qstring4 suffix;
			string2 postdir;
			qstring10 unit_desig;
			qstring8 sec_range;
			qstring25 city_name;
			string2 st;
			qstring5 zip;
			qstring4 zip4;
			string3 county;
			qstring7 geo_blk;
			STRING4 err_stat;
			qstring5 cbsa;
			string1 tnt;
			string1 valid_ssn;
			string1 jflag1;
			string1 jflag2;
			string1 jflag3;
			unsigned8 rawaid := 0;
			string1 valid_dob;
			unsigned6 hhid;
			string18 county_name;
			string120 listed_name;
			string10 listed_phone;
			unsigned4 dod;
			string1 death_code;
			unsigned4 lookup_did;
	END;

	// same as prte_csv.ge_header_base.layout_payload except moving err_stat for easier review
	EXPORT Expanded_Audit_Header_Layout := RECORD
			audit_key_header_data;
			string4         addr_suffix;  // [41..44]
			string25        p_city_name;	// [65..89]
			string25        v_city_name;  // [90..114]
			string4         cart;		// [126..129]
			string1         cr_sort_sz;	// [130]
			string4         lot;		// [131..134]
			string1         lot_order;	// [135]
			string2         dbpc;		// [136..137]
			string1         chk_digit;	// [138]
			string10        geo_lat;		// [146..155]
			string11        geo_long;	// [156..166]
			string4         msa;		// [167..170]
			string1         geo_match;	// [178]
			unsigned6 uid := 0;
			string6 dph_lname;
			string4 l4;
			string3 f3;
			string1 s1;
			string1 s2;
			string1 s3;
			string1 s4;
			string1 s5;
			string1 s6;
			string1 s7;
			string1 s8;
			string1 s9;
			string4 ssn4;
			string5 ssn5;
			unsigned4 city_code;
			string20 pfname;
			string1 minit;
			unsigned2 yob;
			unsigned8 states;
			unsigned4 lname1;
			unsigned4 lname2;
			unsigned4 lname3;
			unsigned4 city1;
			unsigned4 city2;
			unsigned4 city3;
			unsigned4 rel_fname1;
			unsigned4 rel_fname2;
			unsigned4 rel_fname3;
			integer8 fname_count;
			string7 p7:='';
			string3 p3:='';
			unsigned5 person1:=0;
			boolean same_lname:=true;
			unsigned2 number_cohabits:=0;
			integer3 recent_cohabit:=0;
			unsigned5 person2:=0;
			unsigned1 zero:=0;
			unsigned4 lookups:=0;
			unsigned3 addr_dt_last_seen;
			qstring17 prpty_deed_id;
			qstring22 vehicle_vehnum;
			qstring22 bkrupt_crtcode_caseno;
			integer4 main_count;
			integer4 search_count;
			qstring15 dl_number;
			qstring12 bdid;
			integer4 run_date;
			integer4 total_records;
			unsigned3 addr_dt_first_seen := 0;
			string10 adl_ind := '';
			string9 s_ssn;
			unsigned8 cnt;
			boolean cellphone;
			unsigned8 persistent_record_ID:=0;
	END;


END;