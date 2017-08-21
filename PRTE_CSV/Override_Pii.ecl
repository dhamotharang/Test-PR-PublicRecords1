export Override_Pii :=

module

	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'20100108';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;

export rthor_data400__key__override__pii__did	:=
record
	unsigned6 s_did;
	string13 uid;
	string8 date_created;
	string8 dt_first_seen;
	string8 dt_last_seen;
	string12 did;
	string20 fname;
	string20 mname;
	string20 lname;
	string5 name_suffix;
	string9 ssn;
	string8 dob;
	string2 predir;
	string28 prim_name;
	string10 prim_range;
	string4 suffix;
	string2 postdir;
	string10 unit_desig;
	string8 sec_range;
	string4 zip4;
	string51 address;
	string30 city_name;
	string2 st;
	string9 zip;
	string10 phone;
	string20 dl_number;
	string2 dl_state;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__override__pii__ssn	:=
record
	string9 ssn;
	string13 uid;
	string8 date_created;
	string8 dt_first_seen;
	string8 dt_last_seen;
	string12 did;
	string20 fname;
	string20 mname;
	string20 lname;
	string5 name_suffix;
	string8 dob;
	string2 predir;
	string28 prim_name;
	string10 prim_range;
	string4 suffix;
	string2 postdir;
	string10 unit_desig;
	string8 sec_range;
	string4 zip4;
	string51 address;
	string30 city_name;
	string2 st;
	string9 zip;
	string10 phone;
	string20 dl_number;
	string2 dl_state;
	unsigned8 __internal_fpos__;
end;

export dthor_data400__key__override__pii__did := dataset(lCSVFileNamePrefix + 'thor_data400__key__override__pii__' + lCSVVersion + '__did.csv', rthor_data400__key__override__pii__did, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__override__pii__ssn := dataset(lCSVFileNamePrefix + 'thor_data400__key__override__pii__' + lCSVVersion + '__ssn.csv', rthor_data400__key__override__pii__ssn, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
end;