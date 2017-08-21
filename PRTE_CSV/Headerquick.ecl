export Headerquick := 

module

	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'20091222';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;
	
export rthor_data400__key__headerquick__autokey_address	:=
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

export rthor_data400__key__headerquick__autokey_citystname	:=
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

export rthor_data400__key__headerquick__autokey_name	:=
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

export rthor_data400__key__headerquick__autokey_payload	:=
record
	integer8 fakeid;
	unsigned6 did;
	unsigned6 rid;
	string1 pflag1;
	string1 pflag2;
	string1 pflag3;
	string2 src;
	unsigned3 dt_first_seen;
	unsigned3 dt_last_seen;
	unsigned3 dt_vendor_last_reported;
	unsigned3 dt_vendor_first_reported;
	unsigned3 dt_nonglb_last_seen;
	string1 rec_type;
	qstring18 vendor_id;
	qstring10 phone;
	qstring9 ssn;
	integer4 dob;
	qstring5 title;
	qstring20 fname;
	qstring20 mname;
	qstring20 lname;
	qstring5 name_suffix;
	qstring10 prim_range;
	string2 predir;
	qstring28 prim_name;
	qstring4 suffix;
	string2 postdir;
	qstring10 unit_desig;
	qstring8 sec_range;
	qstring25 city_name;
	string2 st;
	qstring5 zip;
	qstring4 zip4;
	string3 county;
	qstring7 geo_blk;
	qstring5 cbsa;
	string1 tnt;
	string1 valid_ssn;
	string1 jflag1;
	string1 jflag2;
	string1 jflag3;
	unsigned8 rawaid;
	integer1 zero1;
	integer1 zero2;
	string1 blank;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__headerquick__autokey_phone	:=
record
	string7 p7;
	string3 p3;
	string6 dph_lname;
	string20 pfname;
	string2 st;
	unsigned6 did;
end;

export rthor_data400__key__headerquick__autokey_ssn	:=
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

export rthor_data400__key__headerquick__autokey_stname	:=
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

export rthor_data400__key__headerquick__autokey_zip	:=
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

export rthor_data400__key__headerquick__autokey_zipprlname	:=
record
	integer4 zip;
	string10 prim_range;
	string20 lname;
	unsigned4 lookups;
	unsigned6 did;
end;

export rthor_data400__key__headerquick__did	:=
record
  unsigned6 did;
  unsigned6 rid;
  string1 pflag1;
  string1 pflag2;
  string1 pflag3;
  string2 src;
  unsigned3 dt_first_seen;
  unsigned3 dt_last_seen;
  unsigned3 dt_vendor_last_reported;
  unsigned3 dt_vendor_first_reported;
  unsigned3 dt_nonglb_last_seen;
  string1 rec_type;
  qstring18 vendor_id;
  qstring10 phone;
  qstring9 ssn;
  integer4 dob;
  qstring5 title;
  qstring20 fname;
  qstring20 mname;
  qstring20 lname;
  qstring5 name_suffix;
  qstring10 prim_range;
  string2 predir;
  qstring28 prim_name;
  qstring4 suffix;
  string2 postdir;
  qstring10 unit_desig;
  qstring8 sec_range;
  qstring25 city_name;
  string2 st;
  qstring5 zip;
  qstring4 zip4;
  string3 county;
  qstring7 geo_blk;
  qstring5 cbsa;
  string1 tnt;
  string1 valid_ssn;
  string1 jflag1;
  string1 jflag2;
  string1 jflag3;
  unsigned8 rawaid;
end;

export dthor_data400__key__headerquick__autokey_address 						:= dataset(lCSVFileNamePrefix + 'thor_data400__key__headerquick__' + lCSVVersion + '__autokey_address.csv', rthor_data400__key__headerquick__autokey_address, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__headerquick__autokey_citystname 					:= dataset(lCSVFileNamePrefix + 'thor_data400__key__headerquick__' + lCSVVersion + '__autokey_citystname.csv', rthor_data400__key__headerquick__autokey_citystname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__headerquick__autokey_name 								:= dataset(lCSVFileNamePrefix + 'thor_data400__key__headerquick__' + lCSVVersion + '__autokey_name.csv', rthor_data400__key__headerquick__autokey_name, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__headerquick__autokey_payload 						:= dataset(lCSVFileNamePrefix + 'thor_data400__key__headerquick__' + lCSVVersion + '__autokey_payload.csv', rthor_data400__key__headerquick__autokey_payload, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__headerquick__autokey_phone 							:= dataset(lCSVFileNamePrefix + 'thor_data400__key__headerquick__' + lCSVVersion + '__autokey_phone.csv', rthor_data400__key__headerquick__autokey_phone, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__headerquick__autokey_ssn 								:= dataset(lCSVFileNamePrefix + 'thor_data400__key__headerquick__' + lCSVVersion + '__autokey_ssn.csv', rthor_data400__key__headerquick__autokey_ssn, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__headerquick__autokey_stname 							:= dataset(lCSVFileNamePrefix + 'thor_data400__key__headerquick__' + lCSVVersion + '__autokey_stname.csv', rthor_data400__key__headerquick__autokey_stname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__headerquick__autokey_zip 								:= dataset(lCSVFileNamePrefix + 'thor_data400__key__headerquick__' + lCSVVersion + '__autokey_zip.csv', rthor_data400__key__headerquick__autokey_zip, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__headerquick__autokey_zipprlname 					:= dataset(lCSVFileNamePrefix + 'thor_data400__key__headerquick__' + lCSVVersion + '__autokey_zipprlname.csv', rthor_data400__key__headerquick__autokey_zipprlname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__headerquick__did 												:= dataset(lCSVFileNamePrefix + 'thor_data400__key__headerquick__' + lCSVVersion + '__did.csv', rthor_data400__key__headerquick__did, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
end;