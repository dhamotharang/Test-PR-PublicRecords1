export Smart_Jury := 

module

	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'20080923';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;

export rthor_400__key__smart_jury__data	:=
record
	string2 stusab;
	string3 county;
	string6 tract;
	string1 blkgrp;
	string5 age;
	string9 income;
	string9 home_value;
	string5 education;
	unsigned integer8 __internal_fpos__;
end;

export dthor_400__key__smart_jury__data := dataset(lCSVFileNamePrefix + 'thor_400__key__smart_jury__' + lCSVVersion + '__data.csv', rthor_400__key__smart_jury__data, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
end;