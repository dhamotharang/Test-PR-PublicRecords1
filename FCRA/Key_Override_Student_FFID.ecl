import fcra, data_services;

string_rec := record
 string32 key;
 string9 ssn;
 string24 did;
 string8 process_date;
 string8 date_first_seen;
 string8 date_last_seen;
 string8 date_vendor_first_reported;
 string8 date_vendor_last_reported;
 string40 full_name;
 string20 first_name;
 string20 last_name;
 string30 address_1;
 string30 address_2;
 string16 city;
 string2 state;
 string5 zip;
 string4 zip_4;
 string4 crrt_code;
 string2 delivery_point_barcode;
 string1 zip4_check_digit;
 string1 address_type_code;
 string30 address_type;
 string3 county_number;
 string9 county_name;
 string1 gender_code;
 string6 gender;
 string2 age;
 string6 birth_date;
 string8 dob_formatted;
 string10 telephone;
 string2 class;
 string2 college_class;
 string14 college_name;
 string1 college_code;
 string20 college_code_exploded;
 string1 college_type;
 string25 college_type_exploded;
 string11 head_of_household_first_name;
 string1 head_of_household_gender_code;
 string6 head_of_household_gender;
 string1 income_level_code;
 string20 income_level;
 string1 file_type;
 string5 title;
 string20 fname;
 string20 mname;
 string20 lname;
 string5 name_suffix;
 string3 name_score;
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
 string5 z5;
 string4 zip4;
 string4 cart;
 string1 cr_sort_sz;
 string4 lot;
 string1 lot_order;
 string2 dpbc;
 string1 chk_digit;
 string2 rec_type;
 string2 ace_fips_st;
 string3 fips_county;
 string10 geo_lat;
 string11 geo_long;
 string4 msa;
 string7 geo_blk;
 string1 geo_match;
 string4 err_stat;
 string20 flag_file_id;
end;
ds := dataset('~thor_data400::base::override::fcra::qa::american_student',string_rec,flat);

fcra.layout_override_student proj_recs(ds l) := transform
	self.key := (integer8)l.key;
	self.did := (unsigned6)l.did;
	self.college_major := '';
	self := l;
end;

kf := project(ds,proj_recs(left));

export Key_Override_Student_FFID := index(kf,
                                          {flag_file_id}, 
                                          {kf},
                                          data_services.data_location.prefix() + 'thor_data400::key::override::fcra::student::qa::ffid');