export Pullssn := 

module

	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'20091214';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;

export rthor_data400__key__pullssn__ssn := { string60 ssn, unsigned8 __internal_fpos__ };

export dthor_data400__key__pullssn__ssn := dataset(lCSVFileNamePrefix + 'thor_data400__key__pullssn__' + lCSVVersion + '__ssn.csv', rthor_data400__key__pullssn__ssn, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
end;