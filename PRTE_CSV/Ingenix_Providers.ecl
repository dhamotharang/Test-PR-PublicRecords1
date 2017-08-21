export Ingenix_Providers := 

module

	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'20100713a';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;

export name := 
RECORD
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

export rthor_data400__key__ingenix_providerid_upin__providerid	:=
record
	string6 l_upin;
	unsigned6 l_providerid;
	string filetyp;
	string processdate;
	string providerid;
	string upin;
	string upincompanycount;
	string upintiertypeid;
	string8 dt_first_seen;
	string8 dt_last_seen;
	string8 dt_vendor_first_reported;
	string8 dt_vendor_last_reported;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__ingenix_providers__autokey__address	:=
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

export rthor_data400__key__ingenix_providers__autokey__citystname	:=
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

export rthor_data400__key__ingenix_providers__autokey__name	:=
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

export rthor_data400__key__ingenix_providers__autokey__payload	:=
record
	unsigned6 fakeid;
	string providerid;
	string addressid;
	string filetyp;
	string birthdate;
	string phonenumber;
	unsigned6 did;
	addr addr;
	name name;
	unsigned1 zero;
	string1 blank;
	unsigned6 lookups;
end;

export rthor_data400__key__ingenix_providers__autokey__phone2	:=
record
	string7 p7;
	string3 p3;
	string6 dph_lname;
	string20 pfname;
	string2 st;
	unsigned6 did;
	unsigned4 lookups;
end;

export rthor_data400__key__ingenix_providers__autokey__stname	:=
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

export rthor_data400__key__ingenix_providers__autokey__zip	:=
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

export rthor_data400__key__ingenix_residency__providerid	:=
record
	unsigned6 l_providerid;
	string12 bdid;
	string3 bdid_score;
	string8 dt_first_seen;
	string8 dt_last_seen;
	string8 dt_vendor_first_reported;
	string8 dt_vendor_last_reported;
	string filetyp;
	string processdate;
	string providerid;
	string residency;
	string residencycompanycount;
	string residencytiertypeid;
	unsigned8 __internal_fpos__;
end;

export dthor_data400__key__ingenix_providerid_upin__providerid 					:= dataset(lCSVFileNamePrefix + 'thor_data400__key__ingenix_providerid_upin__' + lCSVVersion + '__providerid.csv', rthor_data400__key__ingenix_providerid_upin__providerid, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ingenix_providers__autokey__address 					:= dataset(lCSVFileNamePrefix + 'thor_data400__key__ingenix_providers__' + lCSVVersion + '__autokey__address.csv', rthor_data400__key__ingenix_providers__autokey__address, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ingenix_providers__autokey__citystname 			:= dataset(lCSVFileNamePrefix + 'thor_data400__key__ingenix_providers__' + lCSVVersion + '__autokey__citystname.csv', rthor_data400__key__ingenix_providers__autokey__citystname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ingenix_providers__autokey__name 						:= dataset(lCSVFileNamePrefix + 'thor_data400__key__ingenix_providers__' + lCSVVersion + '__autokey__name.csv', rthor_data400__key__ingenix_providers__autokey__name, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ingenix_providers__autokey__payload 					:= dataset(lCSVFileNamePrefix + 'thor_data400__key__ingenix_providers__' + lCSVVersion + '__autokey__payload.csv', rthor_data400__key__ingenix_providers__autokey__payload, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ingenix_providers__autokey__phone2 					:= dataset(lCSVFileNamePrefix + 'thor_data400__key__ingenix_providers__' + lCSVVersion + '__autokey__phone2.csv', rthor_data400__key__ingenix_providers__autokey__phone2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ingenix_providers__autokey__stname 					:= dataset(lCSVFileNamePrefix + 'thor_data400__key__ingenix_providers__' + lCSVVersion + '__autokey__stname.csv', rthor_data400__key__ingenix_providers__autokey__stname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ingenix_providers__autokey__zip 							:= dataset(lCSVFileNamePrefix + 'thor_data400__key__ingenix_providers__' + lCSVVersion + '__autokey__zip.csv', rthor_data400__key__ingenix_providers__autokey__zip, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ingenix_residency__providerid 								:= dataset(lCSVFileNamePrefix + 'thor_data400__key__ingenix_residency__' + lCSVVersion + '__providerid.csv', rthor_data400__key__ingenix_residency__providerid, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
end;