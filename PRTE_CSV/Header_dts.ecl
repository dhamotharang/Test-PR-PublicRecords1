export Header_dts := 

module

	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'20110201';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;

export rthor_data400__key__header__dts__fname_small	:=
record
	string20 pfname;
	string2 st;
	integer4 zip;
	unsigned3 dt_last_seen;
	string28 prim_name;
	unsigned3 dt_first_seen;
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

export rthor_data400__key__header__dts__pname_prange_st_city_sec_range_lname	:=
record
	string28 prim_name;
	string10 prim_range;
	string2 st;
	unsigned4 city_code;
	string5 zip;
	unsigned3 dt_last_seen;
	string8 sec_range;
	string6 dph_lname;
	string20 lname;
	string20 pfname;
	string20 fname;
	unsigned3 dt_first_seen;
	unsigned8 states;
	unsigned4 lname1;
	unsigned4 lname2;
	unsigned4 lname3;
	unsigned4 lookups;
	unsigned6 did;
end;

export rthor_data400__key__header__dts__pname_zip_name_range	:=
record
	string28 prim_name;
	integer4 zip;
	unsigned3 dt_last_seen;
	string6 dph_lname;
	string20 pfname;
	string10 prim_range;
	string20 lname;
	string20 fname;
	unsigned3 dt_first_seen;
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

export dthor_data400__key__header__dts__fname_small 													:= dataset(lCSVFileNamePrefix + 'thor_data400__key__header__dts__' + lCSVVersion + '__fname_small.csv', rthor_data400__key__header__dts__fname_small, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header__dts__pname_prange_st_city_sec_range_lname 	:= dataset(lCSVFileNamePrefix + 'thor_data400__key__header__dts__' + lCSVVersion + '__pname.prange.st.city.sec_range.lname.csv', rthor_data400__key__header__dts__pname_prange_st_city_sec_range_lname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header__dts__pname_zip_name_range 									:= dataset(lCSVFileNamePrefix + 'thor_data400__key__header__dts__' + lCSVVersion + '__pname.zip.name.range.csv', rthor_data400__key__header__dts__pname_zip_name_range, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
end;