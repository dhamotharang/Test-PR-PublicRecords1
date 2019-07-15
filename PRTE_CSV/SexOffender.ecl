export SexOffender := 

module

	shared	lSubDirName			:=	'';
	shared	lCSVVersion			:=	'';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;
	
	shared	lSubDirName1		:=	'';
	shared	lCSVVersion1		:=	'';
	shared	lCSVFileNamePrefix1	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;
	
	
export rthor_data400__key__sexoffender__autokey__address	:=
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

export rthor_data400__key__sexoffender__autokey__citystname	:=
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

export rthor_data400__key__sexoffender__autokey__latlong	:=
	record
		integer4 lat;
		integer4 long;
		string6 dph_lname;
		string20 lname;
		string20 pfname;
		string20 fname;
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

export rthor_data400__key__sexoffender__autokey__name	:=
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

export rthor_data400__key__sexoffender__autokey__payload	:=
	record
		unsigned6 fakeid;
		string60 seisint_primary_key;
		unsigned8 did;
		string9 ssn;
		string30 lname;
		string30 fname;
		string20 mname;
		string8 dob;
		string10 prim_range;
		string28 prim_name;
		string8 sec_range;
		string25 city_name;
		string2 st;
		string2 orig_state_code;
		string5 zip5;
		qstring10 geo_lat;
		qstring11 geo_long;
		qstring1 geo_match;
		unsigned1 zero;
		string1 blank;
		unsigned8 __internal_fpos__;
	end;

export rthor_data400__key__sexoffender__autokey__ssn2	:=
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

export rthor_data400__key__sexoffender__autokey__stname	:=
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

export rthor_data400__key__sexoffender__autokey__zip	:=
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

export rthor_data400__key__sexoffender__didpublic	:=
	record
		unsigned8 did;
		string60 seisint_primary_key;
		real8 lat;
		real8 long;
		unsigned8 __internal_fpos__;
	end;

export rthor_data400__key__sexoffender__enhpublic	:=
	record
		string60 sspk;
		string60 seisint_primary_key;
		string1 alt_type;
		string10 alt_prim_range;
		string2 alt_predir;
		string28 alt_prim_name;
		string4 alt_suffix;
		string2 alt_postdir;
		string10 alt_unit_desig;
		string8 alt_sec_range;
		string25 alt_city_name;
		string2 alt_st;
		string5 alt_zip;
		string4 alt_zip4;
		unsigned3 alt_addr_dt_first_seen;
		unsigned3 alt_addr_dt_last_seen;
		unsigned1 alt_glb;
		unsigned1 alt_dppa;
		string2 src;
		boolean ismismatched;
		unsigned8 __internal_fpos__;
	end;

export rthor_data400__key__sexoffender__enhpublicaddress	:=
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

export rthor_data400__key__sexoffender__enhpubliccitystname	:=
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

export rthor_data400__key__sexoffender__enhpublicname	:=
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

export rthor_data400__key__sexoffender__enhpublicphone	:=
	record
		string7 p7;
		string3 p3;
		string6 dph_lname;
		string20 pfname;
		string2 st;
		unsigned6 did;
	end;

export rthor_data400__key__sexoffender__enhpublicssn	:=
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
	end;

export rthor_data400__key__sexoffender__enhpublicstname	:=
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

export rthor_data400__key__sexoffender__enhpubliczip	:=
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

export rthor_data400__key__sexoffender__fdid_public	:=
	record
		unsigned6 did;
		string60 seisint_primary_key;
		real8 lat;
		real8 long;
		unsigned8 __internal_fpos__;
	end;

