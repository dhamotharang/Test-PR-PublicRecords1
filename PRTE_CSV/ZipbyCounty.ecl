export ZipbyCounty := 

module

	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'20080918';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;

export rthor_data400__key__zipbycounty__zip	:=
record
	string18 county_name;
	string2 state_code;
	string5 zip5;
	unsigned integer8 __internal_fpos__;
end;

export dthor_data400__key__zipbycounty__zip := dataset(lCSVFileNamePrefix + 'thor_data400__key__zipbycounty__' + lCSVVersion + '__zip.csv', rthor_data400__key__zipbycounty__zip, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
end;