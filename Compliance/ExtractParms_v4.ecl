	IMPORT Address, Compliance, ut;


string ToCaps(string s) := stringlib.stringToUpperCase(s);
string CleanSpaces(string s) := stringlib.StringCleanSpaces(s);

EXPORT Compliance.Layout_Parms_v4 ExtractParms_v4(Compliance.Layout_In srch) := 
	TRANSFORM
//If it's a non-Person Header search, some other type of ID will be in the UID space.
//For example, if a "CRIMS" search, the UID value is probably the DOC Number
	
		SELF.UID := MAP((unsigned6) srch.orig_LexID > 0 => (unsigned6) srch.orig_LexID,	//as of Sept 2014
//										REGEXFIND('LexID\\(',srch.search_str, nocase) 	=> (unsigned6) REGEXFIND('~LEXID\\(SM\\): ([0-9]+)~', ToCaps(srch.search_str), 1),
										REGEXFIND('LexID',srch.search_str, nocase) 				=> (unsigned6) REGEXFIND('LEXID\\(([0-9]+)\\)', ToCaps(srch.search_str), 1),
//										REGEXFIND('businessid',srch.search_str, nocase) 	=> (unsigned6) REGEXFIND('BUSINESSID\\(([0-9]+)\\)', ToCaps(srch.search_str), 1),
										REGEXFIND('Link ID',srch.search_str) 	=> (unsigned6) REGEXFIND('~LINK ID: ([0-9]+)~', ToCaps(srch.search_str), 1),
										
										REGEXFIND('',trim(srch.search_str,all)) 	=> (unsigned6) REGEXFIND('UID=([0-9-]+)~', ToCaps(srch.document_num), 1),
										
										0
									 );
									 
									 
		SELF.fname := MAP(REGEXFIND('FNAME',srch.search_str) 			=> REGEXFIND('FNAME=\\(([0-9A-Z* ,#./-]+)\\)', ToCaps(srch.search_str), 1),
											REGEXFIND('first-name',srch.search_str, nocase) => REGEXFIND('FIRST-NAME\\(([0-9A-Z* ,#./-]+)\\)', ToCaps(srch.search_str), 1),
											REGEXFIND('First Name:',srch.search_str, nocase) => REGEXFIND('FIRST NAME: ([0-9A-Z* ,#./-]+)~', ToCaps(srch.search_str), 1),
											REGEXFIND('First Name',srch.search_str, nocase) => REGEXFIND('~FIRST NAME: ([0-9A-Z* ,#./-]+)~', ToCaps(srch.search_str), 1),
											''
										 );
		SELF.mname := MAP(REGEXFIND('MNAME',srch.search_str) 				=> REGEXFIND('MNAME=\\(([0-9A-Z* ,#./-]+)\\)', ToCaps(srch.search_str), 1),
											REGEXFIND('middle-name',srch.search_str, nocase) 	=> REGEXFIND('MIDDLE-NAME\\(([0-9A-Z* ,#./-]+)\\)', ToCaps(srch.search_str), 1),
											REGEXFIND('Middle Name',srch.search_str, nocase) => REGEXFIND('~MIDDLE NAME: ([0-9A-Z* ,#./-]+)~', ToCaps(srch.search_str), 1),
											''
										 );								 
		
		SELF.lname := MAP(REGEXFIND('LNAME',srch.search_str) 			=> TRIM(Stringlib.Stringfilterout(
																																			REGEXFIND('LNAME=\\(([0-9A-Z* ,#./-]+)\\)', ToCaps(srch.search_str), 1),
																																			'*0123456789,.-#/'),left,right),
											REGEXFIND('last-name',srch.search_str, nocase) 	=> TRIM(Stringlib.Stringfilterout(
																																			REGEXFIND('LAST-NAME\\(([0-9A-Z* ,#./-]+)\\)', ToCaps(srch.search_str), 1),
																																			'*0123456789,.-#/'),left,right),
											REGEXFIND('Last Name',srch.search_str, nocase) 	=> TRIM(Stringlib.Stringfilterout(
																																			REGEXFIND('~LAST NAME: ([0-9A-Z* ,#./-]+)~', ToCaps(srch.search_str), 1),
																																			'*0123456789,.-#/'),left,right),
											''
										 );								 
		
		SELF.address := MAP(
												REGEXFIND('ADDRESS=',srch.search_str) 			=> TRIM(Stringlib.Stringfilterout(
																																					REGEXFIND('ADDRESS=\\(([0-9A-Z* ,#./-]+)\\)', ToCaps(srch.search_str), 1),
																																					'*,.#'),left,right),
												REGEXFIND('street address',srch.search_str) 	=> TRIM(Stringlib.Stringfilterout(
																																					REGEXFIND('STREET ADDRESS\\(([0-9A-Z* ,#./-]+)\\)', ToCaps(srch.search_str), 1),
																																					'*,.#'),left,right),
												REGEXFIND('Street Address:',srch.search_str) 	=> TRIM(Stringlib.Stringfilterout(
																																					REGEXFIND('~STREET ADDRESS: ([0-9A-Z* ,#./-]+)~', ToCaps(srch.search_str), 1),
																																					'*,.#'),left,right),
											  ''
											 );
		
		SELF.city := MAP(
										 REGEXFIND('CITY=',srch.search_str) 	=> REGEXFIND('CITY=\\(([0-9A-Z* ,#./-]+)\\)', ToCaps(srch.search_str), 1),
										 REGEXFIND('city\\(',srch.search_str) 	=> REGEXFIND('CITY\\(([0-9A-Z* ,#./-]+)\\)', ToCaps(srch.search_str), 1),
										 REGEXFIND('City:',srch.search_str) 	=> REGEXFIND('~CITY: ([0-9A-Z* ,#./-]+)', ToCaps(srch.search_str), 1),
											''
										 );
		

			SELF.state := MAP(
												REGEXFIND('STATE=',regexreplace('ALL',srch.search_str, '',nocase)) 	=> REGEXFIND('STATE=\\(([A-Z]+)\\)', ToCaps(regexreplace('ALL',srch.search_str, '',nocase)), 1),
												REGEXFIND('state',regexreplace('ALL',srch.search_str, '',nocase)) 	=> REGEXFIND('STATE\\(([A-Z]+)\\)', ToCaps(regexreplace('ALL',srch.search_str, '',nocase)), 1),
												REGEXFIND('~State',regexreplace('ALL',srch.search_str, '',nocase)) 	=> REGEXFIND('~STATE: ([A-Z]+)~', ToCaps(regexreplace('ALL',srch.search_str, '',nocase)), 1),
											''
										 );
		
		
		SELF.zip := MAP(REGEXFIND('zip code\\([0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]\\)',srch.search_str, nocase) => REGEXFIND('ZIP CODE\\([0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]\\)', ToCaps(srch.search_str), 0)[10..14],
										REGEXFIND('ZIP CODE\\(([0-9]+)\\)',srch.search_str, nocase) => REGEXFIND('ZIP CODE\\(([0-9]+)\\)', ToCaps(srch.search_str), 1),
										REGEXFIND('ZIP=',srch.search_str, nocase) 			=> REGEXFIND('ZIP=\\(([0-9]+)\\)', ToCaps(srch.search_str), 1),
										REGEXFIND('~ZIP CODE: ([0-9]+)~',srch.search_str, nocase) => REGEXFIND('~ZIP CODE: ([0-9]+)~', ToCaps(srch.search_str), 1),
										
										''
									 );
		
		SELF.ssn := MAP(REGEXFIND('SSN=',srch.search_str) 	=> REGEXFIND('SSN=\\(([0-9-]+)\\)', ToCaps(regexreplace('-',srch.search_str, '', nocase)), 1),
										REGEXFIND('ssn\\(',srch.search_str) 	=> REGEXFIND('SSN\\(([0-9-]+)\\)', ToCaps(regexreplace('-',srch.search_str, '', nocase)), 1),
										REGEXFIND('~SSN',srch.search_str) => REGEXFIND('~SSN: ([0-9-]+)~', ToCaps(regexreplace('-',srch.search_str, '', nocase)), 1),
										REGEXFIND('SSN',srch.search_str) => REGEXFIND('SSN: ([0-9-]+)', ToCaps(regexreplace('-',srch.search_str, '', nocase)), 1),
										''
									 );
		
		SELF.dob := MAP(REGEXFIND('DOB',srch.search_str) 	=> (integer) REGEXFIND('DOB=\\(([0-9]+)\\)', ToCaps(srch.search_str), 1),
//										REGEXFIND('dob',srch.search_str) 	=> (integer) REGEXFIND('DOB\\(([0-9]+)\\)', ToCaps(srch.search_str), 1),
										REGEXFIND('dob',srch.search_str) 	=>  (integer) ut.ConvertDateMultiple(REGEXFIND('DOB\\(([0-9]+/[0-9]+/[0-9]+)\\)', ToCaps(srch.search_str), 1),['%m/%d/%Y', '%Y-%m-%d %H:%M:%S', '%B %d %Y %I:%M%p', '%B %d %Y %k:%M'],'%Y%m%d'),
										0
									 );
		
		SELF.phone := MAP(REGEXFIND('PHONE',srch.search_str) 	=> REGEXFIND('PHONE=\\(([0-9]+)\\)', ToCaps(srch.search_str), 1),
										REGEXFIND('phone',Stringlib.Stringfilterout(srch.search_str,') -')) 		=> REGEXFIND('PHONE\\(([0-9]+)\\)', ToCaps(Stringlib.Stringfilterout(srch.search_str,') -')), 1),
										REGEXFIND('Phone:',srch.search_str) => REGEXFIND('~PHONE: ([0-9-]+)~', ToCaps(regexreplace('-',srch.search_str, '', nocase)), 1),
										''
									 );
		
		SELF.fullname := MAP(REGEXFIND('FULL_NAME',srch.search_str, nocase) => REGEXFIND('FULL_NAME=\\(([0-9A-Z* ,#./-]+)\\)', ToCaps(srch.search_str), 1),		//new
												REGEXFIND('~Name',srch.search_str, nocase) => REGEXFIND('~NAME: ([0-9A-Z* ,#./-]+)~', ToCaps(srch.search_str), 1),
												''
											);
		
		SELF.tag := MAP(REGEXFIND('TAG',srch.search_str, nocase) => REGEXFIND('TAG\\(([0-9A-Z* ,#./-]+)\\)', ToCaps(srch.search_str), 1),		//Vehicle Plate/Tag OR DL license number
										SELF.UID = 0 AND REGEXFIND('(DLSEARCH|DRVLIC)',srch.file) AND REGEXFIND('UID=([0-9A-Z-]+)~', ToCaps(srch.document_num))	=>	REGEXFIND('UID=([0-9A-Z-]+)~', ToCaps(srch.document_num), 1),	//DL License Number
										REGEXFIND('~Record Id',srch.search_str) => REGEXFIND('~RECORD ID: ([0-9A-Z* ,#./-]+)~', ToCaps(srch.search_str), 1),	//PROFLIC Prof License
										
										''
										);
		
		SELF.vin := MAP(REGEXFIND('VIN\\(',srch.search_str) 	=> REGEXFIND('VIN\\(([0-9A-Z]+)\\)', ToCaps(srch.search_str), 1),		//Vehicle VIN
										REGEXFIND('',trim(srch.search_str,all)) AND REGEXFIND('(GV_MVREPORT|MOTORV|MVREPORT2|MVSEARCH2|MVWILDSRCH)',srch.file) AND  REGEXFIND('UID=([0-9A-Z]+)', ToCaps(srch.document_num))	=> REGEXFIND('UID=([0-9A-Z]+)', ToCaps(srch.document_num), 1)
										,''
									 );	
		
