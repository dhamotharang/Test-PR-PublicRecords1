export Key_Codes := 

module

	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'20080724';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;

export rthor_data400__key__codes__codes_v3	:=
record
	string35 file_name;
	string50 field_name;
	string5 field_name2;
	string15 code;
	string330 long_desc;
	unsigned integer8 __fpos;
end;

export dthor_data400__key__codes__codes_v3 := dataset(lCSVFileNamePrefix + 'thor_data400__key__codes__' + lCSVVersion + '__codes_v3.csv', rthor_data400__key__codes__codes_v3, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
end;
