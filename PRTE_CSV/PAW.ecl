export PAW := 

module

	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'20090820g';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;
	
export rthor_data400__key__paw__autokey__address	:=
record
	string28 prim_name;
	string10 prim_range;
	string2 st;
	unsigned integer4 city_code;
	string5 zip;
	string8 sec_range;
	string6 dph_lname;
	string20 lname;
	string20 pfname;
	string20 fname;
	unsigned integer8 states;
	unsigned integer4 lname1;
	unsigned integer4 lname2;
	unsigned integer4 lname3;
	unsigned integer4 lookups;
	unsigned integer6 did;
end;

export rthor_data400__key__paw__autokey__addressb2	:=
record
	string28 prim_name;
	string10 prim_range;
	string2 st;
	unsigned integer4 city_code;
	string5 zip;
	string8 sec_range;
	string40 cname_indic;
	string40 cname_sec;
	unsigned integer6 bdid;
	unsigned integer4 lookups;
end;

export rthor_data400__key__paw__autokey__citystname	:=
record
	unsigned integer4 city_code;
	string2 st;
	string6 dph_lname;
	string20 lname;
	string20 pfname;
	string20 fname;
	integer4 dob;
	unsigned integer8 states;
	unsigned integer4 lname1;
	unsigned integer4 lname2;
	unsigned integer4 lname3;
	unsigned integer4 city1;
	unsigned integer4 city2;
	unsigned integer4 city3;
	unsigned integer4 rel_fname1;
	unsigned integer4 rel_fname2;
	unsigned integer4 rel_fname3;
	unsigned integer4 lookups;
	unsigned integer6 did;
end;

export rthor_data400__key__paw__autokey__citystnameb2	:=
record
	unsigned integer4 city_code;
	string2 st;
	string40 cname_indic;
	string40 cname_sec;
	unsigned integer6 bdid;
	unsigned integer4 lookups;
end;

export rthor_data400__key__paw__autokey__fein2	:=
record
	string1 f1;
	string1 f2;
	string1 f3;
	string1 f4;
	string1 f5;
	string1 f6;
	string1 f7;
	string1 f8;
	string1 f9;
	string40 cname_indic;
	string40 cname_sec;
	unsigned integer6 bdid;
	unsigned integer4 lookups;
end;

export rthor_data400__key__paw__autokey__name	:=
record
	string6 dph_lname;
	string20 lname;
	string20 pfname;
	string20 fname;
	string1 minit;
	unsigned integer2 yob;
	unsigned integer2 s4;
	integer4 dob;
	unsigned integer8 states;
	unsigned integer4 lname1;
	unsigned integer4 lname2;
	unsigned integer4 lname3;
	unsigned integer4 city1;
	unsigned integer4 city2;
	unsigned integer4 city3;
	unsigned integer4 rel_fname1;
	unsigned integer4 rel_fname2;
	unsigned integer4 rel_fname3;
	unsigned integer4 lookups;
	unsigned integer6 did;
end;

export rthor_data400__key__paw__autokey__nameb2	:=
record
	string40 cname_indic;
	string40 cname_sec;
	unsigned integer6 bdid;
	unsigned integer4 lookups;
end;

export rthor_data400__key__paw__autokey__namewords2	:=
record
	string40 word;
	string2 state;
	unsigned integer1 seq;
	unsigned integer6 bdid;
	unsigned integer4 lookups;
end;

standard__base	:=
record
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
	string5 zip5;
	string4 zip4;
	string2 fips_state;
	string3 fips_county;
	string2 addr_rec_type;
end;
standard__name	:=
record
	string5 title;
	string20 fname;
	string20 mname;
	string20 lname;
	string5 name_suffix;
	string3 name_score;
end;

export rthor_data400__key__paw__autokey__payload	:=
record
	unsigned integer6 fakeid;
	string120 company_name;
	unsigned integer6 contact_id;
	string9 ssn;
	string9 company_fein;
	string10 company_phone;
	unsigned integer6 did;
	string10 phone;
	unsigned integer6 bdid;
standard__base bus_addr;
standard__base person_addr;
standard__name person_name;
	unsigned integer1 zero;
end;

export rthor_data400__key__paw__autokey__phone2	:=
record
	string7 p7;
	string3 p3;
	string6 dph_lname;
	string20 pfname;
	string2 st;
	unsigned integer6 did;
	unsigned integer4 lookups;
end;

export rthor_data400__key__paw__autokey__phoneb2	:=
record
	string7 p7;
	string3 p3;
	string40 cname_indic;
	string40 cname_sec;
	string2 st;
	unsigned integer6 bdid;
	unsigned integer4 lookups;
end;

export rthor_data400__key__paw__autokey__ssn2	:=
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
	unsigned integer6 did;
	unsigned integer4 lookups;
