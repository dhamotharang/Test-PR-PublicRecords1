export Appriss := 

module

	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'20110929';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;
          
export rthor_data400__key__appriss__autokey__address :=

RECORD
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
 END;

export rthor_data400__key__appriss__autokey__citystname :=

RECORD
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
 END;


export rthor_data400__key__appriss__autokey__name :=

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
 END;

export rthor_data400__key__appriss__autokey__payload :=

RECORD
  unsigned6 fakeid;
  string15 booking_sid;
  string10 prim_range;
  string28 prim_name;
  string8 sec_range;
  string25 p_city_name;
  string2 state;
  string5 zip5;
  string20 fname;
  string20 mname;
  string20 lname;
  string9 ssn;
  string8 date_of_birth;
  unsigned8 did;
  string25 home_phone;
  string30 work_phone;
  unsigned1 zero;
  string1 blank;
  unsigned8 __internal_fpos__;
 END;

export rthor_data400__key__appriss__autokey__phone2 :=

RECORD
  string7 p7;
  string3 p3;
  string6 dph_lname;
  string20 pfname;
  string2 st;
  unsigned6 did;
  unsigned4 lookups;
 END;

export rthor_data400__key__appriss__autokey__ssn2 :=

RECORD
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
 END;

export rthor_data400__key__appriss__autokey__stname :=

RECORD
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
 END;

export rthor_data400__key__appriss__autokey__zip :=

RECORD
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
 END;

export rthor_data400__key__appriss__autokey__agencystatecd :=

RECORD
  string20 agency_ori;
  string2 state_cd;
  string15 booking_sid;
  unsigned8 __internal_fpos__;
 END;

export rthor_data400__key__appriss__autokey__ap_ssn :=
record
{ string11 ap_ssn, string15 booking_sid, unsigned8 __internal_fpos__ };

END;

export rthor_data400__key__appriss__autokey__bookings_id :=
RECORD
 ,maxLength(28000)
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
  string11 ap_ssn;
  string15 ap_ssn_dash;
  string50 ap_lname;
  string50 ap_fname;
  string50 ap_mname;
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


export rthor_data400__key__appriss__autokey__charges_id :=

RECORD
,maxLength(2000)
  string15 booking_sid;
  integer8 charge_seq;
  string20 creation_ts;
  string20 last_change_ts;
  string30 maxqueuesid;
  string15 agencykey;
  string20 agencyori;
  string10 doctype;
  string5 site_id;
  string5 agency;
  string5 charge_cnt;
  string50 charge;
  string100 description;
  string10 charge_dt;
  string10 court_dt;
  string5 key_severity;
  string15 bond_amt;
  string20 disposition_dt;
  string100 disposition_text;
  string35 ncic_offense_class_txt;
  string20 ncic_offense_cd;
  string50 bond_type_txt;
  unsigned8 __internal_fpos__;
 END;

export rthor_data400__key__appriss__autokey__demographic :=

RECORD
  string1 key_gender;
  string3 key_race;
  unsigned4 date_of_birth;
  unsigned2 key_hgt;
  unsigned2 key_wgt;
  string5 key_hair;
  string5 key_eye;
  string15 booking_sid;
  unsigned8 __internal_fpos__;
 END;

export rthor_data400__key__appriss__autokey__did :=
RECORD
{ unsigned6 did, string15 booking_sid, unsigned8 __internal_fpos__ };

END;

export rthor_data400__key__appriss__autokey__dl :=
RECORD
{ string25 dlnumber, string15 booking_sid, unsigned8 __internal_fpos__ };

END;

export rthor_data400__key__appriss__autokey__fbi :=
RECORD
{ string25 fbi_nbr, string15 booking_sid, unsigned8 __internal_fpos__ };

END;

export rthor_data400__key__appriss__autokey__gang :=
RECORD
{ string25 gang, string15 booking_sid, unsigned8 __internal_fpos__ };

END;

