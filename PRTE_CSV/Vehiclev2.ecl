export Vehiclev2 :=

module

	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'';
//shared	lCSVVersion					:=	'20100110a';	
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;

export rthor_data400__data__vehiclev2__wildcard_public	:=
record
  string30 vehicle_key;
  string15 iteration_key;
  string15 sequence_key;
  big_endian unsigned integer4 wd_veh_id;
  big_endian unsigned integer2 wd_year_make;
  big_endian unsigned integer2 wd_make_code;
  big_endian unsigned integer2 wd_model_description;
  big_endian unsigned integer1 wd_major_color_code;
  qstring10 wd_plate_number;
  qstring25 wd_vin;
  string1 wd_gender;
  big_endian unsigned integer1 wd_years_since_1900;
  big_endian unsigned integer3 wd_zip;
  big_endian unsigned integer1 wd_state;
  big_endian unsigned integer1 wd_orig_state;
  big_endian unsigned integer1 wd_person_source;
  unsigned2 wd_body_code;
end;

export rthor_data400__key__vehiclev2__keymodelindex_public	:=
record
	qstring36 str;
	unsigned2 i;
end;

export rthor_data400__key__vehiclev2__keynameindex_public	:=
record
	qstring20 str;
	unsigned4 i;
end;

export name := RECORD
   string5 title;
   string20 fname;
   string20 mname;
   string20 lname;
   string5 name_suffix;
   string3 name_score;
  END;

export Addr := RECORD
   string10 prim_range;
   string2 predir;
   string28 prim_name;
   string4 addr_suffix;
   string2 postdir;
   string10 unit_desig;
   string8 sec_range;
   string25 v_city_name;
   string2 st;
   string5 zip5;
   string4 zip4;
   string2 addr_rec_type;
   string2 fips_state;
   string3 fips_county;
   string10 geo_lat;
   string11 geo_long;
   string4 cbsa;
   string7 geo_blk;
   string1 geo_match;
   string4 err_stat;
  END;
	
export rthor_data400__key__vehiclev2__autokey__address	:=
record
	string28 prim_name;
	string10 prim_range;
	string2 st;
	unsigned4 city_code;
	string5 zip;
	string8 sec_range;
	string6 dph_lname;
	string20 lname;
	string20 pfname;
	string20 fname;
	unsigned8 states;
	unsigned4 lname1;
	unsigned4 lname2;
	unsigned4 lname3;
	unsigned4 lookups;
	unsigned6 did;
end;

export rthor_data400__key__vehiclev2__autokey__addressb2	:=
record
	string28 prim_name;
	string10 prim_range;
	string2 st;
	unsigned4 city_code;
	string5 zip;
	string8 sec_range;
	string40 cname_indic;
	string40 cname_sec;
	unsigned6 bdid;
	unsigned4 lookups;
end;

export rthor_data400__key__vehiclev2__autokey__citystname	:=
record
	unsigned4 city_code;
	string2 st;
	string6 dph_lname;
	string20 lname;
	string20 pfname;
	string20 fname;
	integer4 dob;
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
	unsigned4 lookups;
	unsigned6 did;
end;

export rthor_data400__key__vehiclev2__autokey__citystnameb2	:=
record
	unsigned4 city_code;
	string2 st;
	string40 cname_indic;
	string40 cname_sec;
	unsigned6 bdid;
	unsigned4 lookups;
end;

export rthor_data400__key__vehiclev2__autokey__fein2	:=
record
	string1 f1;
	string1 f2;
	string1 f3;
	string1 f4;
	string1 f5;
	string1 f6;
	string1 f7;
	string1 f8;
	string1 f9;
	string40 cname_indic;
	string40 cname_sec;
	unsigned6 bdid;
	unsigned4 lookups;
end;

export rthor_data400__key__vehiclev2__autokey__name	:=
record
	string6 dph_lname;
	string20 lname;
	string20 pfname;
	string20 fname;
	string1 minit;
	unsigned2 yob;
	unsigned2 s4;
	integer4 dob;
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
	unsigned4 lookups;
	unsigned6 did;