export rthor_data400__key__sexoffender__offenses_public	:=
	record
	,maxLength(200000)
		string60 sspk;
		string60 seisint_primary_key;
		string80 conviction_jurisdiction;
		string8 conviction_date;
		string30 court;
		string25 court_case_number;
		string8 offense_date;
		string20 offense_code_or_statute;
		string320 offense_description;
		string180 offense_description_2;
		unsigned8 offense_category;
		string1 victim_minor;
		string3 victim_age;
		string10 victim_gender;
		string30 victim_relationship;
		string180 sentence_description;
		string180 sentence_description_2;
		string8 arrest_date;
		string250 arrest_warrant;
		string1 fcra_conviction_flag;
		string1 fcra_traffic_flag;
		string8 fcra_date;
		string1 fcra_date_type;
		string8 conviction_override_date;
		string1 conviction_override_date_type;
		string2 offense_score;
		unsigned8 offense_persistent_id;
		unsigned8 __internal_fpos__;
	end;

export rthor_data400__key__sexoffender__publicaddress	:=
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

export rthor_data400__key__sexoffender__publiccitystname	:=
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

export rthor_data400__key__sexoffender__publicname	:=
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

export rthor_data400__key__sexoffender__publicphone	:=
	record
		string7 p7;
		string3 p3;
		string6 dph_lname;
		string20 pfname;
		string2 st;
		unsigned6 did;
	end;

export rthor_data400__key__sexoffender__publicssn	:=
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
	end;

export rthor_data400__key__sexoffender__publicstname	:=
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

