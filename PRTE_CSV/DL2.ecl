export DL2 := 

module


	shared	lSubDirName					:=	'';
//	shared	lCSVVersion					:=	'20100713';
	shared	lCSVVersion					:=	'20120823';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;
	
export rthor_data400__data__dl2__wildcard	:=
record
	qstring24 dl_number;
  unsigned6 dl_seq;
  big_endian unsigned integer1 orig_state;
  big_endian unsigned integer1 years_since_1900;
  string1 gender;
end;
	
export rthor_data400__key__dl2__accident_dlcp_key	:=
record
	string14 dlcp_key;
	string8 process_date;
	string8 dt_first_seen;
	string8 dt_last_seen;
	string2 src_state;
	string2 type_cd;
	string50 type_desc;
	string2 county;
	string2 jurisdiction;
	string1 severity_cd;
	string35 severity_desc;
	string8 accident_date;
	string1 vehicle_no;
	string1 hazardous_cd;
	string50 hazardous_desc;
	string8 create_date;
	string10 bmv_case_nbr_1;
	string8 expunged_date;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__dl2__autokey__address	:=
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

export rthor_data400__key__dl2__autokey__citystname	:=
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

export rthor_data400__key__dl2__autokey__name	:=
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

export rthor_data400__key__dl2__autokey__payload	:=
record
	unsigned6 fakeid;
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
	qstring5 zip;
	string2 province;
	string3 country;
	string10 postal_code;
	unsigned4 dob;
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
	qstring14 dl_number;
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
	qstring20 fname;
	qstring20 mname;
	qstring20 lname;
	qstring5 name_suffix;
	qstring3 cleaning_score;
	string1 addr_fix_flag;
	qstring10 prim_range;
	qstring2 predir;
	qstring28 prim_name;
	qstring4 suffix;
	qstring2 postdir;
	qstring10 unit_desig;
	qstring8 sec_range;
	qstring25 p_city_name;
	qstring25 v_city_name;
	qstring2 st;
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
	qstring14 old_dl_number;
	qstring9 dl_key_number;
	string3 cdl_status;
	string1 record_type;
	unsigned1 zero;
	string1 blank;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__dl2__autokey__ssn2	:=
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

export rthor_data400__key__dl2__autokey__stname	:=
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

export rthor_data400__key__dl2__autokey__uberrefs	:=
record
  unsigned4 word_id;
  unsigned2 field;
  unsigned6 uid;
  unsigned8 __internal_fpos__;
end;

export rthor_data400__key__dl2__autokey__uberwords	:=
record
  string30 word;
  unsigned8 cnt;
  unsigned4 id;
  real8 field_specificity;
  unsigned8 __internal_fpos__;
end;

export rthor_data400__key__dl2__autokey__zip	:=
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

export rthor_data400__key__dl2__indicatives_public	:=
record
  string1 race;
  string1 sex_flag;
  unsigned1 age;
  string2 orig_state;
  unsigned8 randomizer;
  qstring24 dl_number;
  unsigned8 __internal_fpos__;
end;

export rthor_data400__key__dl2__conviction_dlcp_key	:=
record
	string14 dlcp_key;
	string8 process_date;
	string8 dt_first_seen;
	string8 dt_last_seen;
	string2 src_state;
	string4 type_cd;
	string50 type_desc;
	string8 violation_date;
	string8 plate_nbr;
	string8 conviction_date;
	string9 court_name_cd;
	string50 court_name_desc;
	string6 court_county;
	string10 court_type_cd;
	string45 court_type_desc;
	string4 st_offense_conv_cd;
	string60 st_offense_conv_desc;
	string1 sentence;
	string50 sentence_desc;
	string2 points;
	string1 hazardous_cd;
	string50 hazardous_desc;
	string1 plea_cd;
	string10 plea_desc;
	string16 court_case_nbr;
	string4 acd_offense_cd;
	string250 acd_offense_desc;
	string1 vehicle_no;
	string3 reduced_cd;
	string30 reduced_desc;
	string8 create_date;
	string10 bmv_case_nbr_1;
	string10 bmv_case_nbr_2;
	string10 bmv_case_nbr_3;
	string10 habitual_case_nbr;
	string8 filed_date;
	string8 expunged_date;
	string2 jurisdiction;
	string8 soa_conviction;
	string10 bmv_sp_case_nbr;
	string25 out_of_state_dl_nbr;
	string2 state_of_origin;
	string20 county;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__dl2__did_public	:=
