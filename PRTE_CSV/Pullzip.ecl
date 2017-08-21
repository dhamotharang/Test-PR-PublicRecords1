export Pullzip := 

module

	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'20051201b';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;

export rthor_data400__key__pullzip__zip := { string5 zip, unsigned integer8 __internal_fpos__ };

export dthor_data400__key__pullzip__zip := dataset(lCSVFileNamePrefix + 'thor_data400__key__pullzip__' + lCSVVersion + '__zip.csv', rthor_data400__key__pullzip__zip, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
end;