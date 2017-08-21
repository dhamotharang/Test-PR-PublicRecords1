string ToCaps(string s) := stringlib.stringToUpperCase(s);

EXPORT Layout_Parms ExtractParms(Layout_In src) := TRANSFORM
	SELF.fname := ToCaps(REGEXFIND('FNAME=\\(([A-Z]+)\\)', src.search_str, 1));
	SELF.mname := ToCaps(REGEXFIND('MNAME=\\(([A-Z]+)\\)', src.search_str, 1));
	SELF.lname := ToCaps(REGEXFIND('LNAME=\\(([A-Z]+)\\)', src.search_str, 1));
	SELF.address := 
		ToCaps(TRIM(Stringlib.Stringfilterout(
			REGEXFIND('ADDRESS=\\(([0-9A-Z #./-]+)\\)', src.search_str, 1),
			'.-#/'),ALL));
	SELF.city := ToCaps(REGEXFIND('CITY=\\(([A-Z ]+)\\)', src.search_str, 1));
	SELF.state := ToCaps(REGEXFIND('STATE=\\(([A-Z]+)\\)', src.search_str, 1));
	SELF.zip := REGEXFIND('ZIP=\\(([0-9]+)\\)', src.search_str, 1);
	SELF.ssn := REGEXFIND('SSN=\\(([0-9]+)\\)', src.search_str, 1);
	SELF.dob := (integer)REGEXFIND('DOB=\\(([0-9]+)\\)', src.search_str, 1);
	SELF.phone := REGEXFIND('PHONE=\\(([0-9]+)\\)', src.search_str, 1);
	SELF.UID := (unsigned6)REGEXFIND('UID=([0-9]+)~',src.document_num,1);
	SELF.fullname := ToCaps(REGEXFIND('FULL_NAME=\\(([A-Z -]+)\\)', src.search_str, 1));
	SELF.busname := ToCaps(REGEXFIND('BUSINESS_NAME=\\((.+)\\)', src.search_str, 1));
	SELF.class := 
			TRIM(
			  IF(SELF.fname='','','F') +
			  IF(SELF.mname='','','M') +
			  IF(SELF.lname='','','L') +
			  IF(SELF.address='','','A') +
			  IF(SELF.city='','','C') +
			  IF(SELF.state='','','S') +
			  IF(SELF.zip='','','Z') +
			  IF(SELF.ssn='','','N') +
			  //IF(SELF.dob=0,'','D') +
			  MAP(
				SELF.dob=0 => '',
				SELF.dob<999999 => 'E',	// year & month
				'D'
			  ) +
			  IF(SELF.phone='','','P') +
			  IF (SELF.UID = 0, '','U') +
			  IF(SELF.fullname='','','X') +		// X for eXtended name
			  IF(SELF.busname='','','B')
			  ,ALL);
	SELF.searchstr := IF(SELF.UID != 0 AND src.search_str='', src.document_num,
							src.search_str);
	
	SELF := src;
END;