end;

export rthor_data400__key__paw__autokey__stname	:=
record
	string2 st;
	string6 dph_lname;
	string20 lname;
	string20 pfname;
	string20 fname;
	string1 minit;
	unsigned integer2 yob;
	unsigned integer2 s4;
	integer4 zip;
	integer4 dob;
	unsigned integer8 states;
	unsigned integer4 lname1;
	unsigned integer4 lname2;
	unsigned integer4 lname3;
	unsigned integer4 city1;
	unsigned integer4 city2;
	unsigned integer4 city3;
	unsigned integer4 rel_fname1;
	unsigned integer4 rel_fname2;
	unsigned integer4 rel_fname3;
	unsigned integer4 lookups;
	unsigned integer6 did;
end;

export rthor_data400__key__paw__autokey__stnameb2	:=
record
	string2 st;
	string40 cname_indic;
	string40 cname_sec;
	unsigned integer6 bdid;
	unsigned integer4 lookups;
end;

export rthor_data400__key__paw__autokey__zip	:=
record
	integer4 zip;
	string6 dph_lname;
	string20 lname;
	string20 pfname;
	string20 fname;
	string1 minit;
	unsigned integer2 yob;
	unsigned integer2 s4;
	integer4 dob;
	unsigned integer8 states;
	unsigned integer4 lname1;
	unsigned integer4 lname2;
	unsigned integer4 lname3;
	unsigned integer4 city1;
	unsigned integer4 city2;
	unsigned integer4 city3;
	unsigned integer4 rel_fname1;
	unsigned integer4 rel_fname2;
	unsigned integer4 rel_fname3;
	unsigned integer4 lookups;
	unsigned integer6 did;
end;

export rthor_data400__key__paw__autokey__zipb2	:=
record
	integer4 zip;
	string40 cname_indic;
	string40 cname_sec;
	unsigned integer6 bdid;
	unsigned integer4 lookups;
end;

export rthor_data400__key__paw__bdid := { unsigned integer6 bdid, unsigned integer6 contact_id };

export rthor_data400__key__paw__contactid	:=
record
	unsigned integer6 contact_id;
	unsigned integer6 did;
	unsigned integer6 bdid;
	string9 ssn;
	string3 score;
	string120 company_name;
	string10 company_prim_range;
	string2 company_predir;
	string28 company_prim_name;
	string4 company_addr_suffix;
	string2 company_postdir;
	string5 company_unit_desig;
	string8 company_sec_range;
	string25 company_city;
	string2 company_state;
	string5 company_zip;
	string4 company_zip4;
	string35 company_title;
	string35 company_department;
	string10 company_phone;
	string9 company_fein;
	string5 title;
	string20 fname;
	string20 mname;
	string20 lname;
	string5 name_suffix;
	string10 prim_range;
	string2 predir;
	string28 prim_name;
	string4 addr_suffix;
	string2 postdir;
	string5 unit_desig;
	string8 sec_range;
	string25 city;
	string2 state;
	string5 zip;
	string4 zip4;
	string3 county;
	string4 msa;
	string10 geo_lat;
	string11 geo_long;
	string10 phone;
	string60 email_address;
	string8 dt_first_seen;
	string8 dt_last_seen;
	string1 record_type;
	string1 active_phone_flag;
	string1 glb;
	string2 source;
	string2 dppa_state;
	string3 old_score;
	unsigned integer6 source_count;
	unsigned integer1 dead_flag;
	string10 company_status;
	unsigned integer8 __internal_fpos__;
end;

export rthor_data400__key__paw__companyname_domain :=
record
  string50 domain;
  string120 company_name;
  string1 domain_type;
  real8 ratio;
  unsigned8 __internal_fpos__;
end;

export rthor_data400__key__paw__linkids	:=
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
  unsigned6 contact_id;
  unsigned6 did;
  unsigned6 bdid;
  string9 ssn;
  string3 score;
  string120 company_name;
  string10 company_prim_range;
  string2 company_predir;
  string28 company_prim_name;
  string4 company_addr_suffix;
  string2 company_postdir;
  string5 company_unit_desig;
  string8 company_sec_range;
  string25 company_city;
  string2 company_state;
  string5 company_zip;
  string4 company_zip4;
  string35 company_title;
  string35 company_department;
  string10 company_phone;
  string9 company_fein;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string5 unit_desig;
  string8 sec_range;
  string25 city;
  string2 state;
  string5 zip;
  string4 zip4;
  string3 county;
  string4 msa;
  string10 geo_lat;
  string11 geo_long;
  string10 phone;
  string60 email_address;
  string8 dt_first_seen;
  string8 dt_last_seen;
  string1 record_type;
  string1 active_phone_flag;
  string1 glb;
  string2 source;
  string2 dppa_state;
  string3 old_score;
  unsigned6 source_count;
  unsigned1 dead_flag;
  string10 company_status;
  string from_hdr;
  string vendor_id;
  unsigned8 rawaid;
  unsigned8 company_rawaid;
  integer1 fp;