//		SELF.busname := REGEXFIND('BUSINESS_NAME=\\((.+)\\)', ToCaps(srch.search_str), 1);				//new
		SELF.busname := MAP(REGEXFIND('BUSINESS_NAME',srch.search_str) 	=> REGEXFIND('BUSINESS_NAME=\\(([0-9A-Z* ,#./-]+)\\)', ToCaps(srch.search_str), 1),
											 REGEXFIND('company',srch.search_str) 				=> REGEXFIND('COMPANY\\(([0-9A-Z* ,#./-]+)\\)', ToCaps(srch.search_str), 1),
											 REGEXFIND('FULL_NAME',srch.search_str) 			=> REGEXFIND('FULL_NAME=\\(([0-9A-Z* ,#./-]+)\\)', ToCaps(srch.search_str), 1),
												''
											 );

		
		SELF.age_lower := MAP(REGEXFIND('Age Range:',srch.search_str, nocase) => (integer) REGEXFIND('AGE RANGE: ([0-9 ]+)', ToCaps(srch.search_str), 1),
													REGEXFIND('Age Range=',srch.search_str, nocase) => (integer) REGEXFIND('AGE RANGE=\\(([0-9 ]+)', ToCaps(srch.search_str), 1),
													REGEXFIND('Age Range',srch.search_str) 			=> (integer) REGEXFIND('AGE RANGE\\(([0-9 ]+)', ToCaps(srch.search_str), 1),
											
											0
										 );
		
		SELF.age_upper := MAP(REGEXFIND('Age Range:',srch.search_str, nocase) =>  (integer) REGEXFIND('AGE RANGE: ([0-9A-Z ]+)', ToCaps(srch.search_str), 0)[18..19],
													REGEXFIND('Age Range=',srch.search_str, nocase) =>  (integer) REGEXFIND('AGE RANGE=\\(([0-9A-Z ]+)', ToCaps(srch.search_str), 0)[18..19],
													REGEXFIND('Age Range',srch.search_str) 		=>  (integer) REGEXFIND('AGE RANGE\\(([0-9A-Z ]+)', ToCaps(srch.search_str), 0)[17..18],
											
											0
										 );

