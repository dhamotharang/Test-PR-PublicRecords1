export Bankruptcy := 

module
					
	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;

	 export rthor_data400__key__bankruptcy__autokey__address	:=
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

  export rthor_data400__key__bankruptcy__autokey__addressb2	:=
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

 export rthor_data400__key__bankruptcy__autokey__citystname	:=
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

export rthor_data400__key__bankruptcy__autokey__citystnameb2	:=
record
	unsigned4 city_code;
	string2 st;
	string40 cname_indic;
	string40 cname_sec;
	unsigned6 bdid;
	unsigned4 lookups;
end;

export rthor_data400__key__bankruptcy__autokey__fein2	:=
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
	unsigned6 bdid;
	unsigned4 lookups;
end;

export rthor_data400__key__bankruptcy__autokey__name	:=
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

export rthor_data400__key__bankruptcy__autokey__nameb2	:=
record
	string40 cname_indic;
	string40 cname_sec;
	unsigned6 bdid;
	unsigned4 lookups;
end;

export rthor_data400__key__bankruptcy__autokey__namewords2	:=
record
	string40 word;
	string2 state;
	unsigned1 seq;
	unsigned6 bdid;
	unsigned4 lookups;
end;

addr	:=
record
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
end;
name	:=
record
	string5 title;
	string20 fname;
	string20 mname;
	string20 lname;
	string5 name_suffix;
	string3 name_score;
end;
export rthor_data400__key__bankruptcy__autokey__payload	:=
record
	unsigned6 fakeid;
	string2 name_type;
	unsigned4 party_bits;
	unsigned1 zero;
	string50 tmsid;
	unsigned6 intdid;
	unsigned6 intbdid;
	string150 cname;
	string9 ssn;
	string9 tax_id;
	addr company_addr;
	addr person_addr;
	name person_name;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__bankruptcy__autokey__phone2	:=
record
	string7 p7;
	string3 p3;
	string6 dph_lname;
	string20 pfname;
	string2 st;
	unsigned6 did;
	unsigned4 lookups;
end;

export rthor_data400__key__bankruptcy__autokey__phoneb2	:=
record
	string7 p7;
	string3 p3;
	string40 cname_indic;
	string40 cname_sec;
	string2 st;
	unsigned6 bdid;
	unsigned4 lookups;
end;

export rthor_data400__key__bankruptcy__autokey__ssn2	:=
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

export rthor_data400__key__bankruptcy__autokey__ssnlast4name := 
record
  string1 s6;
  string1 s7;
  string1 s8;
  string1 s9;
  string6 dph_lname;
  string20 lname;
  string20 fname;
  string20 pfname;
  string1 minit;
  unsigned6 did;
end;

export rthor_data400__key__bankruptcy__autokey__stname	:=
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

export rthor_data400__key__bankruptcy__autokey__stnameb2	:=
record
	string2 st;
	string40 cname_indic;
	string40 cname_sec;
	unsigned6 bdid;
	unsigned4 lookups;
end;

export rthor_data400__key__bankruptcy__autokey__zip	:=
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

export rthor_data400__key__bankruptcy__autokey__zipb2	:=
record
	integer4 zip;
	string40 cname_indic;
	string40 cname_sec;
	unsigned6 bdid;
	unsigned4 lookups;
end;