end;

export rthor_data400__key__paw__did := { unsigned integer6 did, unsigned integer6 contact_id };
export dthor_data400__key__paw__autokey__address 			:= dataset(lCSVFileNamePrefix + 'thor_data400__key__paw__' + lCSVVersion + '__autokey__address.csv'			, rthor_data400__key__paw__autokey__address			, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__paw__autokey__addressb2 		:= dataset(lCSVFileNamePrefix + 'thor_data400__key__paw__' + lCSVVersion + '__autokey__addressb2.csv'		, rthor_data400__key__paw__autokey__addressb2		, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__paw__autokey__citystname 	:= dataset(lCSVFileNamePrefix + 'thor_data400__key__paw__' + lCSVVersion + '__autokey__citystname.csv'	, rthor_data400__key__paw__autokey__citystname	, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__paw__autokey__citystnameb2 := dataset(lCSVFileNamePrefix + 'thor_data400__key__paw__' + lCSVVersion + '__autokey__citystnameb2.csv', rthor_data400__key__paw__autokey__citystnameb2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__paw__autokey__fein2 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__paw__' + lCSVVersion + '__autokey__fein2.csv'				, rthor_data400__key__paw__autokey__fein2				, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__paw__autokey__name 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__paw__' + lCSVVersion + '__autokey__name.csv'				, rthor_data400__key__paw__autokey__name				, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__paw__autokey__nameb2 			:= dataset(lCSVFileNamePrefix + 'thor_data400__key__paw__' + lCSVVersion + '__autokey__nameb2.csv'			, rthor_data400__key__paw__autokey__nameb2			, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__paw__autokey__namewords2 	:= dataset(lCSVFileNamePrefix + 'thor_data400__key__paw__' + lCSVVersion + '__autokey__namewords2.csv'	, rthor_data400__key__paw__autokey__namewords2	, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__paw__autokey__payload 			:= dataset(lCSVFileNamePrefix + 'thor_data400__key__paw__' + lCSVVersion + '__autokey__payload.csv'			, rthor_data400__key__paw__autokey__payload			, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__paw__autokey__phone2 			:= dataset(lCSVFileNamePrefix + 'thor_data400__key__paw__' + lCSVVersion + '__autokey__phone2.csv'			, rthor_data400__key__paw__autokey__phone2			, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__paw__autokey__phoneb2 			:= dataset(lCSVFileNamePrefix + 'thor_data400__key__paw__' + lCSVVersion + '__autokey__phoneb2.csv'			, rthor_data400__key__paw__autokey__phoneb2			, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__paw__autokey__ssn2 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__paw__' + lCSVVersion + '__autokey__ssn2.csv'				, rthor_data400__key__paw__autokey__ssn2				, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__paw__autokey__stname 			:= dataset(lCSVFileNamePrefix + 'thor_data400__key__paw__' + lCSVVersion + '__autokey__stname.csv'			, rthor_data400__key__paw__autokey__stname			, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__paw__autokey__stnameb2 		:= dataset(lCSVFileNamePrefix + 'thor_data400__key__paw__' + lCSVVersion + '__autokey__stnameb2.csv'		, rthor_data400__key__paw__autokey__stnameb2		, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__paw__autokey__zip 					:= dataset(lCSVFileNamePrefix + 'thor_data400__key__paw__' + lCSVVersion + '__autokey__zip.csv'					, rthor_data400__key__paw__autokey__zip					, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__paw__autokey__zipb2 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__paw__' + lCSVVersion + '__autokey__zipb2.csv'				, rthor_data400__key__paw__autokey__zipb2				, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__paw__bdid 									:= dataset(lCSVFileNamePrefix + 'thor_data400__key__paw__' + lCSVVersion + '__bdid.csv'									, rthor_data400__key__paw__bdid									, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__paw__contactid 						:= dataset(lCSVFileNamePrefix + 'thor_data400__key__paw__' + lCSVVersion + '__contactid.csv'						, rthor_data400__key__paw__contactid						, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__paw__did 									:= dataset(lCSVFileNamePrefix + 'thor_data400__key__paw__' + lCSVVersion + '__did.csv'									, rthor_data400__key__paw__did									, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__paw__companyname_domain		:= dataset([], rthor_data400__key__paw__companyname_domain);
export dthor_data400__key__paw__linkids								:= dataset([], rthor_data400__key__paw__linkids);
end;