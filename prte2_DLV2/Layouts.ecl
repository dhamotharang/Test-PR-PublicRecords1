import DriversV2, AID;
EXPORT Layouts := module

 //  CONVICTIONS
	export Layout_Convictions := DriversV2.Layouts_DL_Conv_Points_Common.Layout_Convictions;
		
    //	SUSPENSIONS
	export Layout_Suspensions := DriversV2.Layouts_DL_Conv_Points_Common.Layout_Suspensions;		
		
    //	DRIVING RECORD INFORMATION
	export Layout_Driver_Record_Info := DriversV2.Layouts_DL_Conv_Points_Common.Layout_Driver_Record_Info;
	  
    //	ACCIDENT 
	export Layout_Accident :=  DriversV2.Layouts_DL_Conv_Points_Common.Layout_Accident;
	 
	//	FRA_INSURANCE
	export Layout_FRA_Insurance := DriversV2.Layouts_DL_Conv_Points_Common.Layout_FRA_Insurance;		

	EXPORT Layout_Drivers := DriversV2.Layout_Drivers_Extended;
  

  EXPORT Layout_Base := RECORD
		Layout_Drivers;
    string100 cust_name;
    string20 bug_num;
    qstring8 link_dob;
    qstring9 link_ssn;
  END;    
	
	//Non exported layout from DriversV2.File_DL_base_for_Autokeys
	EXPORT Layout_DL_AutoKeys  := record
		Layout_Drivers - IssuedRecord;
		unsigned1 zero  := 0;
		string1   blank := '';
	end;


	
	EXPORT Layout_DL := DriversV2.Layout_DL;
	
	EXPORT ExtendedLayout := RECORD
		Layout_DL;
		string1 record_type :='';
		STRING18 county_name := '';
		string30 history_name := '';
		string30 attention_name := '';
		string30 race_name := '';
		string30 sex_name := '';
		string30 hair_color_name := '';
		string30 eye_color_name := '';
		string30 orig_state_name := '';
	END;
	
	EXPORT Layout_DL_Wildcard := DriversV2.Layout_DL_Wildcard;
	
	EXPORT Layouts_DL_uber_Layout_Base := DriversV2.Layouts_DL_uber.Layout_Base;
	
	EXPORT Layouts_DL_uber_Layout_Plus := DriversV2.Layouts_DL_uber.Layout_Plus;
	
EXPORT Layout_indic_rec := RECORD
	STRING1 race;
	STRING1 sex_flag;
	UNSIGNED1 age;
	STRING2 orig_state;
	qstring24 dl_number;
	unsigned randomizer := 0;
END;

EXPORT Layout_As_Header := driversv2.Layout_Base_withAID;	

EXPORT Layout_in := RECORD
unsigned6 dl_seq;
unsigned6 did;
unsigned6 preglb_did;
unsigned3 dt_first_seen;
unsigned3 dt_last_seen;
unsigned3 dt_vendor_first_reported;
unsigned3 dt_vendor_last_reported;
string14 dlcp_key;
string2 orig_state;
string2 source_code;
string1 history;
qstring52 name;
string1 addr_type;
qstring40 addr1;
qstring20 city;
qstring2 state;
string5 zip;
string2 province;
string3 country;
string10 postal_code;
integer4 dob;
string1 race;
string1 sex_flag;
string6 license_class;
qstring4 license_type;
qstring4 moxie_license_type;
qstring14 attention_flag;
qstring8 dod;
qstring42 restrictions;
qstring42 restrictions_delimited;
unsigned4 orig_expiration_date;
unsigned4 orig_issue_date;
unsigned4 lic_issue_date;
unsigned4 expiration_date;
unsigned3 active_date;
unsigned3 inactive_date;
qstring10 lic_endorsement;
qstring4 motorcycle_code;
qstring24 dl_number;
qstring9 ssn;
qstring9 ssn_safe;
qstring3 age;
string1 privacy_flag;
string1 driver_edu_code;
string1 dup_lic_count;
string1 rcd_stat_flag;
qstring3 height;
qstring3 hair_color;
qstring3 eye_color;
qstring3 weight;
qstring25 oos_previous_dl_number;
string2 oos_previous_st;
qstring5 title;
string20 fname;
qstring20 mname;
string20 lname;
qstring5 name_suffix;
qstring3 cleaning_score;
string1 addr_fix_flag;
string10 prim_range;
qstring2 predir;
string28 prim_name;
qstring4 suffix;
qstring2 postdir;
qstring10 unit_desig;
string8 sec_range;
qstring25 p_city_name;
qstring25 v_city_name;
string2 st;
qstring5 zip5;
qstring4 zip4;
qstring4 cart;
string1 cr_sort_sz;
qstring4 lot;
string1 lot_order;
string2 dpbc;
string1 chk_digit;
string2 rec_type;
string2 ace_fips_st;
qstring3 county;
qstring10 geo_lat;
qstring11 geo_long;
qstring4 msa;
qstring7 geo_blk;
string1 geo_match;
qstring4 err_stat;
string3 status;
qstring2 issuance;
qstring8 address_change;
string1 name_change;
string1 dob_change;
string1 sex_change;
qstring24 old_dl_number;
qstring9 dl_key_number;
string3 cdl_status;
string1 record_type;
unsigned1 zero;
string1 blank;
string100 cust_name;
string20 bug_num;
qstring8 link_dob;
qstring9 link_ssn;
END;

END;