export CityStZip := 

module

	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'20121206';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;

export rthor_data400__key__citystzip__citystzip	:=
record
	string5 zip5;
	string1 zipclass;
	string28 city;
	string2 state;
	string25 county;
	string28 prefctystname;
	unsigned integer8 __internal_fpos__;
end;

export zthor_data400__key__zipcityst__zipcityst	:=
RECORD
  string28 city;
  string2 state;
  string5 zip5;
  string1 zipclass;
  string25 county;
  string28 prefctystname;
  unsigned8 __internal_fpos__;
 END;



export dthor_data400__key__citystzip__citystzip := dataset(lCSVFileNamePrefix + 'thor_data400__key__citystzip__'+ lCSVVersion +'__citystzip.csv', rthor_data400__key__citystzip__citystzip, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export sthor_data400__key__zipcityst__zipcityst := dataset(lCSVFileNamePrefix + 'thor_data400__key__zipcityst__'+ lCSVVersion +'__zipcityst.csv', zthor_data400__key__zipcityst__zipcityst, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
end;