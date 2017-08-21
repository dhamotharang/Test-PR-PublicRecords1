export Death_Masterv2 := 

module

	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;

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

export rthor_data400__key__death_masterv2__autokey__address	:=
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

export rthor_data400__key__death_masterv2__autokey__citystname	:=
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

export rthor_data400__key__death_masterv2__autokey__name	:=
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

export rthor_data400__key__death_masterv2__autokey__payload	:=
record
	unsigned6 fakeid;
	unsigned6 did;
	string9 ssn;
	string8 dob;
	addr addr;
	string15 fname;
	string15 mname;
	string20 lname;
	string16 state_death_id;
	unsigned1 zero;
	string1 blank;
	unsigned8 __internal_fpos__;
end;


export rthor_data400__key__death_masterv2__autokey__payload__new	:=
RECORD
  unsigned6 fakeid;
  unsigned6 did;
  string9 ssn;
  string8 dob;
  addr addr;
  string15 fname;
  string15 mname;
  string20 lname;
  string16 state_death_id;
  unsigned1 zero;
  string1 blank;
  string2 src := '';
  string1 glb_flag := '';
  unsigned8 __internal_fpos__;
 END;


export rthor_data400__key__death_masterv2__autokey__ssn2	:=
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

export rthor_data400__key__death_masterv2__autokey__stname	:=
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

export rthor_data400__key__death_masterv2__autokey__zip	:=
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

export rthor_data400__key__death_masterv2__death_id	:=
record
	string16 state_death_id;
	string12 did;
	unsigned1 did_score;
	string8 filedate;
	string1 rec_type;
	string1 rec_type_orig;
	string9 ssn;
	string20 lname;
	string4 name_suffix;
	string15 fname;
	string15 mname;
	string1 vorp_code;
	string8 dod8;
	string8 dob8;
	string2 st_country_code;
	string5 zip_lastres;
	string5 zip_lastpayment;
	string2 state;
	string3 fipscounty;
	string2 crlf;
	string18 county_name;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__death_masterv2__death_id__new	:=
RECORD
	string16 state_death_id;
  string12 did;
  unsigned1 did_score;
  string8 filedate;
  string1 rec_type;
  string1 rec_type_orig;
  string9 ssn;
  string20 lname;
  string4 name_suffix;
  string15 fname;
  string15 mname;
  string1 vorp_code;
  string8 dod8;
  string8 dob8;
  string2 st_country_code;
  string5 zip_lastres;
  string5 zip_lastpayment;
  string2 state;
  string3 fipscounty;
  string2 crlf;
	string1 state_death_flag := '';
  string3 death_rec_src := '';
  string2 src := '';
  string1 glb_flag := '';
  string18 county_name;
  unsigned8 __internal_fpos__;
 END;


export rthor_data400__key__death_masterv2__did	:=
record
     unsigned6 l_did;
     string12 did;
     unsigned1 did_score;
     string8 filedate;
     string1 rec_type;
     string1 rec_type_orig;
     string9 ssn;
     string20 lname;
     string4 name_suffix;
     string15 fname;
     string15 mname;
     string1 vorp_code;
     string8 dod8;
     string8 dob8;
     string2 st_country_code;
     string5 zip_lastres;
     string5 zip_lastpayment;
     string2 state;
     string3 fipscounty;
     string2 crlf;
		 string1 state_death_flag := '';
		 string3 death_rec_src := '';
     string16 state_death_id;
     string2 src := '';
     string1 glb_flag:='';
     string18 county_name;
     unsigned8 __internal_fpos__;
end;

export rthor_data400__key__death_masterv2__dob	:=
record
	string8 dob8;
	string2 state;
	string20 dph_lname;
	string25 pfname;
	string16 state_death_id;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__death_masterv2__dod	:=
record
	string8 dod8;
	string2 state;
	string20 dph_lname;
	string25 pfname;
	string16 state_death_id;
	unsigned8 __internal_fpos__;
end;

export dthor_data400__key__death_masterv2__autokey__address					:=	dataset(lCSVFileNamePrefix + 'thor_data400__key__death_masterv2__' + lCSVVersion + '__autokey__address.csv', rthor_data400__key__death_masterv2__autokey__address, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__death_masterv2__autokey__citystname			:=	dataset(lCSVFileNamePrefix + 'thor_data400__key__death_masterv2__' + lCSVVersion + '__autokey__citystname.csv', rthor_data400__key__death_masterv2__autokey__citystname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__death_masterv2__autokey__name						:=	dataset(lCSVFileNamePrefix + 'thor_data400__key__death_masterv2__' + lCSVVersion + '__autokey__name.csv', rthor_data400__key__death_masterv2__autokey__name, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__death_masterv2__autokey__payload 				:=	dataset(lCSVFileNamePrefix + 'thor_data400__key__death_masterv2__' + lCSVVersion + '__autokey__payload.csv', rthor_data400__key__death_masterv2__autokey__payload, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__death_masterv2__autokey__ssn2						:=	dataset(lCSVFileNamePrefix + 'thor_data400__key__death_masterv2__' + lCSVVersion + '__autokey__ssn2.csv', rthor_data400__key__death_masterv2__autokey__ssn2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__death_masterv2__autokey__stname					:=	dataset(lCSVFileNamePrefix + 'thor_data400__key__death_masterv2__' + lCSVVersion + '__autokey__stname.csv', rthor_data400__key__death_masterv2__autokey__stname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__death_masterv2__autokey__zip 						:=	dataset(lCSVFileNamePrefix + 'thor_data400__key__death_masterv2__' + lCSVVersion + '__autokey__zip.csv', rthor_data400__key__death_masterv2__autokey__zip, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__death_masterv2__death_id 								:=	dataset(lCSVFileNamePrefix + 'thor_data400__key__death_masterv2__' + lCSVVersion + '__death_id.csv', rthor_data400__key__death_masterv2__death_id, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__death_masterv2__did											:=	dataset(lCSVFileNamePrefix + 'thor_data400__key__death_masterv2__' + lCSVVersion + '__did.csv', rthor_data400__key__death_masterv2__did, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__death_masterv2__dob											:=	dataset(lCSVFileNamePrefix + 'thor_data400__key__death_masterv2__' + lCSVVersion + '__dob.csv', rthor_data400__key__death_masterv2__dob, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__death_masterv2__dod											:=	dataset(lCSVFileNamePrefix + 'thor_data400__key__death_masterv2__' + lCSVVersion + '__dod.csv', rthor_data400__key__death_masterv2__dod, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
end;