end;

export rthor_data400__key__vehiclev2__autokey__nameb2	:=
record
	string40 cname_indic;
	string40 cname_sec;
	unsigned6 bdid;
	unsigned4 lookups;
end;

export rthor_data400__key__vehiclev2__autokey__namewords2	:=
record
	string40 word;
	string2 state;
	unsigned1 seq;
	unsigned6 bdid;
	unsigned4 lookups;
end;

export rthor_data400__key__vehiclev2__autokey__payload	:=
record
	unsigned6 fakeid;
	string30 vehicle_key;
	string15 iteration_key;
	string15 sequence_key;
	unsigned1 zero;
	unsigned4 lookup_bit;
	string2 source_code;
	unsigned6 append_did;
	unsigned6 append_bdid;
	string70 append_clean_cname;
	string9 append_ssn;
	string9 append_fein;
	Addr company_addr;
	Addr person_addr;
	name person_name;
	string1 orig_name_type;
	string1 history;
	unsigned4 reg_latest_effective_date;
	unsigned4 reg_latest_expiration_date;
	unsigned4 ttl_latest_issue_date;
end;

export rthor_data400__key__vehiclev2__autokey__ssn2	:=
record
	string1 s1;
	string1 s2;
	string1 s3;
	string1 s4;
	string1 s5;
	string1 s6;
	string1 s7;
	string1 s8;
	string1 s9;
	string6 dph_lname;
	string20 pfname;
	unsigned6 did;
	unsigned4 lookups;
end;

export rthor_data400__key__vehiclev2__autokey__stname	:=
record
	string2 st;
	string6 dph_lname;
	string20 lname;
	string20 pfname;
	string20 fname;
	string1 minit;
	unsigned2 yob;
	unsigned2 s4;
	integer4 zip;
	integer4 dob;
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
	unsigned4 lookups;
	unsigned6 did;
end;

export rthor_data400__key__vehiclev2__autokey__stnameb2	:=
record
	string2 st;
	string40 cname_indic;
	string40 cname_sec;
	unsigned6 bdid;
	unsigned4 lookups;
end;

export rthor_data400__key__vehiclev2__autokey__zip	:=
record
	integer4 zip;
	string6 dph_lname;
	string20 lname;
	string20 pfname;
	string20 fname;
	string1 minit;
	unsigned2 yob;
	unsigned2 s4;
	integer4 dob;
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
	unsigned4 lookups;
	unsigned6 did;
end;

export rthor_data400__key__vehiclev2__autokey__zipb2	:=
record
	integer4 zip;
	string40 cname_indic;
	string40 cname_sec;
	unsigned6 bdid;
	unsigned4 lookups;
end;

export rthor_data400__key__vehiclev2__bdid	:=
record
	unsigned6 append_bdid;
	string30 vehicle_key;
	string15 iteration_key;
	string15 sequence_key;
	unsigned8 __internal_fpos__;
end;

layout_veh_info := 
record
   unsigned2 year_make;
   string10 make;
   string10 model;
   boolean title;
   string25 vin;
   string2 orig_state;
   string2 source_code;
  END;

export rthor_data400__key__vehiclev2__bocashell_did	:=
record
  unsigned6 did;
  string30 vehicle_key;
  string15 iteration_key;
  string15 sequence_key;
  unsigned1 current_count;
  unsigned1 historical_count;
  layout_veh_info vehicle1;
  layout_veh_info vehicle2;
  layout_veh_info vehicle3;
  unsigned8 __internal_fpos__;
 END;

export rthor_data400__key__vehiclev2__did	:=
record
	unsigned6 append_did;
	boolean is_minor;
	string30 vehicle_key;
	string15 iteration_key;
	string15 sequence_key;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__vehiclev2__dl_number	:=
record
	string20 dl_number;
	string2 state_origin;
	boolean is_minor;
	string30 vehicle_key;
	string15 iteration_key;
	string15 sequence_key;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__vehiclev2__lic_plate	:=