record
	unsigned6 did;
	unsigned6 dl_seq;
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
	qstring5 zip;
	string2 province;
	string3 country;
	string10 postal_code;
	unsigned4 dob;
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
	qstring14 dl_number;
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
	qstring20 fname;
	qstring20 mname;
	qstring20 lname;
	qstring5 name_suffix;
	qstring3 cleaning_score;
	string1 addr_fix_flag;
	qstring10 prim_range;
	qstring2 predir;
	qstring28 prim_name;
	qstring4 suffix;
	qstring2 postdir;
	qstring10 unit_desig;
	qstring8 sec_range;
	qstring25 p_city_name;
	qstring25 v_city_name;
	qstring2 st;
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
	qstring14 old_dl_number;
	qstring9 dl_key_number;
	string3 cdl_status;
	string1 record_type;
	string18 county_name;
	string30 history_name;
	string30 attention_name;
	string30 race_name;
	string30 sex_name;
	string30 hair_color_name;
	string30 eye_color_name;
	string30 orig_state_name;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__dl2__dl_number_public	:=
record
	qstring14 s_dl;
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
	qstring5 zip;
	string2 province;
	string3 country;
	string10 postal_code;
	unsigned4 dob;
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
	qstring14 dl_number;
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
	qstring20 fname;
	qstring20 mname;
	qstring20 lname;
	qstring5 name_suffix;
	qstring3 cleaning_score;
	string1 addr_fix_flag;
	qstring10 prim_range;
	qstring2 predir;
	qstring28 prim_name;
	qstring4 suffix;
	qstring2 postdir;
	qstring10 unit_desig;
	qstring8 sec_range;
	qstring25 p_city_name;
	qstring25 v_city_name;
	qstring2 st;
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
	qstring14 old_dl_number;
	qstring9 dl_key_number;
	string3 cdl_status;
	string1 record_type;
	string18 county_name;
	string30 history_name;
	string30 attention_name;
	string30 race_name;
	string30 sex_name;
	string30 hair_color_name;
	string30 eye_color_name;
	string30 orig_state_name;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__dl2__dl_seq	:=
record
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
	qstring5 zip;
	string2 province;
	string3 country;
	string10 postal_code;
	unsigned4 dob;
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
	qstring14 dl_number;
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
	qstring20 fname;
	qstring20 mname;
	qstring20 lname;
	qstring5 name_suffix;
	qstring3 cleaning_score;
	string1 addr_fix_flag;
	qstring10 prim_range;
	qstring2 predir;
	qstring28 prim_name;
	qstring4 suffix;
	qstring2 postdir;
	qstring10 unit_desig;
	qstring8 sec_range;
	qstring25 p_city_name;
	qstring25 v_city_name;
	qstring2 st;
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
	qstring14 old_dl_number;
	qstring9 dl_key_number;
	string3 cdl_status;
	string1 record_type;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__dl2__dr_info_dlcp_key	:=
record
	string14 dlcp_key;
	string8 process_date;
	string8 dt_first_seen;
	string8 dt_last_seen;
	string2 src_state;
	string4 type_cd;
	string50 type_desc;
	string8 action_date;
	string10 bmv_case_nbr_1;
	string8 clear_date;
	string10 cosigners_dl_nbr;
	string35 cosigners_name;
	string8 cosigners_relationship;
	string16 court_case_nbr;
	string8 create_date;
	string8 dl_nbr;
	string8 expunged_date;
	string8 mailed_date;
	string150 narrative;
	string25 out_of_state_dl_nbr;
	string8 remedial_require_comp;
	string8 remedial_require_denied;
	string8 warrant_eff_date;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__dl2__fra_insur_dlcp_key	:=
record
	string14 dlcp_key;
	string8 process_date;
	string8 dt_first_seen;
	string8 dt_last_seen;
	string2 src_state;
	string8 cancel_posted_date;
	string8 create_date;
	string8 filed_date;
	string8 ins_cancel_dt;
	string16 ins_policy_nbr;
	string3 insurance_co_cd;
	string40 insurance_co_desc;
	string8 latest_proof_start_dt;
	string8 proof_start_date;
	string8 proof_end_date;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__dl2__suspension_dlcp_key	:=
