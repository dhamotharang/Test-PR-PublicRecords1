export Yellowpages := 

module
	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'20100713';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;

export rthor_data400__key__yellowpages__autokey__address	:=
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

export rthor_data400__key__yellowpages__autokey__addressb2	:=
record
	string28 prim_name;
	string10 prim_range;
	string2 st;
	unsigned4 city_code;
	string5 zip;
	string8 sec_range;
	string40 cname_indic;
	string40 cname_sec;
	unsigned6 bdid;
	unsigned4 lookups;
end;

 export rthor_data400__key__yellowpages__autokey__citystname	:=
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

export rthor_data400__key__yellowpages__autokey__citystnameb2	:=
record
	unsigned4 city_code;
	string2 st;
	string40 cname_indic;
	string40 cname_sec;
	unsigned6 bdid;
	unsigned4 lookups;
end;

export rthor_data400__key__yellowpages__autokey__name	:=
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

export rthor_data400__key__yellowpages__autokey__nameb2	:=
record
	string40 cname_indic;
	string40 cname_sec;
	unsigned6 bdid;
	unsigned4 lookups;
end;

export rthor_data400__key__yellowpages__autokey__namewords2	:=
record
	string40 word;
	string2 state;
	unsigned1 seq;
	unsigned6 bdid;
	unsigned4 lookups;
end;


export rthor_data400__key__yellowpages__autokey__payload	:=
record
  unsigned6 fakeid;
  unsigned6 bdid;
  string20 fname;
  string20 mname;
  string20 lname;
  string125 business_name;
  string10 phone10;
  string28 prim_name;
  string10 prim_range;
  string2 st;
  string25 p_city_name;
  string5 zip;
  string8 sec_range;
  unsigned1 zero;
  string1 blank;
  unsigned8 __internal_fpos__;
end;


export rthor_data400__key__yellowpages__autokey__phone2	:=
record
	string7 p7;
	string3 p3;
	string6 dph_lname;
	string20 pfname;
	string2 st;
	unsigned6 did;
	unsigned4 lookups;
end;

export rthor_data400__key__yellowpages__autokey__phoneb2	:=
record
	string7 p7;
	string3 p3;
	string40 cname_indic;
	string40 cname_sec;
	string2 st;
	unsigned6 bdid;
	unsigned4 lookups;
end;

export rthor_data400__key__yellowpages__autokey__stname	:=
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

export rthor_data400__key__yellowpages__autokey__stnameb2	:=
record
	string2 st;
	string40 cname_indic;
	string40 cname_sec;
	unsigned6 bdid;
	unsigned4 lookups;
end;

export rthor_data400__key__yellowpages__autokey__zip	:=
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

export rthor_data400__key__yellowpages__autokey__zipb2	:=
record
	integer4 zip;
	string40 cname_indic;
	string40 cname_sec;
	unsigned6 bdid;
	unsigned4 lookups;
end;

export rthor_data400__key__yellowpages__bdid	:=
record
	unsigned6 bdid;
	string10 primary_key;
	string125 business_name;
	string100 orig_street;
	string75 orig_city;
	string2 orig_state;
	string9 orig_zip;
	string9 orig_latitude;
	string10 orig_longitude;
	string10 orig_phone10;
	string10 phone10;
	string140 heading_string;
	string8 sic_code;
	string1 toll_free_indicator;
	string1 fax_indicator;
	string6 pub_date;
	string9 index_value;
	string6 naics_code;
	string50 web_address;
	string35 email_address;
	string1 employee_code;
	string10 executive_title;
	string33 executive_name;
	string1 derog_legal_indicator;
	string1 record_type;
	string1 addr_suffix_flag;
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
	string10 geo_lat;
	string11 geo_long;
	string4 msa;
	string7 geo_blk;
	string1 geo_match;
	string4 err_stat;
	string1 bus_name_flag;
	string25 aka_name;
	string5 title;
	string20 fname;
	string20 mname;
	string20 lname;
	string5 name_suffix;
	string3 name_score;
	string5 exec_title;
	string20 exec_fname;
	string20 exec_mname;
	string20 exec_lname;
	string5 exec_name_suffix;
	string3 exec_name_score;
	string25 nn_fix_city;
	string2 nn_fix_state;
	string5 nn_fix_zip;
	string1 nn_fix_ace_flag;
	string25 nn_fix_alt_city1;
	string5 nn_fix_alt_zip1;
	string25 nn_fix_alt_city2;
	string5 nn_fix_alt_zip2;
	string2 n_fix_state;
	string1 address_override;
	string1 phone_override;
	string4 phone_type;
	string2 source;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__yellowpages__linkids	:=