record
	string10 license_plate;
	string2 state_origin;
	string6 dph_lname;
	string20 pfname;
	boolean is_minor;
	string30 vehicle_key;
	string15 iteration_key;
	string15 sequence_key;
	boolean is_current;
	unsigned4 date;
	string8 orig_dob;
	string9 use_ssn;
	string20 fname;
	string20 lname;
	string20 mname;
	string2 predir;
	string28 prim_name;
	string10 prim_range;
	string4 addr_suffix;
	string2 postdir;
	string8 sec_range;
	string25 v_city_name;
	string5 zip5;
	string70 append_clean_cname;
	string1 state_type;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__vehiclev2__lic_plate_blur	:=
record
	string10 license_plate_blur;
	string10 license_plate;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__vehiclev2__linkids	:=
record
  unsigned6 ultid;
  unsigned6 orgid;
  unsigned6 seleid;
  unsigned6 proxid;
  unsigned6 powid;
  unsigned6 empid;
  unsigned6 dotid;
  unsigned2 ultscore;
  unsigned2 orgscore;
  unsigned2 selescore;
  unsigned2 proxscore;
  unsigned2 powscore;
  unsigned2 empscore;
  unsigned2 dotscore;
  unsigned2 ultweight;
  unsigned2 orgweight;
  unsigned2 seleweight;
  unsigned2 proxweight;
  unsigned2 powweight;
  unsigned2 empweight;
  unsigned2 dotweight;
  unsigned8 source_rec_id;
  string30 vehicle_key;
  string15 iteration_key;
  string15 sequence_key;
  string2 source_code;
  string2 state_origin;
  unsigned8 state_bitmap_flag;
  string1 latest_vehicle_flag;
  string1 latest_vehicle_iteration_flag;
  string1 history;
  unsigned3 date_first_seen;
  unsigned3 date_last_seen;
  unsigned3 date_vendor_first_reported;
  unsigned3 date_vendor_last_reported;
  string1 orig_party_type;
  string1 orig_name_type;
  string10 orig_conjunction;
  string70 orig_name;
  string70 orig_address;
  string35 orig_city;
  string2 orig_state;
  string30 orig_province;
  string30 orig_country;
  string10 orig_zip;
  string9 orig_ssn;
  string9 orig_fein;
  string20 orig_dl_number;
  string8 orig_dob;
  string1 orig_sex;
  string8 orig_lien_date;
  name append_clean_name;
  string70 append_clean_cname;
  addr append_clean_address;
  unsigned6 append_did;
  unsigned1 append_did_score;
  unsigned6 append_bdid;
  unsigned1 append_bdid_score;
  string20 append_dl_number;
  string9 append_ssn;
  string9 append_fein;
  string8 append_dob;
  string8 reg_first_date;
  string8 reg_earliest_effective_date;
  string8 reg_latest_effective_date;
  string8 reg_latest_expiration_date;
  unsigned1 reg_rollup_count;
  string10 reg_decal_number;
  string4 reg_decal_year;
  string1 reg_status_code;
  string20 reg_status_desc;
  string10 reg_true_license_plate;
  string10 reg_license_plate;
  string2 reg_license_state;
  string4 reg_license_plate_type_code;
  string65 reg_license_plate_type_desc;
  string2 reg_previous_license_state;
  string10 reg_previous_license_plate;
  string20 ttl_number;
  string8 ttl_earliest_issue_date;
  string8 ttl_latest_issue_date;
  string8 ttl_previous_issue_date;
  unsigned1 ttl_rollup_count;
  string2 ttl_status_code;
  string48 ttl_status_desc;
  string7 ttl_odometer_mileage;
  string1 ttl_odometer_status_code;
  string42 ttl_odometer_status_desc;
  string8 ttl_odometer_date;
  integer1 fp;
end;

