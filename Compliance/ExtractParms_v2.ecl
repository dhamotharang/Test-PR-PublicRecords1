
string ToCaps(string s) := stringlib.stringToUpperCase(s);

EXPORT Compliance.Layout_Parms_v2 ExtractParms_v2(Compliance.Layout_In srch) := 
	TRANSFORM
		SELF.fname := MAP(REGEXFIND('FNAME',srch.search_str) 			=> REGEXFIND('FNAME=\\(([0-9A-Z* ,#./-]+)\\)', ToCaps(srch.search_str), 1),
											REGEXFIND('first-name',srch.search_str, nocase) => REGEXFIND('FIRST-NAME\\(([0-9A-Z* ,#./-]+)\\)', ToCaps(srch.search_str), 1),
											''
										 );
		SELF.mname := MAP(REGEXFIND('MNAME',srch.search_str) 				=> REGEXFIND('MNAME=\\(([0-9A-Z* ,#./-]+)\\)', ToCaps(srch.search_str), 1),
											REGEXFIND('middle-name',srch.search_str, nocase) 	=> REGEXFIND('MIDDLE-NAME\\(([0-9A-Z* ,#./-]+)\\)', ToCaps(srch.search_str), 1),
											''
										 );								 
		
		SELF.lname := MAP(REGEXFIND('LNAME',srch.search_str) 			=> TRIM(Stringlib.Stringfilterout(
																																			REGEXFIND('LNAME=\\(([0-9A-Z* ,#./-]+)\\)', ToCaps(srch.search_str), 1),
																																			'*0123456789,.-#/'),left,right),
											REGEXFIND('last-name',srch.search_str, nocase) 	=> TRIM(Stringlib.Stringfilterout(
																																			REGEXFIND('LAST-NAME\\(([0-9A-Z* ,#./-]+)\\)', ToCaps(srch.search_str), 1),
																																			'*0123456789,.-#/'),left,right),
											''
										 );								 
		
		SELF.address := MAP(REGEXFIND('ADDRESS',srch.search_str) 			=> TRIM(Stringlib.Stringfilterout(
																																					REGEXFIND('ADDRESS=\\(([0-9A-Z* ,#./-]+)\\)', ToCaps(srch.search_str), 1),
																																					'*,.-#/'),left,right),
												REGEXFIND('street address',srch.search_str, nocase) 	=> TRIM(Stringlib.Stringfilterout(
																																					REGEXFIND('STREET ADDRESS\\(([0-9A-Z* ,#./-]+)\\)', ToCaps(srch.search_str), 1),
																																					'*,.-#/'),left,right),
												''
											 );
		
		SELF.city := MAP(REGEXFIND('CITY',srch.search_str) 	=> REGEXFIND('CITY=\\(([0-9A-Z* ,#./-]+)\\)', ToCaps(srch.search_str), 1),
										 REGEXFIND('city',srch.search_str) 	=> REGEXFIND('CITY\\(([0-9A-Z* ,#./-]+)\\)', ToCaps(srch.search_str), 1),
											''
										 );
		
