export FAA_Airmen := 

module

	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;
	
export rthor_data400__key__faa__airmen__autokey__address	:=
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

export rthor_data400__key__faa__airmen__autokey__citystname	:=
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

export rthor_data400__key__faa__airmen__autokey__name	:=
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

export rthor_data400__key__faa__airmen__autokey__payload	:=
record
	unsigned6 fakeid;
	string3 d_score;
	string9 best_ssn;
	string12 did_out;
	string8 date_first_seen;
	string8 date_last_seen;
	string1 current_flag;
	string10 record_type;
	string1 letter_code;
	string7 unique_id;
	string2 orig_rec_type;
	string30 orig_fname;
	string30 orig_lname;
	string33 street1;
	string33 street2;
	string17 city;
	string2 state;
	string10 zip_code;
	string18 country;
	string2 region;
	string1 med_class;
	string6 med_date;
	string6 med_exp_date;
	string10 prim_range;
	string2 predir;
	string28 prim_name;
	string4 suffix;
	string2 postdir;
	string10 unit_desig;
	string8 sec_range;
	string25 p_city_name;
	string25 v_city_name;
	string2 st;
	string5 zip;
	string4 zip4;
	string4 cart;
	string1 cr_sort_sz;
	string4 lot;
	string1 lot_order;
	string2 dpbc;
	string1 chk_digit;
	string2 rec_type;
	string2 ace_fips_st;
	string3 county;
	string18 county_name;
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
	string2 oer;
	unsigned6 airmen_id;
	unsigned1 zero;
	string1 blank;
	unsigned6 did_out6;
end;

export rthor_data400__key__faa__airmen__autokey__ssn2	:=
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

export rthor_data400__key__faa__airmen__autokey__stname	:=
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

export rthor_data400__key__faa__airmen__autokey__zip	:=
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

export dthor_data400__key__faa__airmen__autokey__address 			:= dataset(lCSVFileNamePrefix + 'thor_data400__key__faa__airmen__' + lCSVVersion + '__autokey__address.csv', rthor_data400__key__faa__airmen__autokey__address, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__faa__airmen__autokey__citystname 	:= dataset(lCSVFileNamePrefix + 'thor_data400__key__faa__airmen__' + lCSVVersion + '__autokey__citystname.csv', rthor_data400__key__faa__airmen__autokey__citystname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__faa__airmen__autokey__name 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__faa__airmen__' + lCSVVersion + '__autokey__name.csv', rthor_data400__key__faa__airmen__autokey__name, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__faa__airmen__autokey__payload 			:= dataset(lCSVFileNamePrefix + 'thor_data400__key__faa__airmen__' + lCSVVersion + '__autokey__payload.csv', rthor_data400__key__faa__airmen__autokey__payload, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__faa__airmen__autokey__ssn2 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__faa__airmen__' + lCSVVersion + '__autokey__ssn2.csv', rthor_data400__key__faa__airmen__autokey__ssn2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__faa__airmen__autokey__stname 			:= dataset(lCSVFileNamePrefix + 'thor_data400__key__faa__airmen__' + lCSVVersion + '__autokey__stname.csv', rthor_data400__key__faa__airmen__autokey__stname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__faa__airmen__autokey__zip 					:= dataset(lCSVFileNamePrefix + 'thor_data400__key__faa__airmen__' + lCSVVersion + '__autokey__zip.csv', rthor_data400__key__faa__airmen__autokey__zip, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
end: DEPRECATED('Use PRTE2_FAA.files instead.');
