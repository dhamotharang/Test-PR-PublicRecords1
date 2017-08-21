export SSNIssue2 := 

module

	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'20100715a';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;


export rthor_data400__key__ssnissue2__ssn5	:=
record
	string5 ssn5;
	string4 start_serial;
	string4 end_serial;
	string8 start_date;
	string8 end_date;
	string50 state;
	unsigned8 __internal_fpos__;
end;

export dthor_data400__key__ssnissue2__ssn5 := dataset(lCSVFileNamePrefix + 'thor_data400__key__ssnissue2__' + lCSVVersion + '__ssn5.csv', rthor_data400__key__ssnissue2__ssn5, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
end;