//		SELF.state := MAP(REGEXFIND('STATE',srch.search_str) 	=> REGEXFIND('STATE=\\(([A-Z]+)\\)', ToCaps(srch.search_str), 1),
//										  REGEXFIND('state',srch.search_str) 	=> REGEXFIND('STATE\\(([A-Z]+)\\)', ToCaps(srch.search_str), 1),
			SELF.state := MAP(REGEXFIND('STATE',regexreplace('ALL',srch.search_str, '',nocase)) 	=> REGEXFIND('STATE=\\(([A-Z]+)\\)', ToCaps(regexreplace('ALL',srch.search_str, '',nocase)), 1),
												REGEXFIND('state',regexreplace('ALL',srch.search_str, '',nocase)) 	=> REGEXFIND('STATE\\(([A-Z]+)\\)', ToCaps(regexreplace('ALL',srch.search_str, '',nocase)), 1),
											''
										 );
		
		
		SELF.zip := MAP(REGEXFIND('ZIP',srch.search_str) 			=> REGEXFIND('ZIP=\\(([0-9]+)\\)', ToCaps(srch.search_str), 1),
										REGEXFIND('zip code',srch.search_str, nocase) => REGEXFIND('ZIP CODE\\(([0-9]+)\\)', ToCaps(srch.search_str), 1),
										''
									 );
		
		SELF.ssn := MAP(REGEXFIND('SSN',srch.search_str) 	=> REGEXFIND('SSN=\\(([0-9-]+)\\)', ToCaps(regexreplace('-',srch.search_str, '', nocase)), 1),
										REGEXFIND('ssn',srch.search_str) 	=> REGEXFIND('SSN\\(([0-9-]+)\\)', ToCaps(regexreplace('-',srch.search_str, '', nocase)), 1),
										''
									 );
		
		SELF.dob := MAP(REGEXFIND('DOB',srch.search_str) 	=> (integer) REGEXFIND('DOB=\\(([0-9]+)\\)', ToCaps(srch.search_str), 1),
										REGEXFIND('dob',srch.search_str) 	=> (integer) REGEXFIND('DOB\\(([0-9]+)\\)', ToCaps(srch.search_str), 1),
										0
									 );
		
		SELF.phone := MAP(REGEXFIND('PHONE',srch.search_str) 	=> REGEXFIND('PHONE=\\(([0-9]+)\\)', ToCaps(srch.search_str), 1),
										REGEXFIND('phone',Stringlib.Stringfilterout(srch.search_str,') -')) 		=> REGEXFIND('PHONE\\(([0-9]+)\\)', ToCaps(Stringlib.Stringfilterout(srch.search_str,') -')), 1),
										''
									 );
		
		SELF.UID := MAP(REGEXFIND('LexID',srch.search_str, nocase) 				=> (unsigned6) REGEXFIND('LEXID\\(([0-9]+)\\)', ToCaps(srch.search_str), 1),
										REGEXFIND('businessid',srch.search_str, nocase) 	=> (unsigned6) REGEXFIND('BUSINESSID\\(([0-9]+)\\)', ToCaps(srch.search_str), 1),
//										REGEXFIND('',trim(srch.search_str,all)) 	=> (unsigned6) REGEXFIND('UID=([0-9-]+)~', ToCaps(srch.document_num), 1),
										
										0
									 );
		
		SELF.fullname := REGEXFIND('FULL_NAME=\\(([0-9A-Z* ,#./-]+)\\)', ToCaps(srch.search_str), 1);		//new
		
		SELF.tag := REGEXFIND('TAG\\(([0-9A-Z* ,#./-]+)\\)', ToCaps(srch.search_str), 1);		//new
		
		SELF.vin := REGEXFIND('VIN\\(([0-9A-Z* ,#./-]+)\\)', ToCaps(srch.search_str), 1);		//new
		
//		SELF.busname := REGEXFIND('BUSINESS_NAME=\\((.+)\\)', ToCaps(srch.search_str), 1);				//new
		SELF.busname := MAP(REGEXFIND('BUSINESS_NAME',srch.search_str) 	=> REGEXFIND('BUSINESS_NAME=\\(([0-9A-Z* ,#./-]+)\\)', ToCaps(srch.search_str), 1),
											 REGEXFIND('company',srch.search_str) 				=> REGEXFIND('COMPANY\\(([0-9A-Z* ,#./-]+)\\)', ToCaps(srch.search_str), 1),
											 REGEXFIND('FULL_NAME',srch.search_str) 			=> REGEXFIND('FULL_NAME=\\(([0-9A-Z* ,#./-]+)\\)', ToCaps(srch.search_str), 1),
												''
											 );
		
		
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
					IF(SELF.busname='','','B') +
					
					IF(SELF.tag='','','T') +
					IF(SELF.vin='','','V') +
					IF(SELF.fullname='','','X') 		// X for eXtended name
					,ALL);
					
//		SELF.searchstr := IF(SELF.UID != 0 AND srch.search_str='', ToCaps(srch.document_num),	ToCaps(srch.search_str));
		SELF.searchstr := ToCaps(srch.search_str);
		
		SELF := srch;
	END;
