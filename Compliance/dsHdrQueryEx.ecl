rHdrQueryEx x(HdrQueryData src) := TRANSFORM
	SELF.fname := REGEXFIND('FNAME=\\(([A-Z]+)\\)', src.searchstr, 1);
	SELF.mname := REGEXFIND('MNAME=\\(([A-Z]+)\\)', src.searchstr, 1);
	SELF.lname := REGEXFIND('LNAME=\\(([A-Z]+)\\)', src.searchstr, 1);
	SELF.address := 
		TRIM(Stringlib.Stringfilterout(
			REGEXFIND('ADDRESS=\\(([0-9A-Z #./-]+)\\)', src.searchstr, 1),
			'.-#/'),ALL);
	SELF.city := REGEXFIND('CITY=\\(([A-Z ]+)\\)', src.searchstr, 1);
	SELF.state := REGEXFIND('STATE=\\(([A-Z]+)\\)', src.searchstr, 1);
	SELF.zip := REGEXFIND('ZIP=\\(([0-9]+)\\)', src.searchstr, 1);
	SELF.ssn := REGEXFIND('SSN=\\(([0-9]+)\\)', src.searchstr, 1);
	SELF.dob := (integer)REGEXFIND('DOB=\\(([0-9]+)\\)', src.searchstr, 1);
	SELF.phone := REGEXFIND('PHONE=\\(([0-9]+)\\)', src.searchstr, 1);
	SELF.UID := (unsigned6)REGEXFIND('UID=([0-9]+)~',src.uidstr,1);
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
			  IF (SELF.UID = 0, '','U')
			  ,ALL);
	SELF.searchstr := IF(SELF.UID != 0 AND src.searchstr='', src.uidstr,
							src.searchstr);
	//SELF := src;
	//SELF := [];
END;

EXPORT dsHdrQueryEx := PROJECT(HdrQueryData, x(LEFT));

