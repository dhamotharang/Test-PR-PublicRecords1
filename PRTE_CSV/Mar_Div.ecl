export Mar_Div := 

module

	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'20091218';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;

export name := RECORD
   string5 title;
   string20 fname;
   string20 mname;
   string20 lname;
   string5 name_suffix;
   string3 name_score;
  END;

export addr := RECORD
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

export rthor_data400__key__mar_div__autokey__address	:=
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

export rthor_data400__key__mar_div__autokey__citystname	:=
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

export rthor_data400__key__mar_div__autokey__name	:=
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

export rthor_data400__key__mar_div__autokey__payload	:=
record
	unsigned6 fakeid;
	unsigned6 did;
	unsigned6 record_id;
	string1 party_type;
	string3 which_party;
	unsigned4 lookups;
	Addr addr;
	name name;
	unsigned1 zero;
	string1 blank;
	string8 party_dob;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__mar_div__autokey__stname	:=
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

export rthor_data400__key__mar_div__autokey__zip	:=
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

export rthor_data400__key__mar_div__did := { unsigned6 did, unsigned6 record_id };

export rthor_data400__key__mar_div__filing_nbr	:=
record
	string25 filing_number;
	string1 filing_type;
	string15 filing_subtype;
	string2 state_origin;
	string35 county;
	unsigned6 record_id;
end;

export rthor_data400__key__mar_div__id_main	:=
record
	unsigned6 record_id;
	unsigned3 dt_first_seen;
	unsigned3 dt_last_seen;
	unsigned3 dt_vendor_first_reported;
	unsigned3 dt_vendor_last_reported;
	string1 filing_type;
	string25 filing_subtype;
	string5 vendor;
	string25 source_file;
	string8 process_date;
	string2 state_origin;
	string1 party1_type;
	string1 party1_name_format;
	string70 party1_name;
	string70 party1_alias;
	string8 party1_dob;
	string2 party1_birth_state;
	string3 party1_age;
	string30 party1_race;
	string50 party1_addr1;
	string50 party1_csz;
	string35 party1_county;
	string20 party1_previous_marital_status;
	string20 party1_how_marriage_ended;
	string2 party1_times_married;
	string8 party1_last_marriage_end_dt;
	string1 party2_type;
	string1 party2_name_format;
	string70 party2_name;
	string70 party2_alias;
	string8 party2_dob;
	string2 party2_birth_state;
	string3 party2_age;
	string30 party2_race;
	string50 party2_addr1;
	string50 party2_csz;
	string35 party2_county;
	string20 party2_previous_marital_status;
	string20 party2_how_marriage_ended;
	string2 party2_times_married;
	string8 party2_last_marriage_end_dt;
	string2 number_of_children;
	string8 marriage_filing_dt;
	string8 marriage_dt;
	string30 marriage_city;
	string35 marriage_county;
	string10 place_of_marriage;
	string10 type_of_ceremony;
	string25 marriage_filing_number;
	string30 marriage_docket_volume;
	string8 divorce_filing_dt;
	string8 divorce_dt;
	string30 divorce_docket_volume;
	string25 divorce_filing_number;
	string30 divorce_city;
	string35 divorce_county;
	string50 grounds_for_divorce;
	string1 marriage_duration_cd;
	string3 marriage_duration;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__mar_div__id_search	:=
record
	unsigned6 record_id;
	string3 which_party;
	unsigned6 did;
	unsigned3 dt_first_seen;
	unsigned3 dt_last_seen;
	unsigned3 dt_vendor_first_reported;
	unsigned3 dt_vendor_last_reported;
	string5 vendor;
	string1 party_type;
	string1 name_sequence;
	string5 title;
	string20 fname;
	string20 mname;
	string20 lname;
	string5 name_suffix;
	string1 nameasis_name_format;
	string100 nameasis;
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
	string8 dob;
  string3 age;
  string2 birth_state;
  string30 race;
  string35 party_county;
  string20 previous_marital_status;
  string20 how_marriage_ended;
  string2 times_married;
  string8 last_marriage_end_dt;
  unsigned8 persistent_record_id;
	unsigned8 __internal_fpos__;
end;

export dthor_data400__key__mar_div__autokey__address 			:= dataset(lCSVFileNamePrefix + 'thor_data400__key__mar_div__' + lCSVVersion + '__autokey__address.csv', rthor_data400__key__mar_div__autokey__address, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__mar_div__autokey__citystname 	:= dataset(lCSVFileNamePrefix + 'thor_data400__key__mar_div__' + lCSVVersion + '__autokey__citystname.csv', rthor_data400__key__mar_div__autokey__citystname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__mar_div__autokey__name 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__mar_div__' + lCSVVersion + '__autokey__name.csv', rthor_data400__key__mar_div__autokey__name, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__mar_div__autokey__payload 			:= dataset(lCSVFileNamePrefix + 'thor_data400__key__mar_div__' + lCSVVersion + '__autokey__payload.csv', rthor_data400__key__mar_div__autokey__payload, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__mar_div__autokey__stname 			:= dataset(lCSVFileNamePrefix + 'thor_data400__key__mar_div__' + lCSVVersion + '__autokey__stname.csv', rthor_data400__key__mar_div__autokey__stname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__mar_div__autokey__zip 					:= dataset(lCSVFileNamePrefix + 'thor_data400__key__mar_div__' + lCSVVersion + '__autokey__zip.csv', rthor_data400__key__mar_div__autokey__zip, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__mar_div__did 									:= dataset(lCSVFileNamePrefix + 'thor_data400__key__mar_div__' + lCSVVersion + '__did.csv', rthor_data400__key__mar_div__did, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__mar_div__filing_nbr 						:= dataset(lCSVFileNamePrefix + 'thor_data400__key__mar_div__' + lCSVVersion + '__filing_nbr.csv', rthor_data400__key__mar_div__filing_nbr, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__mar_div__id_main 							:= dataset(lCSVFileNamePrefix + 'thor_data400__key__mar_div__' + lCSVVersion + '__id_main.csv', rthor_data400__key__mar_div__id_main, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__mar_div__id_search 						:= dataset(lCSVFileNamePrefix + 'thor_data400__key__mar_div__' + lCSVVersion + '__id_search.csv', rthor_data400__key__mar_div__id_search, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
end: DEPRECATED('Use PRTE2_Marriage_Divorce.files instead.');;