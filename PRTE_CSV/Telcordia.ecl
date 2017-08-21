export Telcordia := 

module

  shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'20080915';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;
	
	
	shared	lSubDirName1					:=	'';
	shared	lCSVVersion1					:=	'20081015';
	shared	lCSVFileNamePrefix1	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;

export rthor_data400__key__telcordia__tds	:=
record
  string3 npa;
  string3 nxx;
  string1 tb;
  string2 state;
  string1 timezone;
  string3 coctype;
  string4 ssc;
  string4 wireless_ind;
  unsigned8 __internal_fpos__;
end;

export rthor_data400__key__telcordia__npa_st := { string3 npa, string2 st, integer8 groupcount };

export rthor_data400__key__telcordia__tpm	:=
record
	string3 npa;
	string3 nxx;
	string1 tb;
	string50 city;
	string2 st;
	string30 ocn;
	string1 company_type;
	string2 nxx_type;
	string1 dial_ind;
	string1 point_id;
	string1 lf;
	string5 zip;
	unsigned integer8 __internal_fpos__;
end;

export dthor_data400__key__telcordia__20080915__tds 		:= dataset(lCSVFileNamePrefix + 'thor_data400__key__telcordia__' + lCSVVersion + '__tds.csv', rthor_data400__key__telcordia__tds, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__telcordia__20081015__npa_st 	:= dataset(lCSVFileNamePrefix1 + 'thor_data400__key__telcordia__' + lCSVVersion1 + '__npa_st.csv', rthor_data400__key__telcordia__npa_st, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__telcordia__20081015__tpm 		:= dataset(lCSVFileNamePrefix1 + 'thor_data400__key__telcordia__' + lCSVVersion1 + '__tpm.csv', rthor_data400__key__telcordia__tpm, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
end;