export rthor_data400__key__appriss__autokey__state_id :=
RECORD
{ string25 state_id, string15 booking_sid, unsigned8 __internal_fpos__ };
END;


export dthor_data400__key__appriss__autokey__address 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__appriss__' + lCSVVersion + '__autokey__address.csv', rthor_data400__key__appriss__autokey__address, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__appriss__autokey__citystname 		:= dataset(lCSVFileNamePrefix + 'thor_data400__key__appriss__' + lCSVVersion + '__autokey__citystname.csv', rthor_data400__key__appriss__autokey__citystname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__appriss__autokey__name 			  	:= dataset(lCSVFileNamePrefix + 'thor_data400__key__appriss__' + lCSVVersion + '__autokey__name.csv', rthor_data400__key__appriss__autokey__name, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__appriss__autokey__payload 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__appriss__' + lCSVVersion + '__autokey__payload.csv', rthor_data400__key__appriss__autokey__payload, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__appriss__autokey__phone2 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__appriss__' + lCSVVersion + '__autokey__phone2.csv', rthor_data400__key__appriss__autokey__phone2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__appriss__autokey__ssn2 				  := dataset(lCSVFileNamePrefix + 'thor_data400__key__appriss__' + lCSVVersion + '__autokey__ssn2.csv', rthor_data400__key__appriss__autokey__ssn2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__appriss__autokey__stname 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__appriss__' + lCSVVersion + '__autokey__stname.csv', rthor_data400__key__appriss__autokey__stname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__appriss__autokey__zip 				    := dataset(lCSVFileNamePrefix + 'thor_data400__key__appriss__' + lCSVVersion + '__autokey__zip.csv', rthor_data400__key__appriss__autokey__zip, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__appriss__autokey__agencystatecd 	:= dataset(lCSVFileNamePrefix + 'thor_data400__key__appriss__' + lCSVVersion + '__autokey__agencystatecd.csv', rthor_data400__key__appriss__autokey__agencystatecd, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__appriss__autokey__ap_ssn 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__appriss__' + lCSVVersion + '__autokey__ap_ssn.csv', rthor_data400__key__appriss__autokey__ap_ssn, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__appriss__autokey__bookings_id 		:= dataset(lCSVFileNamePrefix + 'thor_data400__key__appriss__' + lCSVVersion + '__autokey__bookings_id.csv', rthor_data400__key__appriss__autokey__bookings_id, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__appriss__autokey__charges_id 		:= dataset(lCSVFileNamePrefix + 'thor_data400__key__appriss__' + lCSVVersion + '__autokey__charges_id.csv', rthor_data400__key__appriss__autokey__charges_id, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__appriss__autokey__demographic 		:= dataset(lCSVFileNamePrefix + 'thor_data400__key__appriss__' + lCSVVersion + '__autokey__demographic.csv', rthor_data400__key__appriss__autokey__demographic, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__appriss__autokey__did 				    := dataset(lCSVFileNamePrefix + 'thor_data400__key__appriss__' + lCSVVersion + '__autokey__did.csv', rthor_data400__key__appriss__autokey__did, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__appriss__autokey__dl 				    := dataset(lCSVFileNamePrefix + 'thor_data400__key__appriss__' + lCSVVersion + '__autokey__dl.csv', rthor_data400__key__appriss__autokey__dl, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__appriss__autokey__fbi 				    := dataset(lCSVFileNamePrefix + 'thor_data400__key__appriss__' + lCSVVersion + '__autokey__fbi.csv', rthor_data400__key__appriss__autokey__fbi, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__appriss__autokey__gang 				  := dataset(lCSVFileNamePrefix + 'thor_data400__key__appriss__' + lCSVVersion + '__autokey__gang.csv', rthor_data400__key__appriss__autokey__gang, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__appriss__autokey__state_id 			:= dataset(lCSVFileNamePrefix + 'thor_data400__key__appriss__' + lCSVVersion + '__autokey__state_id.csv', rthor_data400__key__appriss__autokey__state_id, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
end;