export rthor_data400__key__sexoffender__publiczip	:=
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

	export rthor_data400__key__sexoffender__spkpublic	:=
	record
		string60 sspk;
		unsigned8 did;
		unsigned1 score;
		string9 ssn_appended;
		unsigned1 ssn_perms;
		string8 dt_first_reported;
		string8 dt_last_reported;
		string30 orig_state;
		string2 orig_state_code;
		string60 seisint_primary_key;
		string2 vendor_code;
		string20 source_file;
		string2 record_type;
		string50 name_orig;
		string30 lname;
		string30 fname;
		string20 mname;
		string20 name_suffix;
		string1 name_type;
		unsigned8 nid;
		string1 ntype;
		unsigned2 nindicator;
		string320 intnet_email_address_1;
		string320 intnet_email_address_2;
		string320 intnet_email_address_3;
		string320 intnet_email_address_4;
		string320 intnet_email_address_5;
		string320 intnet_instant_message_addr_1;
		string320 intnet_instant_message_addr_2;
		string320 intnet_instant_message_addr_3;
		string320 intnet_instant_message_addr_4;
		string320 intnet_instant_message_addr_5;
		string320 intnet_user_name_1;
		string255 intnet_user_name_1_url;
		string320 intnet_user_name_2;
		string255 intnet_user_name_2_url;
		string320 intnet_user_name_3;
		string255 intnet_user_name_3_url;
		string320 intnet_user_name_4;
		string255 intnet_user_name_4_url;
		string320 intnet_user_name_5;
		string255 intnet_user_name_5_url;
		string50 offender_status;
		string40 offender_category;
		string10 risk_level_code;
		string50 risk_description;
		string50 police_agency;
		string35 police_agency_contact_name;
		string55 police_agency_address_1;
		string35 police_agency_address_2;
		string10 police_agency_phone;
		string25 registration_type;
		string8 reg_date_1;
		string28 reg_date_1_type;
		string8 reg_date_2;
		string28 reg_date_2_type;
		string8 reg_date_3;
		string28 reg_date_3_type;
		string125 registration_address_1;
		string45 registration_address_2;
		string35 registration_address_3;
		string35 registration_address_4;
		string35 registration_address_5;
		string35 registration_county;
		string10 registration_home_phone;
		string10 registration_cell_phone;
		string125 other_registration_address_1;
		string45 other_registration_address_2;
		string35 other_registration_address_3;
		string35 other_registration_address_4;
		string35 other_registration_address_5;
		string35 other_registration_county;
		string10 other_registration_phone;
		string125 temp_lodge_address_1;
		string45 temp_lodge_address_2;
		string35 temp_lodge_address_3;
		string35 temp_lodge_address_4;
		string35 temp_lodge_address_5;
		string35 temp_lodge_county;
		string10 temp_lodge_phone;
		string55 employer;
		string55 employer_address_1;
		string35 employer_address_2;
		string35 employer_address_3;
		string35 employer_address_4;
		string35 employer_address_5;
		string35 employer_county;
		string10 employer_phone;
		string140 employer_comments;
		string75 professional_licenses_1;
		string75 professional_licenses_2;
		string75 professional_licenses_3;
		string75 professional_licenses_4;
		string75 professional_licenses_5;
		string55 school;
		string55 school_address_1;
		string35 school_address_2;
		string35 school_address_3;
		string35 school_address_4;
		string35 school_address_5;
		string35 school_county;
		string10 school_phone;
		string140 school_comments;
		string30 offender_id;
		string30 doc_number;
		string40 sor_number;
		string30 st_id_number;
		string30 fbi_number;
		string30 ncic_number;
		string9 ssn;
		string8 dob;
		string8 dob_aka;
		string3 age;
		string250 dna;
		string30 race;
		string30 ethnicity;
		string10 sex;
		string40 hair_color;
		string40 eye_color;
		string3 height;
		string3 weight;
		string20 skin_tone;
		string30 build_type;
		string200 scars_marks_tattoos;
		string6 shoe_size;
		string1 corrective_lense_flag;
		string140 addl_comments_1;
		string140 addl_comments_2;
		string30 orig_dl_number;
		string2 orig_dl_state;
		string150 orig_dl_link;
		string8 orig_dl_date;
		string1 passport_type;
		string10 passport_code;
		string25 passport_number;
		string50 passport_first_name;
		string100 passport_given_name;
		string30 passport_nationality;
		string8 passport_dob;
		string55 passport_place_of_birth;
		string10 passport_sex;
		string8 passport_issue_date;
		string55 passport_authority;
		string8 passport_expiration_date;
		string50 passport_endorsement;
		string150 passport_link;
		string8 passport_date;
		string4 orig_veh_year_1;
		string40 orig_veh_color_1;
		string40 orig_veh_make_model_1;
		string40 orig_veh_plate_1;
		string17 orig_registration_number_1;
		string2 orig_veh_state_1;
		string50 orig_veh_location_1;
		string4 orig_veh_year_2;
		string40 orig_veh_color_2;
		string40 orig_veh_make_model_2;
		string40 orig_veh_plate_2;
		string17 orig_registration_number_2;
		string2 orig_veh_state_2;
		string50 orig_veh_location_2;
		string4 orig_veh_year_3;
		string40 orig_veh_color_3;
		string40 orig_veh_make_model_3;
		string40 orig_veh_plate_3;
		string17 orig_registration_number_3;
		string2 orig_veh_state_3;
		string50 orig_veh_location_3;
		string4 orig_veh_year_4;
		string40 orig_veh_color_4;
		string40 orig_veh_make_model_4;
		string40 orig_veh_plate_4;
		string17 orig_registration_number_4;
		string2 orig_veh_state_4;
		string50 orig_veh_location_4;
		string4 orig_veh_year_5;
		string40 orig_veh_color_5;
		string40 orig_veh_make_model_5;
		string40 orig_veh_plate_5;
		string17 orig_registration_number_5;
		string2 orig_veh_state_5;
		string50 orig_veh_location_5;
		string150 fingerprint_link;
		string8 fingerprint_date;
		string150 palmprint_link;
		string8 palmprint_date;
		string150 image_link;
		string8 image_date;
		string6 addr_dt_last_seen;
		qstring10 prim_range;
		string2 predir;
		qstring28 prim_name;
		qstring4 addr_suffix;
		string2 postdir;
		qstring10 unit_desig;
		qstring8 sec_range;
		qstring25 p_city_name;
		qstring25 v_city_name;
		string2 st;
		qstring5 zip5;
		qstring4 zip4;
		qstring4 cart;
		string1 cr_sort_sz;
		qstring4 lot;
		string1 lot_order;
		string2 dbpc;
		string1 chk_digit;
		string2 rec_type;
		qstring5 county;
		qstring10 geo_lat;
		qstring11 geo_long;
		qstring4 msa;
		qstring7 geo_blk;
		string1 geo_match;
		qstring4 err_stat;
		unsigned1 clean_errors;
		unsigned8 rawaid;
		string1 curr_incar_flag;
		string1 curr_parole_flag;
		string1 curr_probation_flag;
		string1 fcra_conviction_flag;
		string1 fcra_traffic_flag;
		string8 fcra_date;
		string1 fcra_date_type;
		string8 conviction_override_date;
		string1 conviction_override_date_type;
		string2 offense_score;
		unsigned8 offender_persistent_id;
		real8 lat;
		real8 long;
		unsigned8 __internal_fpos__;
	end;

