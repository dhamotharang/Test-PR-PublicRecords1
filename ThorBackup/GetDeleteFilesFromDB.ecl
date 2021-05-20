import dops;
EXPORT GetDeleteFilesFromDB(string l_cluster = '',string l_daliip = '', string l_owner = '', string l_filename = '',boolean getallfiles = true, string excludedeletedfiles = '1'
					,string noofdays = '10'
					,string dopsenv = dops.constants.dopsenvironment) := function
	InputRec := record
		string cluster{xpath('cluster')} := l_cluster;
		string daliip{xpath('daliip')} := l_daliip;
		string fileowner{xpath('fileowner')} := l_owner;
		string filename{xpath('filename')} := l_filename;
		string getonlynondeletedfiles{xpath('getonlynondeletedfiles')} := excludedeletedfiles;
		string noofdays{xpath('noofdays')} := noofdays;
	end;
	
	outrec := record
		string filename {xpath('filename')};
		string filepattern {xpath('filepattern')};
		string modified {xpath('modified')};
		unsigned size {xpath('size')};
		string owner {xpath('owner')};
		string cluster {xpath('cluster')};
		integer totalmatchedfiles {xpath('totalmatchedfiles')};
		string daliip {xpath('daliip')};
		string issetfordelete {xpath('issetfordelete')};
		string statuscode {xpath('statuscode')};
		string statusdescription {xpath('statusdescription')};
		integer noofdays {xpath('noofdays')};
		string emailid {xpath('emailid')};
		integer excludeme{xpath('excludeme')};
		
	end;
	
	soapresults := SOAPCALL(
				dops.constants.prboca.serviceurl(dopsenv),
				'GetThorFileList',
				InputRec,
				dataset(outrec),
				xpath('GetThorFileListResponse/GetThorFileListResult/filelist'),
				NAMESPACE('http://lexisnexis.com/'),
				LITERAL,
				SOAPACTION('http://lexisnexis.com/GetThorFileList'));
	
	
	return if (getallfiles, soapresults, soapresults(issetfordelete = '0'));
	

	
end;