//-----------------------										 
		SELF.class := 
				TRIM(IF(SELF.UID = 0, '','U') +
				
							IF(SELF.fname='','','F') +
							IF(SELF.mname='','','M') +
							IF(SELF.lname='','','L') +
							IF(SELF.address='','','A') +
							IF(SELF.city='','','C') +
							IF(SELF.state='','','S') +
							IF(SELF.zip='','','Z') +
							IF(SELF.ssn='','','N') +
							
							MAP(
									SELF.dob=0 => '',
									SELF.dob<999999 => 'E',	// year & month
									'D'
									) +
							IF(SELF.phone='','','P') +
							
							IF(SELF.busname='','','B') +
							
							IF(SELF.tag='','','T') +
							IF(SELF.vin='','','V') +
							IF(SELF.fullname='','','X') + 		// X for eXtended name
							IF(SELF.age_lower=0,'','O')
							,ALL);
					
//		SELF.searchstr := IF(SELF.UID != 0 AND srch.search_str='', ToCaps(srch.document_num),	ToCaps(srch.search_str));
		SELF.searchstr := ToCaps(srch.search_str);
		
		self.name_clnr_string		:=	Address.CleanPerson73(			 SELF.fname
																														 + ' '
																														 + SELF.mname
																														 + ' '
																														 + SELF.lname
//																														 + ' '
//																														 + LE.SUFFIX
																											 );