export dthor_data400__key__bankruptcy__autokey__address 		:= dataset(lCSVFileNamePrefix + 'thor_data400__key__bankruptcy__'+ lCSVVersion + '__autokey__address.csv', rthor_data400__key__bankruptcy__autokey__address, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__bankruptcy__autokey__addressb2 	:= dataset(lCSVFileNamePrefix + 'thor_data400__key__bankruptcy__'+ lCSVVersion + '__autokey__addressb2.csv', rthor_data400__key__bankruptcy__autokey__addressb2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__bankruptcy__autokey__citystname 	:= dataset(lCSVFileNamePrefix + 'thor_data400__key__bankruptcy__'+ lCSVVersion + '__autokey__citystname.csv', rthor_data400__key__bankruptcy__autokey__citystname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__bankruptcy__autokey__citystnameb2:= dataset(lCSVFileNamePrefix + 'thor_data400__key__bankruptcy__'+ lCSVVersion + '__autokey__citystnameb2.csv',rthor_data400__key__bankruptcy__autokey__citystnameb2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__bankruptcy__autokey__fein2 			:= dataset([], rthor_data400__key__bankruptcy__autokey__fein2); //dataset(lCSVFileNamePrefix + 'thor_data400__key__bankruptcy__'+ lCSVVersion + '__autokey__fein2.csv', rthor_data400__key__bankruptcy__autokey__fein2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__bankruptcy__autokey__name 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__bankruptcy__'+ lCSVVersion + '__autokey__name.csv', rthor_data400__key__bankruptcy__autokey__name, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__bankruptcy__autokey__nameb2 			:= dataset(lCSVFileNamePrefix + 'thor_data400__key__bankruptcy__'+ lCSVVersion + '__autokey__nameb2.csv', rthor_data400__key__bankruptcy__autokey__nameb2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__bankruptcy__autokey__namewords2 	:= dataset(lCSVFileNamePrefix + 'thor_data400__key__bankruptcy__'+ lCSVVersion + '__autokey__namewords2.csv', rthor_data400__key__bankruptcy__autokey__namewords2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__bankruptcy__autokey__payload 		:= dataset(lCSVFileNamePrefix + 'thor_data400__key__bankruptcy__'+ lCSVVersion + '__autokey__payload.csv', rthor_data400__key__bankruptcy__autokey__payload, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__bankruptcy__autokey__phone2 			:= dataset([], rthor_data400__key__bankruptcy__autokey__phone2); //dataset(lCSVFileNamePrefix + 'thor_data400__key__bankruptcy__'+ lCSVVersion + '__autokey__phone2.csv', rthor_data400__key__bankruptcy__autokey__phone2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__bankruptcy__autokey__phoneb2 		:= dataset([], rthor_data400__key__bankruptcy__autokey__phoneb2); //dataset(lCSVFileNamePrefix + 'thor_data400__key__bankruptcy__'+ lCSVVersion + '__autokey__phoneb2.csv', rthor_data400__key__bankruptcy__autokey__phoneb2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__bankruptcy__autokey__ssn2 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__bankruptcy__'+ lCSVVersion + '__autokey__ssn2.csv', rthor_data400__key__bankruptcy__autokey__ssn2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__bankruptcy__autokey__ssnlast4name:= dataset([], rthor_data400__key__bankruptcy__autokey__ssnlast4name); //dataset(lCSVFileNamePrefix + 'thor_data400__key__bankruptcy__'+ lCSVVersion + '__autokey__ssnlast4name.csv', rthor_data400__key__bankruptcy__autokey__ssnlast4name, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__bankruptcy__autokey__stname 			:= dataset(lCSVFileNamePrefix + 'thor_data400__key__bankruptcy__'+ lCSVVersion + '__autokey__stname.csv', rthor_data400__key__bankruptcy__autokey__stname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__bankruptcy__autokey__stnameb2 		:= dataset(lCSVFileNamePrefix + 'thor_data400__key__bankruptcy__'+ lCSVVersion + '__autokey__stnameb2.csv', rthor_data400__key__bankruptcy__autokey__stnameb2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__bankruptcy__autokey__zip 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__bankruptcy__'+ lCSVVersion + '__autokey__zip.csv', rthor_data400__key__bankruptcy__autokey__zip, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__bankruptcy__autokey__zipb2 			:= dataset(lCSVFileNamePrefix + 'thor_data400__key__bankruptcy__'+ lCSVVersion + '__autokey__zipb2.csv', rthor_data400__key__bankruptcy__autokey__zipb2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
end;