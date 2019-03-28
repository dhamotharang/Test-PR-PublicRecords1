IMPORT corp2, corp2_mapping, lib_stringlib;

EXPORT Functions := Module

		//********************************************************************
		//fgetCorpStatusDesc: Returns "corp_status_desc".
		//********************************************************************	
		EXPORT fgetCorpStatusDesc(STRING s) := FUNCTION

			uc_Status  := corp2.t2u(s);
			RETURN map( uc_Status = '1'  => 'ACTIVE',
									uc_Status = '2'  => 'ADMIN DISSOLVED',
									uc_Status = '3'  => 'INACTIVE',
									uc_Status = '4'  => 'CANCELLED',
									uc_Status = '5'  => 'VOLUNTARILY DISSOLVED',
									uc_Status = '6'  => 'REVOKED',
									uc_Status = '7'  => 'WITHDRAWN',
									uc_Status = '8'  => 'MERGED',
									uc_Status = '9'  => 'JUDICIALLY DISSOLVED',
									uc_Status = '10' => 'NON-QUALIFIED MERGED',
								  uc_Status = '11' => 'SURRENDERED',
									uc_Status = '12' => 'RESERVED',
									uc_Status = '13' => 'EXPIRED',
									uc_Status = '14' => 'ABANDONED',
									uc_Status = '15' => 'CONVERTED',
									uc_Status = '16' => 'PENDING ADMIN DISSOLUTION',
									uc_Status = '17' => 'PENDING REVOCATION',
									uc_Status = '18' => 'PENDING CONVERSION',
									uc_Status = '19' => 'CONVERTED OUT',
									uc_Status = '20' => 'PENDING',
									uc_Status = '21' => 'PAST DUE',
									uc_Status = '22' => 'PENDING DOMESTICATION',
									uc_Status = '23' => 'PENDING SURRENDER',
									uc_Status = '24' => 'PENDING MERGER',
									uc_Status = '25' => 'PROTECTED NAME DISSOLVED',
								  uc_Status = '26' => 'VOLUNTARILY DISSOLVED (NAME PROTECTED)',
									uc_Status = '27' => 'PENDING SHARE EXCHANGE',
									'');
		END;	

		//********************************************************************
		//fgetCorpActs: Returns "corp_acts".
		//********************************************************************	
		EXPORT fgetCorpActs(STRING s) := FUNCTION

			uc_Acts  := corp2.t2u(s);
			RETURN map( uc_Acts = '1'  => 'INDIANA AGRICULTURAL COOPERATIVE ACT',
									uc_Acts = '2'  => 'INDIANA BUSINESS CORPORATION LAW',
									uc_Acts = '3'  => 'INDIANA BUSINESS FLEXIBILITY ACT',
									uc_Acts = '4'  => 'INDIANA BUSINESS TRUST ACT OF 1963',
									uc_Acts = '5'  => 'THE INDIANA FINANCIAL INSTITUTIONS ACT',
									uc_Acts = '6'  => 'INDIANA INSURANCE LAW',
									uc_Acts = '7'  => 'INDIANA NONPROFIT CORPORATION ACT OF 1991',
									uc_Acts = '8'  => 'INDIANA PROFESSIONAL CORPORATION ACT OF 1983',
									uc_Acts = '9'  => 'REVISED UNIFORM LIMITED PARTNERSHIP ACT',
									uc_Acts = '10' => 'UNIFORM PARTNERSHIP ACT',
									uc_Acts in ['','IN']   => '',
									'**|'+ uc_Acts);
						
		END;	
		//********************************************************************
		//fgetcontTitle: Returns "cont_title1_desc".
		//********************************************************************	
		EXPORT fgetcontTitle(STRING s) := FUNCTION

			uc_Title  := corp2.t2u(s);
			RETURN map( UC_TITLE in ['1','27','37','46','54','63','71','80','88','107','117','126','135',
                               '143','151','159','167','175','183','201','208','216','223','232','241',
															 '250','259']                                                                => 'PRESIDENT',                             
									UC_TITLE in ['2','28','38','47','55','64','72','81','89','108','118','127','136',
                               '144','152','160','168','176','184','202','209','217','224','233','242',
															 '251','260']                                                                => 'VICE PRESIDENT',
									UC_TITLE in ['3','25','35','44','52','61','69','78','86','105','115','124','133',
                               '141','149','157','165','173','181','199','206','214','221','230',
															 '239','248','257']                                                          => 'SECRETARY',
									UC_TITLE in ['109','169']                                                                => 'ASSISTANT SECRETARY',
									UC_TITLE in ['4','26','36','45','53','62','70','79','87','106','116','125','134',
                               '142','150','158','166','174','182','200','207','215','222','231','240',
															 '249','258']                                                                => 'TREASURER',
									UC_TITLE in ['5','40','57','74','101','195','210']                                       => 'INCORPORATOR',
									UC_TITLE in ['6']                                                                        => 'NEW FILING OFFICER',
									UC_TITLE in ['7','91','94','97','99']                                                    => 'GENERAL PARTNER',
									UC_TITLE in ['8']                                                                        => 'DIRECTOR',
									UC_TITLE in ['9']                                                                        => 'OTHER',
									UC_TITLE in ['10','21','31','226','235','244','253']                                     => 'MANAGER',
									UC_TITLE in ['11']                                                                       => 'PARTNER',
									UC_TITLE in ['12','23','33','42','50','59','67','76','84','103','113','122','131',
                               '139','147','155','163','171','179','197','204','212','219','228','237',
															 '246','255']                                                                => 'CEO',
									UC_TITLE in ['13','111','185']                                                           => 'TRUSTEE',
									UC_TITLE in ['14']                                                                       => 'ATTORNEY',
									UC_TITLE in ['15']                                                                       => 'CPA',
									UC_TITLE in ['17']                                                                       => 'OFFICER',
									UC_TITLE in ['18']                                                                       => 'NAME RESERVATION APPLICANT',
									UC_TITLE in ['19']                                                                       => 'TRANSFEREE',
									UC_TITLE in ['20','30','225','234','243','252']                                          => 'MEMBER',
									UC_TITLE in ['24','34','43','51','60','68','77','85','104','114','123','132',
                               '140','148','156','164','172','180','198','205','213','220','229','238',
															 '247','256']                                                                => 'CFO',
									UC_TITLE in ['22','32','41','49','58','66','75','83','102','112','121','130',
                               '138','146','154','162','170','178','196','203','211','218','227','245',
															 '254']                                                                      => 'CHAIRMAN',
									UC_TITLE in ['92','95','98']                                                             => 'LIMITED PARTNER',
									UC_TITLE in ['100']                                                                      => 'LIMITED PARTNER 20',
									UC_TITLE in ['186','188','190','192']                                                    => 'BENEFIT DIRECTOR',
									UC_TITLE in ['187','189','191','193']                                                    => 'BENEFIT OFFICER',
									UC_TITLE in ['','0','16']                                                                => '',
									'**|'+ UC_TITLE);
						
		END;	
		//********************************************************************
		//fgetOrgStructDesc: Returns "corp_orig_org_structure_desc".
		//********************************************************************		
		EXPORT  string fgetOrgStructDesc(STRING code) := FUNCTION

			st  := corp2.t2u(code);
			RETURN case(st,
				'2'  => 'DOMESTIC AGRICULTURAL COOP',
				'3'  => 'DOMESTIC BUSINESS TRUST',
				'4'  => 'DOMESTIC FINANCIAL INSTITUTIONS',
				'5'  => 'DOMESTIC FOR-PROFIT CORPORATION',
				'6'  => 'DOMESTIC INSURANCE CORPORATION',
				'7'  => 'DOMESTIC LIMITED LIABILITY COMPANY',
				'8'  => 'DOMESTIC LIMITED LIABILITY PARTNERSHIP',
				'9'  => 'DOMESTIC LIMITED PARTNERSHIP',
				'10' => 'DOMESTIC NON-PROFIT CORPORATION',
				'11' => 'DOMESTIC PROFESSIONAL CORPORATION',
				'14' => 'FOREIGN AGRICULTURAL COOP',
				'15' => 'FOREIGN BUSINESS TRUST',
				'16' => 'FOREIGN FINANCIAL INSTITUTIONS',
				'17' => 'FOREIGN FOR-PROFIT CORPORATION',
				'18' => 'FOREIGN INSURANCE CORPORATION',
				'19' => 'FOREIGN LIMITED LIABILITY COMPANY',
				'20' => 'FOREIGN LIMITED LIABILITY PARTNERSHIP',
				'21' => 'FOREIGN LIMITED PARTNERSHIP',
				'22' => 'FOREIGN NON-PROFIT CORPORATION',
				'23' => 'FOREIGN PROFESSIONAL CORPORATION',
				'30' => 'LEG. NON-QUALIFIED FOREIGN CORPORATION',
				'31' => 'NAME TRANSFER - NEW',
				'32' => 'DOMESTIC MISCELLANEOUS',
				'33' => 'FOREIGN MISCELLANEOUS',
				'34' => 'DOMESTIC BENEFIT CORPORATION',
				'35' => 'FOREIGN BENEFIT CORPORATION',
				'36' => 'DOMESTIC PROFESSIONAL BENEFIT CORPORATION',
				'37' => 'FOREIGN PROFESSIONAL BENEFIT CORPORATION',
				'39' => 'DOMESTIC MASTER LLC',
				'40' => 'FOREIGN MASTER LLC',
				'41' => 'DOMESTIC SERIES',
				'42' => 'FOREIGN SERIES',
				'45' => 'INDIVIDUAL COMMERCIAL REGISTERED AGENT',
				'46' => 'BUSINESS COMMERCIAL REGISTERED AGENT',
				''   => '',
				'**|'+ st);
				
		END;

		//********************************************************************
		//Get_State_Code: validates vendor codes and Returns '**' if we receive invalid or new codes from vendor 
		//********************************************************************	
		EXPORT Get_State_Code(string code) 
			:= map( corp2.t2u(code) in 
							['AL','AK','AS','AZ','AR','CA','CO','CT','DE','DC','FM','FL','GA','GU','HI','ID','IL','IN','IA','KS','KY',
							 'LA','ME','MH','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','MP','OH','OK',
							 'OR','PW','PA','PR','RI','SC','SD','TN','TX','UT','VT','VI','VA','WA','WV','WI','WY','AE','AP','AA',
							 'CB','UK','GB','CD','HK','MX','EU','CI','SA','II','SL','US','BE','FR','JA','NL','NS','OA','BR',
							 'AF','IE','AU','LX','CH','CZ','PH','BL','BW','GR','PN'] 			=> corp2.t2u(code),
							 corp2.t2u(code) in ['XX','X','..','.','11/','12','AN','']    => '', //as per CI
							 '**'
						);
				
		//********************************************************************
		//fGetStateDesc: Returns full name from "Two digit State_Code" 
		//********************************************************************	
		EXPORT  string fGetStateDesc(STRING state) := FUNCTION

			st  := corp2.t2u(state);
			RETURN case(st,
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
				'AE'=>'ARMED FORCES EUROPE, THE MIDDLE EAST, AND CANADA',
				'AP'=>'ARMED FORCES PACIFIC',
				'AA'=>'ARMED FORCES AMERICAS EXCEPT CANADA)',
				'CB'=>'COLUMBIA',
				'UK'=>'UNITED KINGDOM',
				'GB'=>'GREAT BRITAIN',
				'CD'=>'CANADA',
				'HK'=>'HONG KONG',
				'MX'=>'MEXICO',
				'EU'=>'EUROPE',
				'CI'=>'COOK ISLANDS',
				'SA'=>'OTHER S&C AMERICAN',
				'II'=>'INDIA',
				'SL'=>'SCOTLAND',
				'US'=>'UNITED STATES',
				'BE'=>'BERMUDA',
				'FR'=>'FRANCE',
				'JA'=>'JAPAN',
				'MH'=>'MARSHALL ISLANDS',
				'NL'=>'NETHERLANDS',
				'NS'=>'NOVA SCOTIA, CANADA',
				'OA'=>'OTHER ASIA',
				'BR'=>'BARBADOS',
				'AF'=>'AFRICA',
				'IE'=>'IRELAND',
				'AU'=>'AUSTRALIA',
				'LX'=>'LUXEMBOURG',
				'CH'=>'CHINA',
				'CZ'=>'CANAL ZONE',
				'PH'=>'PHILIPPINES',
				'BL'=>'BELGIUM',
				'BW'=>'BRITISH WEST INDIES',
				'GR'=>'GERMANY',
				'PN'=>'PANAMA',
				'XX'=>'',
				'X' =>'',
				'..'=>'',
				'.' =>'',
				'11/'=>'',
				'12'=>'',
				'AN'=>'',				
				''  =>'',
				'**|'+ st);
			
		END;

	//********************************************************************
		//fgetFiling_desc: Returns "event_filing_desc".
		//********************************************************************	
	EXPORT  string fgetFiling_desc(STRING filcode,STRING enttype ='' ) := FUNCTION

    st  := corp2.t2u(filcode);
		en  := corp2.t2u(enttype);		
		RETURN map( st = '1'             															     => 'ABANDONMENT OF CONVERSION',
								st = '2'             															     => 'ABANDONMENT OF DOMESTICATION',
								st = '3'             															     => 'ABANDONMENT OF MERGER',
								st = '4'             															     => 'ABANDONMENT OF SHARE EXCHANGE',
								st = '5'             															     => 'ADMINISTRATIVE DISSOLUTION',
								st = '6'             															     => 'ARTICLES OF AMENDMENT',
								st = '10'             															   => 'ARTICLES OF ACCEPTANCE',
								st = '13'             															   => 'ARTICLES OF CHARTER CONVERSION',
								st = '18'             															   => 'ARTICLES OF MUTUAL BANK CONVERSION',
								st = '19'             															   => 'CERTIFICATE OF ASSUMED BUSINESS NAME',
								st = '20'             															   => 'CANCELLATION OF ASSUMED BUSINESS NAME',
								st = '23'             															   => 'CERTIFICATE OF CANCELLATION',
								st = '31'             															   => 'CHANGE OF OFFICER',
								st = '32'             															   => 'CHANGE OF PRINCIPAL ADDRESS',
								st = '33'             															   => 'ARTICLES OF CHARTER SURRENDER',
								st = '34'             															   => 'ARTICLES OF CHARTER SURRENDER',
								st = '35'             															   => 'ARTICLES OF CONSOLIDATION',
								st = '37'             																 => 'ARTICLES OF CONVERSION',
								st = '38'            																	 => 'ARTICLES OF CORRECTION',
								st = '39'             																 => 'ARTICLES OF DISSOLUTION',
								st = '40'            																	 => 'ARTICLES OF DOMESTICATION',																
								st = '42' and en in ['14','16']                        => 'APPLICATION FOR ADMISSION',
								st = '42' and en in ['17','19','22','23']              => 'APPLICATION FOR CERTIFICATE OF AUTHORITY',
								st = '42' and en in ['21']                             =>	'APPLICATION FOR REGISTRATION',
								st = '42' and en in ['','2','3','4','5','6',
								                     '10','11','26','34','35']         =>	'ARTICLES OF INCORPORATION',
								st = '42' and en in ['7','39','40']                    =>	'ARTICLES OF ORGANIZATION',
								st = '42' and en in ['9']                              =>	'CERTIFICATE OF LIMITED PARTNERSHIP',
								st = '42' and en in ['18']                             => 'CERTIFICATE OF AUTHORITY',
								st = '42' and en in ['32','33']                        =>	'MISC FILING',
								st = '42' and en in ['8','20']                         =>	'REGISTRATION OF LIMITED LIABILITY PARTNERSHIP',
								st = '42' and en in ['15']                             =>	'TRUST AGREEMENT',
								st = '43'             															   => 'JUDICIAL DISSOLUTION',
								st = '46'             															   => 'ARTICLES OF MERGER',
								st = '47'             															   => 'ARTICLES OF MERGER',
								st = '48'             															   => 'MISCELLANEOUS',
								st = '50'             															   => 'NAME CANCELLED', 
								st = '51'             															   => 'NAME RENEWAL',
								st = '52'             															   => 'NAME RESERVATION',
								st = '53'             															   => 'NAME TRANSFER',
								st = '54'             															   => 'NOTICE OF MERGER',
								st = '56'             															   => 'PRECLEARANCE',
								st = '57'             															   => 'CHANGE OF REGISTERED OFFICE/AGENT',
								st = '59'             															   => 'RESIGNATION OF REGISTERED AGENT',
								st = '60'             															   => 'ARTICLES OF RECONSTITUTION',
								st = '61'             															   => 'ARTICLES OF REINCORPORATION',
								st = '62'             															   => 'APPLICATION FOR REINSTATEMENT',
								st = '63'             															   => 'ARTICLES OF REORGANIZATION',
								st = '65'             															   => 'ARTICLES OF RESTATEMENT',
								st = '66'             															   => 'AMENDED AND RESTATED ARTICLES',
								st = '67'             															   => 'REVOCATION OF CERTIFICATE OF AUTHORITY',
								st = '68'             															   => 'ARTICLES OF REVOCATION OF DISSOLUTION',
								st = '69'             															   => 'ARTICLES OF SHARE EXCHANGE',
								st = '70'             															   => 'SURRENDER OF CERTIFICATE OF INCORPORATION',
								st = '71'             															   => 'APPLICATION FOR CERTIFICATE OF WITHDRAWAL',
								st = '75'             															   => 'ARTICLES OF DESIGNATION - FORMATION',
								st = '76'             															   => 'ARTICLES OF DESIGNATION - AMENDMENT',
								st = '77'             															   => 'ARTICLES OF DESIGNATION - DISSOLUTION',
								st = '78'             															   => 'NOTICE OF CONVERSION',
								st = '79'             															   => 'COMMERCIAL REGISTERED AGENT LISTING',
								st = '81'             															   => 'COMMERCIAL REGISTERED AGENT CHANGE',
								st = '82'             															   => 'COMMERCIAL REGISTERED AGENT TERMINATION',
								st = '1004'                                            => 'OFFICE CORRECTION',
								st = '1005'                                            => 'LEGACY ARTICLES OF SPECIAL TRANSACTIONS',
								st = '1006'                                            => 'LEGACY NAME REGISTRATION',
								st = '1007'                                            => 'LEGACY WITHDRAWAL / DISSOLUTION',
								st = '' and en = ''                                    => '',
								'**|'+ st + '_' + en);
	 END;

END;