////Addr_clnr_string may not have a value if City or State or Zip is not provided, even though Street Address is provided	////
		self.addr_clnr_string	   :=	Address.CleanAddress182(SELF.address,						//LE.Street_Number + ' ' + LE.PREDIR + ' ' + LE.Street_Name + ' ' + LE.STRTYPE + ' ' + LE.POSTDIR + ' ' + LE.APTTYPE + LE.orig_secondaryapttype + ' ' + LE.APTNBR + LE.orig_secondaryaptnbr
																													SELF.city + ' ' + SELF.state + ' ' + SELF.zip												
																													);

//----------

//"which_parms" is a check against the results of "class"		
		SELF.which_parms := 
				TRIM(MAP((unsigned6) srch.orig_LexID > 0 => 'U',	//as of Sept 2014
									REGEXFIND('uid',srch.search_str, nocase) 	=> 'U',
									REGEXFIND('UID=([0-9-]+)~', ToCaps(srch.document_num), nocase)
										AND NOT REGEXFIND('UID=0~', ToCaps(srch.document_num), nocase)	=> 'U',
									''
							)							+
							
						MAP(REGEXFIND('FNAME',srch.search_str) 			=> 'F',
								REGEXFIND('first-name',srch.search_str, nocase) => 'F',
								REGEXFIND('First Name',srch.search_str, nocase) => 'F',
								''
								)							+
						
						MAP(REGEXFIND('MNAME',srch.search_str) 				=> 'M',
								REGEXFIND('middle-name',srch.search_str, nocase) 	=> 'M',
								REGEXFIND('Middle Name',srch.search_str, nocase) => 'M',
								''
								)							+
						MAP(REGEXFIND('LNAME',srch.search_str) 			=> 'L',
								REGEXFIND('last-name',srch.search_str, nocase) 	=> 'L',
								REGEXFIND('Last Name',srch.search_str, nocase) 	=> 'L',
								''
								)							+
						MAP(REGEXFIND('ADDRESS=',srch.search_str) 			=> 'A',
								REGEXFIND('street address',srch.search_str, nocase) 	=> 'A',
								''
								)							+
						MAP(REGEXFIND('CITY',srch.search_str, nocase) 	=> 'C',
								''
								)							+
						MAP(REGEXFIND('state',srch.search_str,nocase)AND NOT REGEXFIND('\\(ALL',srch.search_str,nocase) 	=> 'S',
								''
								)							+
						MAP(REGEXFIND('ZIP Code',srch.search_str, nocase) => 'Z',
								REGEXFIND('ZIP',srch.search_str,nocase) 			=> 'Z',
								''
								)							+
						MAP(REGEXFIND('SSN',srch.search_str, nocase) 	=> 'N',
								''
								)							+
						
						MAP(REGEXFIND('(DOB=\\(|DOB\\()',srch.search_str, nocase) 	=> 'D',
								''
								)							+
						MAP(REGEXFIND('phone',srch.search_str, nocase) 	=> 'P',
								''
								)							+
						
						MAP(REGEXFIND('(busname|business_name)',srch.search_str, nocase) 	=> 'B',
								''
								)							+
						
						MAP(REGEXFIND('tag\\(',srch.search_str, nocase) 	=> 'T',
								SELF.UID = 0 AND REGEXFIND('(DLSEARCH|DRVLIC)',srch.file) AND REGEXFIND('UID=([0-9A-Z-]+)~', ToCaps(srch.document_num))	=> 'T',
								''
								)							+
						MAP(REGEXFIND('(vin\\()',srch.search_str, nocase) 	=> 'V',
								REGEXFIND('',trim(srch.search_str,all)) AND REGEXFIND('(GV_MVREPORT|MOTORV|MVREPORT2|MVSEARCH2|MVWILDSRCH)',srch.file) AND REGEXFIND('UID=([0-9A-Z]+)', ToCaps(srch.document_num))	=> 'V',
								''
								)							+
						MAP(REGEXFIND('fullname',srch.search_str, nocase) 	=> 'X',
								''
								)							+	// X for eXtended name
						MAP(REGEXFIND('Age Range',srch.search_str, nocase) 	=> 'O',		//how "O"ld
								''
								)
					,ALL);

