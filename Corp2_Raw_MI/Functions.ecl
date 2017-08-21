IMPORT corp2;

EXPORT Functions := MODULE

		//****************************************************************************
		//State_Descriptions: returns the us state description.
		//****************************************************************************
		EXPORT State_Description(string s) := FUNCTION

					 uc_s := corp2.t2u(s);

	         RETURN map(uc_s = 'AA'																								=> 'ARMED FORCES AMERICAS EXCEPT CANADA',
											uc_s = 'AE'																								=> 'ARMED FORCES EUROPE, THE MIDDLE EAST AND CANADA',
											uc_s = 'AL'																								=> 'ALABAMA',
											uc_s = 'AK'																								=> 'ALASKA', 
											uc_s = 'AP'																								=> 'ARMED FORCES PACIFIC',
											uc_s = 'ARMED FORCES EUROPE, THE MIDDLE EAST AND CANADA' 	=> uc_s,
											uc_s = 'AR'																								=> 'ARKANSAS', 
											uc_s = 'AS'																								=> 'AMERICAN SAMOA', 
											uc_s = 'AZ'																								=> 'ARIZONA', 
											uc_s = 'CA'																								=> 'CALIFORNIA', 
											uc_s = 'CO'																								=> 'COLORADO', 
											uc_s = 'CT'																								=> 'CONNECTICUT',
											uc_s = 'CZ'																								=> 'CANAL ZONE',											
											uc_s = 'DC'																								=> 'DISTRICT OF COLUMBIA', 
											uc_s = 'DE'																								=> 'DELAWARE', 
											uc_s = 'FL'																								=> 'FLORIDA', 
											uc_s = 'GA'																								=> 'GEORGIA', 
											uc_s = 'GU'																								=> 'GUAM', 
											uc_s = 'HI'																								=> 'HAWAII', 
											uc_s = 'IA'																								=> 'IOWA', 
											uc_s = 'ID'																								=> 'IDAHO', 
											uc_s = 'IL'																								=> 'ILLINOIS', 
											uc_s = 'IN'																								=> 'INDIANA', 
											uc_s = 'KS'																								=> 'KANSAS', 
											uc_s = 'KY'																								=> 'KENTUCKY', 
											uc_s = 'LA'																								=> 'LOUISIANA', 
											uc_s = 'MA'																								=> 'MASSACHUSETTS', 
											uc_s = 'MD'																								=> 'MARYLAND', 
											uc_s = 'ME'																								=> 'MAINE' , 
											uc_s = 'MI'																								=> 'MICHIGAN', 
											uc_s = 'MN'																								=> 'MINNESOTA', 
											uc_s = 'MO'																								=> 'MISSOURI', 
											uc_s = 'MS'																								=> 'MISSISSIPPI', 
											uc_s = 'MT'																								=> 'MONTANA', 
											uc_s = 'NC'																								=> 'NORTH CAROLINA', 
											uc_s = 'ND'																								=> 'NORTH DAKOTA', 
											uc_s = 'NE'																								=> 'NEBRASKA', 
											uc_s = 'NH'																								=> 'NEW HAMPSHIRE', 
											uc_s = 'NJ'																								=> 'NEW JERSEY', 
											uc_s = 'NM'																								=> 'NEW MEXICO', 
											uc_s = 'NV'																								=> 'NEVADA', 
											uc_s = 'NY'																								=> 'NEW YORK', 
											uc_s = 'OH'																								=> 'OHIO', 
											uc_s = 'OK'																								=> 'OKLAHOMA', 
											uc_s = 'OR'																								=> 'OREGON', 
											uc_s = 'PA'																								=> 'PENNSYLVANIA', 
											uc_s = 'PR'																								=> 'PUERTO RICO', 
											uc_s = 'RI'																								=> 'RHODE ISLAND', 
											uc_s = 'SC'																								=> 'SOUTH CAROLINA', 
											uc_s = 'SD'																								=> 'SOUTH DAKOTA', 
											uc_s = 'TN'																								=> 'TENNESSEE', 
											uc_s = 'TX'																								=> 'TEXAS', 
											uc_s = 'US'																								=> 'US', 
											uc_s = 'UT'																								=> 'UTAH', 
											uc_s = 'VA'																								=> 'VIRGINIA', 
											uc_s = 'VI'																								=> 'VIRGIN ISLANDS', 
											uc_s = 'VT'																								=> 'VERMONT', 
											uc_s = 'WA'																								=> 'WASHINGTON', 
											uc_s = 'WI'																								=> 'WISCONSIN', 
											uc_s = 'WV'																								=> 'WEST VIRGINIA', 
											uc_s = 'WY'																								=> 'WYOMING',						
											uc_s = 'XX'																								=> '',
											uc_s = ''   																							=> '',
											'**|'+uc_s
										 );
		END;

		//****************************************************************************
		//Foreign_Description: returns the country description.
		//****************************************************************************
		EXPORT Foreign_Description(string s) := FUNCTION

					 uc_s := corp2.t2u(s);
					 
	         RETURN CASE(uc_s,
											 ''    => '',
											 '00'	 => 'MICHIGAN',  								//ASK ROSEMARY											 
											 'AB'	 => 'ALBERTA',									//CANADIAN PROVINCE
											 'AN'  => 'ANGOLA',										//FROM SOS WEBSITE
											 'AT'  => 'AUSTRIA',									//FROM SOS WEBSITE
											 'AU'  => 'AUSTRALIA',								//FROM SOS WEBSITE
											 'BA'  => 'BAHAMAS',									//FROM SOS WEBSITE
											 'BC'  => 'BRITISH COLUMBIA',					//CANADIAN PROVINCE
											 'BE'  => 'BELGIUM',									//FROM SOS WEBSITE
											 'BH'  => 'BOZNIA HERZEGOVINA',				//FROM SOS WEBSITE
											 'BM'  => 'ISLANDS OF BERMUDA',				//FROM SOS WEBSITE
											 'BN'  => 'BURNEI DARUSSALAM',				//FROM SOS WEBSITE
											 'BS'  => 'BARBADOS',									//FROM SOS WEBSITE
											 'CI'  => 'CAYMAN ISLANDS',						//FROM SOS WEBSITE
											 'CK'  => 'COOK ISLANDS',							//FROM SOS WEBSITE
											 'CN'  => 'CANADA',										//FROM SOS WEBSITE
											 'DO'  => 'DOMINICAN REPUBLIC',				//FROM SOS WEBSITE
											 'EG'  => 'EGYPT',										//FROM SOS WEBSITE
											 'EN'  => 'ENGLAND',									//FROM SOS WEBSITE
											 'EW'  => 'ENGLAND AND WALES',				//FROM SOS WEBSITE
											 'FI'  => 'FINLAND',									//FROM SOS WEBSITE
											 'FN'  => 'SAC AND FOX NATION',				//FROM SOS WEBSITE
											 'FR'  => 'FRANCE',										//FROM SOS WEBSITE
											 'GR'  => 'GREAT BRITAIN',						//FROM SOS WEBSITE
											 'HD'  => 'HONDURAS',									//FROM SOS WEBSITE
											 'HJ'  => 'HASHIMET JORDANIAN KING',	//FROM SOS WEBSITE
											 'HK'  => 'HONG KONG',								//FROM SOS WEBSITE
											 'II'  => 'INDIA', 										//FROM SOS WEBSITE											 
											 'IQ'  => 'IRAQ',											//FROM SOS WEBSITE
											 'IR'  => 'IRELAND',									//FROM SOS WEBSITE
											 'IS'  => 'ISRAEL',										//FROM SOS WEBSITE 
											 'IT'  => 'ITALY',										//FROM SOS WEBSITE
											 'IV'  => 'ISLAND OF NEVIS',					//FROM SOS WEBSITE
											 'JA'  => 'JAPAN',										//FROM SOS WEBSITE
											 'JM'  => 'JAMAICA',									//FROM SOS WEBSITE
											 'KB'  => 'KEWEENAW BAY INDIAN COMM',	//FROM SOS WEBSITE
											 'KO'  => 'SOUTH KOREA',							//FROM SOS WEBSITE
											 'KR'  => 'REPUBLIC OF KOREA',				//FROM SOS WEBSITE
											 'KW'  => 'KUWAIT',										//FROM SOS WEBSITE
											 'LE'  => 'LEBANON',									//FROM SOS WEBSITE
											 'LI'  => 'LIECHTENSTEIN',						//FROM SOS WEBSITE
											 'LK'  => 'SRI LANKA',								//FROM SOS WEBSITE
											 'LU'  => 'LUXEMBOURG',								//FROM SOS WEBSITE
											 'MB'  => 'MANITOBA',									//CANADIAN PROVINCE				 
											 'MJ'  => 'MESA GRANDE BOM INDIANS',	//FROM SOS WEBSITE
											 'ML'  => 'MALAYSIA',									//FROM SOS WEBSITE
											 'MP'  => 'MEBNSW BAND OF PI',				//FROM SOS WEBSITE
											 'MR'  => 'NORTHERN MARIANA ISLANDS',	//FROM SOS WEBSITE
											 'MX'  => 'MEXICO',										//FROM SOS WEBSITE
											 'NA'  => 'NETHERLANDS ANTILLES',			//FROM SOS WEBSITE
											 'NB'  => 'NEW BRUNSWICK',						//CANADIAN PROVINCE
											 'NF'  => 'NEWFOUNDLAND',							//CANADIAN PROVINCE
											 'NI'  => 'NIGERIA',									//FROM SOS WEBSITE
											 'NL'  => 'NETHERLANDS',							//FROM SOS WEBSITE
											 'NO'  => 'NORWAY',										//FROM SOS WEBSITE
											 'NS'  => 'NOVA SCOTIA',							//CANADIAN PROVINCE
											 'NT'  => 'NORTH WEST TERRITORIES',		//CANADIAN PROVINCE
											 'ON'  => 'ONTARIO',									//CANADIAN PROVINCE
											 'PE'  => 'PRINCE EDWARD ISLAND',			//CANADIAN PROVINCE
											 'PH'  => 'PHILIPPINES',							//FROM SOS WEBSITE
											 'PK'  => 'PAKISTAN',									//FROM SOS WEBSITE
											 'PM'	 => 'PANAMA',										//FROM SOS WEBSITE
											 'PO'  => 'POLAND ',									//FROM SOS WEBSITE
											 'PQ'  => 'QUEBEC',										//CANADIAN PROVINCE
											 'RC'  => 'PEOPLES REPUBLIC OF CHINA',//FROM SOS WEBSITE
											 'RM'  => 'REPUBLIC OF MAURITIUS',		//FROM SOS WEBSITE
											 'RS'  => 'REP OF MARSHALL ISLANDS',	//FROM SOS WEBSITE
											 'RT'  => '', 												//RECORD FAILS ON SOS SITE
											 'RV'  => 'SOCIALIST REP. OF VIETNAM',//FROM SOS WEBSITE
											 'SF'  => 'SOUTH AFRICA',							//FROM SOS WEBSITE
											 'SG'  => 'SINGAPORE', 								//FROM SOS WEBSITE
											 'SI'  => 'SIERRA LEONE', 						//FROM SOS WEBSITE
											 'SK'  => 'SASKATCHEWAN',							//CANADIAN PROVINCE
											 'SL'  => 'SAINT LUCIA', 							//FROM SOS WEBSITE
											 'SN'  => 'SWEDEN',										//FROM SOS WEBSITE
											 'SP'  => 'SPAIN',										//FROM SOS WEBSITE
											 'SS'  => 'REPUBLIC OF SEYCHELLES',		//FROM SOS WEBSITE
											 'SU'  => 'SAUDI ARABIA',							//FROM SOS WEBSITE
											 'SW'  => 'SWITZERLAND',							//FROM SOS WEBSITE
											 'SY'  => 'SYRIA',										//FROM SOS WEBSITE
											 'TC'  => 'TURKS & CAICOS ISLANDS',		//FROM SOS WEBSITE
											 'TI'  => 'LITTLE TRAVERSE ODAWA IND',//FROM SOS WEBSITE 											//UNKNOWN											 
											 'TU'  => 'TURKEY',										//FROM SOS WEBSITE
											 'TZ'  => 'UR OF TANZANIA',						//FROM SOS WEBSITE
											 'UE'  => 'UKRAINE',									//FROM SOS WEBSITE
											 'UK'  => 'UNITED KINGDOM',						//FROM SOS WEBSITE
											 'VE'  => 'VENEZUELA',								//FROM SOS WEBSITE
											 'VG'  => 'BRITISH VIRGIN ISLANDS',		//FROM SOS WEBSITE
											 'YT'  => 'YUKON',										//CANADIAN PROVINCE
											 'WG'  => 'WEST GERMANY',							//FROM SOS WEBSITE
											 'YE'  => 'YEMEN',										//FROM SOS WEBSITE
											 'YN'  => 'YAKAMA NATION',						//FROM SOS WEBSITE
											 'ZI'  => 'ZIMBABWE',									//FROM SOS WEBSITE
											 'TURKS & CAICOS ISLANDS' 		=> uc_s,
											 'SOCIALIST REP. OF VIETNAM' 	=> uc_s,	
											 '**|'+uc_s
							 );
		END;
		//****************************************************************************
		//CorpForgnStateCD: returns "corp_forgn_state_cd".
		//****************************************************************************
		EXPORT CorpForgnStateCD(STRING s) := FUNCTION

					 uc_s := corp2.t2u(s);
					 
	         RETURN map(State_Description(uc_s)[1..2] 	<> '**' => uc_s,
											Foreign_Description(uc_s)[1..2] <> '**' => uc_s,
											'**|'+uc_s
										 );
		END;

		//****************************************************************************
		//CorpForgnStateDesc: returns "corp_forgn_state_desc".
		//****************************************************************************
		EXPORT CorpForgnStateDesc(string s) := FUNCTION

					 uc_s := corp2.t2u(s);

	         RETURN map(State_Description(uc_s)[1..2] 	<> '**'	=> State_Description(uc_s),
											Foreign_Description(uc_s)[1..2] <> '**' => Foreign_Description(uc_s),
											'**|'+uc_s
										 );
		END;

		//****************************************************************************
		//CorpActs: returns the overloaded field "corp_acts" that needs to retain
		//					c_act2_1a and c_act2_1a as part of "corp_acts" until the fields 
		//     			corp_acts2 and corp_acts3 are customer facing.
		//****************************************************************************
		export CorpActs(string act1, string act2, string act3) := function
		
			uc_act1 := corp2.t2u(act1);
			uc_act2 := corp2.t2u(act2);
			uc_act3 := corp2.t2u(act3);
			
			return if(uc_act1='','',uc_act1+if(uc_act2='','','; '+uc_act2+if(uc_act3='','','; '+uc_act3)));

		end;
		
		//****************************************************************************
		//MailingAddr: returns a standardized PO Box verbage and removes email 
		//						 addresses.
		//****************************************************************************
		export MailingAddr(string s) := function
					 uc_s := corp2.t2u(s);
					 return map(regexfind('^PO BOX:',   uc_s,0) <> '' => uc_s, 																			//correct format, return input
											regexfind('^P.O. BOX:', uc_s,0) <> '' => regexreplace('^P.O. BOX:',uc_s,'PO BOX:'), //standardize format
											regexfind('^P.O. BOX',  uc_s,0) <> '' => regexreplace('^P.O. BOX', uc_s,'PO BOX:'), //standardize format
											regexfind('^P O BOX:',  uc_s,0) <> '' => regexreplace('^P O BOX:', uc_s,'PO BOX:'), //standardize format
											regexfind('^P O BOX',   uc_s,0) <> '' => regexreplace('^P O BOX',  uc_s,'PO BOX:'), //standardize format
											regexfind('^PO BOX',    uc_s,0) <> '' => regexreplace('^PO BOX',   uc_s,'PO BOX:'), //standardize format
											regexfind('@',uc_s,0)<>'' and regexfind(' ',uc_s,0)='' => '', 											//An email address
											uc_s																																								//not a po box, return input
										 );
		end;
		 
		//****************************************************************************
    //CorpAgentCounty: returns the "Corp Agent County".
    //****************************************************************************
    export CorpAgentCounty(string s) := function
			 uc_s := corp2.t2u(s);
			 return map(uc_s = '00'  				=> '',
									uc_s = '1' 					=> 'ALCONA',
								  uc_s = '2' 					=> 'ALGER',
								  uc_s = '3' 					=> 'ALLEGAN',
								  uc_s = '4' 					=> 'ALPENA',
								  uc_s = '5' 					=> 'ANTRIM',
								  uc_s = '6' 					=> 'ARENAC',
								  uc_s = '7' 					=> 'BARAGA',
								  uc_s = '8' 					=> 'BARRY',
								  uc_s = '9' 					=> 'BAY',
								  uc_s = '10' 				=> 'BENZIE',
								  uc_s = '11' 				=> 'BERRIEN',
								  uc_s = '12' 				=> 'BRANCH',
								  uc_s = '13' 				=> 'CALHOUN',
								  uc_s = '14' 				=> 'CASS',
								  uc_s = '15' 				=> 'CHARLEVOIX',
								  uc_s = '16' 				=> 'CHEBOYGAN',
								  uc_s = '17' 				=> 'CHIPPEWA',
								  uc_s = '18' 				=> 'CLARE',
								  uc_s = '19' 				=> 'CLINTON',
								  uc_s = '20' 				=> 'CRAWFORD',
								  uc_s = '21' 				=> 'DELTA',
								  uc_s = '22' 				=> 'DICKINSON',
								  uc_s = '23' 				=> 'EATON',
								  uc_s = '24' 				=> 'EMMET',
								  uc_s = '25' 				=> 'GENESEE',
								  uc_s = '26' 				=> 'GLADWIN',
								  uc_s = '27' 				=> 'GOGEBIC',
								  uc_s = '28' 				=> 'GRAND TRAVERSE',
								  uc_s = '29' 				=> 'GRATIOT',
								  uc_s = '30' 				=> 'HILLSDALE',
								  uc_s = '31' 				=> 'HOUGHTON',
								  uc_s = '32' 				=> 'HURON',
								  uc_s = '33' 				=> 'INGHAM',
								  uc_s = '34' 				=> 'IONIA',
								  uc_s = '35' 				=> 'IOSCO',
								  uc_s = '36' 				=> 'IRON',
								  uc_s = '37' 				=> 'ISABELLA',
								  uc_s = '38' 				=> 'JACKSON',
								  uc_s = '39' 				=> 'KALAMAZOO',
								  uc_s = '40' 				=> 'KALKASKA',
								  uc_s = '41' 				=> 'KENT',
								  uc_s = '42' 				=> 'KEWEENAW',
								  uc_s = '43' 				=> 'LAKE',
								  uc_s = '44' 				=> 'LAPEER',
								  uc_s = '45' 				=> 'LEEINAU',
								  uc_s = '46' 				=> 'LENAWEE',
								  uc_s = '47' 				=> 'LIVINGSTON',
								  uc_s = '48' 				=> 'LUCE',
								  uc_s = '49' 				=> 'MACKINAC',
								  uc_s = '50' 				=> 'MACOMB',
								  uc_s = '51' 				=> 'MAINSTEE',
								  uc_s = '52' 				=> 'MARQUETTE',
								  uc_s = '53' 				=> 'MASON',
								  uc_s = '54' 				=> 'MECOSTA',
								  uc_s = '55' 				=> 'MENOMINEE',
								  uc_s = '56' 				=> 'MIDLAND',
								  uc_s = '57' 				=> 'MISSAUKEE',
								  uc_s = '58' 				=> 'MONROE',
								  uc_s = '59' 				=> 'MONTCALM',
								  uc_s = '60' 				=> 'MONTMORENCY',
								  uc_s = '61' 				=> 'MUSKEGON',
								  uc_s = '62' 				=> 'NEWAYGO',
								  uc_s = '63' 				=> 'OAKLAND',
								  uc_s = '64' 				=> 'OCEANA',
								  uc_s = '65' 				=> 'OGEMAW',
								  uc_s = '66' 				=> 'ONTONAGON',
								  uc_s = '67' 				=> 'OSCEOLA',
								  uc_s = '68' 				=> 'OSCODA',
								  uc_s = '69' 				=> 'OTSEGO',
								  uc_s = '70' 				=> 'OTTAWA',
								  uc_s = '71' 				=> 'PRESQUE ISLE',
								  uc_s = '72' 				=> 'ROSCOMMON',
								  uc_s = '73' 				=> 'SAGINAW',
								  uc_s = '74' 				=> 'ST. CLAIR',
								  uc_s = '75' 				=> 'ST. JOSEPH',
								  uc_s = '76' 				=> 'SANILAC',
								  uc_s = '77' 				=> 'SCHOOLCRAFT',
								  uc_s = '78' 				=> 'SHIAWASSEE',
								  uc_s = '79' 				=> 'TUSCOLA',
								  uc_s = '80' 				=> 'VAN BUREN',
								  uc_s = '81' 				=> 'WASHTENAW',
								  uc_s = '82' 				=> 'WAYNE',
								  uc_s = '83' 				=> 'WEXFORD',
									uc_s
								 );
    end;
										 	
		//****************************************************************************
    //CorpPurpose: returns the "corp_purpose".
    //****************************************************************************
    export CorpPurpose(string s) := function
			 uc_s := corp2.t2u(s);
			 return map(uc_s = 'APC' 			=> 'ALL PURPOSE CLAUSE',
								  uc_s = 'ECC' 			=> 'ECCLESIASTICAL CORPORATION',
								  uc_s = 'GENBKLAW' => 'GENERAL BANKING LAW',																												 
								  uc_s = 'HMO' 			=> 'HEALTH MAINTENANCE ORGANIZATION',
								  uc_s = 'PSA' 			=> 'PUBLIC SCHOOL ACADEMY',
								  uc_s = 'TPA' 			=> 'THIRD PARTY ADMINISTRATOR',
								  uc_s
								 );
    end;	
		
		//****************************************************************************
    //CorpStatusComment: returns the "corp_status_cmt" (comment).
		//****************************************************************************
		export CorpStatusComment(string s) := function
			 uc_s := corp2.t2u(s);
			 return map(uc_s = ''					  => '',
									uc_s = '00'					=> '',
									uc_s = '10' 				=> 'COUNTER FILINGS - DETROIT',
									uc_s = '11' 				=> 'COUNTER FILINGS - LANSING',
									uc_s = '20' 				=> 'HELD 30 DAY FOLLOW-UP LETTER SENT',
									uc_s = '21' 				=> 'HELD FOR MONEY',
									uc_s = '22' 				=> 'HELD FOR ANNUAL REPORT REINSTATEMENT',
									uc_s = '23' 				=> 'HELD PENDING DISSOLUTION',
									uc_s = '24' 				=> 'HELD FOR GOOD STANDING',
									uc_s = '25' 				=> 'HELD FOR TAX CLEARANCE',
									uc_s = '26' 				=> 'HELD FOR ATTORNEY GENERAL CONSENT',
									uc_s = '27' 				=> 'HELD AND HAVE DONE TAX CLEARANCE FOLLOW UP LETTER',
									uc_s = '28' 				=> 'HELD FOR DEPARTMENT OF EDUCATION APPROVAL',
									uc_s = '29' 				=> 'HELD FOR INSURANCE BUREAU APPROVAL',
									uc_s = '30' 				=> 'HELD - RESPONSE RECEIVED; NEED MORE INFORMATION',
									uc_s = '31' 				=> 'PRECLEARANCE',
									uc_s = '40' 				=> 'RETURNED FOR ANNUAL REPORT REINSTATEMENT',
									uc_s = '41' 				=> 'RETURNED FOR SIGNATURE',
									uc_s = '42' 				=> 'RETURNED DOCUMENT, HELD GOOD-STANDING',
									uc_s = '43' 				=> 'RETURNED FOR NAME CORRECTION',
									uc_s = '44' 				=> 'RETURNED FOR RESIDENT AGENT CORRECTION',
									uc_s = '45' 				=> 'RETURNED FOR REGISTERED OFFICE CORRECTION',
									uc_s = '46' 				=> 'RETURNED FOR ITEM 5B CORRECTION',
									uc_s = '47' 				=> 'RETURNED FOR STOCK CORRECTION',
									uc_s = '48' 				=> 'RETURNED WITH 30 DAY FOLLOW-UP LETTER',
									uc_s = '49' 				=> 'RETURNED - INCORRECT FORM USED',
									uc_s = '50' 				=> 'RETURNED FOR REDRAFTING - FORM ILLEGIBLE',
									uc_s = '51' 				=> 'RETURNED AMENDMENT NEED RESTATED CERTIFICATE (L-P)',
									uc_s = '52' 				=> 'RETURNED - NEED CONTRIBUTION ON SUPPLEMENT L (L-P)',
									uc_s = '53' 				=> 'RETURNED - NEED ITEM 4 ON SUPPLEMENT L COMPLETED (L-P)',
									uc_s = '54' 				=> 'RETURNED - NEED ITEM 5 ON SUPPLEMENT L COMPLETED (L-P)',
									uc_s = '55' 				=> 'RETURNED PURPOSES QUESTIONED',
									uc_s = '56' 				=> 'RETURNED FOR DIRECTOR LIABILITY PROVISIONS',
									uc_s = '60' 				=> 'DENIED - 15 DAYS TO RESPOND (MARKS)',
									uc_s = '61' 				=> 'HELD FOR SAMPLES (MARKS)',
									uc_s = '62' 				=> 'RETURNED DOCUMENT, HELD SAMPLES (MARKS)',
									uc_s = '70' 				=> 'OTHER',
									uc_s = '71' 				=> '30 DAY FOLLOW-UP COMPLETED',
									uc_s = '72' 				=> 'REINSTATEMENT PENDING',
									uc_s = 'AD' 				=> 'AUTOMATIC DISSOLUTION',
									uc_s = 'AR' 				=> 'ARTICLES OF ORGANIZATION RESCINDED BY FILING CERTIFICATE OF CORRECTION',
									uc_s = 'AW' 				=> 'AUTOMATIC WITHDRAWAL',
									uc_s = 'CC' 				=> 'CERTIFICATE OF CANCELLATION',
									uc_s = 'CD' 				=> 'CERTIFICATE OF DISSOLUTION',
									uc_s = 'CM' 				=> 'CONSENT OF MEMBERS',
									uc_s = 'CN' 				=> 'CONSOLIDATION',
									uc_s = 'CO' 				=> 'COURT ORDER',
									uc_s = 'CV' 				=> 'CERTIFICATE OF CONVERSION',
									uc_s = 'CW' 				=> 'CERTIFICATE OF WITHDRAWAL',
									uc_s = 'DC' 				=> 'DISHONORED CHECK',
									uc_s = 'FC' 				=> 'FAILURE TO COMPLY',
									uc_s = 'FN' 				=> 'FOREIGN LIMITED PARTNERSHIP THAT DID NOT REGISTER UNDER ACT 213 OF 1982',
									uc_s = 'FR' 				=> 'FOREIGN RAILROAD NOT QUALIFIED',
									uc_s = 'ME' 				=> 'MERGER',
									uc_s = 'N1' 				=> 'FOREIGN NONPROFIT CORPORATION - FAILURE TO MAINTAIN RESIDENT AGENT',
									uc_s = 'N2' 				=> 'FOREIGN NONPROFIT CORPORATION - FAILURE TO FILE CHANGE OF RESIDENT AGENT OR REGISTERED OFFICE',
									uc_s = 'N3' 				=> 'FOREIGN NONPROFIT CORPORATION - FAILURE TO FILE COPY OF AMENDMENT',
									uc_s = 'N4' 				=> 'FOREIGN NONPROFIT CORPORATION - FAILURE TO FILE CERTIFICATE ATTESTING TO MERGER',
									uc_s = 'N5' 				=> 'FOREIGN NONPROFIT CORPORATION - FAILURE TO FILE ANNUAL REPORT OR FAILURE TO PAY ANNUAL FILING FEE',
									uc_s = 'N6' 				=> 'NONPROFIT DOCUMENT RESCINDED BY FILING CERTIFICATE OF CORRECTION',
									uc_s = 'OT' 				=> 'OTHER TYPE OF DISSOLUTION/CANCELLATION',
									uc_s = 'P1' 				=> 'FOREIGN PROFIT CORPORATION - FAILURE TO MAINTAIN RESIDENT AGENT',
									uc_s = 'P2' 				=> 'FOREIGN PROFIT CORPORATION - FAILURE TO FILE CHANGE OF RESIDENT AGENT OR REGISTERED OFFICE',
									uc_s = 'P3' 				=> 'FOREIGN PROFIT CORPORATION - FAILURE TO AMEND APPLICATION AS REQUIRED',
									uc_s = 'P4' 				=> 'FOREIGN PROFIT CORPORATION - FAILURE TO FILE CERTIFICATE ATTESTING TO MERGER',
									uc_s = 'P5' 				=> 'FOREIGN PROFIT CORPORATION - FAILURE TO FILE SUPPLEMENTAL STATEMENT',
									uc_s = 'P6' 				=> 'FOREIGN PROFIT CORPORATION - FAILURE TO FILE ANNUAL REPORT OR FAILURE TO PAY ANNUAL FILING FEE',
									uc_s = 'P7' 				=> 'PROFIT DOCUMENT RESCINDED BY FILING CERTIFICATE OF CORRECTION',
									uc_s = 'R' 					=> 'FAILURE TO COMPLY',
									uc_s = 'RE' 				=> 'RESCINDED',
									uc_s = 'SE' 				=> 'SPECIFIED EVENT',
									uc_s = 'TE' 				=> 'TERM EXPIRATION',
									uc_s = 'TM' 				=> 'TERMINATION OF MEMBERSHIP',
									'**|'+uc_s
								 );
    end;

		//****************************************************************************
		//EventFilingDesc: returns the "ar_comment" and "event_filing_desc".
		//****************************************************************************
		export EventFilingDesc(String s) := function
			 uc_s := corp2.t2u(s);
			 return map(uc_s = '01' => 'SPECIAL ENTRIES',
								  uc_s = '02' => 'IDENTIFICATION NUMBER CHANGES',
								  uc_s = '03' => 'NAME CHANGES',
								  uc_s = '04' => 'HISTORY TRUE NAME',
								  uc_s = '05' => 'CHANGE OF AGENT AND/OR OFFICE',
								  uc_s = '06' => 'CHANGE OF AGENT AND/OR OFFICE',
								  uc_s = '09' => 'ADDITIONAL STOCK AND SPECIAL NOTES RELATED TO CURRENT STOCK',
								  uc_s = '14' => 'MERGERS',
								  uc_s = '17' => 'REVOCATION - FOREIGN CORPORATION',
								  uc_s = '18' => 'ANNUAL REPORT FILED',
									uc_s = '23' => 'STOCK HISTORY',
								  uc_s = '27' => 'CONSOLIDATION',
								  uc_s = '31' => 'ALERT MESSAGE',
								  uc_s = '37' => 'RAILROAD RECORDS TRANSFERRED PER ACT 354 OF 1993',
								  uc_s = '40' => 'MULTIPLE FILING HISTORY',
								  uc_s = '41' => 'CHANGE OF LIMITED PARTNERSHIP',
									uc_s = '82' => 'ANNUAL REPORT - REPORT RETURNED',
									uc_s = '85' => 'ANNUAL REPORT - NO FEE RECEIVED OR FEE RECEIVED, NO REPORT',
								  ''
								 );
    end;


		//****************************************************************************
		//InfoString: returns the "event_desc" and "stock_addl_info".
		//****************************************************************************
		export InfoString(string s1, string s2, string s3, string s4, string s5, string s6, string s7) := function
			 uc_s1 := corp2.t2u(s1); //info_70
			 uc_s2 := if(stringlib.stringfilterout(s2,'0123456789 ')<>'',corp2.t2u(s2),''); //roll_70
			 uc_s3 := if(stringlib.stringfilterout(s3,'0123456789 ')<>'',corp2.t2u(s3),''); //frame_70
			 uc_s4 := corp2.t2u(s4); //info2_70
			 uc_s5 := corp2.t2u(s5); //info3_70
			 uc_s6 := corp2.t2u(s6); //info4_70
			 uc_s7 := corp2.t2u(s7); //info5_70
						
			 return corp2.t2u(uc_s1+' '+uc_s2+' '+uc_s3+' '+uc_s4+' '+uc_s5+' '+uc_s6+' '+uc_s7);
	  end;
		
		//****************************************************************************
    //LLCForeignDomesticInd: returns the "corp_foreign_domestic_ind".
    //****************************************************************************
    export LLCForeignDomesticInd(String s) := function
			 uc_s := corp2.t2u(s);
			 return map(uc_s between 'D00001' and 'D8999Z' => 'D',
								  uc_s between 'E00001' and 'E8999Z' => 'D',
								  uc_s between 'F00001' and 'F8999Z' => 'D',
								  uc_s between 'G00001' and 'G8999Z' => 'D',
								  uc_s between 'H00001' and 'H8999Z' => 'D',
								  uc_s between 'LC0000' and 'LC899Z' => 'D',
								  uc_s between 'B90000' and 'B9499Z' => 'F',
								  uc_s between 'D90000' and 'D9499Z' => 'F',
								  uc_s between 'E90000' and 'E9499Z' => 'F',
								  uc_s between 'F90000' and 'F9499Z' => 'F',
								  uc_s between 'G90000' and 'G9499Z' => 'F',
								  uc_s between 'H90000' and 'H9499Z' => 'F',
								  uc_s between 'LC9000' and 'LC949Z' => 'F',
								  ''
								 );
	  end;

END;