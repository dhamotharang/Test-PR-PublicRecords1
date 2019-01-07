/* ***********************************************************************************************************
PRTE2_Alpha_Data.Layouts_Alpha

Commented out all MHDR that I saw - it should all be obsolete
*********************************************************************************************************** */

EXPORT Layouts_Alpha := MODULE

		EXPORT IHDR_DL_Death := RECORD
					UNSIGNED6	UniqueID;
					UNSIGNED6 BocaDID := 0;				// Added 11/2015
					STRING2		ADDR_IND;
					UNSIGNED6	UniqueRID;
					STRING28 	LAST_NAME;
					STRING20 	FIRST_NAME;
					STRING20 	MIDDLE_NAME;
					STRING5		NAME_SUFFIX;
					STRING1		GENDER;
					STRING8		DOB;
					STRING8		DOD;
					STRING9		SSN;
					STRING100	STREET_ADDRESS;
					STRING25	CITY;
					STRING2		STATE;
					STRING5		ZIP5;
					STRING8 	DATE_FIRST_SEEN;
					STRING8		DATE_LAST_SEEN;
					STRING25	DL_NUMBER;
					STRING2		DL_STATE;
					QSTRING50 LICENSE_CLASS;		//Jul, 2014 change
					QSTRING50 LICENSE_TYPE;			//Jul, 2014 change
					QSTRING50 STATUS;						//Jul, 2014 change
					STRING8		LICENSE_ISSUE_DATE;
					STRING8		LICENSE_EXPIRATION_DATE;
					STRING50  RESTRICTIONS;
					QSTRING50 LIC_ENDORSEMENT := '';				// Oct 2014 
					STRING8 	ORIG_ISSUE_DATE := '';				// Oct 2014 - Convert to UNSIGNED4
					STRING3   CDL_STATUS;
					QSTRING3	HEIGHT;
					QSTRING3	HAIR_COLOR;
					QSTRING3	EYE_COLOR;
					QSTRING3	WEIGHT;	
					STRING8		ORIG_ORIGCDLDATE := '';				// Oct 2014 - Convert to UNSIGNED4
					STRING15	ORIG_COUNTY := '';						// Oct 2014 
					STRING1		ORIG_HABITUALOFFENDER := '';	// Oct 2014 	
					STRING1		SCHOOL_BUS_PHYSICAL_TYPE;
					UNSIGNED4	SCHOOL_BUS_PHYSICAL_EXPDATE;
					STRING10	CUST_TEST_DATA_TYPE;
					STRING1		AGE_DATA_FLAG;
					STRING1		HAS_SECURITY_FREEZE;
					STRING10	CONSUMER_NUMBER;
					STRING2		INSURANCE_TYPE:='PA';					// July 2017 - default to PA 
					STRING15	LN_PRODUCT_TIE := '';					//Aug 2016
					STRING15	LN_PRODUCT_NOTES := '';				//Aug 2016
		END;

		EXPORT Layout_Base_BC2 := RECORD
				STRING 		LexID := '';
				STRING3 	xSponsorCode := '';
				STRING6 	xAmbestNumber := '';
				STRING20 	FIRST_NAME;
				STRING20 	MIDDLE_NAME;
				STRING28 	LAST_NAME;
				STRING5		NAME_SUFFIX;
				STRING8		DOB;
				STRING9		SSN;
				STRING1		GENDER;
				STRING100	STREET_ADDRESS;
				STRING25	CITY;
				STRING2		STATE;
				STRING5		ZIP5;
				STRING4		xZip4 := '';
				STRING2		DL_STATE;
				STRING25	DL_NUMBER;
				UNSIGNED6 BocaDID := 0;
				UNSIGNED6	AlphaDid := 0;
				STRING2		ADDR_IND;
				UNSIGNED6	UniqueRID;
				STRING8		DOD;
				STRING8 	DATE_FIRST_SEEN;
				STRING8		DATE_LAST_SEEN;
				QSTRING50	LICENSE_CLASS;
				QSTRING50	LICENSE_TYPE;
				QSTRING50	STATUS;
				STRING8		LICENSE_ISSUE_DATE;
				STRING8		LICENSE_EXPIRATION_DATE;
				STRING50	RESTRICTIONS;
				QSTRING50	LIC_ENDORSEMENT := '';
				STRING8 	ORIG_ISSUE_DATE := '';
				STRING3		CDL_STATUS;
				QSTRING3	HEIGHT;
				QSTRING3	HAIR_COLOR;
				QSTRING3	EYE_COLOR;
				QSTRING3	WEIGHT;
				STRING8		ORIG_ORIGCDLDATE := '';
				STRING15	ORIG_COUNTY := '';
				STRING1		ORIG_HABITUALOFFENDER := '';
				STRING1		SCHOOL_BUS_PHYSICAL_TYPE;
				UNSIGNED4	SCHOOL_BUS_PHYSICAL_EXPDATE;
				STRING10	CUST_TEST_DATA_TYPE;
				STRING1		AGE_DATA_FLAG;
				STRING1		HAS_SECURITY_FREEZE;
				STRING10	CONSUMER_NUMBER;
				STRING2		INSURANCE_TYPE:='PA';
				STRING15	LN_PRODUCT_TIE := '';
				STRING15	LN_PRODUCT_NOTES := '';
		END;

		EXPORT Layout_InsHead := RECORD
				INTEGER			id;
				UNSIGNED6		RID;
				STRING2 		ADDR_IND;
				STRING9			fb_ssn;
				STRING30		fb_first_name;
				STRING20		fb_mid_name;
				STRING30		fb_last_name;
				STRING30		fb_2lst_name; 
				STRING20		fb_sfx_name;
				STRING20		fb_house_num;
				STRING2     fb_predir;	// Added in Aug 2015
				STRING30		fb_street;
				STRING20		fb_stsfx;
				STRING2     fb_postdir; // Added in Aug 2015
				STRING20		fb_unit_name;
				STRING20		fb_unit_no;
				STRING30		fb_city;
				STRING5			fb_state;
				STRING5			fb_zip;
				STRING4			fb_zip4;
				STRING4 		fb_err_stat;  // Added in Aug 2015
				STRING3			fb_gender;
				STRING8			fb_dob;
				STRING30		fb_dln;
				STRING2			fb_dlstate;
				STRING20		fb_dln_type;										
				STRING1628 	fb_other;
				STRING8   	fb_loaddt;
				STRING4   	fb_score;
				UNSIGNED6 	fb_seq;
				STRING1   	fb_rest;
				STRING8 		fb_first_dt;
				STRING8			fb_last_dt;
				STRING9			fb_src := '';
				STRING2			INSURANCE_TYPE:='PA';
		END;