record
  unsigned6 ultid;
  unsigned6 orgid;
  unsigned6 seleid;
  unsigned6 proxid;
  unsigned6 powid;
  unsigned6 empid;
  unsigned6 dotid;
  unsigned2 ultscore;
  unsigned2 orgscore;
  unsigned2 selescore;
  unsigned2 proxscore;
  unsigned2 powscore;
  unsigned2 empscore;
  unsigned2 dotscore;
  unsigned2 ultweight;
  unsigned2 orgweight;
  unsigned2 seleweight;
  unsigned2 proxweight;
  unsigned2 powweight;
  unsigned2 empweight;
  unsigned2 dotweight;
  unsigned6 bdid;
  string12 primary_key;
  string125 business_name;
  string100 orig_street;
  string75 orig_city;
  string2 orig_state;
  string9 orig_zip;
  string11 orig_latitude;
  string11 orig_longitude;
  string10 orig_phone10;
  string10 phone10;
  string140 heading_string;
  string8 sic_code;
  string1 toll_free_indicator;
  string1 fax_indicator;
  string8 pub_date;
  string9 index_value;
  string6 naics_code;
  string60 web_address;
  string35 email_address;
  string1 employee_code;
  string40 executive_title;
  string40 executive_name;
  string1 derog_legal_indicator;
  string1 record_type;
  string1 addr_suffix_flag;
  unsigned8 rawaid;
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
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  string1 bus_name_flag;
  string25 aka_name;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 name_score;
  string5 exec_title;
  string20 exec_fname;
  string20 exec_mname;
  string20 exec_lname;
  string5 exec_name_suffix;
  string3 exec_name_score;
  string25 nn_fix_city;
  string2 nn_fix_state;
  string5 nn_fix_zip;
  string1 nn_fix_ace_flag;
  string25 nn_fix_alt_city1;
  string5 nn_fix_alt_zip1;
  string25 nn_fix_alt_city2;
  string5 nn_fix_alt_zip2;
  string2 n_fix_state;
  string1 address_override;
  string1 phone_override;
  string4 phone_type;
  string2 source;
  string4 chainid;
  string30 busshortname;
  string100 busdeptname;
  string2 fips;
  string3 countycode;
  string8 sic2;
  string8 sic3;
  string8 sic4;
  string1 indstryclass;
  string1 nosolicitcode;
  string1 dso;
  string1 timezone;
  string2 singleaddrflag;
  unsigned8 source_rec_id;
  integer1 fp;
end;

export rthor_data400__key__yellowpages__phone	:=
record
	string10 phone10;
	string125 business_name;
	string10 prim_range;
	string28 prim_name;
	string8 sec_range;
	string5 zip;
	string10 geo_lat;
	string11 geo_long;
	unsigned8 __internal_fpos__;
end;
/* autokeys are not part of the package file */
export dthor_data400__key__yellowpages__autokey__address 			:= dataset([],rthor_data400__key__yellowpages__autokey__address);
export dthor_data400__key__yellowpages__autokey__addressb2 		:= dataset([],rthor_data400__key__yellowpages__autokey__addressb2);
export dthor_data400__key__yellowpages__autokey__citystname 	:= dataset([],rthor_data400__key__yellowpages__autokey__citystname);
export dthor_data400__key__yellowpages__autokey__citystnameb2	:= dataset([],rthor_data400__key__yellowpages__autokey__citystnameb2);
export dthor_data400__key__yellowpages__autokey__name 				:= dataset([],rthor_data400__key__yellowpages__autokey__name);
export dthor_data400__key__yellowpages__autokey__nameb2 			:= dataset([],rthor_data400__key__yellowpages__autokey__nameb2);
export dthor_data400__key__yellowpages__autokey__namewords2 	:= dataset([],rthor_data400__key__yellowpages__autokey__namewords2);
export dthor_data400__key__yellowpages__autokey__payload 			:= dataset([],rthor_data400__key__yellowpages__autokey__payload);
export dthor_data400__key__yellowpages__autokey__phone2 			:= dataset([],rthor_data400__key__yellowpages__autokey__phone2);
export dthor_data400__key__yellowpages__autokey__phoneb2 			:= dataset([],rthor_data400__key__yellowpages__autokey__phoneb2);
export dthor_data400__key__yellowpages__autokey__stname 			:= dataset([],rthor_data400__key__yellowpages__autokey__stname);
export dthor_data400__key__yellowpages__autokey__stnameb2 		:= dataset([],rthor_data400__key__yellowpages__autokey__stnameb2);
export dthor_data400__key__yellowpages__autokey__zip 					:= dataset([],rthor_data400__key__yellowpages__autokey__zip);
export dthor_data400__key__yellowpages__autokey__zipb2 				:= dataset([],rthor_data400__key__yellowpages__autokey__zipb2);
export dthor_data400__key__yellowpages__bdid  								:= dataset(lCSVFileNamePrefix  + 'thor_data400__key__yellowpages__' + lCSVVersion + '__bdid.csv', rthor_data400__key__yellowpages__bdid, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__yellowpages__linkids								:= dataset([],rthor_data400__key__yellowpages__linkids);
export dthor_data400__key__yellowpages__phone 								:= dataset(lCSVFileNamePrefix + 'thor_data400__key__yellowpages__' + lCSVVersion + '__phone.csv', rthor_data400__key__yellowpages__phone, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
end;