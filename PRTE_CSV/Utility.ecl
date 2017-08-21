export Utility := 

module

	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'20091221';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;
	
export rthor_data400__key__utility__address	:=
record
	string28 prim_name;
	string2 st;
	string5 zip;
	string10 prim_range;
	string8 sec_range;
	string15 id;
	string10 exchange_serial_number;
	string8 date_added_to_exchange;
	string8 connect_date;
	string8 date_first_seen;
	string8 record_date;
	string10 util_type;
	string25 orig_lname;
	string20 orig_fname;
	string20 orig_mname;
	string5 orig_name_suffix;
	string1 addr_type;
	string1 addr_dual;
	string10 address_street;
	string100 address_street_name;
	string5 address_street_type;
	string2 address_street_direction;
	string10 address_apartment;
	string20 address_city;
	string2 address_state;
	string10 address_zip;
	string9 ssn;
	string10 work_phone;
	string10 phone;
	string8 dob;
	string2 drivers_license_state_code;
	string22 drivers_license;
	string2 predir;
	string4 addr_suffix;
	string2 postdir;
	string10 unit_desig;
	string25 p_city_name;
	string25 v_city_name;
	string4 zip4;
	string4 cart;
	string1 cr_sort_sz;
	string4 lot;
	string1 lot_order;
	string2 dbpc;
	string1 chk_digit;
	string2 rec_type;
	string5 county;
	string10 geo_lat;
	string11 geo_long;
	string4 msa;
	string7 geo_blk;
	string1 geo_match;
	string4 err_stat;
	string12 did;
	string5 title;
	string20 fname;
	string20 mname;
	string20 lname;
	string5 name_suffix;
	string3 name_score;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__utility__daily_address	:=
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

export rthor_data400__key__utility__daily_citystname	:=
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

export rthor_data400__key__utility__daily_did	:=
record
	unsigned6 s_did;
	string15 id;
	string10 exchange_serial_number;
	string8 date_added_to_exchange;
	string8 connect_date;
	string8 date_first_seen;
	string8 record_date;
	string10 util_type;
	string25 orig_lname;
	string20 orig_fname;
	string20 orig_mname;
	string5 orig_name_suffix;
	string1 addr_type;
	string1 addr_dual;
	string10 address_street;
	string100 address_street_name;
	string5 address_street_type;
	string2 address_street_direction;
	string10 address_apartment;
	string20 address_city;
	string2 address_state;
	string10 address_zip;
	string9 ssn;
	string10 work_phone;
	string10 phone;
	string8 dob;
	string2 drivers_license_state_code;
	string22 drivers_license;
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
	string5 zip;
	string4 zip4;
	string4 cart;
	string1 cr_sort_sz;
	string4 lot;
	string1 lot_order;
	string2 dbpc;
	string1 chk_digit;
	string2 rec_type;
	string5 county;
	string10 geo_lat;
	string11 geo_long;
	string4 msa;
	string7 geo_blk;
	string1 geo_match;
	string4 err_stat;
	string12 did;
	string5 title;
	string20 fname;
	string20 mname;
	string20 lname;
	string5 name_suffix;
	string3 name_score;
	unsigned6 fdid;
	unsigned6 hhid;
end;

export rthor_data400__key__utility__daily_fid	:=
record
	unsigned6 fdid;
	string15 id;
	string10 exchange_serial_number;
	string8 date_added_to_exchange;
	string8 connect_date;
	string8 date_first_seen;
	string8 record_date;
	string10 util_type;
	string25 orig_lname;
	string20 orig_fname;
	string20 orig_mname;
	string5 orig_name_suffix;
	string1 addr_type;
	string1 addr_dual;
	string10 address_street;
	string100 address_street_name;
	string5 address_street_type;
	string2 address_street_direction;
	string10 address_apartment;
	string20 address_city;
	string2 address_state;
	string10 address_zip;
	string9 ssn;
	string10 work_phone;
	string10 phone;
	string8 dob;
	string2 drivers_license_state_code;
	string22 drivers_license;
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
	string5 zip;
	string4 zip4;
	string4 cart;
	string1 cr_sort_sz;
	string4 lot;
	string1 lot_order;
	string2 dbpc;
	string1 chk_digit;
	string2 rec_type;
	string5 county;
	string10 geo_lat;
	string11 geo_long;
	string4 msa;
	string7 geo_blk;
	string1 geo_match;
	string4 err_stat;
	string12 did;
	string5 title;
	string20 fname;
	string20 mname;
	string20 lname;
	string5 name_suffix;
	string3 name_score;
	unsigned6 hhid;
end;

export rthor_data400__key__utility__daily_name	:=
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

export rthor_data400__key__utility__daily_phone	:=
record
	string7 p7;
	string3 p3;
	string6 dph_lname;
	string20 pfname;
	string2 st;
	unsigned6 did;
end;

export rthor_data400__key__utility__daily_ssn	:=
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

export rthor_data400__key__utility__daily_stname	:=
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

export rthor_data400__key__utility__daily_zip	:=
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

export rthor_data400__key__utility__daily_zipprlname	:=
record
	integer4 zip;
	string10 prim_range;
	string20 lname;
	unsigned4 lookups;
	unsigned6 did;
end;

export dthor_data400__key__utility__address 					:= dataset(lCSVFileNamePrefix + 'thor_data400__key__utility__' + lCSVVersion + '__address.csv', rthor_data400__key__utility__address, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__utility__daily_address 		:= dataset(lCSVFileNamePrefix + 'thor_data400__key__utility__' + lCSVVersion + '__dailyaddress.csv', rthor_data400__key__utility__daily_address, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__utility__daily_citystname 	:= dataset(lCSVFileNamePrefix + 'thor_data400__key__utility__' + lCSVVersion + '__daily_citystname.csv', rthor_data400__key__utility__daily_citystname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__utility__daily_did 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__utility__' + lCSVVersion + '__daily_did.csv', rthor_data400__key__utility__daily_did, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__utility__daily_fid 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__utility__' + lCSVVersion + '__daily_fid.csv', rthor_data400__key__utility__daily_fid, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__utility__daily_name 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__utility__' + lCSVVersion + '__daily_name.csv', rthor_data400__key__utility__daily_name, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__utility__daily_phone 			:= dataset(lCSVFileNamePrefix + 'thor_data400__key__utility__' + lCSVVersion + '__daily_phone.csv', rthor_data400__key__utility__daily_phone, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__utility__daily_ssn 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__utility__' + lCSVVersion + '__daily_ssn.csv', rthor_data400__key__utility__daily_ssn, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__utility__daily_stname 			:= dataset(lCSVFileNamePrefix + 'thor_data400__key__utility__' + lCSVVersion + '__daily_stname.csv', rthor_data400__key__utility__daily_stname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__utility__daily_zip 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__utility__' + lCSVVersion + '__daily_zip.csv', rthor_data400__key__utility__daily_zip, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__utility__daily_zipprlname 	:= dataset(lCSVFileNamePrefix + 'thor_data400__key__utility__' + lCSVVersion + '__daily_zipprlname.csv', rthor_data400__key__utility__daily_zipprlname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
end;