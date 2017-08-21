IMPORT corp2, ut;

EXPORT Functions := MODULE
  
  EXPORT FormatDateStr(STRING inDate) := FUNCTION
   Time_Pattern :='[ ]?\\d{1,2}([:.]?\\d{1,2})([A|P]M)?$';
	 //Remove time stamp and add slashes to denote where the day and year starts
   out_date  := REGEXREPLACE(' ',REGEXREPLACE(Time_Pattern,corp2.t2u(inDate),''),'/');
	 Date_str  := case(out_date[1..3],
									'JAN'   => '01' + out_date[4..],
									'FEB'   => '02' + out_date[4..],
									'MAR'   => '03' + out_date[4..],
									'APR'   => '04' + out_date[4..],
									'MAY'   => '05' + out_date[4..],
									'JUN'   => '06' + out_date[4..],
									'JUL'   => '07' + out_date[4..],
									'AUG'   => '08' + out_date[4..],
									'SEP'   => '09' + out_date[4..],
									'OCT'   => '10' + out_date[4..],
									'NOV'   => '11' + out_date[4..],
									'DEC'   => '12' + out_date[4..],
									  '');
		Date_str2 := ut.date_slashed_MMDDYYYY_to_YYYYMMDD(Date_str);
		RETURN Date_str2;
	END;

  EXPORT GetAddrCd(string code)
		:= case(corp2.t2u(code),
			'1'  => 'A' , 	
			'2'  => 'AA',	
			'3'  => 'AD', 	
			'4'  => 'M' ,	
			'5'  => '5' ,
			'6'  => '6' ,
			'7'  => '7' ,
			'8'  => 'PE',
			'9'  => 'PP',
			'10' => 'PM',
			'11' => '11',
			'12' => '12',
			'13' => '9' ,
			'16' => '16',
			'17' => 'B' ,
			'19' => '19',
			'20' => '20',
			''   => 'B' ,
				corp2.t2u(code));
		
	EXPORT GetAddrDesc(string code, string desc)
		:= case(corp2.t2u(code),
			'1'  => corp2.t2u(desc),				// A	 - ABANDON
			'2'  => corp2.t2u(desc),				// AA	 - APPLICANT ADDRESS
			'3'  => corp2.t2u(desc),				// AD - ASSOCIATION ADDRESS 	
			'4'  => corp2.t2u(desc),				// M	 - MAILING
			'5'  => corp2.t2u(desc),				// 5  - FOREIGN ADDRESS
			'6'  => corp2.t2u(desc),				// 6  - LISTING
			'7'  => corp2.t2u(desc),				// 7  - NAME REGISTRATION ADDRESS
			'8'  => corp2.t2u(desc),				// PE - PENDING
			'9'  => corp2.t2u(desc),			  // PP - PRINCIPAL PLACE OF BUSINESS
			'10' => 'PREVIOUS MAILING',			// PM - PREVIOUS MAILING
			'11' => 'PREVIOUS APPLICANT',		// 11 - PREVIOUS APPLICANT
			'12' => corp2.t2u(desc),				// 12 - PREVIOUS PRINCIPAL PLACE OF BUSINESS
			'13' => 'PREVIOUS PRINICIPAL',	// 9  - PREVIOUS PRINICIPAL
			'16' => corp2.t2u(desc),				// 16 - PREVIOUS UCC ADDRESS
			'17' => 'BUSINESS',							// B  - BUSINESS
			'19' => corp2.t2u(desc),				// 19 - UCC ADDRESS
			'20' => corp2.t2u(desc),			  // 20 - WITHDRAWAL ADDRESS
			''   => 'BUSINESS',							// B  - BUSINESS
			'');			
	
  EXPORT GetNameTypCd(string code)
		:= case(corp2.t2u(code),
			'1'  => 'AB',
			'2'  => 'A',
			'3'  => '01',
			'5'  => '02',
			'6'  => 'HS',
			'7'  => 'IN',
			'8'  => 'PE',
			'9'  => 'PH',
			'10' => '10',
			'11' => 'P',
			'12' => '12',
			'13' => '07',
			'14' => '14',
				corp2.t2u(code));
				
	EXPORT GetNameTypDesc(string code, string desc)
		:= case(corp2.t2u(code),
			'1'  => corp2.t2u(desc),							// AB - ABANDON
			'2'  => corp2.t2u(desc),							// A  - ALIAS
			'3'  => 'LEGAL',											// 01 - LEGAL
			'5'  => 'DBA',												// 02 - DBA
			'6'  => corp2.t2u(desc),							// HS - HOME STATE
			'7'  => corp2.t2u(desc),							// IN - INFORMAL
			'8'  => corp2.t2u(desc),							// PE - PENDING
			'9'  => 'PREVIOUS HOME STATE',				// PH - PREVIOUS HOME STATE
			'10' => 'PREVIOUS REGISTERED ALIAS',	// 10 - PREVIOUS REGISTERED ALIAS
			'11' => 'PRIOR',											// P  - PRIOR
			'12' => 'REGISTERED ALIAS',						// 12 - REGISTERED ALIAS
			'13' => corp2.t2u(desc),							// 07 - RESERVED
			'14' => corp2.t2u(desc),							// 14 - TAX ID
			'');			

  EXPORT GetARType(string code)
		:= case(corp2.t2u(code),
			'100' => 'ANNUAL BENEFIT REPORT (3331)',
			'101' => 'ANNUAL STATEMENT-NONPROFIT (5110)',
			'148' => 'CERTIFICATE OF ANNUAL REGISTRATION-REGISTERED LLP (8221)',
			'149' => 'CERTIF. OF ANNUAL REGISTRATION-RESTRICTED PROF. LLC (8998)',
			'245' => 'ANNUAL REPORT-BENEFIT',
			'258' => 'ANNUAL REPORT WEB',
			'286' => 'ANNUAL STATEMENT - NON PROFIT',
			'298' => 'CERTIFICATE OF ANNUAL REPORT - LLC (ANNUAL REPORT)',
			'311' => 'CERTIFICATE OF ANNUAL REPORT - LLC',
			'319' => 'CERTIFICATE OF ANNUAL REPORT - LLP',
			'356' => 'CERTIFICATE OF ANNUAL REPORT',
			'');

  EXPORT ShortenDesc(string cd, string desc) 
		:= case(corp2.t2u(cd),
			'1'   => 'STATEMENT OF BREACH OF QUALIFYING CONDITION',
			'2'   => 'STATEMENT OF CURE OF BREACH OF QUAL CONDITION',
			'16'  => 'APPLICATION FOR REGISTRATION OF NAME',
			'50'  => 'APPLICATION FOR REG OF UNINCORPORATED ASSOC NAME',
			'51'  => 'STATEMENT OF TERMINATION OF REG OF ASSOCIATE NAME',
			'57'  => 'ARTICLES OF INCORPORATION',
			'58'  => 'ARTICLES OF INCORPORATION',
			'59'  => 'ARTICLES OF INCORPORATION',
			'60'  => 'ARTICLES OF INCORPORATION',
			'61'  => 'ARTICLES OF INCORPORATION',
			'62'  => 'ARTICLES OF INCORPORATION',
			'63'  => 'ARTICLES OF INCORPORATION',
			'64'  => 'ARTICLES OF INCORPORATION',
			'70'  => 'STATEMENT OR CERTIFICATE OF CHANGE OF REGISTERED OFFICE',
			'71'  => 'STATEMENT OR CERTIFICATE OF CHANGE OF REGISTERED OFFICE',
			'72'  => 'STATEMENT OR CERTIFICATE OF CHANGE OF REGISTERED OFFICE',
			'73'  => 'STATEMENT OR CERTIFICATE OF CHANGE OF REGISTERED OFFICE',
			'74'  => 'STATEMENT OR CERTIFICATE OF CHANGE OF REGISTERED OFFICE',
			'75'  => 'STATEMENT OR CERTIFICATE OF CHANGE OF REGISTERED OFFICE',
			'76'  => 'STATEMENT OF SHARES - BUSINESS STOCK CORPORATION',
			'81'  => 'ARTICLES/CERTIFICATE OF DIVISION',
			'83'  => 'ARTICLES/CERTIFICATE OF DIVISION',
			'85'  => 'ARTICLES OF CONVERSION',
			'86'  => 'ARTICLES OF DISSOLUTION BEFORE COMMENCEMENT OF BUSINESS',
			'87'  => 'ARTICLES OF DISSOLUTION BEFORE COMMENCEMENT OF BUSINESS',
			'89'  => 'ARTICLES OF DISSOLUTION',
			'90'  => 'ARTICLES OF INVOLUNTARY DISSOLUTION',
			'91'  => 'ARTICLES OF INVOLUNTARY DISSOLUTION',
			'92'  => 'ARTICLES OF AMENDMENT',
			'93'  => 'ARTICLES OF AMENDMENT',
			'94'  => 'STATEMENT OF BREACH OF QUALIFYING CONDITION (2309A)',
			'95'  => 'STATEMENT OF CURE OF BREACH OF QUAL CONDITION (2309B)',
			'96'  => 'ARTICLES OF AMENDMENT',
			'97'  => 'ARTICLES OF AMENDMENT',
			'98'  => 'ARTICLES OF AMENDMENT',
			'103' => 'ARTICLES OF INCORPORATION',
			'105' => 'ARTICLES OF AMENDMENT',
			'106' => 'ARTICLES OF AMENDMENT',
			'107' => 'ARTICLES OF AMENDMENT',
			'108' => 'ARTICLES OF AMENDMENT',
			'109' => 'ARTICLES OF DOMESTICATION',
			'110' => 'ARTICLES OF DOMESTICATION',
			'111' => 'APPLICATION FOR REGISTRATION',
			'112' => 'APPLICATION FOR REGISTRATION',
			'113' => 'STATEMENT OF CHANGE OF ADDRESS BY WITHDRAWN CORP',
			'114' => 'STATEMENT OF CHANGE OF ADDRESS BY WITHDRAWN CORP',
			'115' => 'APPLICATION FOR AMENDED CERTIFICATE OF AUTHORITY',
			'116' => 'APPLICATION FOR AMENDED CERTIFICATE OF AUTHORITY',
			'117' => 'APPLICATION FOR TERMINATION OF AUTHORITY',
			'118' => 'APPLICATION FOR TERMINATION OF AUTHORITY',
			'119' => 'STATEMENT OF MERGER, CONSOLIDATION OR DIVISION',
			'120' => 'STATEMENT OF MERGER, CONSOLIDATION OR DIVISION',
			'121' => 'APPLICATION FOR CERTIFICATE OF AUTHORITY',
			'122' => 'APPLICATION FOR CERTIFICATE OF AUTHORITY',
			'123' => 'APPLICATION FOR REGISTRATION',
			'124' => 'APPLICATION FOR AMENDMENT',
			'134' => 'STATEMENT OF TERMINATION OF DOMESTICATION',
			'135' => 'APP FOR RENEWAL OF CONTINGENT OR TEMP DOM STATUS',
			'136' => 'STATEMENT OF CONSUMMATION OF DOMESTICATION',
			'137' => 'STATEMENT OF CONTINGENT DOMESTICATION',
			'138' => 'STATEMENT OF CONTINGENT DOMESTICATION',
			'139' => 'STATEMENT OF CONTINGENT DOMESTICATION',
			'140' => 'STATEMENT OF CONTINGENT DOMESTICATION',
			'142' => 'STATEMENT OF CONTINGENT DOMESTICATION',
			'144' => 'STATEMENT OF REGISTRATION',
			'145' => 'STATEMENT OF AMENDMENT',
			'146' => 'STATEMENT OF TERMINATION',
			'147' => 'STATEMENT OF WITHDRAWAL',
			'150' => 'CERTIFICATE OF ORGANIZATION',
			'152' => 'CERTIFICATE OF AMENDMENT',
			'157' => 'CERTIFICATE OF ELECTION',
			'165' => 'CERTIFICATE OF WITHDRAWAL',
			'169' => 'APPLICATION FOR REGISTRATION',
			'170' => 'APPLICATION FOR REGISTRATION',
			'171' => 'APPLICATION FOR REGISTRATION',
			'172' => 'APPLICATION FOR REGISTRATION',
			'175' => 'CERTIFICATE OF DOMESTICATION',
			'176' => 'CERTIFICATE OF DOMESTICATION',
			'179' => 'STATEMENT APPOINTING AGENT ',
			'181' => 'CANCELLATION OF STATEMENT',
			'343' => 'REGISTRATION/AMENDMENT OF MARK',
			'423' => 'STATEMENT OF WITHDRAWAL',
			'' => '',
			corp2.t2u(desc));	
	
  EXPORT Decode_state(string code) 
		:= case(corp2.t2u(code),
			'AL'=>'ALABAMA',
			'AK'=>'ALASKA',
			'AS'=>'AMERICAN SAMOA',
			'AZ'=>'ARIZONA',
			'AR'=>'ARKANSAS',
			'CA'=>'CALIFORNIA',
			'CO'=>'COLORADO',
			'CT'=>'CONNECTICUT',
			'DE'=>'DELAWARE',
			'DC'=>'DISTRICT OF COLUMBIA',
			'FM'=>'FEDERATED STATES OF MICRONESIA',
			'FL'=>'FLORIDA',
			'GA'=>'GEORGIA',
			'GU'=>'GUAM',
			'HI'=>'HAWAII',
			'ID'=>'IDAHO',
			'IL'=>'ILLINOIS',
			'IN'=>'INDIANA',
			'IA'=>'IOWA',
			'KS'=>'KANSAS',
			'KY'=>'KENTUCKY',
			'LA'=>'LOUISIANA',
			'ME'=>'MAINE',
			'MH'=>'MARSHALL ISLANDS',
			'MD'=>'MARYLAND',
			'MA'=>'MASSACHUSETTS',
			'MI'=>'MICHIGAN',
			'MN'=>'MINNESOTA',
			'MS'=>'MISSISSIPPI',
			'MO'=>'MISSOURI',
			'MT'=>'MONTANA',
			'NE'=>'NEBRASKA',
			'NV'=>'NEVADA',
			'NH'=>'NEW HAMPSHIRE',
			'NJ'=>'NEW JERSEY',
			'NM'=>'NEW MEXICO',
			'NY'=>'NEW YORK',
			'NC'=>'NORTH CAROLINA',
			'ND'=>'NORTH DAKOTA',
			'MP'=>'NORTHERN MARIANA ISLANDS',
			'OH'=>'OHIO',
			'OK'=>'OKLAHOMA',
			'OR'=>'OREGON',
			'PW'=>'PALAU',
			'PA'=>'PENNSYLVANIA',
			'PR'=>'PUERTO RICO',
			'RI'=>'RHODE ISLAND',
			'SC'=>'SOUTH CAROLINA',
			'SD'=>'SOUTH DAKOTA',
			'TN'=>'TENNESSEE',
			'TX'=>'TEXAS',
			'UT'=>'UTAH',
			'VT'=>'VERMONT',
			'VI'=>'VIRGIN ISLANDS',
			'VA'=>'VIRGINIA',
			'WA'=>'WASHINGTON',
			'WV'=>'WEST VIRGINIA',
			'WI'=>'WISCONSIN',
			'WY'=>'WYOMING',
			'AE'=>'ARMED FORCES EUROPE, THE MIDDLE EAST AND CANADA',
			'AP'=>'ARMED FORCES PACIFIC',
			'AA'=>'ARMED FORCES AMERICAS EXCEPT CANADA',
      'CZ'=>'CANAL ZONE',
			'AU'=>'AUSTRALIA',
			'BA'=>'BOSNIA AND HERZEGOVINA',
			'CH'=>'SWITZERLAND',
			'CN'=>'CANADA',
			'DO'=>'DOMINICAN REPUBLIC',
			'GE'=>'GEORGIA, COUNTRY OF',
			'IR'=>'IRAN',
			'IT'=>'ITALY',
			'IS'=>'ICELAND',
			'PH'=>'PHILIPPINES',
			'SA'=>'SAUDI ARABIA',
			'SO'=>'SOMALIA',
			'SW'=>'SWITZERLAND',
			'EA'=>'',
			'JA'=>'',
			'OU'=>'',
			'UN'=>'',
			'XX'=>'',
			'**|'+corp2.t2u(code));
END;