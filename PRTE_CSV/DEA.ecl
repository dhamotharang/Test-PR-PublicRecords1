export DEA := 

module


	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;
	
export rthor_data400__key__dea__autokey__address	:=
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

export rthor_data400__key__dea__autokey__addressb2	:=
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

export rthor_data400__key__dea__autokey__citystname	:=
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

export rthor_data400__key__dea__autokey__citystnameb2	:=
record
	unsigned4 city_code;
	string2 st;
	string40 cname_indic;
	string40 cname_sec;
	unsigned6 bdid;
	unsigned4 lookups;
end;

export rthor_data400__key__dea__autokey__name	:=
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

export rthor_data400__key__dea__autokey__nameb2	:=
record
	string40 cname_indic;
	string40 cname_sec;
	unsigned6 bdid;
	unsigned4 lookups;
end;

export rthor_data400__key__dea__autokey__namewords2	:=
record
	string40 word;
	string2 state;
	unsigned1 seq;
	unsigned6 bdid;
	unsigned4 lookups;
end;

export rthor_data400__key__dea__autokey__payload	:=
record
	unsigned6 fakeid;
	string8 date_first_reported;
	string8 date_last_reported;
	string9 dea_registration_number;
	string1 business_activity_code;
	string16 drug_schedules;
	string8 expiration_date;
	string40 address1;
	string40 address2;
	string40 address3;
	string40 address4;
	string33 address5;
	string2 state;
	string5 zip_code;
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
	string5 title;
	string20 fname;
	string20 mname;
	string20 lname;
	string5 name_suffix;
	string3 name_score;
	integer1 filler;
	boolean is_company_flag;
	string40 cname;
	string2 crlf;
	string18 county_name;
	string12 did;
	string3 score;
	string9 best_ssn;
	string12 bdid;
	string10 cprim_range;
	string28 cprim_name;
	string8 csec_range;
	string25 cv_city_name;
	string2 cst;
	string5 czip;
	unsigned1 zero;
	unsigned6 indid;
	unsigned6 inbdid;
end;

export rthor_data400__key__dea__autokey__ssn2	:=
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

export rthor_data400__key__dea__autokey__stname	:=
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

export rthor_data400__key__dea__autokey__stnameb2	:=
record
	string2 st;
	string40 cname_indic;
	string40 cname_sec;
	unsigned6 bdid;
	unsigned4 lookups;
end;

export rthor_data400__key__dea__autokey__zip	:=
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

export rthor_data400__key__dea__autokey__zipb2	:=
record
	integer4 zip;
	string40 cname_indic;
	string40 cname_sec;
	unsigned6 bdid;
	unsigned4 lookups;
end;

export rthor_data400__key__dea__bdid	:=
record
	unsigned6 bd;
	string8 date_first_reported;
	string8 date_last_reported;
	string9 dea_registration_number;
	string1 business_activity_code;
	string16 drug_schedules;
	string8 expiration_date;
	string40 address1;
	string40 address2;
	string40 address3;
	string40 address4;
	string33 address5;
	string2 state;
	string5 zip_code;
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
	string5 title;
	string20 fname;
	string20 mname;
	string20 lname;
	string5 name_suffix;
	string3 name_score;
	integer1 filler;
	boolean is_company_flag;
	string40 cname;
	string2 crlf;
	string18 county_name;
	string12 did;
	string3 score;
	string9 best_ssn;
	string12 bdid;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__dea__did	:=
record
	unsigned6 my_did;
	string8 date_first_reported;
	string8 date_last_reported;
	string9 dea_registration_number;
	string1 business_activity_code;
	string16 drug_schedules;
	string8 expiration_date;
	string40 address1;
	string40 address2;
	string40 address3;
	string40 address4;
	string33 address5;
	string2 state;
	string5 zip_code;
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
	string5 title;
	string20 fname;
	string20 mname;
	string20 lname;
	string5 name_suffix;
	string3 name_score;
	integer1 filler;
	boolean is_company_flag;
	string40 cname;
	string2 crlf;
	string18 county_name;
	string12 did;
	string3 score;
	string9 best_ssn;
	string12 bdid;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__dea__reg_num	:=