export rthor_data400__key__sexoffender__zip_type_public	:=
	record
		integer4 alt_zip;
		string1 alt_type;
		unsigned2 yob;
		integer4 dob;
		unsigned6 did;
	end;

export dthor_data400__key__sexoffender__autokey__address 						:= dataset(lCSVFileNamePrefix + 'thor_data400__key__sexoffender__' + lCSVVersion + '__autokey__address.csv', rthor_data400__key__sexoffender__autokey__address, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__sexoffender__autokey__citystname 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__sexoffender__' + lCSVVersion + '__autokey__citystname.csv', rthor_data400__key__sexoffender__autokey__citystname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__sexoffender__autokey__latlong 						:= dataset(lCSVFileNamePrefix + 'thor_data400__key__sexoffender__' + lCSVVersion + '__autokey__latlong.csv', rthor_data400__key__sexoffender__autokey__latlong, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__sexoffender__autokey__name 							:= dataset(lCSVFileNamePrefix + 'thor_data400__key__sexoffender__' + lCSVVersion + '__autokey__name.csv', rthor_data400__key__sexoffender__autokey__name, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__sexoffender__autokey__payload 						:= dataset(lCSVFileNamePrefix + 'thor_data400__key__sexoffender__' + lCSVVersion + '__autokey__payload.csv', rthor_data400__key__sexoffender__autokey__payload, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__sexoffender__autokey__ssn2 							:= dataset(lCSVFileNamePrefix + 'thor_data400__key__sexoffender__' + lCSVVersion + '__autokey__ssn2.csv', rthor_data400__key__sexoffender__autokey__ssn2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__sexoffender__autokey__stname 						:= dataset(lCSVFileNamePrefix + 'thor_data400__key__sexoffender__' + lCSVVersion + '__autokey__stname.csv', rthor_data400__key__sexoffender__autokey__stname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__sexoffender__autokey__zip 								:= dataset(lCSVFileNamePrefix + 'thor_data400__key__sexoffender__' + lCSVVersion + '__autokey__zip.csv', rthor_data400__key__sexoffender__autokey__zip, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__sexoffender__didpublic 									:= dataset(lCSVFileNamePrefix1 + 'thor_data400__key__sexoffender__' + lCSVVersion1 + '__didpublic.csv', rthor_data400__key__sexoffender__didpublic, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__sexoffender__enhpublic 									:= dataset(lCSVFileNamePrefix1 + 'thor_data400__key__sexoffender__' + lCSVVersion1 + '__enhpublic.csv', rthor_data400__key__sexoffender__enhpublic, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__sexoffender__enhpublicaddress 						:= dataset(lCSVFileNamePrefix1 + 'thor_data400__key__sexoffender__' + lCSVVersion1 + '__enhpublicaddress.csv', rthor_data400__key__sexoffender__enhpublicaddress, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__sexoffender__enhpubliccitystname 				:= dataset(lCSVFileNamePrefix1 + 'thor_data400__key__sexoffender__' + lCSVVersion1 + '__enhpubliccitystname.csv', rthor_data400__key__sexoffender__enhpubliccitystname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__sexoffender__enhpublicname 							:= dataset(lCSVFileNamePrefix1 + 'thor_data400__key__sexoffender__' + lCSVVersion1 + '__enhpublicname.csv', rthor_data400__key__sexoffender__enhpublicname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__sexoffender__enhpublicphone 							:= dataset(lCSVFileNamePrefix1 + 'thor_data400__key__sexoffender__' + lCSVVersion1 + '__enhpublicphone.csv', rthor_data400__key__sexoffender__enhpublicphone, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__sexoffender__enhpublicssn 								:= dataset(lCSVFileNamePrefix1 + 'thor_data400__key__sexoffender__' + lCSVVersion1 + '__enhpublicssn.csv', rthor_data400__key__sexoffender__enhpublicssn, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__sexoffender__enhpublicstname 						:= dataset(lCSVFileNamePrefix1 + 'thor_data400__key__sexoffender__' + lCSVVersion1 + '__enhpublicstname.csv', rthor_data400__key__sexoffender__enhpublicstname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__sexoffender__enhpubliczip 								:= dataset(lCSVFileNamePrefix1 + 'thor_data400__key__sexoffender__' + lCSVVersion1 + '__enhpubliczip.csv', rthor_data400__key__sexoffender__enhpubliczip, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__sexoffender__fdid_public 								:= dataset(lCSVFileNamePrefix1 + 'thor_data400__key__sexoffender__' + lCSVVersion1 + '__fdid_public.csv', rthor_data400__key__sexoffender__fdid_public, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__sexoffender__offenses_public 						:= dataset(lCSVFileNamePrefix1 + 'thor_data400__key__sexoffender__' + lCSVVersion1 + '__offenses_public.csv', rthor_data400__key__sexoffender__offenses_public, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__sexoffender__publicaddress 							:= dataset(lCSVFileNamePrefix1 + 'thor_data400__key__sexoffender__' + lCSVVersion1 + '__publicaddress.csv', rthor_data400__key__sexoffender__publicaddress, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__sexoffender__publiccitystname 						:= dataset(lCSVFileNamePrefix1 + 'thor_data400__key__sexoffender__' + lCSVVersion1 + '__publiccitystname.csv', rthor_data400__key__sexoffender__publiccitystname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__sexoffender__publicname 									:= dataset(lCSVFileNamePrefix1 + 'thor_data400__key__sexoffender__' + lCSVVersion1 + '__publicname.csv', rthor_data400__key__sexoffender__publicname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__sexoffender__publicphone 								:= dataset(lCSVFileNamePrefix1 + 'thor_data400__key__sexoffender__' + lCSVVersion1 + '__publicphone.csv', rthor_data400__key__sexoffender__publicphone, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__sexoffender__publicssn 									:= dataset(lCSVFileNamePrefix1 + 'thor_data400__key__sexoffender__' + lCSVVersion1 + '__publicssn.csv', rthor_data400__key__sexoffender__publicssn, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__sexoffender__publicstname 								:= dataset(lCSVFileNamePrefix1 + 'thor_data400__key__sexoffender__' + lCSVVersion1 + '__publicstname.csv', rthor_data400__key__sexoffender__publicstname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__sexoffender__publiczip 									:= dataset(lCSVFileNamePrefix1 + 'thor_data400__key__sexoffender__' + lCSVVersion1 + '__publiczip.csv', rthor_data400__key__sexoffender__publiczip, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__sexoffender__spkpublic 									:= dataset(lCSVFileNamePrefix1 + 'thor_data400__key__sexoffender__' + lCSVVersion1 + '__spkpublic.csv', rthor_data400__key__sexoffender__spkpublic, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__sexoffender__zip_type_public 						:= dataset(lCSVFileNamePrefix1 + 'thor_data400__key__sexoffender__' + lCSVVersion1 + '__zip_type_public.csv', rthor_data400__key__sexoffender__zip_type_public, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
end :DEPRECATED('Use PRTE2_SEXOFEENDER.FILES');