export rthor_data400__key__vehiclev2__main_key	:=
record
	string30 vehicle_key;
	string15 iteration_key;
	string2 source_code;
	string2 state_origin;
	unsigned8 state_bitmap_flag;
	string25 orig_vin;
	string4 orig_year;
	string5 orig_make_code;
	string36 orig_make_desc;
	string3 orig_series_code;
	string25 orig_series_desc;
	string3 orig_model_code;
	string30 orig_model_desc;
	string5 orig_body_code;
	string20 orig_body_desc;
	string6 orig_net_weight;
	string6 orig_gross_weight;
	string1 orig_number_of_axles;
	string1 orig_vehicle_use_code;
	string30 orig_vehicle_use_desc;
	string5 orig_vehicle_type_code;
	string30 orig_vehicle_type_desc;
	string3 orig_major_color_code;
	string15 orig_major_color_desc;
	string3 orig_minor_color_code;
	string15 orig_minor_color_desc;
	string1 vina_veh_type;
	string5 vina_ncic_make;
	string2 vina_model_year_yy;
	string17 vina_vin;
	string1 vina_vin_pattern_indicator;
	string1 vina_bypass_code;
	string1 vina_vp_restraint;
	string4 vina_vp_abbrev_make_name;
	string2 vina_vp_year;
	string3 vina_vp_series;
	string3 vina_vp_model;
	string1 vina_vp_air_conditioning;
	string1 vina_vp_power_steering;
	string1 vina_vp_power_brakes;
	string1 vina_vp_power_windows;
	string1 vina_vp_tilt_wheel;
	string1 vina_vp_roof;
	string1 vina_vp_optional_roof1;
	string1 vina_vp_optional_roof2;
	string1 vina_vp_radio;
	string1 vina_vp_optional_radio1;
	string1 vina_vp_optional_radio2;
	string1 vina_vp_transmission;
	string1 vina_vp_optional_transmission1;
	string1 vina_vp_optional_transmission2;
	string1 vina_vp_anti_lock_brakes;
	string1 vina_vp_front_wheel_drive;
	string1 vina_vp_four_wheel_drive;
	string1 vina_vp_security_system;
	string1 vina_vp_daytime_running_lights;
	string25 vina_vp_series_name;
	string4 vina_model_year;
	string3 vina_series;
	string3 vina_model;
	string2 vina_body_style;
	string36 vina_make_desc;
	string36 vina_model_desc;
	string25 vina_series_desc;
	string25 vina_body_style_desc;
	string2 vina_number_of_cylinders;
	string4 vina_engine_size;
	string1 vina_fuel_code;
	string6 vina_price;
	string5 best_make_code;
	string3 best_series_code;
	string3 best_model_code;
	string5 best_body_code;
	string4 best_model_year;
	string3 best_major_color_code;
	string3 best_minor_color_code;
	unsigned8 __internal_fpos__;
end;

//DF-17145. Add MDF search key
export rthor_data400__key__vehiclev2__mfd_srch	:=
record
  string5 zip5;
  string10 prim_range;
  string28 prim_name;
  string4 suffix;
  string2 predir;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 v_city_name;
  string2 st;
  string4 zip4;
  string30 vehicle_key;
  string15 iteration_key;
  string15 sequence_key;
  string2 source_code;
  string2 state_origin;
  boolean is_minor;
  string1 history;
  unsigned3 date_last_seen;
  unsigned6 reg_expire_date;
end;

