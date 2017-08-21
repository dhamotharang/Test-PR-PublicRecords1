export Header_wild := 

module

	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'20110201';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;

export rthor_data400__key__header_wild__fname_small	:=
record
	string20 fname;
	string2 st;
	integer4 zip;
	string28 prim_name;
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
	integer8 fname_count;
end;

export rthor_data400__key__header_wild__lname_fname	:=
record
	string20 lname;
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

export rthor_data400__key__header_wild__phone	:=
record
	string7 p7;
	string3 p3;
	string20 lname;
	string20 fname;
	string2 st;
	unsigned6 did;
end;

export rthor_data400__key__header_wild__pname_prange_st_city_sec_range_lname	:=
record
	string28 prim_name;
	string10 prim_range;
	string2 st;
	unsigned4 city_code;
	string5 zip;
	string8 sec_range;
	string20 lname;
	string20 fname;
	unsigned8 states;
	unsigned4 lname1;
	unsigned4 lname2;
	unsigned4 lname3;
	unsigned4 lookups;
	unsigned6 did;
end;

export rthor_data400__key__header_wild__pname_zip_name_range	:=
record
	string28 prim_name;
	integer4 zip;
	string10 prim_range;
	string20 lname;
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

export rthor_data400__key__header_wild__ssn_did	:=
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
	string20 lname;
	string20 fname;
	unsigned6 did;
end;

export rthor_data400__key__header_wild__st_city_fname_lname	:=
record
	unsigned4 city_code;
	string2 st;
	string20 lname;
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

export rthor_data400__key__header_wild__st_fname_lname	:=
record
	string2 st;
	string20 lname;
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

export rthor_data400__key__header_wild__zip_lname_fname	:=
record
	integer4 zip;
	string20 lname;
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


export dthor_data400__key__header_wild__fname_small 													:= dataset(lCSVFileNamePrefix  + 'thor_data400__key__header_wild__' + lCSVVersion + '__fname_small.csv', rthor_data400__key__header_wild__fname_small, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header_wild__lname_fname 													:= dataset(lCSVFileNamePrefix  + 'thor_data400__key__header_wild__' + lCSVVersion + '__lname.fname.csv', rthor_data400__key__header_wild__lname_fname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header_wild__phone 																:= dataset(lCSVFileNamePrefix  + 'thor_data400__key__header_wild__' + lCSVVersion + '__phone.csv', rthor_data400__key__header_wild__phone, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header_wild__pname_prange_st_city_sec_range_lname 	:= dataset(lCSVFileNamePrefix  + 'thor_data400__key__header_wild__' + lCSVVersion + '__pname.prange.st.city.sec_range.lname.csv', rthor_data400__key__header_wild__pname_prange_st_city_sec_range_lname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header_wild__pname_zip_name_range 									:= dataset(lCSVFileNamePrefix  + 'thor_data400__key__header_wild__' + lCSVVersion + '__pname.zip.name.range.csv', rthor_data400__key__header_wild__pname_zip_name_range, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header_wild__ssn_did 															:= dataset(lCSVFileNamePrefix  + 'thor_data400__key__header_wild__' + lCSVVersion + '__ssn.did.csv', rthor_data400__key__header_wild__ssn_did, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header_wild__st_city_fname_lname    								:= dataset(lCSVFileNamePrefix  + 'thor_data400__key__header_wild__' + lCSVVersion + '__st.city.fname.lname.csv', rthor_data400__key__header_wild__st_city_fname_lname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header_wild__st_fname_lname 												:= dataset(lCSVFileNamePrefix  + 'thor_data400__key__header_wild__' + lCSVVersion + '__st.fname.lname.csv', rthor_data400__key__header_wild__st_fname_lname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header_wild__zip_lname_fname 											:= dataset(lCSVFileNamePrefix  + 'thor_data400__key__header_wild__' + lCSVVersion + '__zip.lname.fname.csv', rthor_data400__key__header_wild__zip_lname_fname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
end;