//July 2016: See Compliance.ExtractDetailsFromActionField		
		SELF.ACTION_DPPA := MAP(REGEXFIND('\\(DPPA=',srch.action, nocase)	=> REGEXFIND('\\(DPPA=([0-9A-Z* ,#./-_]+)\\)', ToCaps(srch.action), 1)
													 ,''
													 );
		SELF.ACTION_GLBA := MAP(REGEXFIND('\\(GLBA=',srch.action, nocase)	=> REGEXFIND('\\(GLBA=([0-9A-Z* ,#./_-]+)\\)', ToCaps(srch.action), 1)
													 ,''
													 );
		SELF.ACTION_DMF_Desc := MAP(REGEXFIND('\\(DMFDESC=',srch.action, nocase)	=> REGEXFIND('\\(DMFDESC=DMP. BIT 1: ([0-9A-Z* ,#./_-]+)\\)', ToCaps(srch.action), 1)
															 ,''
															 );
		SELF.ACTION_DMF_Value := MAP(REGEXFIND('\\(DMFVALUE=',srch.action, nocase)	=> REGEXFIND('\\(DMFVALUE=([0-9A-Z* ,#./_-]+)\\)', ToCaps(srch.action), 1)
																 ,''
																 );
													 
//		SELF.ACTION_FuncName := MAP(REGEXFIND('\\(FUNCNAME=',srch.action, nocase)	=> REGEXFIND('\\(FUNCNAME=([0-9A-Z* ,#./-_()]+)\\)\\(', ToCaps(srch.action), 1)
//		SELF.ACTION_FuncName := MAP(REGEXFIND('\\(FUNCNAME=',srch.action, nocase)	=> REGEXFIND('\\(FUNCNAME=([0-9A-Z*: ,#./_()-]+)\\)\\(', ToCaps(srch.action), 1)
		SELF.ACTION_FuncName := MAP(REGEXFIND('\\(FUNCNAME=([0-9A-Z*: ,#./_()-]+)\\)\\(',srch.action, nocase)	=> REGEXFIND('\\(FUNCNAME=([0-9A-Z*: ,#./_()-]+)\\)\\(', ToCaps(srch.action), 1)
																,REGEXFIND('\\(FUNCNAME=([0-9A-Z*: ,#./_()-]+)\\)',srch.action, nocase)	=> REGEXFIND('\\(FUNCNAME=([0-9A-Z*: ,#./_()-]+)\\)', ToCaps(srch.action), 1)
																,''
													 );
		
		SELF := srch;
	END;
