Import Gong_Neustar, Gong, WatchDog,Relocations,Gong_v2,Gong_Platinum,Business_Header, prte2, BIPv2;

EXPORT Layouts := module

EXPORT Layout_bscurrent_raw := record
  unsigned6 did;
	Gong_Neustar.Layout_bscurrent_raw;
	prte2.Layouts.DEFLT_CPA;
end;

//Append CCPA fields
EXPORT Layout_history := {Gong.Layout_history or {string100 cust_name,string20 bug_num, string address1 := '', string city := '', string state := ''
																		, string zip := '',string link_ssn :='',string link_dob:='',string link_fein:='',string link_inc_date:=''
																		, unsigned6 powid := 0, unsigned6 proxid := 0, unsigned6 seleid := 0, unsigned6 orgid := 0, unsigned6 ultid := 0}};
//Append CCPA fields
EXPORT  layout_historyaid := gong.layout_historyaid;

//Append CCPA fields
EXPORT Layout_Gong_DID := record
Watchdog.Layout_Gong_DID;
prte2.layouts.DEFLT_CPA;
end;

EXPORT Layout_extra := RECORD
	STRING30	word;
	STRING25	city;
	Layout_bscurrent_raw;
END;
EXPORT AreaCodeSummary :=record
	 string5   zip;
	 string10  phone;
	 string3   timezone:='';
end;

EXPORT AreaCodeFinal :=record
	 string5 zip;
	 string3 areacode;
	 string3 timezone;
	 integer occurs;
end;

//Need to add CCPA fields
EXPORT cn_layout := record
	Layout_bscurrent_raw.listed_name;
	Layout_bscurrent_raw.caption_text;
	string cn_all := '';
	string100 cn := '';
	string2 st := '';
	string25 p_city_name;
	string25 v_city_name;
	string5 z5 := '';
	string10 phone10;
end;

export phone_table_rec := RECORD
	STRING10	phone10;
	BOOLEAN 	isCurrent;
	unsigned3 dt_first_seen;
	STRING20 	lname;
	string28 	prim_name;
	STRING10 	prim_range;
	string25 	city;
	string2  	state;
	STRING5  	zip5;
	STRING4  	zip4;
	boolean  	potDisconnect := false;
	BOOLEAN  	isaCompany := false;
	STRING1  	company_type := '';
	BOOLEAN  	company_type_A := false;
	string4  	sic_code := '';
	string120 company_name := '';
	unsigned3 hri_dt_first_seen := 0;
	STRING2 	nxx_type := '';
	integer did_ct;
	integer did_ct_c6;	
	unsigned6 did;
	prte2.layouts.deflt_cpa;
END;

export phone_table_rec_fcra := record
phone_table_rec - [did, global_sid, record_sid];
end;

Export LayoutScoringAttributes := Gong_Platinum.LayoutScoringAttributes;

Export ScoringRecord := RECORD
 Gong_Platinum.LayoutScoringAttributes.KeyLayout;
 prte2.layouts.deflt_cpa;
END;

EXPORT rec_address := record
  unsigned1 listing_type; 
  Layout_bscurrent_raw.publish_code;
  Layout_bscurrent_raw.phone10;
  Layout_bscurrent_raw.prim_range;
  Layout_bscurrent_raw.predir;
  Layout_bscurrent_raw.prim_name;
  Layout_bscurrent_raw.suffix;
  Layout_bscurrent_raw.sec_range;
  Layout_bscurrent_raw.st;
  Layout_bscurrent_raw.z5;
  typeof (Layout_bscurrent_raw.name_first) fname; 
  typeof (Layout_bscurrent_raw.name_middle) mname;
  typeof (Layout_bscurrent_raw.name_last) lname;
  Layout_bscurrent_raw.omit_phone;
  Layout_bscurrent_raw.name_suffix;
  Layout_bscurrent_raw.listed_name;
  string8 date_first_seen;
  Layout_bscurrent_raw.dual_name_flag;
	unsigned6 did;
	prte2.Layouts.deflt_cpa;
END;



EXPORT Layout_extra_city := RECORD
	STRING25	city;
	Layout_bscurrent_raw;
END;

EXPORT Layout_extra_fname_city := RECORD
	STRING20	fname;
	STRING25	city;
	Layout_bscurrent_raw;
END;

export layout_gng_hhid_temp := RECORD
	UNSIGNED6 did := 0;
	UNSIGNED6 hhid := 0;
	Layout_Gong_DID;
END;

// Append CCPA fields
export layout_gng_hhid := RECORD
	UNSIGNED6 hhid := 0;
	Layout_bscurrent_raw;
	PRTE2.Layouts.DEFLT_CPA;
END;

export Layout_HistorySurname := Gong.Layout_HistorySurname;

