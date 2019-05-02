﻿IMPORT corp2, std, ut;
EXPORT Functions := Module;

//********************************************************************
		//Get_State_Code: validates vendor codes and Returns '**' if we receive invalid or new codes from vendor 
	//********************************************************************	
		EXPORT Get_State_Code(string code):= FUNCTION

		st  := corp2.t2u(code);
		RETURN map(st	 ='UT`'=>'UT',
							 st  ='0H'=>'OH',
							 st  in ['AB','AL','AK','AS','AZ','AR','BC','CA','CN','CO','CR','CT','CAN','CAY','DE','DEL',
											 'DC','ENG','FM','FL','FR','GA','GU','HI','ISR','ID','IT','IL','IN','IA','KS','KY','LA','LUX',
											 'ME','MH','MD','MA','MI','MN','MS','MO','MT','NE','NC','NV','NH','NJ','NM',
											 'NY','ND','MP','OH','OK','OR','ON','ONT','PW','PH','PA','PR','QC','RI','SC','SD',
											 'SCO','TN','TX','UK','UT','US','VT','VI','VA','WA','WV','WI','WY']=> corp2.t2u(code),
							 st  in ['ALB','ANT','ANT','ARG','AUS','BEL','BMU','CAN','CAN','CHI',
											 'CHN','COK','CRI','CYM','DEL','DEU','ENG','FRA','GBR','GBR',
											 'GER','IND','IRE','JAP','JPN','MEX','NEW','NLD','NOR','NZL',
											 'PHI','PHL','PHL','PRI','SGP','SWE','SWI','VEN','VIR']=> corp2.t2u(code),//3 digit codes from vendor
							 st  in ['0','02','2','5','14','15','19','20','24','25','26',
											 '30','31','32','34','35','40','42','45','46',
											 '51','54','99']=>'',	//Per CI:Leave blank -  no translation available																			 
							 st  in ['ALA','BAR','BVI','BWI','CAZ','CI','CK','CYP','D3E',
											 'DEN','DR','DRC','EC','FIN','FK','HAR','HK','II',
											 'JAM','KR','LLC','LP','MAH','MB','MGR','MMN','MUM',
											 'MY','NA','NEV','NL','NOV','NS','NTH','PAN','PQ',
											 'PS','QUE','RO','SLO','SP','SPA','SW','TOK','TXR',
											 'UAE','UR','VAQ','WEI','WW','X','XX','XXX']=>'' ,		//Per CI:Leave blank -  no translation available								 
						'**');
							
	END;	
	
	//********************************************************************
		//fGetStateDesc: Returns full name from "Two digit State_Code" 
	//********************************************************************	
	EXPORT  string fGetStateDesc(STRING state) := FUNCTION

		st  := corp2.t2u(state);
		RETURN map( st='AB'=>'ALBERTA',
								st='AK'=>'ALASKA',
								st='AL'=>'ALABAMA',
								st='ALB'=>'ALBANIA',
								st='ANT'=>'NETHERLANDS ANTILLES',
								st='AR'=>'ARKANSAS',
								st='AS'=>'AMERICAN SAMOA',
								st='AUS'=>'AUSTRALIA',
								st='AZ'=>'ARIZONA',
								st='BC'=>'BRITISH COLUMBIA',
								st='BEL'=>'BELARUS',
								st='CA'=>'CALIFORNIA',
								st='CAN'=>'CANADA',
								st='CAY'=>'CAYMAN ISLANDS',
								st='CHI'=>'CHINA',
								st='CN'=>'CHINA',
								st='CO'=>'COLORADO',
								st='CR'=>'COL EL RETONO',
								st='CT'=>'CONNECTICUT',
								st='DC'=>'DISTRICT OF COLUMBIA',
								st='DE'=>'DELAWARE',
								st='DEL'=>'DELAWARE',
								st='ENG'=>'ENGLAND',
								st='FL'=>'FLORIDA',
								st='FM'=>'FEDERATED STATES OF MICRONESIA',
								st='FR'=>'FAROE ISLANDS',
								st='GA'=>'GEORGIA',
								st='GER'=>'GERMANY',
								st='GU'=>'GUAM',
								st='HI'=>'HAWAII',
								st='IA'=>'IOWA',
								st='ID'=>'IDAHO',
								st='IL'=>'ILLINOIS',
								st='IN'=>'INDIANA',
								st='IND'=>'INDIA',
								st='IRE'=>'IRELAND',
								st='ISR'=>'ISRAEL',
								st='IT'=>'ITALY',
								st='JAP'=>'JAPAN',
								st='KS'=>'KANSAS',
								st='KY'=>'KENTUCKY',
								st='LA'=>'LOUISIANA',
								st='LUX'=>'LUXEMBOURG',
								st='MA'=>'MASSACHUSETTS',
								st='MD'=>'MARYLAND',
								st='ME'=>'MAINE',
								st='MEX'=>'MEXICO',
								st='MH'=>'MARSHALL ISLANDS',
								st='MI'=>'MICHIGAN',
								st='MN'=>'MINNESOTA',
								st='MO'=>'MISSOURI',
								st='MP'=>'NORTHERN MARIANA ISLANDS',
								st='MS'=>'MISSISSIPPI',
								st='MT'=>'MONTANA',
								st='NC'=>'NORTH CAROLINA',
								st='ND'=>'NORTH DAKOTA',
								st='NE'=>'NEBRASKA',
								st='NH'=>'NEW HAMPSHIRE',
								st='NJ'=>'NEW JERSEY',
								st='NM'=>'NEW MEXICO',
								st='NV'=>'NEVADA',
								st='NY'=>'NEW YORK',
								st='OH'=>'OHIO',
								st='0H'=>'OHIO',
								st='OK'=>'OKLAHOMA',
								st='ON'=>'ONTARIO',
								st='ONT'=>'ONTARIO',
								st='OR'=>'OREGON',
								st='PA'=>'PENNSYLVANIA',
								st='PH'=>'PHILIPPINES',
								st='PHI'=>'PHILIPPINES',
								st='PR'=>'PUERTO RICO',
								st='PW'=>'PALAU',
								st='QC'=>'QUEBEC',
								st='RI'=>'RHODE ISLAND',
								st='SC'=>'SOUTH CAROLINA',
								st='SCO'=>'SCOTLAND',
								st='SD'=>'SOUTH DAKOTA',
								st='SGP'=>'SINGAPORE',
								st='SWI'=>'SWITZERLAND',
								st='TN'=>'TENNESSEE',
								st='TX'=>'TEXAS',
								st='UK'=>'UNITED KINGDOM',
								st='US'=>'UNITED STATES',
								st='UT'=>'UTAH',
								st='UT`'=>'UTAH',
								st='VA'=>'VIRGINIA',
								st='VI'=>'VIRGIN ISLANDS',
								st='VT'=>'VERMONT',
								st='WA'=>'WASHINGTON',
								st='WI'=>'WISCONSIN',
								st='WV'=>'WEST VIRGINIA',
								st='WY'=>'WYOMING',
								st in ['0','02','2','5','14','15','19','20','24','25','26','30',
											 '31','32','34','35','40','42','45','46','51','54','99',
											 'ALA','BAR','BVI','BWI','CAZ','CI','CK','CYP','D3E',
											 'DEN','DR','DRC','EC','FIN','FK','HAR','HK','II',
											 'JAM','KR','LLC','LP','MAH','MB','MGR','MMN','MUM',
											 'MY','NA','NEV','NL','NOV','NS','NTH','PAN','PQ',
											 'PS','QUE','RO','SLO','SP','SPA','SW','TOK','TXR',
											 'UAE','UR','VAQ','WEI','WW','X','XX','XXX',''] =>'',
							 '**|'+ st);
							
	END;	
		
  //********************************************************************
		//fGetOrg_structure_desc: Returns "corp_orig_org_structure_desc" 
	//********************************************************************	
	EXPORT  string fGetOrg_structure_desc(STRING Org_code) := FUNCTION

		st  := corp2.t2u(Org_code);
		RETURN case(st,
								'BC' =>'BENEFIT CORPORATION',
								'BT' =>'BUSINESS TRUST',
								'C'  =>'CORPORATION',
								'CA' =>'COOPERATIVE ASSOCIATION',
								'CD' =>'CONSERVATION DISTRICTS',
								'CSO'=>'CREDIT SERVICE ORGANIZATION',
								'DC' =>'DEBT COLLECTOR',
								'EC' =>'EXEMPT CORPORATION',
								'ECS'=>'EXEMPT CSO',
								'ELC'=>'EXEMPT LLC',
								'ELP'=>'EXEMPT LP',
								'EMB'=>'EMBLEM',
								'FN' =>'FICTITIOUS NAME',
								'GP' =>'GENERAL PARTNERSHIP',
								'I'  =>'INSURANCE COMPANY',
								'LLC'=>'LIMITED LIABILITY COMPANY',
								'LLP'=>'LIMITED LIABILITY PARTNERSHIP',
								'LP' =>'LIMITED PARTNERSHIP',
								'NRG' =>'',
								'NRS' =>'',
								'PC' =>'PUBLIC CORPORATION',
								'PFP'=>'PURCHASER OF FUTURE PAYMENTS',
								'PLC'=>'PROFESSIONAL LIMITED LIABILITY COMPANY',
								'SP' =>'SOLE PROPRIETOR',
								'TM' =>'',
								'TMO'=>'TRADEMARK HOLDER',
								'UNA'=>'UNINCORPORATED NON-PROFIT ORGANIZATION',
								'VA' =>'VOLUNTARY ASSOCIATION',
								'Z'	 =>'NOT PROCESSED',
								''   =>'',
								'**|'+st);
		end;	

  //********************************************************************
		//fGetTerminationDesc: Returns "Corp_Termination_Desc" 
	//********************************************************************	
	EXPORT  string fGetTerminationDesc(STRING Org_code) := FUNCTION

		st  := corp2.t2u(Org_code);
		RETURN case(st,
								'B'=>'BANKRUPTCY',
								'C'=>'DISSOLUTION BY COURT ORDER',
								'L'=>'LLC CANCELLATION (FOREIGN)',
								'M'=>'MERGER',
								'N'=>'NAME CHANGE (RESERVED FOR OLD RECORDS)',
								'P'=>'PENDING DISSOLUTION WITHDRAWAL OR MERGER',
								'R'=>'REVOKED (FAILURE TO FILE ANNUAL REPORT)',
								'T'=>'LLC TERMINATION (DOMESTIC)',
								'V'=>'VOLUNTARY DISSOLUTION (DOMESTIC)',
								'W'=>'WITHDRAWAL (FOREIGN)',
								'X'=>'LLC TERMINATION',
								'Z'=>'NOT PROCESSED',
								'' =>'',
								'**|'+st);
	end;	


  //********************************************************************
		//fGetStatusDesc: Returns "corp_status_Comment" 
	//********************************************************************	
	EXPORT  string fGetStatusDesc(STRING Org_code) := FUNCTION

		st  := corp2.t2u(Org_code);
		RETURN case(st,
								'B'=>'BANKRUTPCY DECLARED BY COURT',
								'C'=>'DISSOLUTION BY ORDER OF COURT',
								'L'=>'VOLUNTARY CANCELLATION OF A FOREIGN LLC',
								'M'=>'MERGER',
								'N'=>'NAME CHANGE',
								'P'=>'PENDING DISSOLUTION, WITHDRAWAL OR MERGER',
								'R'=>'REVOCATION FOR FAILURE TO FILE ANNUAL RETURNS OR ANNUAL REPORT',
								'T'=>'VOLUNTARY TERMINATION',
								'V'=>'VOLUNTARY DISSOLUTION',
								'W'=>'VOLUNTARY WITHDRAWAL',
								'X'=>'EXPIRATION OF TERM OF LLC',
								'Z'=>'NOT PROCESSED',
								'' 
								);
	end;
 
	//****************************************************************************
		//fGetCountryDesc: returns the "Country Description".
	//****************************************************************************
	EXPORT fGetCountryDesc(STRING Code) :=  function
		st  := corp2.t2u(Code);
		RETURN map (st in ['AL','AK','AZ','AR','CA','CO','CT','DE','DC','FL','GA','HI','ID','IL','IA',
											 'IN','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH',
											 'NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT',
											 'US','VT','VA','WA','WV','WI','WY'] => 'US',
								st in ['AB','BC','MB','NB','NF','NS','NT','ON','PE','PQ','QC','SK','YT']	=> 'CANADA',// Canadian Provinces
								st in ['II','LLC','NA','Z','156','260','203','250','255','257','253','247','258',
											 '264','267','262','254','252','256','074','544','752','`',
											 '307','261','100','109','120','327','190','266','926','230',
											 '411','912','249','530','503','112','201','457','263','662','840','240','280']	=> '',//Per CI:Leave blank -  no translation available
								st in ['PAR','SLO','TE','UDS','UIS','USS','WOR']=>'',		//Per CI:Leave blank -  no translation available	 
								st ='ABW'=>'ARUBA',	
								st ='AFG'=>'AFGHANISTAN',	
								st ='AGO'=>'ANGOLA',	
								st ='AIA'=>'ANGUILLA',	
								st ='ALA'=>'ALAND ISLANDS',	
								st ='ALB'=>'ALBANIA',	
								st ='AND'=>'ANDORRA',	
								st ='ANT'=>'NETHERLANDS ANTILLES',	
								st ='ARE'=>'UNITED ARAB EMIRATES',	
								st ='ARG'=>'ARGENTINA',	
								st ='ARM'=>'ARMENIA',	
								st ='ASM'=>'AMERICAN SAMOA',	
								st ='ATA'=>'ANTARCTICA',	
								st ='ATF'=>'FRENCH SOUTHERN TERRITORIES',	
								st ='ATG'=>'ANTIGUA AND BARBUDA',	
								st ='AUS'=>'AUSTRALIA',	
								st ='AUT'=>'AUSTRIA',	
								st ='AZE'=>'AZERBAIJAN',	
								st ='BAH'=>'BAHAMAS',	
								ST ='BAR'=>'BARBADOS',	
								st ='BDI'=>'BURUNDI',	
								st ='BEL'=>'BELGIUM',	
								st ='BEL'=>'BELGIUM',	
								st ='BEN'=>'BENIN',	
								st ='BFA'=>'BURKINA FASO',	
								st ='BGD'=>'BANGLADESH',	
								st ='BGR'=>'BULGARIA',	
								st ='BHR'=>'BAHRAIN',	
								st ='BHS'=>'BAHAMAS',	
								st ='BIH'=>'BOSNIA AND HERZEGOWINA',	
								st ='BLM'=>'SAINT-BARTHELEMY',	
								st ='BLR'=>'BELARUS',	
								st ='BLZ'=>'BELIZE',	
								st ='BMU'=>'BERMUDA',	
								st ='BOL'=>'BOLIVIA',	
								st ='BRA'=>'BRAZIL',	
								st ='BRB'=>'BARBADOS',	
								st ='BRN'=>'BRUNEI DARUSSALAM',	
								st ='BTN'=>'BHUTAN',	
								st ='BVT'=>'BOUVET ISLAND',	
								st ='BWA'=>'BOTSWANA',	
								st ='CAF'=>'CENTRAL AFRICAN REPUBLIC',	
								st ='CAN'=>'CANADA',	
								st ='CAY'=>'CAYMAN ISLANDS',	
								st ='CCK'=>'COCOS (KEELING) ISLANDS',	
								st ='CHE'=>'SWITZERLAND',	
								st ='CHI'=>'CHINA',	
								st ='CHL'=>'CHILE',	
								st ='CHN'=>'CHINA',	
								st ='CIV'=>'COTE DIVOIRE',	
								st ='CL'=>'CHILE',	
								st ='CMR'=>'CAMEROON',	
								st ='CN'=>'CHINA',	
								st ='CNA'=>'CANADA',	
								st ='COD'=>'CONGOTHE DRC',	
								st ='COG'=>'CONGO',	
								st ='COK'=>'COOK ISLANDS',	
								st ='COL'=>'COLOMBIA',	
								st ='COM'=>'COMOROS',	
								st ='CPV'=>'CAPE VERDE',	
								st ='CR'=>'COSTA RICA',	
								st ='CRI'=>'COSTA RICA',	
								st ='CUB'=>'CUBA',	
								st ='CXR'=>'CHRISTMAS ISLAND',	
								st ='CYM'=>'CAYMAN ISLANDS',	
								st ='CYP'=>'CYPRUS',	
								st ='CZE'=>'CZECH REPUBLIC',	
								st ='DEN'=>'DENMARK',	
								st ='DEU'=>'GERMANY',	
								st ='DJI'=>'DJIBOUTI',	
								st ='DMA'=>'DOMINICA',	
								st ='DNK'=>'DENMARK',	
								st ='DOM'=>'DOMINICAN REPUBLIC',	
								st ='DZA'=>'ALGERIA',	
								st ='EAS'=>'EGYPT',	
								st ='ECU'=>'ECUADOR',	
								st ='EGY'=>'EGYPT',	
								st ='ENG'=>'ENGLAND',	
								st ='ERI'=>'ERITREA',	
								st ='ESH'=>'WESTERN SAHARA',	
								st ='ESP'=>'SPAIN',	
								st ='EST'=>'ESTONIA',	
								st ='ETH'=>'ETHIOPIA',	
								st ='FIN'=>'FINLAND',	
								st ='FJI'=>'FIJI',	
								st ='FLK'=>'FALKLAND ISLANDS (MALVINAS)',	
								st ='FR'=>'FAROE ISLANDS',	
								st ='FRA'=>'FRANCE',	
								st ='FRA'=>'FRANCE',	
								st ='FRO'=>'FAROE ISLANDS',	
								st ='FSM'=>'MICRONESIAFEDERATED STATES OF',	
								st ='FXX'=>'FRANCEMETROPOLITAN',	
								st ='GAB'=>'GABON',	
								st ='GB'=>'ENGLAND',	
								st ='GBR'=>'LONDON',	
								st ='GEO'=>'GEORGIA',	
								st ='GER'=>'GERMANY',	
								st ='GHA'=>'GHANA',	
								st ='GIB'=>'GIBRALTAR',	
								st ='GIN'=>'GUINEA',	
								st ='GLP'=>'GUADELOUPE',	
								st ='GMB'=>'GAMBIA',	
								st ='GNB'=>'GUINEA-BISSAU',	
								st ='GNQ'=>'EQUATORIAL GUINEA',	
								st ='GRB'=>'UNITED KINGDOM',	
								st ='GRC'=>'GREECE',	
								st ='GRD'=>'GRENADA',	
								st ='GRL'=>'GREENLAND',	
								st ='GTM'=>'GUATEMALA',	
								st ='GUF'=>'FRENCH GUIANA',	
								st ='GUY'=>'GUYANA',
								st in ['GUM','GUA']=>'GUAM',	
								st ='HKG'=>'HONG KONG',	
								st ='HMD'=>'HEARD AND MC DONALD ISLANDS',	
								st ='HND'=>'HONDURAS',	
								st ='HRV'=>'CROATIA',	
								st ='HTI'=>'HAITI',	
								st ='HUN'=>'HUNGARY',	
								st ='IDN'=>'INDONESIA',	
								st ='IMN'=>'ISLE OF MAN',	
								st ='IND'=>'INDIA',	
								st ='IOT'=>'BRITISH INDIAN OCEAN TERRITORY',	
								st ='IRE'=>'IRELAND',	
								st ='IRL'=>'IRELAND',	
								st ='IRN'=>'IRAN',	
								st ='IRQ'=>'IRAQ',	
								st ='IS'=>'ISRAEL',	
								st ='ISA'=>'ISRAEL',	
								st ='ISL'=>'ICELAND',	
								st ='ISR'=>'ISRAEL',	
								st ='IT'=>'ITALY',	
								st ='ITA'=>'ITALY',	
								st ='ITL'=>'ITALY',	
								st ='JA'=>'JAPAN',	
								st ='JAM'=>'JAMAICA',	
								st ='JAP'=>'JAPAN',	
								st ='JEY'=>'JERSEY',	
								st ='JOR'=>'JORDAN',	
								st ='JPN'=>'JAPAN',	
								st ='KAZ'=>'KAZAKHSTAN',	
								st ='KEN'=>'KENYA',	
								st ='KGZ'=>'KYRGYZSTAN',	
								st ='KHM'=>'CAMBODIA',	
								st ='KIR'=>'KIRIBATI',	
								st ='KN'=>'SAINT KITTS AND NEVIS',	
								st ='KNA'=>'SAINT KITTS AND NEVIS',	
								st ='KOR'=>'KOREA, REPUBLIC OF',	
								st ='KOREA, REPUBLIC OF'=>'KOREA, REPUBLIC OF', 	
								st ='KOREAREPUBLIC OF'=>'KOREA, REPUBLIC OF',	
								st ='KR'=>'KOREA, REPUBLIC OF',	
								st ='KWT'=>'KUWAIT',	
								st ='LAO'=>'LAOS',	
								st ='LBN'=>'LEBANON',	
								st ='LBR'=>'LIBERIA',	
								st ='LBY'=>'LIBYAN ARAB JAMAHIRIYA',	
								st ='LCA'=>'SAINT LUCIA',	
								st ='LIE'=>'LIECHTENSTEIN',	
								st ='LKA'=>'SRI LANKA',	
								st ='LSO'=>'LESOTHO',	
								st ='LTU'=>'LITHUANIA',	
								st ='LUX'=>'LUXEMBOURG',	
								st ='LVA'=>'LATVIA',	
								st ='MAC'=>'MACAU',	
								st ='MAF'=>'SAINT-MARTIN (FRENCH PART)',	
								st ='MAR'=>'MOROCCO',	
								st ='MCO'=>'MONACO',	
								st ='MDA'=>'MOLDOVAREPUBLIC OF',	
								st ='MDG'=>'MADAGASCAR',	
								st ='MDV'=>'MALDIVES',	
								st ='MEX'=>'MEXICO',	
								st ='MEX'=>'MEXICO',	
								st ='MHL'=>'MARSHALL ISLANDS',	
								st ='MKD'=>'MACEDONIA',	
								st ='MLI'=>'MALI',	
								st ='MLT'=>'MALTA',	
								st ='MMR'=>'MYANMAR (BURMA)',	
								st ='MNE'=>'MONTENEGRO',	
								st ='MNG'=>'MONGOLIA',	
								st ='MNP'=>'NORTHERN MARIANA ISLANDS',	
								st ='MOZ'=>'MOZAMBIQUE',	
								st ='MRT'=>'MAURITANIA',	
								st ='MSR'=>'MONTSERRAT',	
								st ='MTQ'=>'MARTINIQUE',	
								st ='MUS'=>'MAURITIUS',	
								st ='MWI'=>'MALAWI',	
								st ='MYS'=>'MALAYSIA',	
								st ='MYT'=>'MAYOTTE',	
								st ='NAM'=>'NAMIBIA',	
								st ='NCL'=>'NEW CALEDONIA',	
								st ='NER'=>'NIGER',	
								st ='NEW'=>'NEW ZELAND',	
								st ='NEW'=>'NEW ZELAND',	
								st ='NFK'=>'NORFOLK ISLAND',	
								st ='NGA'=>'NIGERIA',	
								st ='NIC'=>'NICARAGUA',	
								st ='NIU'=>'NIUE',	
								st ='NL'=>'NETHERLANDS',	
								st ='NLD'=>'NETHERLANDS',	
								st ='NOR'=>'NORWAY',	
								st ='NOV'=>'NOVA SCOTIA',	
								st ='NPL'=>'NEPAL',	
								st ='NRU'=>'NAURU',	
								st ='NZL'=>'NEW ZEALAND',	
								st ='OMN'=>'OMAN',	
								st ='PAK'=>'PAKISTAN',	
								st ='PAN'=>'PANAMA',	
								st ='PCN'=>'PITCAIRN',	
								st ='PER'=>'PERU',	
								st ='PHI'=>'PHILIPPINES',	
								st ='PHI'=>'PHILIPPINES',	
								st ='PHL'=>'PHILIPPINES',	
								st ='PLW'=>'PALAU',	
								st ='PN' =>'PITCAIRN',	
								st ='PNG'=>'PAPUA NEW GUINEA',	
								st ='POL'=>'POLAND',	
								st ='PR'=>'PARAGUAY',	
								st ='PRI'=>'PUERTO RICO',	
								st ='PRK'=>'KOREAD.P.R.O.',	
								st ='PRT'=>'PORTUGAL',	
								st ='PRY'=>'PARAGUAY',	
								st ='PSE'=>'PALESTINIAN TERRITORYOCCUPIED',	
								st ='PYF'=>'FRENCH POLYNESIA',	
								st ='QAT'=>'QATAR',	
								st ='REU'=>'REUNION',	
								st ='ROM'=>'ROMANIA',	
								st ='ROU'=>'ROMANIA',	
								st ='RUS'=>'RUSSIAN FEDERATION',	
								st ='RWA'=>'RWANDA',	
								st ='SAU'=>'SAUDI ARABIA',	
								st ='SCO'=>'SCOTLAND',	
								st ='SDN'=>'SUDAN',	
								st ='SEN'=>'SENEGAL',	
								st ='SGP'=>'SINGAPORE',	
								st ='SGP'=>'SINGAPORE',	
								st ='SGS'=>'SOUTH GEORGIA AND SOUTH S.S.',	
								st ='SHN'=>'ST.HELENA',	
								st ='SIN'=>'SINGAPORE',	
								st ='SJM'=>'SVALBARD AND JAN MAYEN ISLANDS',	
								st ='SLB'=>'SOLOMON ISLANDS',	
								st ='SLE'=>'SIERRA LEONE',	
								st ='SLV'=>'EL SALVADOR',	
								st ='SMR'=>'SAN MARINO',	
								st ='SOM'=>'SOMALIA',	
								st ='SOU'=>'SOUTH AFRICA',	
								st ='SPA'=>'SPAIN',	
								st ='SPM'=>'ST.PIERRE AND MIQUELON',	
								st ='SRB'=>'SERBIA',	
								st ='SSD'=>'SOUTH SUDAN',	
								st ='STP'=>'SAO TOME AND PRINCIPE',	
								st ='SUR'=>'SURINAME',	
								st ='SVK'=>'SLOVAKIA (SLOVAK REPUBLIC)',	
								st ='SVN'=>'SLOVENIA',	
								st ='SWE'=>'SWEDEN',	
								st ='SWI'=>'SWITZERLAND',	
								st ='SWI'=>'SWITZERLAND',	
								st ='SWZ'=>'SWAZILAND',	
								st ='SYC'=>'SEYCHELLES',	
								st ='SYR'=>'SYRIAN ARAB REPUBLIC',	
								st ='TC'	=> 'TURKS AND CAICOS ISLANDS',
								st ='TCA'=>'TURKS AND CAICOS ISLANDS',	
								st ='TCD'=>'CHAD',	
								st ='TG'	=> 'TOGO',
								st ='TGO'=>'TOGO',	
								st ='THA'=>'THAILAND',	
								st ='TJK'=>'TAJIKISTAN',	
								st ='TK'	=> 'TOKELAU',
								st ='TKL'=>'TOKELAU',	
								st ='TKM'=>'TURKMENISTAN',	
								st ='TM'	=> 'TURKMENISTAN',
								st ='TMP'=>'EAST TIMOR',	
								st ='TN'	=> 'TUNISIA',
								st ='TO'	=> 'TONGA',
								st ='TON'=>'TONGA',	
								st ='TR'	=> 'TURKEY',
								st ='TT'	=> 'TRINIDAD AND TOBAGO',
								st ='TTO'=>'TRINIDAD AND TOBAGO',	
								st ='TUN'=>'TUNISIA',	
								st ='TUR'=>'TURKEY',	
								st ='TUV'=>'TUVALU',	
								st ='TV'	=> 'TUVALU',
								st ='TWN'=>'TAIWANPROVINCE OF CHINA',	
								st ='TZA'=>'TANZANIAUNITED REPUBLIC OF',	
								st ='U.S.'=>'US',	
								st ='U.S.A.'=>'US',	
								st ='U.S.A'=>'US',	
								st ='UA' 	=> 'UKRAINE',
								st ='UG'	=> 'UGANDA',
								st ='UGA'=>'UGANDA',	
								st ='UK'=>'UNITED KINGDOM',	
								st ='UKR'=>'UKRAINE',	
								st ='UMI'=>'U.S. MINOR ISLANDS',	
								st ='UNI'=>'US',	
								st ='UNITED STATES'=>'US',	
								st ='URU'=>'URUGUAY',	
								st ='URY'=>'URUGUAY',	
								st ='US'=>'US',	
								st ='USA'=>'US',
								st ='7US'=>'US',		
								st ='UZB'=>'UZBEKISTAN',	
								st ='VAT'=>'HOLY SEE (VATICAN CITY STATE)',	
								st ='VCT'=>'SAINT VINCENT AND THE GRENADINES',	
								st ='VEN'=>'VENEZUELA',	
								st ='VGB'=>'VIRGIN ISLANDS (BRITISH)',	
								st ='VI' =>'VIRGIN ISLANDS',	
								st ='VIR'=>'VIRGIN ISLANDS (U.S.)',	
								st ='VNM'=>'VIET NAM',	
								st ='VUT'=>'VANUATU',	
								st ='WI'=>'WEST INDIES',	
								st ='WLF'=>'WALLIS AND FUTUNA ISLANDS',	
								st ='WSM'=>'SAMOA',	
								st ='YEM'=>'YEMEN',	
								st ='YSA'=>'US',	
								st ='ZAF'=>'SOUTH AFRICA',	
								st ='ZMB'=>'ZAMBIA',	
								st ='ZWE'=>'ZIMBABWE',
								st =''=>'',
								'**|'+corp2.t2u(code)
						);
						
	END;
	
  //********************************************************************
		//fGetCountyDesc: Returns "corp_inc_county" 
	//********************************************************************	
	EXPORT  fGetCountyDesc(STRING code) := FUNCTION	

	  st  := corp2.t2u(code);	
		RETURN case(st,
								'1'=>'BARBOUR',
								'2'=>'BERKELEY',
								'3'=>'BOONE',
								'4'=>'BRAXTON',
								'5'=>'BROOKE',
								'6'=>'CABELL',
								'7'=>'CALHOUN',
								'8'=>'CLAY',
								'9'=>'DODDRIDGE',
								'10'=>'FAYETTE',
								'11'=>'GILMER',
								'12'=>'GRANT',
								'13'=>'GREENBRIER',
								'14'=>'HAMPSHIRE',
								'15'=>'HANCOCK',
								'16'=>'HARDY',
								'17'=>'HARRISON',
								'18'=>'JACKSON',
								'19'=>'JEFFERSON',
								'20'=>'KANAWHA',
								'21'=>'LEWIS',
								'22'=>'LINCOLN',
								'23'=>'LOGAN',
								'24'=>'MARION',
								'25'=>'MARSHALL',
								'26'=>'MASON',
								'33'=>'MCDOWELL',
								'27'=>'MERCER',
								'28'=>'MINERAL',
								'29'=>'MINGO',
								'30'=>'MONONGALIA',
								'31'=>'MONROE',
								'32'=>'MORGAN',
								'34'=>'NICHOLAS',
								'35'=>'OHIO',
								'36'=>'PENDLETON',
								'37'=>'PLEASANTS',
								'38'=>'POCAHONTAS',
								'39'=>'PRESTON',
								'40'=>'PUTNAM',
								'41'=>'RALEIGH',
								'42'=>'RANDOLPH',
								'43'=>'RITCHIE',
								'44'=>'ROANE',
								'45'=>'SUMMERS',
								'46'=>'TAYLOR',
								'47'=>'TUCKER',
								'48'=>'TYLER',
								'49'=>'UPSHUR',
								'50'=>'WAYNE',
								'51'=>'WEBSTER',
								'52'=>'WETZEL',
								'53'=>'WIRT',
								'54'=>'WOOD',
								'55'=>'WYOMING',
								'56'=>'',
								'99'=>'FOREIGN COUNTRY',
								'0'=>'',
								''=>'',
								'**|'+st
								);
		
    END;
	
   //"fix_ForeignChar" function returns WV state-site matching “Legal Names” by replacing –“foreign character patterns" with “WV-Sate site character patterns"
	 //line numbers from 645 to 658 (Regexfind- functions are different than rest them since those companies does not have common replacement char
		EXPORT fix_ForeignChar(STRING s) := FUNCTION

			uc_s  							 := corp2.t2u(s);				
			temp_Lname 					 := regexreplace('Â|||', uc_s, '');  //unprintables noticed in the data & Cleaning them
			fix_legal_name       := map(regexfind('ARETÃ HOLDINGS LTD. CO.',  temp_Lname,0)  <> ''  				=>'ARETA HOLDINGS LTD CO',
																	regexfind('BÃRKI ENTERPRISES LLC',  temp_Lname,0)  <> ''						=>'BARKI ENTERPRISES LLC',
																	regexfind('BRUADER MÃR',  temp_Lname,0)  <> ''										  =>'BRUADER MOR',
																	regexfind('CAFÃ INTERNACIONAL, LLC',  temp_Lname,0)  <> ''					=>'CAFE INTERNACIONAL LLC' ,
																	regexfind('DRAGON CAFÃ INC.',  temp_Lname,0)  <> ''									=>'DRAGON CAFE INC',
																	regexfind('E-THERAPY CAFÃ INC.',  temp_Lname,0)  <> ''							=>'E THERAPY CAFE INC',
																	regexfind('HUDROKHOÃS DESIGN AND BUILD, LLC',  temp_Lname,0)  <> ''	=>'HUDROKHOAS DESIGN AND BUILD LLC',
																	regexfind('INFINITY CRAFT & DÃ¨COR, LLC',  temp_Lname,0)  <> ''			=>'INFINITY CRAFT & DECOR LLC',
																	regexfind('MÃLODIE MUSIC STUDIO, INC',  temp_Lname,0)  <> ''				=>'MALODIE MUSIC STUDIO INC',
																	regexfind('MCCUTÃE LLC',  temp_Lname,0)  <> ''											=>'MCCUTIE LLC',
																	regexfind('MOJO Ã GOGO LLC',  temp_Lname,0)  <> ''									=>'MOJO A GOGO LLC',
																	regexfind('PFÃRTNER - PREMIUM PROPERTIES',  temp_Lname,0)  <> ''		=>'PFORTNER - PREMIUM PROPERTIES',
																	regexfind('PORTA JÃIAS',  temp_Lname,0)  <> ''											=>'PORTA JOIAS',
																	regexfind('ILASHÃ LLC',  temp_Lname,0)  <> ''												=>'ILASHA LLC',
																	regexfind('Â²', temp_Lname,0) 	 <> ''															=>regexreplace('Â²', temp_Lname, ''),
																	regexfind('Â³', temp_Lname,0)   <> ''																=>regexreplace('Â³', temp_Lname, ''),
																	regexfind('Â|Â¢|Â°|â|â¢',  temp_Lname,0)  <> ''											=>regexreplace('Â|Â¢|Â°|â|â¢',  temp_Lname, ''),
																	temp_Lname);
		 return ut.fn_RemoveSpecialChars((string)Std.Uni.CleanAccents(fix_legal_name));		
				
   	END;
		
END;