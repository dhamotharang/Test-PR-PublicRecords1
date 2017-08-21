export Fips2county := 

module

	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'20080724';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;
	
export	rthor_data400__key__fips2county__	:=
record
	string2 state_code;
	string3 county_fips;
	string18 county_name;
	unsigned integer8 __internal_fpos__;
end;

export dthor_data400__key__fips2county__:= dataset(lCSVFileNamePrefix  + 'thor_data400__key__fips2county__' + lCSVVersion + '.csv', rthor_data400__key__fips2county__, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
end;