record
	string14 dlcp_key;
	string8 process_date;
	string8 dt_first_seen;
	string8 dt_last_seen;
	string2 src_state;
	string4 type_cd;
	string50 type_desc;
	string8 violation_date;
	string8 clear_date;
	string8 filed_date;
	string8 action_date;
	string8 start_date;
	string8 end_date;
	string10 bmv_case_nbr_1;
	string16 court_case_nbr;
	string6 court_name_cd;
	string50 court_name_desc;
	string15 court_county;
	string20 court_type;
	string3 st_offense_conv_cd;
	string100 st_offense_conv_desc;
	string1 vehicle_no_cd;
	string30 vehicle_no_desc;
	string1 hazardous_cd;
	string50 hazardous_desc;
	string2 jurisdiction;
	string8 fee_pd_date;
	string8 plate_nbr;
	string3 cdl_disq_reason_cd;
	string50 cdl_disq_reason_desc;
	string3 cdl_ofs_disqual_reason_cd;
	string30 cdl_ofs_disqual_reason_desc;
	string1 disq_ext_cd;
	string20 disq_ext_desc;
	string8 disq_reason_ref;
	string20 disq_reason_desc;
	string6 sd_nbr;
	string1 wd_clear_reason_cd;
	string35 wd_clear_reason_desc;
	string5 naic_ins_cd;
	string30 naic_ins_desc;
	string1 ins_bnd_filing_ind;
	string8 cleared_date;
	string4 wd_reason_cd;
	string40 wd_reason_desc;
	string8 remedial_drv_crs_dt;
	string8 exam_date;
	string3 acd_offense_cd;
	string250 acd_offense_desc;
	string1 wd_status_cd;
	string20 wd_status_desc;
	string8 mod_drv_date;
	string8 settle_agree_date;
	string2 restriction_cd;
	string20 restriction_desc;
	string8 conviction_date;
	string8 appeal_file_date;
	string8 appeal_deny_date;
	string8 appeal_granted_date;
	string1 plea_cd;
	string10 plea_desc;
	string1 suspension_revocation;
	string2 county_cd;
	string25 county_desc;
	string8 arrest_date;
	string8 license_number;
	string8 create_date;
	string8 license_rec_date;
	string8 plate_rec_date;
	string8 fra_sup_start_date;
	string8 fra_sup_end_date;
	string8 accident_date;
	string10 related_bmv_case_nbr;
	string1 narrative_cd;
	string30 narrative_desc;
	string1 fee_required;
	string1 vehicle_owner_ind;
	string8 soa_conviction;
	string8 expunged_date;
	string8 modified_drv_end_dt;
	string1 appeal_sup_stay;
	string3 wd_type_detail;
	string1 hp_license_cancel;
	string10 bmv_dl_case_nbr;
	string10 related_bmv_case_nbr_2;
	string8 fine_paid_date;
	string4 csea;
	string10 csea_case_nbr;
	string17 csea_order_nbr;
	string12 csea_part_nbr;
	unsigned8 __internal_fpos__;
end;

export dthor_data400__data__dl2__wildcard					  		:= dataset([],rthor_data400__data__dl2__wildcard);
export dthor_data400__key__dl2__accident_dlcp_key 			:= dataset(lCSVFileNamePrefix + 'thor_data400__key__dl2____accident_dlcp_key.csv', rthor_data400__key__dl2__accident_dlcp_key, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__dl2__autokey__address 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__dl2____autokey__address.csv', rthor_data400__key__dl2__autokey__address, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__dl2__autokey__citystname 		:= dataset(lCSVFileNamePrefix + 'thor_data400__key__dl2____autokey__citystname.csv', rthor_data400__key__dl2__autokey__citystname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__dl2__autokey__name 					:= dataset(lCSVFileNamePrefix + 'thor_data400__key__dl2____autokey__name.csv', rthor_data400__key__dl2__autokey__name, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__dl2__autokey__payload 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__dl2____autokey__payload.csv', rthor_data400__key__dl2__autokey__payload, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__dl2__autokey__ssn2 					:= dataset(lCSVFileNamePrefix + 'thor_data400__key__dl2____autokey__ssn2.csv', rthor_data400__key__dl2__autokey__ssn2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__dl2__autokey__stname 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__dl2____autokey__stname.csv', rthor_data400__key__dl2__autokey__stname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__dl2__autokey__uberrefs 			:= dataset(lCSVFileNamePrefix + 'thor_data400__key__dl2____autokey__uberrefs.csv', rthor_data400__key__dl2__autokey__uberrefs, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__dl2__autokey__uberwords			:= dataset([], rthor_data400__key__dl2__autokey__uberwords);
export dthor_data400__key__dl2__autokey__zip 						:= dataset(lCSVFileNamePrefix + 'thor_data400__key__dl2____autokey__zip.csv', rthor_data400__key__dl2__autokey__zip, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__dl2__conviction_dlcp_key 		:= dataset([], rthor_data400__key__dl2__conviction_dlcp_key);
export dthor_data400__key__dl2__did_public 							:= dataset(lCSVFileNamePrefix + 'thor_data400__key__dl2____did_public.csv', rthor_data400__key__dl2__did_public, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__dl2__dl_number_public 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__dl2____dl_number_public.csv', rthor_data400__key__dl2__dl_number_public, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__dl2__dl_seq 									:= dataset(lCSVFileNamePrefix + 'thor_data400__key__dl2____dl_seq.csv', rthor_data400__key__dl2__dl_seq, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__dl2__dr_info_dlcp_key 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__dl2____dr_info_dlcp_key.csv', rthor_data400__key__dl2__dr_info_dlcp_key, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__dl2__fra_insur_dlcp_key 			:= dataset(lCSVFileNamePrefix + 'thor_data400__key__dl2____fra_insur_dlcp_key.csv', rthor_data400__key__dl2__fra_insur_dlcp_key, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__dl2__indicatives_public 		  := dataset([], rthor_data400__key__dl2__indicatives_public);
export dthor_data400__key__dl2__suspension_dlcp_key 		:= dataset(lCSVFileNamePrefix + 'thor_data400__key__dl2____suspension_dlcp_key.csv', rthor_data400__key__dl2__suspension_dlcp_key, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
end;