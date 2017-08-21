export SSN_Suppression := 

module

	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'20080915';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;

export rthor_data400__key__ssn_suppression	:=
record
	string9 ssn;
	string ssn_mask;
	string rc;
	unsigned integer8 __internal_fpos__;
end;

export dthor_data400__key__ssn_suppression := dataset(lCSVFileNamePrefix + 'thor_data400__key__' + lCSVVersion + '__ssn_suppression.csv', rthor_data400__key__ssn_suppression, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
end;