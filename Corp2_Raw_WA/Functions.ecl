IMPORT corp2_raw_ia, corp2;

EXPORT FUNCTIONs := Module
  	
	EXPORT FixLastName(string fnm, string lnm) := FUNCTION
	  ucLNm := corp2.t2u(lnm);
		ucFNm := corp2.t2u(fnm);
		ucFullNm := corp2.t2u(fnm + ' ' + lnm);
		invalid_name_patterns := '^ADDITIONAL NAM|^ADDITIONAL OFF|^ADDITIONAL DIR|^ADDITIONAL LIS|^ADDITIONAL MEM|'+
														 '^NAME WITHHELD|^ON FILE ADDIT|^ADDTL NAMES|^VACANT|^WITHHELD|'+
														 '^NOT DESIGNATED$|^NOT AVAILABLE$|^ON FILE ADDITIONAL NAMES$|^POSITIONS VACANT$|'+
														 '^DIRECTOR ON FILE$|^DIRECTORS$|^DIRECTORS ON FILM$|^APPLICABLE$|^SEE FILE FOR ADDITIONAL$|'+
														 '^DIRECTORS SEE FILE FOR ADDITIONAL$|^NOT APPLICABLE$|^AVAILABLE$|^NAMES LISTED ON FILE$|'+
														 '^NOT APPLICAPLE$|^NOT APPOINTED$|^NOT DESIGATED$|^NOTAPPLICABLE POSITION$|^NAMES ON FILE$|'+
														 '^NOTASSIGNED$|^NOTAVAIL SAME$|^POSITION IS VACANT AT THIS TIME$|^WITHHELD$|^WITHHELD TRUST$|'+
														 '^POSITION NOT NOT FILLED$|^POSITION OPEN$|^VAC ANT ANT VACANT$|^VACANAT VACANT$|^ADDITONAL NAMES$|'+
														 '^NAME1 WITHHELD1$|^NAME2 WITHHELD2$|^NAME3 WITHHELD3$|^OFFICER NOT NOT APPOINTED$|'+
														 '^OFFICER PENDING$|^ON FILE$|^ON FILE ADDITONAL NAMES$|^DIRECTORS ON FILE$|^IN THE APPLICATION$|'+
														 '^POSITION NOT FILLED$|^NOT DESIGNATED$|^NOT DESIGATED$|^NOTE VACANT POSITION$|^VACANT$|^NOTAVAIL$|'+
														 '^OFFICER NOT APPOINTED$|^OFFICER PENDING$|^NOT APPOINTED$|^NOT APPLICAPLE$|'+
														 '^POSITION OPEN$|^POSITION IS OPEN$|NOTAPPLICABLE POSITION|^ON FILE ADDIT';														 
	  RETURN	  if (regexfind('^ADD',ucLNm,0)<>'' and regexfind(' FILE$',ucLNm,0)<>'' or
									regexfind(invalid_name_patterns,ucLNm,0)<>'' or
									regexfind(invalid_name_patterns,ucFNm,0)<>'' or
									regexfind(invalid_name_patterns,ucFullNm,0)<>''
                ,'***' ,'');	
  END;

	
  EXPORT GetOrgStrucDesc(string code)
	    := case(corp2.t2u(code),
			'3LP'  =>  'LIMITED LIABILITY LIMITED PARTNERSHIP',
			'AUT'  =>  'JOINT MUNICIPAL SERVICE AUTHORITIES',
			'BNK'  =>  'BANK',
			'CAS'  =>  'SPECIAL COOPERATIVE',
			'COP'  =>  'COOPERATIVE',
			'CRU'  =>  'CREDIT UNION',
			'FBS'  =>  'FRATERNAL BUILDING SOCIETY',
			'FMA'  =>  'FISH MARKET AC',
			'FRA'  =>  'FRATERNAL SOCIETY',
			'GRG'  =>  'GRANGE',
			'INS'  =>  'INSURANCE',
			'LLC'  =>  'LIMITED LIABILITY REGULAR',
			'LLP'  =>  'LIMITED LIABILITY PARTNERSHIP',
			'LTD'  =>  'LIMITED PARTNERSHIP',
			'MAS'  =>  'MASSACHUSETTS TRUST',
			'MIL'  =>  'MILITARY',
			'MIN'  =>  'PROFIT', 
			'MMC'  =>  'MISCELLANEOUS AND MUTUAL',
			'PBC'  =>  'PUBLIC BENEFIT CORPORATION',
			'PLC'  =>  'LIMITED LIABILITY PROFESSIONAL',
			'PRO'  =>  'PROFESSIONAL SERVICE',
			'PUB'  =>  'PUBLIC UTILITIES',
			'REG'  =>  'REGULAR CORPORATION',
			'RFN'  =>  'FOREIGN REGISTRATION',
			'SAL'  =>  'SAVINGS AND LOAN',
			'SOL'  =>  'CORPORATION SOLE',
			'SPC'  =>  'SOCIAL PURPOSE',			
			'');

		EXPORT DecodeState(string code) 
				:= case(corp2.t2u(code),
			  'AK'  =>  'ALASKA',
				'AL'  =>  'ALABAMA',
				'AR'  =>  'ARKANSAS',
				'AZ'  =>  'ARIZONA',
				'CA'  =>  'CALIFORNIA',
				'CO'  =>  'COLORADO',
				'CT'  =>  'CONNECTICUT',
				'DC'  =>  'DISTRICT OF COLUMBIA',
				'DE'  =>  'DELAWARE',
				'FL'  =>  'FLORIDA',
				'GA'  =>  'GEORGIA',
				'HI'  =>  'HAWAII',
				'IA'  =>  'IOWA',
				'ID'  =>  'IDAHO',
				'IL'  =>  'ILLINOIS',
				'IN'  =>  'INDIANA',
				'KS'  =>  'KANSAS',
				'KY'  =>  'KENTUCKY',
				'LA'  =>  'LOUISIANA',
				'MA'  =>  'MASSACHUSETTS',
				'MD'  =>  'MARYLAND',
				'ME'  =>  'MAINE',
				'MI'  =>  'MICHIGAN',
				'MN'  =>  'MINNESOTA',
				'MO'  =>  'MISSOURI',
				'MS'  =>  'MISSISSIPPI',
				'MT'  =>  'MONTANA',
				'NC'  =>  'NORTH CAROLINA',
				'ND'  =>  'NORTH DAKOTA',
				'NE'  =>  'NEBRASKA',
				'NH'  =>  'NEW HAMPSHIRE',
				'NJ'  =>  'NEW JERSEY',
				'NM'  =>  'NEW MEXICO',
				'NV'  =>  'NEVADA',
				'NY'  =>  'NEW YORK',
				'OH'  =>  'OHIO',
				'OK'  =>  'OKLAHOMA',
				'OR'  =>  'OREGON',
				'PA'  =>  'PENNSYLVANIA',
				'RI'  =>  'RHODE ISLAND',
				'SC'  =>  'SOUTH CAROLINA',
				'SD'  =>  'SOUTH DAKOTA',
				'TN'  =>  'TENNESSEE',
				'TX'  =>  'TEXAS',
				'UT'  =>  'UTAH',
				'VA'  =>  'VIRGINIA',
				'VT'  =>  'VERMONT',
				'WA'  =>  'WASHINGTON',
				'WI'  =>  'WISCONSIN',
				'WV'  =>  'WEST VIRGINIA',
				'WY'  =>  'WYOMING',
				'AE'  =>  'ARMED FORCES EUROPE, THE MIDDLE EAST AND CANADA',
				'AP'  =>  'ARMED FORCES PACIFIC',
				'AA'  =>  'ARMED FORCES AMERICAS EXCEPT CANADA',
				'ALB' =>  'ALBERTA',
				'AB'  =>  'ALBERTA',
				'AUS' =>  'AUSTRALIA',
				'BAR' =>  'BARBADOS',
				'BC'  =>  'BRITISH COLUMBIA',
				'BEL' =>  'BELGIUM',
				'BER' =>  'BERMUDA',
				'BI'  =>  'BAHAMA ISLANDS',
				'BRZ' =>  'BRAZIL',
				'BWI' =>  'BRITISH WEST INDIES',
				'CAN' =>  'CANADA',
				'CHI' =>  'CHANNEL ISLANDS',
				'CI'  =>  'CAYMAN ISLANDS',
				'CR'  =>  'COSTA RICA',
				'CUB' =>  'CUBA',
				'ENG' =>  'ENGLAND',
				'FIN' =>  'FINLAND',
				'FRA' =>  'FRANCE',
				'GER' =>  'GERMANY',
				'GU'  =>  'GUAM',
				'HUN' =>  'HUNGARY',
				'IND' =>  'INDIA',
				'IR'  =>  'IRAN',
				'IRE' =>  'IRELAND',
				'ISR' =>  'ISRAEL',
				'IT'  =>  'ITALY',
				'JPN' =>  'JAPAN',
				'LIE' =>  'LIECHTENSTEIN',
				'MAN' =>  'MANITOBA',
				'MB'  =>  'MANITOBA',
				'NAN' =>  'NETHERLANDS ANTILLES',
				'NT'  =>  'NORTHWEST TERRITORIES',
				'MH'  =>  'MARSHALL ISLANDS',
				'NB'  =>  'NEW BRUNSWICK',
				'NET' =>  'THE NETHERLANDS',
				'NFL' =>  'NEWFOUNDLAND',
				'NOR' =>  'NORWAY',
				'NS'  =>  'NOVA SCOTIA',
				'PAN' =>  'PANAMA',
				'PEI' =>  'PRINCE EDWARD ISLAND',
				'POL' =>  'POLAND',
				'PQ'  =>  'QUEBEC',
				'QC'  =>  'QUEBEC',
				'PR'  =>  'PUERTO RICO',
				'PRC' =>  'PEOPLES REPUBLIC OF CHINA',
				'MEX' =>  'MEXICO',
				'ONT' =>  'ONTARIO',
				'ON'  =>  'ONTARIO',
				'SCT' =>  'SCOTLAND',
				'SJR' =>  'STATES OF JERSEY',
				'SK'  =>  'SASKATCHEWAN',
				'SP'  =>  'SPAIN',
				'SW'  =>  'SWEDEN',
				'SZ'  =>  'SWITZERLAND',
				'UK'  =>  'UNITED KINGDOM',
				'USA' =>  'US',
				'VI'  =>  'VIRGIN ISLANDS',
				'WG'  =>  'WEST GERMANY',
				'01'  =>  '',
				'02'  =>  '',
				'11'  =>  '',
				'13'  =>  '',
				'17'  =>  '',
				'26'  =>  '',
				'34'  =>  '',
				'35'  =>  '',
				'44'  =>  '',
				'46'  =>  '',
				'71'  =>  '',
				'E'   =>  '',
				'ES'  =>  '',
				'FO'  =>  '',   
				'HE'  =>  '',
				'KA'  =>  '',
				'KL'  =>  '',
				'LN'  =>  '',
				'N'   =>  '',
				'N/A' =>  '',
				'QL'  =>  '',
				'TP'  =>  '',
				'ZH'  =>  '',
				''    =>  '',
				'**|' + corp2.t2u(code));
				
END;
