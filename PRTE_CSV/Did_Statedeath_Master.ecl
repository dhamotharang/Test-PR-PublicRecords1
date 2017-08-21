export Did_Statedeath_Master := 

module


	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'20091214';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;
	
export 	rthor_data400__key__did_statedeath_master_	:=
record
	unsigned6 l_did;
	string12 did;
	unsigned1 did_score;
	string2 source_state;
	string28 publication;
	string44 decedent_name;
	string93 decedent_race;
	string69 decedent_origin;
	string12 decedent_sex;
	string34 decedent_age;
	string26 education;
	string74 occupation;
	string62 where_worked;
	string289 cause;
	string9 ssn;
	string8 dob;
	string8 dod;
	string35 birthplace;
	string38 marital_status;
	string44 father;
	string43 mother;
	string8 filed_date;
	string4 year;
	string77 county_residence;
	string23 county_death;
	string76 address;
	string7 autopsy;
	string44 autopsy_findings;
	string3 med_exam;
	string6 est_lic_no;
	string22 disposition;
	string8 disposition_date;
	string9 work_injury;
	string8 injury_date;
	string23 injury_type;
	string50 injury_location;
	string7 surg_performed;
	string8 surgery_date;
	string120 hospital_status;
	string14 pregnancy;
	string70 facility_death;
	string6 embalmer_lic_no;
	string21 death_type;
	string5 time_death;
	string12 birth_cert;
	string31 certifier;
	string20 cert_number;
	string5 local_file_no;
	string39 vdi;
	string28 cite_id;
	string5 file_id;
	string8 date_last_trans;
	string1 amendment_code;
	string2 amendment_year;
	string10 _on_lexis;
	string9 _fs_profile;
	string3 us_armed_forces;
	string49 place_of_death;
	string5 title;
	string20 fname;
	string20 mname;
	string20 lname;
	string5 name_suffix;
	string3 name_score;
	string10 prim_range;
	string2 predir;
	string28 prim_name;
	string4 suffix;
	string2 postdir;
	string10 unit_desig;
	string8 sec_range;
	string25 p_city_name;
	string25 v_city_name;
	string2 state;
	string5 zip;
	string4 zip4;
	string4 cart;
	string1 cr_sort_sz;
	string4 lot;
	string1 lot_order;
	string2 dpbc;
	string1 chk_digit;
	string2 rec_type;
	string2 fips_st;
	string3 fips_county;
	string10 geo_lat;
	string11 geo_long;
	string4 msa;
	string7 geo_blk;
	string1 geo_match;
	string4 err_stat;
	string1 lf;
	string18 county_name;
	unsigned8 __internal_fpos__;
end;

export dthor_data400__key__did_statedeath_master_ := dataset(lCSVFileNamePrefix + 'thor_data400__key__did_statedeath_master_' + lCSVVersion + '.csv', rthor_data400__key__did_statedeath_master_, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
end;