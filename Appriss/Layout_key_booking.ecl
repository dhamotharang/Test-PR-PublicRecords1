export Layout_key_booking := RECORD ,maxLength(28000)
  string15 booking_sid;
  string10 action;
  string15 primarykey;
  string15 agencykey;
  string30 maxqueuesid;
  string25 delete_info;
  string10 site_id;
  string5 agency;
  string2 state_cd;
  string50 booking_nbr;
  string30 inmate_nbr;
  string30 state_id;
  string30 oid;
  string20 creation_ts;
  string10 last_change_session_sid;
  string10 last_change_file_nbr;
  string20 last_change_ts;
	//ap - Appriss supplied fields
  string11 ap_ssn;
  string15 ap_ssn_dash;
  string50 ap_lname;
  string50 ap_fname;
  string50 ap_mname;
	//---------------------------
  string8 arrest_date;
  string25 arrest_ts;
  string20 booking_ts_raw;
  string8 booking_date;
  string25 booking_ts;
  string8 release_date;
  string25 release_ts;
  string8 date_of_birth;
  string20 dob;
  string15 race;
  string15 gender;
  string15 hgt;
  string15 wgt;
  string15 hair;
  string15 eye;
  string10 handed;
  string12 mstatus;
  string1 released_ind;
  string1 incident_ind;
  string1 juvenile_ind;
  string50 rreason;
  string5 custody_status_cd;
  string3 key_race;
  string10 key_gender;
  string3 key_hgt;
  string2 hgt_cd;
  string3 key_wgt;
  string2 wgt_cd;
  string5 key_hair;
  string5 key_eye;
  string7 key_mstatus;
  string3 key_handed;
  string70 ap_address1;
  string50 ap_address2;
  string50 ap_city;
  string35 ap_state;
  string10 ap_zipcode;
  string10 complex;
  string25 dlnumber;
  string25 dlstate;
  string35 pob;
  string1 citizen_ind;
  string1 weekender_ind;
  string1 correct_lenses_ind;
  string180 marks_scars_tatoos;
  string170 other_phy_features;
  string150 warnings_cautions;
  string85 front_image;
  string85 profile_image;
  string25 home_phone;
  string30 employer;
  string25 work_phone;
  string35 occupation;
  string25 language_spoken;
  string25 language_read;
  string25 language_written;
  string25 blood_type;
  string40 medical_alert;
  string1 violent_behavior_ind;
  string1 suicide_risk_ind;
  string1 escape_risk_ind;
  string1 foreign_born_ind;
  string1 sex_offender_ind;
  string1 mental_illness_ind;
  string25 gang;
  string10 military;
  string2 parole_class;
  string25 fbi_nbr;
  string28 education_yrs;
  string100 ap_full_name;
  string55 agency_description;
  string20 agency_ori;
  string1 dep_no_suppress_web_display_ind;
  string1 dep_no_suppress_inquiry_ind;
  string15 ethnicity_cd;
  string50 key_ethnicity_cd;
  string20 ap_name_suffix;
  string15 nationality;
  string8 offense_date;
  string20 offense_ts;
  string8 scheduled_release_date;
  string8 sentence_exp_date;
  string195 scar;
  string100 mark;
  string100 tattoo;
  string1 facial_hair_ind;
  string1 hearing_problem_ind;
  string20 religion;
  string20 passport_visa_nbr;
  string15 ins_reg_nbr;
  string5 holding_facility;
  string10 complexion;
  string10 dlclass_txt;
  string10 residency_status_txt;
  string5 primary_language_txt;
  string1 english_understood_ind;
  string1 dna_sample_taken_ind;
  string20 afis_id;
  string20 arresting_ori_nbr;
  string70 arresting_agency_name;
  string15 arresting_agency_phone;
  string100 holding_facility_desc;
  string20 holding_facility_ori;
  string15 subject_search_sid;
  string15 subject_person_sid;
  string15 subject_group_sid;
  string5 group_rule_version;
  string5 key_complex;
  string1 display_extra_images_ind;
  string7 days_incarcerated;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string25 v_city_name;
  string2 state;
  string5 zip5;
  string4 zip4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dpbc;
  string1 chk_digit;
  string2 rec_type;
  string2 ace_fips_st;
  string3 ace_fips_county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 name_score;
  string9 ssn;
  unsigned8 did;
END;