export rthor_data400__key__vehiclev2__party_key :=
record 
  string30 vehicle_key;
	string15 iteration_key;
	string15 sequence_key;
	string2 source_code;
	string2 state_origin;
	unsigned8 state_bitmap_flag;
	string1 latest_vehicle_flag;
	string1 latest_vehicle_iteration_flag;
	string1 history;
	unsigned3 date_first_seen;
	unsigned3 date_last_seen;
	unsigned3 date_vendor_first_reported;
	unsigned3 date_vendor_last_reported;
	string1 orig_party_type;
	string1 orig_name_type;
	string10 orig_conjunction;
	string70 orig_name;
	string70 orig_address;
	string35 orig_city;
	string2 orig_state;
	string30 orig_province;
	string30 orig_country;
	string10 orig_zip;
	string9 orig_ssn;
	string9 orig_fein;
	string20 orig_dl_number;
	string8 orig_dob;
	string1 orig_sex;
	string8 orig_lien_date;
	name append_clean_name;
	string70 append_clean_cname;
	Addr append_clean_address;
	unsigned6 append_did;
	unsigned1 append_did_score;
	unsigned6 append_bdid;
	unsigned1 append_bdid_score;
	string20 append_dl_number;
	string9 append_ssn;
	string9 append_fein;
	string8 append_dob;
	string8 reg_first_date;
	string8 reg_earliest_effective_date;
	string8 reg_latest_effective_date;
	string8 reg_latest_expiration_date;
	unsigned1 reg_rollup_count;
	string10 reg_decal_number;
	string4 reg_decal_year;
	string1 reg_status_code;
	string20 reg_status_desc;
	string10 reg_true_license_plate;
	string10 reg_license_plate;
	string2 reg_license_state;
	string4 reg_license_plate_type_code;
	string65 reg_license_plate_type_desc;
	string2 reg_previous_license_state;
	string10 reg_previous_license_plate;
	string20 ttl_number;
	string8 ttl_earliest_issue_date;
	string8 ttl_latest_issue_date;
	string8 ttl_previous_issue_date;
	unsigned1 ttl_rollup_count;
	string2 ttl_status_code;
	string48 ttl_status_desc;
	string7 ttl_odometer_mileage;
	string1 ttl_odometer_status_code;
	string42 ttl_odometer_status_desc;
	string8 ttl_odometer_date;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__party_key_linkids	:=
record
   string30 vehicle_key;
   string15 iteration_key;
   string15 sequence_key;
   string2 source_code;
   string2 state_origin;
   unsigned8 state_bitmap_flag;
   string1 latest_vehicle_flag;
   string1 latest_vehicle_iteration_flag;
   string1 history;
   unsigned3 date_first_seen;
   unsigned3 date_last_seen;
   unsigned3 date_vendor_first_reported;
   unsigned3 date_vendor_last_reported;
   string1 orig_party_type;
   string1 orig_name_type;
   string10 orig_conjunction;
   string70 orig_name;
   string70 orig_address;
   string35 orig_city;
   string2 orig_state;
   string30 orig_province;
   string30 orig_country;
   string10 orig_zip;
   string9 orig_ssn;
   string9 orig_fein;
   string20 orig_dl_number;
   string8 orig_dob;
   string1 orig_sex;
   string8 orig_lien_date;
   name append_clean_name;
   string70 append_clean_cname;
   addr append_clean_address;
   unsigned6 append_did;
   unsigned1 append_did_score;
   unsigned6 append_bdid;
   unsigned1 append_bdid_score;
   string20 append_dl_number;
   string9 append_ssn;
   string9 append_fein;
   string8 append_dob;
   string8 reg_first_date;
   string8 reg_earliest_effective_date;
   string8 reg_latest_effective_date;
   string8 reg_latest_expiration_date;
   unsigned1 reg_rollup_count;
   string10 reg_decal_number;
   string4 reg_decal_year;
   string1 reg_status_code;
   string20 reg_status_desc;
   string10 reg_true_license_plate;
   string10 reg_license_plate;
   string2 reg_license_state;
   string4 reg_license_plate_type_code;
   string65 reg_license_plate_type_desc;
   string2 reg_previous_license_state;
   string10 reg_previous_license_plate;
   string20 ttl_number;
   string8 ttl_earliest_issue_date;
   string8 ttl_latest_issue_date;
   string8 ttl_previous_issue_date;
   unsigned1 ttl_rollup_count;
   string2 ttl_status_code;
   string48 ttl_status_desc;
   string7 ttl_odometer_mileage;
   string1 ttl_odometer_status_code;
   string42 ttl_odometer_status_desc;
   string8 ttl_odometer_date;
	 string8	SRC_FIRST_DATE	:= '';
	 string8	SRC_LAST_DATE	:= '';
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
   string70 std_lienholder_name;
   unsigned8 __internal_fpos__;
