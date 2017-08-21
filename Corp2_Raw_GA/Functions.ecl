IMPORT corp2, corp2_mapping, ut;

EXPORT Functions := MODULE

	//********************************************************************
		//State_Code: validates vendor codes and Returns '**' if we receive invalid or new codes from vendor 
	//********************************************************************	
	EXPORT StateCode(STRING code) 
	        := MAP (corp2.t2u(code) IN 
									[ 'AL','AK','AS','AZ','AR','CA','CO','CT','DE','DC','FM','FL','GA',
										'GU','HI','ID','IL','IN','IA','KS','KY','LA','ME','MH','MD','MA',
										'MI','MN','MS','MO','MT','NC','NE','NV','NH','NJ','NM','NY','ND',
										'MP','OH','OK','OR','PA','PR','RI','SC','SD','TN','TX','UT',
										'VT','VI','VA','WA','WV','WI','WY','CD','UK','AB']  => corp2.t2u(code),
									  corp2.t2u(code) in ['XX','X','NA','PW','AE','UN','']=> '', // !!as per Rosemary 
									 '**');
									
	EXPORT CountryDesc(STRING code) := FUNCTION
				 uc_s := corp2.t2u(code);
		     RETURN MAP(uc_s = 'AB'                                       => 'ALBERTA',
				            uc_s IN ['AG','ATG']                              => 'ANTIGUA AND BARBUDA',
							      uc_s IN ['ANT','NETHERLANDS ANTILLES']            => 'NETHERLANDS ANTILLES',
							      uc_s = 'AW'                                       => 'ARUBA',
							      uc_s IN ['ARE','UNITED ARAB EMIRATES']            => 'UNITED ARAB EMIRATES',
							      uc_s = 'AUS'                                      => 'AUSTRALIA',
							      uc_s = 'AUT'                                      => 'AUSTRIA',
							      uc_s IN ['BAH','BHS','BS','BAHAMAS']              => 'BAHAMAS',
										uc_s = 'BAHRAIN'                                  => 'BAHRAIN',
							      uc_s = 'BELARUS'                                  => 'BELARUS',
							      uc_s = 'BENIN'                                    => 'BENIN',
							      uc_s = 'BOLIVIA'                                  => 'BOLIVIA',
							      uc_s = 'BOTSWANA'                                 => 'BOTSWANA',
							      uc_s IN ['BDI','BURUNDI']                         => 'BURUNDI',
							      uc_s IN ['BB','BRB','BARBADOS']                   => 'BARBADOS',
							      uc_s IN ['BE','BEL']                              => 'BELGIUM',
							      uc_s = 'BGD'                                      => 'BANGLADESH',
							      uc_s IN ['BGR','BULGARIA']                        => 'BULGARIA',
							      uc_s = 'BLZ'                                      => 'BELIZE',
							      uc_s IN ['BM','BER','BMU','BRM']	                => 'BERMUDA',
							      uc_s = 'BRA'                                      => 'BRAZIL',
										uc_s = 'BC'	                                      => 'BRITISH COLUMBIA',
							      uc_s IN ['IOT','BRITISH INDIAN OCEAN TERRITORY']  => 'BRITISH INDIAN OCEAN TERRITORY',
							      uc_s IN ['BVI','VGB']                             => 'BRITISH VIRGIN ISLANDS',
										uc_s = 'KHM'                                      => 'CAMBODIA',
							      uc_s IN ['CAN','CN']                              => 'CANADA',
							      uc_s IN ['CAY','CYM']                             => 'CAYMAN ISLANDS',
							      uc_s = 'CHL'                                      => 'CHILE',
							      uc_s IN ['CHN','CHINA']                           => 'CHINA',
							      uc_s = 'CIV'                                      => 'COTE D\'IVOIRE', 
							      uc_s = 'COG'                                      => 'CONGO',
							      uc_s = 'COL'                                      => 'COLUMBIA',
							      uc_s = 'COK'                                      => 'COOK ISLANDS',
							      uc_s = 'CRI'                                      => 'COSTA RICA',
										uc_s = 'CUBA'                                     => 'CUBA',
							      uc_s = 'CYP'                                      => 'CYPRUS',
							      uc_s IN ['CZE','CZECH REPUBLIC']                  => 'CZECH REPUBLIC',
							      uc_s IN ['DEN','DNK']                             => 'DENMARK',
							      uc_s = 'DOM'                                      => 'DOMINICAN REPUBLIC',
							      uc_s IN ['EGY','EGYPT']                           => 'EGYPT',
							      uc_s IN ['ECU','ECUADOR']                         => 'ECUADOR',
							      uc_s = 'ERITREA'                                  => 'ERITREA',
							      uc_s IN ['ESP','SPAIN']                           => 'SPAIN',
							      uc_s IN ['ENG','GB']                              => 'ENGLAND',
							      uc_s = 'FIN'                                      => 'FINLAND',
							      uc_s IN ['FR','FRA']                              => 'FRANCE',
							      uc_s IN ['DEU','GR','GER']                        => 'GERMANY',
	                  uc_s = 'GHA'                                      => 'GHANA',
							      uc_s = 'GBR'                                      => 'GREAT BRITAIN',
							      uc_s IN ['GRC','GRE']                             => 'GREECE',
							      uc_s = 'GTM'                                      => 'GUATEMALA',
							      uc_s IN ['GU','GUM']                              => 'GUAM',
							      uc_s = 'GUINEA'                                   => 'GUINEA',
							      uc_s = 'HKG'                                      => 'HONG KONG',
							      uc_s = 'HTI'                                      => 'HAITI',
							      uc_s = 'HON'                                      => 'HONDURAS',
							      uc_s = 'HUN'                                      => 'HUNGARY',
							      uc_s = 'ISL'                                      => 'ICELAND',
							      uc_s = 'IND'                                      => 'INDIA',
							      uc_s = 'IDN'                                      => 'INDONESIA',
							      uc_s IN ['IRE','IRL']                             => 'IRELAND',
							      uc_s = 'ISR'                                      => 'ISRAEL',
							      uc_s IN ['IT','ITA']          	                  => 'ITALY',
							      uc_s IN ['JM','JAM']                              => 'JAMAICA',
							      uc_s IN ['JA','JP','JAP','JPN']                   => 'JAPAN',
							      uc_s = 'JORDAN'                                   => 'JORDAN',
	                  uc_s = 'KAZ'                                      => 'KAZAKHSTAN',
							      uc_s = 'KEN'                                      => 'KENYA',
										uc_s = 'KOR'                                      => 'KOREA',
                    uc_s = 'LAO'                                      => 'LAO PDR',
							      uc_s = 'LBR'                                      => 'LIBERIA',
							      uc_s = 'LIB'                                      => 'LIBYA',
							      uc_s = 'LIE'                                      => 'LIECHTENSTEIN',
							      uc_s = 'LUX'                                      => 'LUXEMBOURG',
							      uc_s = 'MV'                                       => 'MALDIVES',
							      uc_s = 'MLI'                                      => 'MALI',
							      uc_s IN ['MH','MHL']                              => 'MARSHALL ISLANDS',
							      uc_s = 'MUS'                                      => 'MAURITIUS',
										uc_s = 'MAYOTTE'                                  => 'MAYOTTE',
							      uc_s IN ['MEX','MX']                              => 'MEXICO',
							      uc_s = 'MTQ'                                      => 'MARTINIQUE',
							      uc_s IN ['NA','NAMIBIA']                          => 'NAMIBIA',
							      uc_s IN ['NET','NLD','NTH']                       => 'NETHERLANDS',
						        uc_s = 'NEV'                                      => 'NEVADA',
										uc_s = 'NGA'                            					=> 'NIGERIA',
										uc_s = 'NPL'                           						=> 'NEPAL',
										uc_s = 'NOR'                            					=> 'NORWAY',
										uc_s = 'NZL'                            					=> 'NEW ZEALAND',
										uc_s IN ['ONT','ON']                            	=> 'ONTARIO',
										uc_s = 'OC'                                       => 'OUT OF COUNTRY',
							      uc_s IN ['PK','PAK']          	                  => 'PAKISTAN',
										uc_s = 'PAN'                            					=> 'PANAMA',
										uc_s = 'PY'                             					=> 'PARAGUAY',
										uc_s = 'PER'                           						=> 'PERU',
										uc_s = 'PHL'                            					=> 'PHILIPPINES',
										uc_s = 'PN'                             					=> 'PITCAIRN',
							      uc_s IN ['PL','POL']         	                    => 'POLAND',
							      uc_s IN ['PR','PRI','PUERTO RICO']                => 'PUERTO RICO',
							      uc_s = 'PRT'                                      => 'PORTUGAL',
							      uc_s IN ['QAT','QATAR']                           => 'QATAR',
							      uc_s IN ['QUE','QC']                              => 'QUEBEC',
										uc_s = 'KNA'                                      => 'SAINT KITTS AND NERVIS',
							      uc_s = 'LCA'                                      => 'SAINT LUCIA',
							      uc_s = 'MF'                                       => 'SAINT MARTIN FRENCH PART',
							      uc_s = 'VCT'                                      => 'SAINT VINCENT AND THE GRENADINES',
							      uc_s = 'SEN'                                      => 'SENEGAL',
							      uc_s IN ['SGP','SIN']                             => 'SINGAPORE',
										uc_s = 'SVK'                                      => 'SLOVAKIA',
										uc_s = 'ZAF'                            					=> 'SOUTH AFRICA',
										uc_s = 'LKA'                                      => 'SRI LANKA',
										uc_s = 'SUDAN'                                    => 'SUDAN',
							      uc_s = 'SWE'                                      => 'SWEDEN',
							      uc_s IN ['CH','CHE','SWI']     	                  => 'SWITZERLAND',
										uc_s = 'RUS'                                      => 'RUSSIAN FEDERATION',
										uc_s = 'TWN'                            					=> 'TAIWAN',
										uc_s = 'TZA'                            					=> 'TANZANIA',
										uc_s = 'TUR'                            					=> 'TURKEY',
										uc_s = 'TCA'                            					=> 'TURKS AND CAICOS ISLANDS',
										uc_s = 'UMI'                            					=> 'UNITED STATES MINOR OUTLYING',
										uc_s = 'UK'                            						=> 'UNITED KINGDOM',
										uc_s IN ['US','USA']                              => 'US',
										uc_s = 'URY'                            					=> 'URUGUAY',
										uc_s = 'VEN'                            					=> 'VENEZUELA',
										uc_s = 'VNM'                            					=> 'VIETNAM',
										uc_s = 'VG'                             					=> 'VIRGIN ISLANDS BR',
							      uc_s IN ['VI','VIR']                              => 'VIRGIN ISLANDS',
										uc_s = 'YEMEN'                                    => 'YEMEN',
							      uc_s = 'ZMB'                            					=> 'ZAMBIA',
							      uc_s IN ['ZWE','ZIMBABWE']                        => 'ZIMBABWE',
										uc_s = ''                                         => '',
										'**|' + uc_s								
									 );
	END;
  //********************************************************************
		//Phone_No: cleans phone numbers and Returns a hyphenated 7 or 10 digit number 
	//********************************************************************	
  EXPORT PhoneNo(STRING Phone) := FUNCTION

		ph           := (STRING)(INTEGER)ut.CleanPhone(phone); // we have first 3 digits are zeros in phones EX:0003456789 ,0000000000
    phone_number := IF(TRIM(ph)<>'0',IF(LENGTH(ph) = 10, ph[1..3]+'-'+ph[4..6]+'-'+ph[7..10], IF(LENGTH(ph)=7	,	ph[1..3]+'-'+ph[4..7],ph)),''); //only 10 digit and 7 digit will be hyphenated other numbers will not !
		RETURN phone_number;
		
  END;
	
	//********************************************************************
		//StateDesc: Returns full name from "Two digit State_Code" 
	//********************************************************************	
	EXPORT  STRING StateDesc(STRING state) := FUNCTION

		st  := corp2.t2u(state);
		RETURN case(st,
								'AL' => 'ALABAMA',
								'AK' => 'ALASKA',
								'AS' => 'AMERICAN SAMOA',
								'AZ' => 'ARIZONA',
								'AR' => 'ARKANSAS',
								'CA' => 'CALIFORNIA',
								'CO' => 'COLORADO',
								'CT' => 'CONNECTICUT',
								'DE' => 'DELAWARE',
								'DC' => 'DISTRICT OF COLUMBIA',
								'FM' => 'FEDERATED STATES OF MICRONESIA',
								'FL' => 'FLORIDA',
								'GA' => 'GEORGIA',
								'GU' => 'GUAM',
								'HI' => 'HAWAII',
								'ID' => 'IDAHO',
								'IL' => 'ILLINOIS',
								'IN' => 'INDIANA',
								'IA' => 'IOWA',
								'KS' => 'KANSAS',
								'KY' => 'KENTUCKY',
								'LA' => 'LOUISIANA',
								'ME' => 'MAINE',
								'MD' => 'MARYLAND',
								'MA' => 'MASSACHUSETTS',
								'MI' => 'MICHIGAN',
								'MN' => 'MINNESOTA',
								'MS' => 'MISSISSIPPI',
								'MO' => 'MISSOURI',
								'MT' => 'MONTANA',
								'NC' => 'NORTH CAROLINA',
								'NE' => 'NEBRASKA',
								'NV' => 'NEVADA',
								'NH' => 'NEW HAMPSHIRE',
								'NJ' => 'NEW JERSEY',
								'NM' => 'NEW MEXICO',
								'NY' => 'NEW YORK',
								'ND' => 'NORTH DAKOTA',
								'MP' => 'NORTHERN MARIANA ISLANDS',
								'OH' => 'OHIO',
								'OK' => 'OKLAHOMA',
								'OR' => 'OREGON',
								'PA' => 'PENNSYLVANIA',
								'PR' => 'PUERTO RICO',
								'RI' => 'RHODE ISLAND',
								'SC' => 'SOUTH CAROLINA',
								'SD' => 'SOUTH DAKOTA',
								'TN' => 'TENNESSEE',
								'TX' => 'TEXAS',
								'UT' => 'UTAH',
								'VT' => 'VERMONT',
								'VI' => 'VIRGIN ISLANDS',
								'VA' => 'VIRGINIA',
								'WA' => 'WASHINGTON',
								'WV' => 'WEST VIRGINIA',
								'WI' => 'WISCONSIN',
								'WY' => 'WYOMING',
								'AB' => 'CANADA',
								'AP' => 'ARMED FORCES PACIFIC',
								'AA' => 'ARMED FORCES AMERICAS EXCEPT CANADA',
								'CB' => 'COLUMBIA',
								'UK' => 'UNITED KINGDOM',
								'GB' => 'GREAT BRITAIN',
								'CD' => 'CANADA',
								'HK' => 'HONG KONG',
								'MX' => 'MEXICO',
								'EU' => 'EUROPE',
								'CI' => 'COOK ISLANDS',
								'SA' => 'OTHER S&C AMERICAN',
								'II' => 'INDIA',
								'SL' => 'SCOTLAND',
								'US' => 'UNITED STATES',
								'BE' => 'BERMUDA',
								'FR' => 'FRANCE',
								'JA' => 'JAPAN',
								'MH' => 'MARSHALL ISLANDS',
								'NL' => 'NETHERLANDS',
								'NS' => 'NOVA SCOTIA, CANADA',
								'OA' => 'OTHER ASIA',
								'BR' => 'BARBADOS',
								'AF' => 'AFRICA',
								'IE' => 'IRELAND',
								'AU' => 'AUSTRALIA',
								'LX' => 'LUXEMBOURG',
								'CH' => 'CHINA',
								'CZ' => 'CANAL ZONE',
								'PH' => 'PHILIPPINES',
								'BL' => 'BELGIUM',
								'BW' => 'BRITISH WEST INDIES',
								'GR' => 'GERMANY',
								'PN' => 'PANAMA',
								'UN' => '',           //UNKNOWN
								'PW' => '',           //TYPO - COMPANY IS FROM PUERTO RICO
								'AE' => '',           //MILITARY ADDRESS
								''   => '',
								'**|'+ st);
							
		END;													

    //********************************************************************
      //Below date utility to fix the slashed dates into YYYYMMDD
		//********************************************************************
    EXPORT fix_Date(STRING d):= FUNCTION
		
 			dt:= ut.date_slashed_mmddyyyy_to_yyyymmdd(d);
			RETURN dt;

		END;
		
		//****************************************************************************
		//CorpOrigOrgStructureDesc: returns the "corp_orig_org_structure_desc".
		//												  input: s -> bus_type
		//****************************************************************************
		EXPORT CorpOrigOrgStructureDesc(STRING s) := FUNCTION
					 uc_s := corp2.t2u(s);
					 RETURN	MAP(uc_s = 'ALIEN CORPORATION (RICO)' 											=> uc_s,
											uc_s = 'CABLE/VIDEO FRANCHISE'								          => uc_s,
											uc_s = 'DOCUMENT ORDER'											            => uc_s,
											uc_s = 'DOMESTIC BANK'							                		=> uc_s,
											uc_s = 'DOMESTIC CORPORATION'												    => uc_s,
											uc_s = 'DOMESTIC CREDIT UNION'									        => uc_s,
											uc_s = 'DOMESTIC FORPROFIT COOP'									      => uc_s,
											uc_s = 'DOMESTIC INSURANCE COMPANY'									    => uc_s,
											uc_s = 'DOMESTIC LIMITED LIABILITY COMPANY'							=> uc_s,
											uc_s = 'DOMESTIC LIMITED LIABILITY LIMITED PARTNERSHIP'	=> uc_s,
											uc_s = 'DOMESTIC LIMITED LIABILITY PARTNERSHIP'				  => uc_s,
											uc_s = 'DOMESTIC LIMITED PARTNERSHIP'									  => uc_s,
											uc_s = 'DOMESTIC NON-ENTITY NONFILING'								  => uc_s,
											uc_s = 'DOMESTIC NON-FILING ENTITY'									    => uc_s,
											uc_s = 'DOMESTIC NONPROFIT CORPORATION'									=> uc_s,
											uc_s = 'DOMESTIC PROFESSIONAL CORPORATION'						  => uc_s,
											uc_s = 'DOMESTIC PROFESSIONAL PA'									      => uc_s,
											//uc_s = 'DOMESTIC PROFIT'									              => uc_s,
											uc_s = 'DOMESTIC PROFIT CORPORATION'			              => uc_s,
											uc_s = 'DOMESTIC UNKNOWN'									              => uc_s,
											uc_s = 'FOREIGN BANK'									                  => uc_s,
											uc_s = 'FOREIGN CORPORATION'									          => uc_s,
											uc_s = 'FOREIGN CREDIT UNION'									          => uc_s,
											uc_s = 'FOREIGN INSURANCE COMPANY'									    => uc_s,
											uc_s = 'FOREIGN LIMITED COOPERATIVE ASSOCIATION'				=> uc_s,
											uc_s = 'FOREIGN LIMITED LIABILITY COMPANY'							=> uc_s,
											uc_s = 'FOREIGN LIMITED LIABILITY LIMITED PARTNERSHIP'	=> uc_s,
											uc_s = 'FOREIGN LIMITED LIABILITY PARTNERSHIP'					=> uc_s,
											uc_s = 'FOREIGN LIMITED PARTNERSHIP'									  => uc_s,
											uc_s = 'FOREIGN NONPROFIT CORPORATION'									=> uc_s,
										  uc_s = 'FOREIGN NON-QUALIFYING ENTITY'									=> uc_s,
											uc_s = 'FOREIGN PROFESSIONAL CORPORATION'							  => uc_s,
											uc_s = 'FOREIGN PROFIT CORPORATION'									    => uc_s,
											uc_s = 'FOREIGN UNKNOWN'									              => uc_s,
											uc_s = 'MARKETING ASSOCIATION'									        => uc_s,
											uc_s = 'MUTUAL AID RESOURCE PACT'									      => uc_s,
											uc_s = 'NAME RESERVATION'									              => uc_s,
											uc_s = 'TRANSPORTATION/TELECOMMUNICATION/RAILROAD'		  => uc_s,
											'**|'+uc_s 																													//scrubbing for new business types
										 );

		END;
		
		//****************************************************************************
		//ProfitIndicator: returns "Y" or "N".
		//								 input: s -> bus_type
		//****************************************************************************
		EXPORT ProfitIndicator(STRING s) := FUNCTION
					 uc_s := corp2.t2u(s);
					 RETURN	MAP(uc_s = 'DOMESTIC FORPROFIT COOP'									      => 'Y',
											uc_s = 'DOMESTIC NONPROFIT CORPORATION'									=> 'N',
											uc_s = 'DOMESTIC PROFIT'									              => 'Y',
											uc_s = 'DOMESTIC PROFIT CORPORATION'                    => 'Y',
											uc_s = 'FOREIGN NONPROFIT CORPORATION'									=> 'N',
											uc_s = 'FOREIGN PROFIT CORPORATION'									    => 'Y',
											'' 																													 
										 );

		END;
		
		//****************************************************************************
		//CorpStatusDesc: returns the "corp_status_desc".
		//												  input: s -> EntityStatus
		//****************************************************************************
		EXPORT CorpStatusDesc(STRING s) := FUNCTION
					 uc_s := corp2.t2u(s);
					 RETURN	MAP(uc_s = 'ABANDONED' 										=> uc_s,
											uc_s = 'ACTIVE'								        => uc_s,
											uc_s = 'ACTIVE PENDING'							  => uc_s,
											uc_s = 'ACTIVE/COMPLIANCE'						=> uc_s,
											uc_s = 'ACTIVE/NONCOMPLIANCE'				  => uc_s,
											uc_s = 'ACTIVE/OWES CURRENT YEAR AR'	=> uc_s,
											uc_s = 'ADMIN. DISSOLVED'						  => uc_s,
											uc_s = 'CANCELLED'									  => uc_s,
											uc_s = 'CONSOLIDATED'							    => uc_s,
											uc_s = 'CONVERTED'	                  => uc_s,
											uc_s = 'DISAPPROVED FILING'				    => uc_s,
											uc_s = 'DISSOLVED'									  => uc_s,
											uc_s = 'DO NOT USE DISAPPROVED'				=> uc_s,
											uc_s = 'ELECTION TO LLC/LP'						=> uc_s,
											uc_s = 'EXPIRED'									    => uc_s,
											uc_s = 'FLAWED/DEFICIENT'						  => uc_s,
											uc_s = 'HOLD'									        => uc_s,
											uc_s = 'INACTIVE'									    => uc_s,
											uc_s = 'JUDICAL DISSOLUTION'					=> uc_s,
											uc_s = 'MERGED'									      => uc_s,
											uc_s = 'NAME RESERVATION REJECTED'		=> uc_s,
											uc_s = 'PENDING'									    => uc_s,
											uc_s = 'PENDING DISSOLUTION'					=> uc_s,
											uc_s = 'PENDING MERGER'				        => uc_s,
											uc_s = 'PENDING TERMINATION'				 	=> uc_s,
											uc_s = 'PENDING WITHDRAWAL'	          => uc_s,
											uc_s = 'REDEEMED'					            => uc_s,
											uc_s = 'REJECTED'									    => uc_s,
											uc_s = 'REVOKED'									    => uc_s,
										  uc_s = 'SEE NOTEPAD'									=> uc_s,
											uc_s = 'TERMINATED'							      => uc_s,
											uc_s = 'TO BE DISSOLVED'						  => uc_s,
											uc_s = 'VOID'									        => uc_s,
											uc_s = 'WITHDRAWN'									  => uc_s,
											uc_s = 'WITHDRAWN/MERGED'						  => uc_s,
											'**|'+uc_s 															//scrubbing for new entity status
										 );
	         END;

		//****************************************************************************
		//ForeignDomesticInd: returns the "corp_foreign_domestic_ind".
		//												  input: s -> 	bus_type
		//												  input: fc-> 	foreigncountry
		
		//****************************************************************************
		EXPORT ForeignDomesticInd(STRING s, STRING fc) := FUNCTION
					 US_list 				:= ['USA','US','UNITEDSTATES','GA',''];
					 uc_s 					:= corp2.t2u(s);
					 uc_fc					:= corp2.t2u(stringlib.stringfilter(fc,'ABCDEFGHIJKLMNOPQRSTUVWXYZ')); //remove blanks and special characters					 
					RETURN MAP(uc_s IN ['CABLE/VIDEO FRANCHISE','DOCUMENT ORDER','DOMESTIC BANK','DOMESTIC CORPORATION','DOMESTIC CREDIT UNION',
															'DOMESTIC FORPROFIT COOP','DOMESTIC INSURANCE COMPANY','DOMESTIC LIMITED LIABILITY COMPANY',
															'DOMESTIC LIMITED LIABILITY LIMITED PARTNERSHIP','DOMESTIC LIMITED LIABILITY PARTNERSHIP',
															'DOMESTIC LIMITED PARTNERSHIP','DOMESTIC NON-ENTITY NONFILING','DOMESTIC NON-FILING ENTITY',
															'DOMESTIC NONPROFIT CORPORATION','DOMESTIC PROFESSIONAL CORPORATION','DOMESTIC PROFESSIONAL PA',
															'DOMESTIC PROFIT CORPORATION','DOMESTIC UNKNOWN','MARKETING ASSOCIATION','MUTUAL AID RESOURCE PACT',	
															'NAME RESERVATION','TRANSPORTATION/TELECOMMUNICATION/RAILROAD']                                                     	=> 'D',
										 uc_s IN ['ALIEN CORPORATION (RICO)','FOREIGN BANK','FOREIGN CORPORATION','FOREIGN CREDIT UNION','FOREIGN INSURANCE COMPANY',	
														 'FOREIGN LIMITED COOPERATIVE ASSOCIATION','FOREIGN LIMITED LIABILITY COMPANY',
														 'FOREIGN LIMITED LIABILITY LIMITED PARTNERSHIP','FOREIGN LIMITED LIABILITY PARTNERSHIP',
														 'FOREIGN LIMITED PARTNERSHIP','FOREIGN NONPROFIT CORPORATION','FOREIGN NON-QUALIFYING ENTITY',
														 'FOREIGN PROFESSIONAL CORPORATION','FOREIGN PROFIT CORPORATION','FOREIGN UNKNOWN']                                   	=> 'F',
										 uc_fc NOT IN US_list 																																																					=> 'F',
										 ''
										);
		END;
		
		//****************************************************************************
		//Inc_Date: returns the "corp_inc_date" or "corp_forgn_date".
		//					input: fc -> ForeignCountry		
		//					input: bt -> BusinessTypeDesc
		//					input: cd -> CommencementDate
		//					input: ed -> EffectiveDate
		//****************************************************************************
		EXPORT Inc_Date(STRING fc, STRING bt, STRING cd, STRING ed) := FUNCTION
					 US_list	:= ['USA','US','UNITEDSTATES','GA','']; 
					 uc_fc		:= corp2.t2u(stringlib.stringfilter(fc,'ABCDEFGHIJKLMNOPQRSTUVWXYZ')); //remove blanks and special characters
					 uc_bt		:= corp2.t2u(bt);
					 uc_cd		:= corp2.t2u(cd);
					 uc_ed		:= corp2.t2u(ed);
					 RETURN MAP(ForeignDomesticInd(uc_bt,uc_fc) = 'D' AND Corp2_Mapping.fValidateDate(uc_cd).PastDate <> ''																		=> Corp2_Mapping.fValidateDate(uc_cd).PastDate,
											ForeignDomesticInd(uc_bt,uc_fc) = ''  AND corp2.t2u(fc) IN US_list AND Corp2_Mapping.fValidateDate(uc_cd).PastDate <> '' 			=> Corp2_Mapping.fValidateDate(uc_cd).PastDate,
											ForeignDomesticInd(uc_bt,uc_fc) = 'D' AND Corp2_Mapping.fValidateDate(uc_ed).PastDate <> ''																		=> Corp2_Mapping.fValidateDate(uc_ed).PastDate,
											ForeignDomesticInd(uc_bt,uc_fc) = ''  AND corp2.t2u(fc) IN US_list AND Corp2_Mapping.fValidateDate(uc_ed).PastDate <> ''			=> Corp2_Mapping.fValidateDate(uc_ed).PastDate,
 										  ''
										 );
		END;

		//****************************************************************************
		//Forgn_Date: returns the "corp_inc_date" or "corp_forgn_date".
		//						input: fc -> ForeignCountry		
		//						input: bt -> BusinessTypeDesc
		//						input: cd -> CommencementDate
		//						input: ed -> EffectiveDate
		//****************************************************************************
		EXPORT Forgn_Date(STRING fc, STRING bt, STRING cd, STRING ed) := FUNCTION
					 US_list	:= ['USA','US','UNITEDSTATES','GA','']; 
					 uc_fc		:= corp2.t2u(stringlib.stringfilter(fc,'ABCDEFGHIJKLMNOPQRSTUVWXYZ')); //remove blanks and special characters
					 uc_bt		:= corp2.t2u(bt);
					 uc_cd		:= corp2.t2u(cd);
					 uc_ed		:= corp2.t2u(ed);
					 RETURN MAP(ForeignDomesticInd(uc_bt,uc_fc) = 'F' AND Corp2_Mapping.fValidateDate(uc_cd).PastDate <> ''																		=> Corp2_Mapping.fValidateDate(uc_cd).PastDate,
											ForeignDomesticInd(uc_bt,uc_fc) = ''  AND corp2.t2u(fc) NOT IN US_list AND Corp2_Mapping.fValidateDate(uc_cd).PastDate <> '' 	=> Corp2_Mapping.fValidateDate(uc_cd).PastDate,
											ForeignDomesticInd(uc_bt,uc_fc) = 'F' AND Corp2_Mapping.fValidateDate(uc_ed).PastDate <> ''																		=> Corp2_Mapping.fValidateDate(uc_ed).PastDate,
											ForeignDomesticInd(uc_bt,uc_fc) = ''  AND corp2.t2u(fc) NOT IN US_list AND Corp2_Mapping.fValidateDate(uc_ed).PastDate <> ''	=> Corp2_Mapping.fValidateDate(uc_ed).PastDate,
											''
										 );
		END;

END;		