record
	string9   dea_registration_number;
	string8   date_first_reported;
	string8   date_last_reported;
	string1   business_activity_code;
	string16  drug_schedules;
	string8   expiration_date;
	string40  address1;
	string40  address2;
	string40  address3;
	string40  address4;
	string33  address5;
	string2   state;
	string5   zip_code;
	string1   bus_activity_sub_code;
	string1   exp_of_payment_indicator;
	string8   activity;
	string10  prim_range;
	string2   predir;
	string28  prim_name;
	string4   addr_suffix;
	string2   postdir;
	string10  unit_desig;
	string8   sec_range;
	string25  p_city_name;
	string25  v_city_name;
	string2   st;
	string5   zip;
	string4   zip4;
	string4   cart;
	string1   cr_sort_sz;
	string4   lot;
	string1   lot_order;
	string2   dbpc;
	string1   chk_digit;
	string2   rec_type;
	string5   county;
	string10  geo_lat;
	string11  geo_long;
	string4   msa;
	string7   geo_blk;
	string1   geo_match;
	string4   err_stat;
	string5   title;
	string20  fname;
	string20  mname;
	string20  lname;
	string5   name_suffix;
	string3   name_score;
	integer1  filler;
	boolean   is_company_flag;
	string40  cname;
	string2   crlf;
	string18  county_name;
	string12  did;
	string3   score;
	string9   best_ssn;
	string12  bdid;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__dea__linkids	:=
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
  string8 date_first_reported;
  string8 date_last_reported;
  string9 dea_registration_number;
  string1 business_activity_code;
  string16 drug_schedules;
  string8 expiration_date;
  string40 address1;
  string40 address2;
  string40 address3;
  string40 address4;
  string33 address5;
  string2 state;
  string5 zip_code;
  string1 bus_activity_sub_code;
  string1 exp_of_payment_indicator;
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
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 name_score;
  integer1 filler;
  boolean is_company_flag;
  string40 cname;
  string2 crlf;
  string18 county_name;
  string12 did;
  string3 score;
  string9 best_ssn;
  string12 bdid;
  unsigned8 source_rec_id;
  integer1 fp;
 end;

export rthor_data400__key__dea__lnpid	:=
record
  unsigned8 lnpid;
  string9   dea_registration_number;
	unsigned8 __internal_fpos__;
 end;

export dthor_data400__key__dea__autokey__address 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__dea__' + lCSVVersion + '__autokey__address.csv', rthor_data400__key__dea__autokey__address, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__dea__autokey__addressb2 			:= dataset(lCSVFileNamePrefix + 'thor_data400__key__dea__' + lCSVVersion + '__autokey__addressb2.csv', rthor_data400__key__dea__autokey__addressb2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__dea__autokey__citystname 		:= dataset(lCSVFileNamePrefix + 'thor_data400__key__dea__' + lCSVVersion + '__autokey__citystname.csv', rthor_data400__key__dea__autokey__citystname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__dea__autokey__citystnameb2 	:= dataset(lCSVFileNamePrefix + 'thor_data400__key__dea__' + lCSVVersion + '__autokey__citystnameb2.csv', rthor_data400__key__dea__autokey__citystnameb2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__dea__autokey__name 					:= dataset(lCSVFileNamePrefix + 'thor_data400__key__dea__' + lCSVVersion + '__autokey__name.csv', rthor_data400__key__dea__autokey__name, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__dea__autokey__nameb2 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__dea__' + lCSVVersion + '__autokey__nameb2.csv', rthor_data400__key__dea__autokey__nameb2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__dea__autokey__namewords2 		:= dataset(lCSVFileNamePrefix + 'thor_data400__key__dea__' + lCSVVersion + '__autokey__namewords2.csv', rthor_data400__key__dea__autokey__namewords2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__dea__autokey__payload 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__dea__' + lCSVVersion + '__autokey__payload.csv', rthor_data400__key__dea__autokey__payload, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__dea__autokey__ssn2 					:= dataset(lCSVFileNamePrefix + 'thor_data400__key__dea__' + lCSVVersion + '__autokey__ssn2.csv', rthor_data400__key__dea__autokey__ssn2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__dea__autokey__stname 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__dea__' + lCSVVersion + '__autokey__stname.csv', rthor_data400__key__dea__autokey__stname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__dea__autokey__stnameb2 			:= dataset(lCSVFileNamePrefix + 'thor_data400__key__dea__' + lCSVVersion + '__autokey__stnameb2.csv', rthor_data400__key__dea__autokey__stnameb2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__dea__autokey__zip 						:= dataset(lCSVFileNamePrefix + 'thor_data400__key__dea__' + lCSVVersion + '__autokey__zip.csv', rthor_data400__key__dea__autokey__zip, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__dea__autokey__zipb2 					:= dataset(lCSVFileNamePrefix + 'thor_data400__key__dea__' + lCSVVersion + '__autokey__zipb2.csv', rthor_data400__key__dea__autokey__zipb2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__dea__bdid 										:= dataset(lCSVFileNamePrefix + 'thor_data400__key__dea__' + lCSVVersion + '__bdid.csv', rthor_data400__key__dea__bdid, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__dea__did 										:= dataset(lCSVFileNamePrefix + 'thor_data400__key__dea__' + lCSVVersion + '__did.csv', rthor_data400__key__dea__did, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__dea__reg_num 								:= dataset(lCSVFileNamePrefix + 'thor_data400__key__dea__' + lCSVVersion + '__reg_num.csv', rthor_data400__key__dea__reg_num, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
//export dthor_data400__key__dea__linkids 								:= dataset(lCSVFileNamePrefix + 'thor_data400__key__dea__' + lCSVVersion + '__linkids.csv', rthor_data400__key__dea__linkids, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__dea__linkids                 := dataset([], rthor_data400__key__dea__linkids);
export dthor_data400__key__dea__lnpid                   := dataset([], rthor_data400__key__dea__lnpid);

end;