end;

export rthor_data400__key__vehiclev2__reverse_lic_plate	:=
record
	string10 reverse_license_plate;
	string2 state_origin;
	string6 dph_lname;
	string20 pfname;
	boolean is_minor;
	string30 vehicle_key;
	string15 iteration_key;
	string15 sequence_key;
	boolean is_current;
	unsigned4 date;
	string8 orig_dob;
	string9 use_ssn;
	string20 fname;
	string20 lname;
	string20 mname;
	string2 predir;
	string28 prim_name;
	string10 prim_range;
	string4 addr_suffix;
	string2 postdir;
	string8 sec_range;
	string25 v_city_name;
	string5 zip5;
	string70 append_clean_cname;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__source_rec_id	:=
record
  unsigned8 source_rec_id;
  string30 vehicle_key;
  string15 iteration_key;
  string15 sequence_key;
  unsigned8 __internal_fpos__;
end;

export rthor_data400__key__vehiclev2__title_number	:=
record
	string20 ttl_number;
	string2 state_origin;
	string30 vehicle_key;
	string15 iteration_key;
	string15 sequence_key;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__vehiclev2__vehicles_address	:=
record
  string5 zip5;
  string10 prim_range;
  string28 prim_name;
  string4 suffix;
  string2 predir;
  string10 license_plate;
  string30 vehicle_key;
  string15 iteration_key;
  string15 sequence_key;
  string2 state_origin;
  boolean is_minor;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string2 st;
  string4 zip4;
  string10 geo_lat;
  string11 geo_long;
  string7 geo_blk;
  string5 county;
  string4 msa;
  string1 geo_match;
  string12 geolink;
  string1 state_type;
  string2 source_code;
  unsigned8 state_bitmap_flag;
  string25 orig_vin;
  string4 orig_year;
  string5 orig_make_code;
  string36 orig_make_desc;
  string3 orig_series_code;
  string25 orig_series_desc;
  string3 orig_model_code;
  string30 orig_model_desc;
  string5 orig_body_code;
  string20 orig_body_desc;
  string6 orig_net_weight;
  string6 orig_gross_weight;
  string1 orig_number_of_axles;
  string1 orig_vehicle_use_code;
  string30 orig_vehicle_use_desc;
  string5 orig_vehicle_type_code;
  string30 orig_vehicle_type_desc;
  string3 orig_major_color_code;
  string15 orig_major_color_desc;
  string3 orig_minor_color_code;
  string15 orig_minor_color_desc;
  string1 vina_veh_type;
  string5 vina_ncic_make;
  string2 vina_model_year_yy;
  string17 vina_vin;
  string1 vina_vin_pattern_indicator;
  string1 vina_bypass_code;
  string1 vina_vp_restraint;
  string4 vina_vp_abbrev_make_name;
  string2 vina_vp_year;
  string3 vina_vp_series;
  string3 vina_vp_model;
  string1 vina_vp_air_conditioning;
  string1 vina_vp_power_steering;
  string1 vina_vp_power_brakes;
  string1 vina_vp_power_windows;
  string1 vina_vp_tilt_wheel;
  string1 vina_vp_roof;
  string1 vina_vp_optional_roof1;
  string1 vina_vp_optional_roof2;
  string1 vina_vp_radio;
  string1 vina_vp_optional_radio1;
  string1 vina_vp_optional_radio2;
  string1 vina_vp_transmission;
  string1 vina_vp_optional_transmission1;
  string1 vina_vp_optional_transmission2;
  string1 vina_vp_anti_lock_brakes;
  string1 vina_vp_front_wheel_drive;
  string1 vina_vp_four_wheel_drive;
  string1 vina_vp_security_system;
  string1 vina_vp_daytime_running_lights;
  string25 vina_vp_series_name;
  string4 vina_model_year;
  string3 vina_series;
  string3 vina_model;
  string2 vina_body_style;
  string36 vina_make_desc;
  string36 vina_model_desc;
  string25 vina_series_desc;
  string25 vina_body_style_desc;
  string2 vina_number_of_cylinders;
  string4 vina_engine_size;
  string1 vina_fuel_code;
  string6 vina_price;
  string5 best_make_code;
  string3 best_series_code;
  string3 best_model_code;
  string5 best_body_code;
  string4 best_model_year;
  string3 best_major_color_code;
  string3 best_minor_color_code;
  unsigned8 __internal_fpos__;
