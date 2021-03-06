export CCW := 

module

	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'20100105';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;
	
	
export rthor_data400__key__ccw__autokey__address	:=
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

export rthor_data400__key__ccw__autokey__citystname	:=
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

export rthor_data400__key__ccw__autokey__name	:=
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

export rthor_data400__key__ccw__autokey__payload	:=
record
	unsigned6 fakeid;
	string5 title;
	string20 fname;
	string20 mname;
	string20 lname;
	string5 name_suffix;
	string10 prim_range;
	string2 predir;
	string28 prim_name;
	string4 suffix;
	string2 postdir;
	string10 unit_desig;
	string8 sec_range;
	string25 city_name;
	string2 st;
	string5 zip;
	string4 zip4;
	string3 county;
	string8 unique_id;
	string8 dob;
	string15 ccwpermnum;
	string46 ccwpermtype;
	string15 ccwweapontype;
	string2 source_state;
	string2 res_state;
	string30 occupation;
	string1 gender;
	string9 best_ssn;
	unsigned6 did_out6;
	string2 race;
	unsigned1 zero;
	string1 blank;
	unsigned6 rid;
	unsigned8 persistent_record_id;
end;

export rthor_data400__key__ccw__autokey__ssn2	:=
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

export rthor_data400__key__ccw__autokey__stname	:=
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

export rthor_data400__key__ccw__autokey__zip	:=
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

export rthor_data400__key__ccw__did := { unsigned6 did_out6, unsigned6 rid };

export rthor_data400__key__ccw__rid	:=
record
	unsigned6 rid;
	// unsigned8 persistent_record_id;
	string8 process_date;
	string8 date_first_seen;
	string8 date_last_seen;
	string8 unique_id;
	string3 score;
	string9 best_ssn;
	string12 did_out;
	string7 source;
	string4 file_id;
	string13 vendor_id;
	string2 source_state;
	string2 source_code;
	string8 file_acquired_date;
	string2 _use;
	string10 title_in;
	string30 lname_in;
	string30 fname_in;
	string30 mname_in;
	string30 maiden_prior;
	string3 name_suffix_in;
	string15 votefiller;
	string12 source_voterid;
	string8 dob;
	string2 agecat;
	string2 headhousehold;
	string18 place_of_birth;
	string30 occupation;
	string30 maiden_name;
	string15 motorvoterid;
	string10 regsource;
	string8 regdate;
	string2 race;
	string1 gender;
	string2 poliparty;
	string10 phone;
	string10 work_phone;
	string10 other_phone;
	string1 active_status;
	string1 votefiller2;
	string1 active_other;
	string2 voterstatus;
	string40 resaddr1;
	string40 resaddr2;
	string40 res_city;
	string2 res_state;
	string9 res_zip;
	string3 res_county;
	string40 mail_addr1;
	string40 mail_addr2;
	string40 mail_city;
	string2 mail_state;
	string9 mail_zip;
	string3 mail_county;
	string15 ccwpermnum;
	string15 ccwweapontype;
	string8 ccwregdate;
	string8 ccwexpdate;
	string46 ccwpermtype;
	string10 ccwfill1;
	string20 ccwfill2;
	string15 ccwfill3;
	string15 ccwfill4;
	string15 miscfill1;
	string15 miscfill2;
	string15 miscfill3;
	string15 miscfill4;
	string15 miscfill5;
	string5 title;
	string20 fname;
	string20 mname;
	string20 lname;
	string5 name_suffix;
	string3 score_on_input;
	string10 prim_range;
	string2 predir;
	string28 prim_name;
	string4 suffix;
	string2 postdir;
	string10 unit_desig;
	string8 sec_range;
	string25 p_city_name;
	string25 city_name;
	string2 st;
	string5 zip;
	string4 zip4;
	string4 cart;
	string1 cr_sort_sz;
	string4 lot;
	string1 lot_order;
	string2 dpbc;
	string1 chk_digit;
	string2 record_type;
	string2 ace_fips_st;
	string3 county;
	string18 county_name;
	string10 geo_lat;
	string11 geo_long;
	string4 msa;
	string7 geo_blk;
	string1 geo_match;
	string4 err_stat;
	string10 mail_prim_range;
	string2 mail_predir;
	string28 mail_prim_name;
	string4 mail_addr_suffix;
	string2 mail_postdir;
	string10 mail_unit_desig;
	string8 mail_sec_range;
	string25 mail_p_city_name;
	string25 mail_v_city_name;
	string2 mail_st;
	string5 mail_ace_zip;
	string4 mail_zip4;
	string4 mail_cart;
	string1 mail_cr_sort_sz;
	string4 mail_lot;
	string1 mail_lot_order;
	string2 mail_dpbc;
	string1 mail_chk_digit;
	string2 mail_record_type;
	string2 mail_ace_fips_st;
	string3 mail_fipscounty;
	string10 mail_geo_lat;
	string11 mail_geo_long;
	string4 mail_msa;
	string7 mail_geo_blk;
	string1 mail_geo_match;
	string4 mail_err_stat;
	unsigned8 persistent_record_id;
	unsigned8 __internal_fpos__;
end;
	
export dthor_data400__key__ccw__autokey__address 		:= dataset(lCSVFileNamePrefix + 'thor_data400__key__ccw__'+ lCSVVersion + '__autokey__address.csv', rthor_data400__key__ccw__autokey__address, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ccw__autokey__citystname 	:= dataset(lCSVFileNamePrefix + 'thor_data400__key__ccw__'+ lCSVVersion + '__autokey__citystname.csv', rthor_data400__key__ccw__autokey__citystname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ccw__autokey__name 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__ccw__'+ lCSVVersion + '__autokey__name.csv', rthor_data400__key__ccw__autokey__name, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ccw__autokey__payload 		:= dataset(lCSVFileNamePrefix + 'thor_data400__key__ccw__'+ lCSVVersion + '__autokey__payload.csv', rthor_data400__key__ccw__autokey__payload, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ccw__autokey__ssn2 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__ccw__'+ lCSVVersion + '__autokey__ssn2.csv', rthor_data400__key__ccw__autokey__ssn2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ccw__autokey__stname 			:= dataset(lCSVFileNamePrefix + 'thor_data400__key__ccw__'+ lCSVVersion + '__autokey__stname.csv', rthor_data400__key__ccw__autokey__stname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ccw__autokey__zip 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__ccw__'+ lCSVVersion + '__autokey__zip.csv', rthor_data400__key__ccw__autokey__zip, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ccw__did 									:= dataset(lCSVFileNamePrefix + 'thor_data400__key__ccw__'+ lCSVVersion + '__did.csv', rthor_data400__key__ccw__did, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ccw__rid 								:= dataset(lCSVFileNamePrefix + 'thor_data400__key__ccw__'+ lCSVVersion + '__rid.csv', rthor_data400__key__ccw__rid, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
end;
	