export f_layout_cnt := RECORD(Layout_HistorySurname)
	string20 k_name_last := '';
	string20 k_name_first := '';
	string2 k_st := '';
	unsigned cnt;
END;

export f_layout_num := RECORD(f_layout_cnt)
	unsigned num := 0;
END;

//Append ccpa fields
export layout_narrow := record
Relocations.layout_wdtg.narrow;
// prte2.Layouts.deflt_cpa;
end;

export layout_span := record
	layout_narrow;
	typeof(layout_historyaid.dt_first_seen)	span_first_seen;
	typeof(layout_historyaid.dt_last_seen) 	span_last_seen := '';
	prte2.Layouts.deflt_cpa;
end;

export new_gong_record := record
	Layout_bscurrent_raw;
	string7 phone7;
	string3 area_code;
end;

export layout_gongMasterv2 := Gong_v2.layout_gongMaster;
export layout_gongMaster := Gong_Neustar.layout_gongMaster;

export surnames_slim_rec := RECORD
			layout_gongMaster.name_last;
			layout_gongMaster.st;
			integer cnt;
END;
export temp_ly4 := record
	unsigned did;
	string10 phone10;
	string8 dt_first_seen;
	string8 dt_last_seen;
	unsigned days_in_service := 0;
	unsigned days_interupt := 0;
	boolean has_cur_discon_15_days:=false;
	boolean has_cur_discon_30_days:=false;
	boolean has_cur_discon_60_days:=false;
	boolean has_cur_discon_90_days:=false;
	boolean has_cur_discon_180_days:=false;
	boolean has_cur_discon_360_days:=false;
end;
EXPORT Layout_Gong_Temp := RECORD
		Business_Header.Layout_Business_Header_New;
		string10          group_seq;
		string254         caption_text;
		string10          phone10;
		unsigned2         phone_number_score := 0;
		unsigned2         phone_sequence_score := 0;
		boolean           ebc_flag;
END;

EXPORT Layout_gong_in := RECORD
	string3 bell_id;
	string11 filedate;
	string1 dual_name_flag;
	string10 sequence_number;
	string1 listing_type_bus;
	string1 listing_type_res;
	string1 listing_type_gov;
	string1 publish_code;
	string1 style_code;
	string1 indent_code;
	string20 book_neighborhood_code;
	string3 prior_area_code;
	string10 phone10;
	string address1;
	string city;
	string state;
	string zip;
	string10 prim_range;
	string2 predir;
	string28 prim_name;
	string4 suffix;
	string2 postdir;
	string10 unit_desig;
	string8 sec_range;
	string25 p_city_name;
	string2 v_predir;
	string28 v_prim_name;
	string4 v_suffix;
	string2 v_postdir;
	string25 v_city_name;
	string2 st;
	string5 z5;
	string4 z4;
	string4 cart;
	string1 cr_sort_sz;
	string4 lot;
	string1 lot_order;
	string2 dpbc;
	string1 chk_digit;
	string2 rec_type;
	string5 county_code;
	string10 geo_lat;
	string11 geo_long;
	string4 msa;
	string7 geo_blk;
	string1 geo_match;
	string4 err_stat;
	string32 designation;
	string5 name_prefix;
	string20 name_first;
	string20 name_middle;
	string20 name_last;
	string5 name_suffix;
	string120 listed_name;
	string254 caption_text;
	string10 group_id;
	string10 group_seq;
	string1 omit_address;
	string1 omit_phone;
	string1 omit_locality;
	string64 see_also_text;
	unsigned6 did;
	unsigned6 hhid;
	unsigned6 bdid;
	string8 dt_first_seen;
	string8 dt_last_seen;
	string current_record_flag;
	string8 deletion_date;
	unsigned2 disc_cnt6;
	unsigned2 disc_cnt12;
	unsigned2 disc_cnt18;
	string orig_csv_file;
	string100 cust_name;
	string20 bug_num;
	string9 link_ssn;
	string8 link_dob;
	string link_fein;
	string8 link_inc_date;
END;

export layout_base := record
Gong.Layout_history and not [global_sid, record_sid];
unsigned8 rawaid;
string pclean;
string5 pdid;
string1 nametype;
string80 preppedname;
unsigned8 nid;
unsigned2 name_ind;
unsigned8 persistent_record_id;
BIPV2.IDlayouts.l_xlink_ids;	
//CCPA-22 CCPA new fields
PRTE2.Layouts.DEFLT_CPA;
string address1 := '';
string city := '';
string state := ''; 
string zip := '';
string10 cust_name;
string10 bug_num; 
string link_ssn :='';
string link_dob:='';
string link_fein:='';
string link_inc_date:='';
end;

//Append CCPA fields
EXPORT layout_historyaid_clean := record
gong.layout_historyaid and not [global_sid, record_sid];
PRTE2.Layouts.DEFLT_CPA;
end;

// export layout_linkid := records

END;