end;

export rthor_data400__key__vehiclev2__vin	:=
record
	string25 vin;
	string2 state_origin;
	string30 vehicle_key;
	string15 iteration_key;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__wc_vehicle_bodystyle	:=
record
  string2 body_style;
  unsigned2 i;
  string50 body_style_description;
  string20 category;
  unsigned8 __internal_fpos__;
end;

export rthor_data400__wc_vehicle_make	:=
record
  string10 makecode;
  unsigned2 i;
end;

export dthor_data400__data__vehiclev2__wildcard_public			:= dataset([],rthor_data400__data__vehiclev2__wildcard_public);
export dthor_data400__key__vehiclev2__autokey__address 			:= dataset(lCSVFileNamePrefix + 'thor_data400__key__vehiclev2__' + lCSVVersion + '__autokey__address.csv', rthor_data400__key__vehiclev2__autokey__address, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__vehiclev2__autokey__addressb2 		:= dataset(lCSVFileNamePrefix + 'thor_data400__key__vehiclev2__' + lCSVVersion + '__autokey__addressb2.csv', rthor_data400__key__vehiclev2__autokey__addressb2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__vehiclev2__autokey__citystname 	:= dataset(lCSVFileNamePrefix + 'thor_data400__key__vehiclev2__' + lCSVVersion + '__autokey__citystname.csv', rthor_data400__key__vehiclev2__autokey__citystname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__vehiclev2__autokey__citystnameb2 := dataset(lCSVFileNamePrefix + 'thor_data400__key__vehiclev2__' + lCSVVersion + '__autokey__citystnameb2.csv', rthor_data400__key__vehiclev2__autokey__citystnameb2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__vehiclev2__autokey__fein2 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__vehiclev2__' + lCSVVersion + '__autokey__fein2.csv', rthor_data400__key__vehiclev2__autokey__fein2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__vehiclev2__autokey__name 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__vehiclev2__' + lCSVVersion + '__autokey__name.csv', rthor_data400__key__vehiclev2__autokey__name, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__vehiclev2__autokey__nameb2 			:= dataset(lCSVFileNamePrefix + 'thor_data400__key__vehiclev2__' + lCSVVersion + '__autokey__nameb2.csv', rthor_data400__key__vehiclev2__autokey__nameb2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__vehiclev2__autokey__namewords2 	:= dataset(lCSVFileNamePrefix + 'thor_data400__key__vehiclev2__' + lCSVVersion + '__autokey__namewords2.csv', rthor_data400__key__vehiclev2__autokey__namewords2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__vehiclev2__autokey__payload 			:= dataset(lCSVFileNamePrefix + 'thor_data400__key__vehiclev2__' + lCSVVersion + '__autokey__payload.csv', rthor_data400__key__vehiclev2__autokey__payload, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__vehiclev2__autokey__ssn2 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__vehiclev2__' + lCSVVersion + '__autokey__ssn2.csv', rthor_data400__key__vehiclev2__autokey__ssn2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__vehiclev2__autokey__stname				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__vehiclev2__' + lCSVVersion + '__autokey__stname.csv', rthor_data400__key__vehiclev2__autokey__stname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__vehiclev2__autokey__stnameb2 		:= dataset(lCSVFileNamePrefix + 'thor_data400__key__vehiclev2__' + lCSVVersion + '__autokey__stnameb2.csv', rthor_data400__key__vehiclev2__autokey__stnameb2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__vehiclev2__autokey__zip 					:= dataset(lCSVFileNamePrefix + 'thor_data400__key__vehiclev2__' + lCSVVersion + '__autokey__zip.csv', rthor_data400__key__vehiclev2__autokey__zip, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__vehiclev2__autokey__zipb2 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__vehiclev2__' + lCSVVersion + '__autokey__zipb2.csv', rthor_data400__key__vehiclev2__autokey__zipb2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__vehiclev2__bdid 									:= dataset(lCSVFileNamePrefix + 'thor_data400__key__vehiclev2__' + lCSVVersion + '__bdid.csv', rthor_data400__key__vehiclev2__bdid, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__vehiclev2__bocashell_did					:= dataset([],rthor_data400__key__vehiclev2__bocashell_did);
export dthor_data400__key__vehiclev2__did 									:= dataset(lCSVFileNamePrefix + 'thor_data400__key__vehiclev2__' + lCSVVersion + '__did.csv', rthor_data400__key__vehiclev2__did, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__vehiclev2__dl_number 						:= dataset(lCSVFileNamePrefix + 'thor_data400__key__vehiclev2__' + lCSVVersion + '__dl_number.csv', rthor_data400__key__vehiclev2__dl_number, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__vehiclev2__lic_plate 						:= dataset(lCSVFileNamePrefix + 'thor_data400__key__vehiclev2__' + lCSVVersion + '__lic_plate.csv', rthor_data400__key__vehiclev2__lic_plate, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__vehiclev2__lic_plate_blur				:= dataset([],rthor_data400__key__vehiclev2__lic_plate_blur);
export dthor_data400__key__vehiclev2__linkids								:= dataset([],rthor_data400__key__vehiclev2__linkids);
export dthor_data400__key__vehiclev2__main_key 							:= dataset(lCSVFileNamePrefix + 'thor_data400__key__vehiclev2__' + lCSVVersion + '__main_key.csv', rthor_data400__key__vehiclev2__main_key, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
//DF-17145. Add MDF search key
export dthor_data400__key__vehiclev2__mfd_srch 							:= dataset([], rthor_data400__key__vehiclev2__mfd_srch);
export dthor_data400__key__vehiclev2__party_key 						:= dataset(lCSVFileNamePrefix + 'thor_data400__key__vehiclev2__' + lCSVVersion + '__party_key.csv', rthor_data400__key__vehiclev2__party_key, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__vehiclev2__party_key_linkids			:= dataset([], rthor_data400__key__party_key_linkids);
export dthor_data400__key__vehiclev2__reverse_lic_plate 		:= dataset(lCSVFileNamePrefix + 'thor_data400__key__vehiclev2__' + lCSVVersion + '__reverse_lic_plate.csv', rthor_data400__key__vehiclev2__reverse_lic_plate, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__vehiclev2__source_rec_id			 		:= dataset([],rthor_data400__key__source_rec_id);
export dthor_data400__key__vehiclev2__title_number 					:= dataset(lCSVFileNamePrefix + 'thor_data400__key__vehiclev2__' + lCSVVersion + '__title_number.csv', rthor_data400__key__vehiclev2__title_number, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__vehiclev2__vehicles_address			:= dataset([],rthor_data400__key__vehiclev2__vehicles_address);
export dthor_data400__key__vehiclev2__vin 									:= dataset(lCSVFileNamePrefix + 'thor_data400__key__vehiclev2__' + lCSVVersion + '__vin.csv', rthor_data400__key__vehiclev2__vin, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__Vehiclev2__keymodelindex_public	:= dataset([],rthor_data400__key__vehiclev2__keymodelindex_public);
export dthor_data400__key__Vehiclev2__keynameindex_public		:= dataset([],rthor_data400__key__vehiclev2__keynameindex_public);
export dthor_data400__wc_vehicle_bodystyle									:= dataset([],rthor_data400__wc_vehicle_bodystyle);
export dthor_data400__wc_vehicle_make												:= dataset([],rthor_data400__wc_vehicle_make);
end;