/* 	EXPORT Layout_Merged_IHDR_BHDR := RECORD
   			string1 required_bc;
   			integer8 id;
   			unsigned6 rid;
   			string2 addr_ind;
   			string9 fb_ssn;
   			string30 fb_first_name;
   			string20 fb_mid_name;
   			string30 fb_last_name;
   			string30 fb_2lst_name;
   			string20 fb_sfx_name;
   			string20 fb_house_num;
   			string2 fb_predir;
   			string30 fb_street;
   			string20 fb_stsfx;
   			string2 fb_postdir;
   			string20 fb_unit_name;
   			string20 fb_unit_no;
   			string30 fb_city;
   			string5 fb_state;
   			string5 fb_zip;
   			string4 fb_zip4;
   			string4 fb_err_stat;
   			string3 fb_gender;
   			string8 fb_dob;
   			string30 fb_dln;
   			string2 fb_dlstate;
   			string20 fb_dln_type;
   			string1628 fb_other;
   			string8 fb_loaddt;
   			string4 fb_score;
   			unsigned6 fb_seq;
   			string1 fb_rest;
   			string8 fb_first_dt;
   			string8 fb_last_dt;
   			string addr_match_flag;
   			unsigned6 s_did;
   			unsigned6 did;
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
   			qstring5 cbsa;
   			string1 tnt;
   			string1 valid_ssn;
   			string1 jflag1;
   			string1 jflag2;
   			string1 jflag3;
   			unsigned8 rawaid;
   			string1 valid_dob;
   			unsigned6 hhid;
   			string18 county_name;
   			string120 listed_name;
   			string10 listed_phone;
   			unsigned4 dod;
   			string1 death_code;
   			unsigned4 lookup_did;
   			string4 addr_suffix;
   			string25 p_city_name;
   			string25 v_city_name;
   			string4 cart;
   			string1 cr_sort_sz;
   			string4 lot;
   			string1 lot_order;
   			string2 dbpc;
   			string1 chk_digit;
   			string10 geo_lat;
   			string11 geo_long;
   			string4 msa;
   			string1 geo_match;
   			string4 err_stat;
   			unsigned6 uid;
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
   			string7 p7;
   			string3 p3;
   			unsigned5 person1;
   			boolean same_lname;
   			unsigned2 number_cohabits;
   			integer3 recent_cohabit;
   			unsigned5 person2;
   			unsigned1 zero;
   			unsigned4 lookups;
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
   			unsigned3 addr_dt_first_seen;
   			string10 adl_ind;
   			string9 s_ssn;
   			unsigned8 cnt;
   			boolean cellphone;
   			unsigned8 persistent_record_id;
    END;
*/

		EXPORT primary_Driver_Rec := RECORD
				UNSIGNED6	UniqueID;
				STRING2		ADDR_IND;
				UNSIGNED6	UniqueRID;
				STRING28 	LAST_NAME;
				STRING20 	FIRST_NAME;
				STRING20 	MIDDLE_NAME;
				STRING5		NAME_SUFFIX;
				STRING1		GENDER;
				STRING8		DOB;
				STRING8		DOD;
				STRING9		SSN;
				STRING100	STREET_ADDRESS;
				STRING25	CITY;
				STRING2		STATE;
				STRING5		ZIP5;
				STRING8 	DATE_FIRST_SEEN;
				STRING8		DATE_LAST_SEEN;
				STRING25	DL_NUMBER;
				STRING2		DL_STATE;
				STRING50 	LICENSE_CLASS;		//Jul, 2014 change
				STRING50	LICENSE_TYPE;			//Jul, 2014 change
				STRING50 	STATUS;						//Jul, 2014 change
				STRING8		LICENSE_ISSUE_DATE;
				STRING8		LICENSE_EXPIRATION_DATE;
				STRING50  RESTRICTION;
				STRING50 	LIC_ENDORSEMENT := '';				// Oct 2014 
				STRING8 	ORIG_ISSUE_DATE := '';				// Oct 2014 - Convert to UNSIGNED4
				STRING3   CDL_STATUS;
				STRING3		HEIGHT;
				STRING3		HAIR_COLOR;
				STRING3		EYE_COLOR;
				STRING3		WEIGHT;	
				STRING8		ORIG_ORIGCDLDATE := '';				// Oct 2014 - Convert to UNSIGNED4
				STRING15	ORIG_COUNTY := '';						// Oct 2014 
				STRING1		ORIG_HABITUALOFFENDER := '';	// Oct 2014 	
				STRING1		SCHOOL_BUS_PHYSICAL_TYPE;
				UNSIGNED4	SCHOOL_BUS_PHYSICAL_EXPDATE;
				STRING10	CUST_TEST_DATA_TYPE;
				STRING1		AGE_DATA_FLAG;
				STRING1		HAS_SECURITY_FREEZE;
				STRING10	CONSUMER_NUMBER;
		END;
		
		
		EXPORT primary_Driver_Clean_Rec := RECORD
				unsigned6 uniqueid;
				unsigned6 BocaDID :=0;
				string2 addr_ind;
				unsigned6 uniquerid;
				string28 last_name;
				string20 first_name;
				string20 middle_name;
				string5 name_suffix;
				string1 gender;
				string8 dob;
				string8 dod;
				string9 ssn;
				string100 street_address;
				string25 city;
				string2 state;
				string5 zip5;
				string8 date_first_seen;
				string8 date_last_seen;
				string25 dl_number;
				string2 dl_state;
				string50 license_class;
				string50 license_type;
				string50 status;
				string8 license_issue_date;
				string8 license_expiration_date;
				string50 restriction;
				string50 lic_endorsement;
				string8 orig_issue_date;
				string3 cdl_status;
				string3 height;
				string3 hair_color;
				string3 eye_color;
				string3 weight;
				string8 orig_origcdldate;
				string15 orig_county;
				string1 orig_habitualoffender;
				string1 school_bus_physical_type;
				unsigned4 school_bus_physical_expdate;
				string10 cust_test_data_type;
				string1 age_data_flag;
				string1 has_security_freeze;
				string10 consumer_number;
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
				string2 fips_state;
				string3 fips_county;
				string10 geo_lat;
				string11 geo_long;
				string4 msa;
				string7 geo_blk;
				string1 geo_match;
				string4 err_stat;
				string1 highrise_ind;
				string1 resi_or_busi_ind;
		END;

		EXPORT primary_Driver_Clean_Join_Rec := RECORD
				unsigned6 joinInt;
				primary_Driver_Clean_Rec;
		END;



		EXPORT VIN_Simple_Layout := RECORD
				STRING17 VIN;
				STRING   Year;
				STRING   Make;
				STRING   Model;
		END;


END;