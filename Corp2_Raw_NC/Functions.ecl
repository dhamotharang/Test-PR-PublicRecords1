IMPORT corp2, corp2_mapping;

EXPORT Functions := Module
			
		//********************************************************************
		//CorpOrigOrgStructureDesc: Returns "corp_orig_org_structure_desc" from vendor code.
		//********************************************************************	
		EXPORT CorpOrigOrgStructDesc(STRING s) := FUNCTION	
		
			 OrgSt_dec  := corp2.t2u(s);
			 RETURN 	map(OrgSt_dec='BK'	  =>'BANK',
										OrgSt_dec='BUS'	  =>'BUSINESS CORPORATION',
										OrgSt_dec='CAPI'  =>'CAPTIVE INSURANCE',
										OrgSt_dec='COOP'  =>'COOPERATIVE ASSOCIATION',
										OrgSt_dec='CO54'  =>'COOPERATIVE 54 16',
										OrgSt_dec='CORR'  =>'CORRESPONDENCE',  
										OrgSt_dec='DS'	  =>'DENTAL SERVICE CORPORATION',
										OrgSt_dec='EMC'	  =>'ELECTRIC MEMBERSHIP COOPERATIVE',
										OrgSt_dec='FAIR'  =>'COUNTY AGRICULTURAL FAIR',
										OrgSt_dec='INS'	  =>'INSURANCE COMPANY',
										OrgSt_dec='L3C'	  =>'LOW-PROFIT LIMITED LIABILITY COMPANY',
										OrgSt_dec='LLLP'  =>'REGISTERED LIMITED LIABILITY LIMITED PARTNERSHIP',
										OrgSt_dec='LLC'	  =>'LIMITED LIABILITY COMPANY',
										OrgSt_dec='LLP'	  =>'LIMITED LIABILITY PARTNERSHIP',
										OrgSt_dec='LP'	  =>'LIMITED PARTNERSHIPS',												
										OrgSt_dec='MBA'	  =>'MUTUAL BURIAL ASSOCIATION',
										OrgSt_dec='MDGA'  =>'MUTUAL DEPOSIT GUARANTY ASSOCIATION',
										OrgSt_dec='MUN'	  =>'MUNICIPAL',
										OrgSt_dec='MUT'	  =>'MUTUAL ASSOCIATION',
										OrgSt_dec='NATB'  =>'NATIONAL BANKING ASSOCIATION',
										OrgSt_dec='NDTB'  =>'NON-DOMESTIC TOBACCO',											
										OrgSt_dec='NINP'  =>'NON-INCORPORATED NON-PROFIT',
										OrgSt_dec='NP'	  =>'NON-PROFIT CORPORATION',
										OrgSt_dec='NPCT'  =>'NON-PROFIT COMMUNITY TRUST',
										OrgSt_dec='OTH'	  =>'OTHER',
										OrgSt_dec='PA'	  =>'PROFESSIONAL CORPORATION',
										OrgSt_dec='PLLC'  =>'PROFESSIONAL LIMITED LIABILITY COMPANY',
										OrgSt_dec='PTA'	  =>'PUBLIC TRANSPORTATION AUTHORITY',
										OrgSt_dec='RESA'  =>'ONLINE RESALE',
										OrgSt_dec='RR'	  =>'RAILROAD',
										OrgSt_dec='S&L'	  =>'SAVINGS & LOAN ASSOCIATION',
										OrgSt_dec='SSB'	  =>'STATE SAVINGS BANK',
										OrgSt_dec=''      =>'',
										'');
											 
	END;
		
		//********************************************************************
		//CorpForProfitInd: Returns "corp_for_profit_ind".
		//********************************************************************	
		EXPORT CorpForProfitInd(STRING s) := FUNCTION
		
					 uc_s  := corp2.t2u(s);
					 RETURN map(uc_s in ['NP','NPCT','NINP']=>'N',
											uc_s = 'L3C'=>'Y',
											'');
											
		END;
		
	//********************************************************************
		//GetStatusDesc: Returns "corp_status_desc".
	//********************************************************************		
	EXPORT GetStatusDesc(string code)	
		     := case(corp2.t2u(code),
							'1'  => 'RESERVED NAME',
							'2'  => 'CURRENT-ACTIVE',
							'3'  => 'CANCELLED',
							'5'  => 'AUTO DISSOLVE',
							'7'  => 'IN PROCESS',
							'8'  => 'ADMIN DISSOLVED',
							'9'  => 'CONVERTED',
							'10' => 'SUSPENDED',
							'11' => 'WITHDRAWN BY MERGER',
							'12' => 'WITHDRAWN',
							'13' => 'REVOKED',
							'14' => 'DISSOLVED',
							'15' => 'VOL SURRENDER',
							'16' => 'COURT ORDERED DISSOLUTION',
							'17' => 'TO FED BANK',
							'18' => 'TO FOREIGN INS',
							'19' => 'JUDICIAL DISSOLUTION',
							'20' => 'EXPIRED',
							'21' => 'CONSOLIDATED',
							'22' => 'MULTIPLE',
							'23' => 'APPLIED TO WITHDRAW',
							'24' => 'MERGED',
							'25' => 'NON-DOMESTICATED',
							'26' => 'DOC TRACKING CANCELED',
							'27' => 'MISC',
							'28' => 'PROBLEM REPORT',
							'29' => 'CURRENT-ACTIVE AR ERROR',
							'30' => 'PA SUSPENDED',
							'31' => 'CURRENT-ACTIVE ON NOTICE',
							'32' => 'REVOKED LICENSING BOARD',
							'33' => 'FAILURE TO PAY FEE',
							'34' => 'ADMIN CANCELLED',
							''	 => '',
							''
							);		
							
	//********************************************************************
		//Get_State_Code: validates vendor codes and Returns '**' if we receive invalid or new codes from vendor 
	//********************************************************************	
		EXPORT Get_State_Code(string code) 
	        := map (corp2.t2u(code) in 
									[ 'AL','AB','AE','AK','AS','AZ','AR','AP','AA','CA','CD','CO','CT',
										'DE','DC','FM','FL','GA','GU','HI','ID','IL','IN','IA','KS','KY',
										'LA','ME','MH','MD','MA','MI','MN','MS','MO','MT','MP','NE','NV',
										'NH','NJ','NM','NY','ND','OH','OK','OR','PW','PA','PR','RI','SC',
										'SD','TN','TX','UT','UK','US','VT','VI','VA','WA','WV','WI','WY']=> corp2.t2u(code),
									  corp2.t2u(code) in ['NA','NB','SE','X','XX','']=>'', //SE is a typo for 'DE' & drop code !!as per CI/Rosemary 
									  '**');
									
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
								'AB'=>'CANADA',
								'AE'=>'ARMED FORCES EUROPE, THE MIDDLE EAST, AND CANADA',
								'AP'=>'ARMED FORCES PACIFIC',
								'AA'=>'ARMED FORCES AMERICAS EXCEPT CANADA',
								'AU'=>'AUSTRALIA',	
   							'AF'=>'AFRICA',
 								'BE'=>'BERMUDA',
								'BR'=>'BARBADOS',
								'BL'=>'BELGIUM',
								'BW'=>'BRITISH WEST INDIES',
								'CA'=>'CALIFORNIA',
								'CO'=>'COLORADO',
								'CB'=>'COLUMBIA',
								'CI'=>'COOK ISLANDS',
								'CD'=>'CANADA',
								'CT'=>'CONNECTICUT',
								'CH'=>'CHINA',
								'CZ'=>'CANAL ZONE',
								'DE'=>'DELAWARE',
								'DC'=>'DISTRICT OF COLUMBIA',
								'EU'=>'EUROPE',
								'FM'=>'FEDERATED STATES OF MICRONESIA',
								'FL'=>'FLORIDA',
								'FR'=>'FRANCE',
								'GA'=>'GEORGIA',
								'GU'=>'GUAM',								
								'GR'=>'GERMANY',
								'GB'=>'GREAT BRITAIN',
								'HI'=>'HAWAII',							
								'HK'=>'HONG KONG',
								'ID'=>'IDAHO',
								'IL'=>'ILLINOIS',
								'IN'=>'INDIANA',
								'IA'=>'IOWA',
								'IE'=>'IRELAND',
								'II'=>'INDIA',	
								'JA'=>'JAPAN',
								'KS'=>'KANSAS',
								'KY'=>'KENTUCKY',
								'LA'=>'LOUISIANA',
								'LX'=>'LUXEMBOURG',
								'ME'=>'MAINE',
								'MD'=>'MARYLAND',
								'MA'=>'MASSACHUSETTS',
								'MI'=>'MICHIGAN',
								'MN'=>'MINNESOTA',
								'MS'=>'MISSISSIPPI',
								'MO'=>'MISSOURI',
								'MH'=>'MARSHALL ISLANDS',
								'MT'=>'MONTANA',
								'NE'=>'NEBRASKA',
								'NV'=>'NEVADA',
								'NH'=>'NEW HAMPSHIRE',
								'NJ'=>'NEW JERSEY',
								'NM'=>'NEW MEXICO',
								'NY'=>'NEW YORK',
								'ND'=>'NORTH DAKOTA',
								'NL'=>'NETHERLANDS',
								'NS'=>'NOVA SCOTIA, CANADA',
								'MP'=>'NORTHERN MARIANA ISLANDS',
								'MX'=>'MEXICO',
								'OA'=>'OTHER ASIA',
								'OH'=>'OHIO',
								'OK'=>'OKLAHOMA',
								'OR'=>'OREGON',
								'PW'=>'PALAU',
								'PA'=>'PENNSYLVANIA',
								'PR'=>'PUERTO RICO',
								'PH'=>'PHILIPPINES',
								'PN'=>'PANAMA',
								'RI'=>'RHODE ISLAND',
								'SC'=>'SOUTH CAROLINA',
								'SD'=>'SOUTH DAKOTA',
								'SA'=>'OTHER S&C AMERICAN',
								'SL'=>'SCOTLAND',
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
								'UK'=>'UNITED KINGDOM',
								'US'=>'UNITED STATES',
								'NA'=>'',
								'NB'=>'',	
								'SE'=>'',
								'X' =>'',							
								'XX'=>'',
								''  =>'',
								'**|'+ st
								);
							
		END;
		
		//********************************************************************
		//CorplnNameTypeDesc: Returns "corp_ln_name_type_desc".
		//********************************************************************	
	EXPORT CorplnNameTypeDesc(string code)
		     := case( corp2.t2u(code),
								  '1'	=>'LEGAL',
									'2'	=>'ALIAS',
									'3'	=>'PRIOR',
									'5'	=>'INFORMAL',
									'10'=>'',
									'13'=>'',
									'14'=>'RESERVED',
									'15'=>'PREVIOUS HOME STATE',
									'18'=>'REG ALIAS',
									'19'=>'PREV REG ALIAS',
									'20'=>'CSL DBA',
									'23'=>'CSL LEGAL',
									'22'=>'',
									'24'=>'PREVIOUS CSL LEGAL',
									'25'=>'',
									'26'=>'',
									'31'=>'CURRENT OFFERING',
									'35'=>'PREVIOUS CURRENT OFFERING',									
									'36'=>'',
									'40'=>'',
									'41'=>'CSL REGISTERED DBA',
									''=>'',
									''
									);	

//********************************************************************
	//CorplnNameTypeCD: Returns "corp_ln_name_type_cd".
//********************************************************************	
EXPORT CorplnNameTypeCD(string code)
					 := case( corp2.t2u(code),
										'1' =>'01',
										'2'	=>'42',
										'3'	=>'P',
										'5'	=>'43',
										'10'=>'',
										'13'=>'',
										'14'=>'07',
										'15'=>'44',
										'18'=>'46',
										'19'=>'47',
										'20'=>'CD',
										'22'=>'',
										'23'=>'CL',
										'24'=>'PS',
										'25'=>'',
										'26'=>'',
										'31'=>'5',
										'35'=>'35',
										'36'=>'',
										'40'=>'',
										'41'=>'CR',
										'');
	
	EXPORT fGetfiscalMonth(string code)
					 := case(trim(code,left,right),
										'1'	=>'JANUARY',  
										'2'	=>'FEBRUARY', 
										'3'	=>'MARCH',    
										'4'	=>'APRIL',    
										'5'	=>'MAY',      
										'6'	=>'JUNE',     
										'7'	=>'JULY',    
										'8'	=>'AUGUST',  
										'9'	=>'SEPTEMBER',
										'10'=>'OCTOBER',  
										'11'=>'NOVEMBER', 
										'12'=>'DECEMBER',
										'');
										
	EXPORT fGetARTypeDesc(string code)
					 := case(corp2.t2u(code),
									'AN'	=>'ANNUAL REPORT PRE98',
									'AN98'=>'ANNUAL REPORT PRE98',
									'ANF'	=>'ANNUAL FINANCIALS',
									'ANLP'=>'ANNUAL REPORT RLLP',
									'ANRC'=>'ANNUAL REPORT LLC',
									'ANRL'=>'ANNUAL REPORT LLP',
									'ANRN'=>'ANNUAL REPORT (NOTICE GIVEN)',
									'ANRT'=>'ANNUAL REPORT',
									'AART'=>'AMENDED ANNUAL REPORT',
									''=>'',
									''
									);		
									
	EXPORT fGetEventDesc(string code)
					 := case(corp2.t2u(code),
									'AADR'=>'CHANGE OF ADDRESS OF REGISTERED OFFICE',
									'AAUT'=>'AMENDED CERTIFICATE OF AUTHORITY',
									'ACOP'=>'AMENDMENT FOR AGRICULTURAL MARKETING ASSOC',
									'ADIS'=>'ADM DISSOLUTION',
									'ADMN'=>'ADM NOTICE',
									'AGT'	=>'AGENT CHANGE',
									'AINC'=>'RESTATED ARTICLES OF INCORPORATION',
									'ALLC'=>'AMENDMENT OF ARTICLES OF ORGANIZATION',
									'AMLP'=>'AMENDMENT TO CERTIFICATE OF DOMESTIC LP',
									'AMNC'=>'ARTICLES OF AMENDMENT',
									'AMND'=>'ARTICLES OF AMENDMENT',
									'AMU'	=>'AMENDMENT FOR MUTUAL ASSOCIATION',
									'AMU1'=>'AMENDMENT FOR MUTUAL ASSOCIATION',
									'ANNX'=>'ANNEXATION',
									'AREI'=>'ADM REINSTATEMENT',
									'AREL'=>'ADM REINSTATEMENT LLC',
									'AS&L'=>'ARTICLES OF AMENDMENT FOR SAVINGS AND LOAN',
									'AUTH'=>'APPLICATION FOR CERTIFICATE OF AUTHORITY',
									'BAMD'=>'AMENDMENT FOR BANK',
									'BINC'=>'ARTICLES OF INCORPORATION FOR BANK',
									'BYL'	=>'BY-LAWS',
									'CAAB'=>'CERTIFICATE OF AUTHORITY AMNESTY BILL',
									'CALP'=>'CANCELLATION OF CERTIFICATE OF LP',
									'CANC'=>'CERTIFICATE OF CANCELLATION',
									'CBIN'=>'APPLICATION FOR CERTIFICATE OF AUTHORITY',
									'CBNP'=>'APPLICATION FOR CERTIFICATE OF AUTHORITY',
									'CFLP'=>'CERT OF CHANGE/AMENDMENT OF FOREIGN LP',
									'CINC'=>'ARTICLES OF INCORPORATION',
									'CLLC'=>'ARTICLES OF ORGANIZATION LIMITED LIABILITY',
									'CMA'	=>'CHANGE OF MAILING ADDRESS',
									'CMAP'=>'CHANGE OF PRIN. OFFICE AND AGENT NAME/OFFICE', 
									'CMER'=>'ARTICLES OF MERGER',
									'CNP'	=>'ARTICLES OF INCORPORATION',
									'CNSL'=>'CONSOLIDATION',
									'COI'	=>'CERTIFICATE OF INCREASE',
									'CON'	=>'ARTICLES OF CONVERSION',
									'CONV'=>'CONVERSION',
									'COPA'=>'CHANGE OF PRINCIPAL OFFICE ADDRESS',
									'CORR'=>'ARTICLES OF CORRECTION',
									'CROA'=>'CHANGE OF ADDRESS OF REGISTERED OFFICE/AGENT',
									'DESG'=>'DESIGNATION OF REGISTERED AGENT',
									'DISS'=>'ARTICLES OF DISSOLUTION',
									'DLLP'=>'CERTIFICATE OF LP INCLUDING REG. AS LLLP',
									'DLP'	=>'CERTIFICATE OF DOMESTIC LIMITED PARTNERSHIP',
									'DLPC'=>'CERTIFICATE OF DOMESTIC LP INCLUDING ARTICLES OF CONVERSION',
									'DNAM'=>'CORPORATION NAME CHANGE (DOMESTIC)',
									'DNLP'=>'LIMITED PARTNERSHIP NAME CHANGE (DOMESTIC)',
									'DOPA'=>'DESIGNATION OF PRINCIPAL OFFICE ADDRESS',
									'EXPI'=>'AUTOMATICALLY DISSOLVED',
									'FDBA'=>'NAME CHANGE FOR DBA ONLY',
									'FDCV'=>'CONVERSION FROM STATE BANK TO FEDERAL',
									'FLLP'=>'REGISTRATION AS A FOREIGN LP INCL. AS FOREIGN LLLP',
									'FLP'	=>'APPLICATION FOR CERTIFICATE OF AUTHORITY LP',
									'FNAM'=>'CORPORATION NAME CHANGE (FOREIGN)',
									'FNLP'=>'LIMITED PARTNERSHIP NAME CHANGE (FOREIGN)',
									'HINC'=>'HOUSING AUTHORITY',
									'ICOP'=>'ART OF INCORP FOR AGRICULTURAL MARKETING ASSOC',
									'IMU'	=>'ARTICLES OF INCORPORATION FOR MUTUAL ASSOCIATION',
									'IMU1'=>'ARTICLES OF INCORPORATION FOR MUTUAL ASSOCIATION',
									'INC'	=>'ARTICLES OF INCORPORATION',
									'INCC'=>'ARTICLES OF INCORPORATION INCLUDING ARTICLES OF CONVERSION',
									'IRDM'=>'REDOMESTICATION FROM A FOREIGN TO A NC INSTITUTION',
									'IS&L'=>'ARTICLES OF INCORPORATION FOR SAVINGS & LOAN',
									'JDIS'=>'JUDICIAL DISSOLUTION',
									'JREI'=>'JUDICIAL REINSTATEMENT',
									'JUDO'=>'JUDICIAL ORDER',
									'L3C'	=>'L3C ARTICLES OF ORGANIZATION',
									'L3CF'=>'L3C ARTICLES OF ORGANIZATION FOR',
									'LIQD'=>'LIQUIDATION',
									'LLCC'=>'ARTICLES OF ORGANIZATION (CONVERSION OF BUSINESS ENTITY)',
									'LLCD'=>'ARTICLES OF ORGANIZATION LIMITED LIABILITY',
									'LLCF'=>'APPLICATION FOR CERTIFICATE OF AUTHORITY LIMITED LIABILITY',
									'LLCN'=>'ARTICLES OF ORGANIZATION (CONVERSION OF BUSINESS ENTITY)',
									'LLP'	=>'REGISTRATION FOR LIMITED LIABILITY PARTNERSHIP',
									'LLPC'=>'APPLICATION FOR REGISTRATION OF  LLP INCLUDING ART OF CONV',
									'MDIS'=>'MUTUAL DISSOLUTION',
									'MERD'=>'ARTICLES OF MERGER',
									'MERG'=>'ARTICLES OF MERGER',
									'MISC'=>'MISC. DOCUMENT',
									'NADR'=>'CHANGE OF ADDRESS OF REGISTERED OFFICE BY AGENT',
									'NAME'=>'NAME CHANGE DOMESTIC',
									'NBAN'=>'NAME CHANGE FOR BANK',
									'NCCV'=>'CONVERSION OF A FEDERAL BANK TO A STATE BANK',
									'NCOP'=>'NAME CHANGE FOR AGRICULTURAL MARKETING ASSOCIATION',
									'NIAM'=>'AMENDMENT OF APPOINTMENT',
									'NIAP'=>'APPOINTMENT OF REGISTERED AGENT',
									'NICA'=>'CANCELLATION OF APPOINTMENT',
									'NINC'=>'RESTATED ARTICLES OF INCORPORATION',
									'NIRE'=>'RESIGNATION OF AGENT',
									'NOP'	=>'NOTICE OF PROHIBITION',
									'PASP'=>'PA SUSPENSION',
									'PLSP'=>'PLLC SUSPENSION',
									'PREI'=>'PA REINSTATEMENT',
									'RCCA'=>'RESTATED ARTICLES OF INCORPORATION',
									'RCCC'=>'APPLICATION FOR RE-CREATION OF CERT OF AUTH LLC',
									'RCCN'=>'APPLICATION FOR RE-CREATION OF CERT OF AUTH NP',
									'RCCP'=>'APPLICATION FOR RE-CREATION OF CERT OF AUTH LLP',
									'RCLL'=>'APPLICATION FOR RE-CREATION OF CERT OF AUTH LLLP',
									'RCPC'=>'APPLICATION FOR RE-CREATION OF CERT OF AUTH PC',
									'RCPL'=>'APPLICATION FOR RE-CREATION OF CERT OF AUTH PLLC',
									'RDEV'=>'REDEVELOPMENT COMMISSION',
									'RDNF'=>'REDOMESTICATED FROM NC TO FOREIGN INSURANCE',
									'REG'	=>'APPLICATION TO REGISTER A CORPORATE NAME',
									'REN'	=>'RENEWAL FOR LLP  (LLPS ONLY)',
									'RESR'=>'APPLICATION TO RESERVE A CORPORATE NAME',
									'REV'	=>'ARTICLES OF REVOCATION OF DISSOLUTION',
									'REVK'=>'REVOKED CERTIFICATE OF AUTHORITY',
									'REVL'=>'CANCELLATION OF ARTICLES OF DISSOLUTION (LLC)',
									'REVR'=>'REVOCATION OF REGISTRATION',
									'RINC'=>'RESTATED ARTICLES OF INCORPORATION',
									'RLLC'=>'RESTATED ARTICLES OF ORGANIZATION',
									'RNSE'=>'REINSTATEMENT FOLLOWING REVENUE SUSP IN ERROR',
									'RNST'=>'REINSTATEMENT FOLLOWING REVENUE SUSPENSION',
									'RREG'=>'RENEW REGISTERED CORPORATE NAME',
									'RSCH'=>'RESTATED CHARTER (REG OFFICE & AGENT ONLY)',
									'RSGC'=>'RES. OF REG. AGENT OFFICE CONTINUES',
									'RSGD'=>'RES. OF REG. AGENT OFFICE DISCONTINUED',
									'RSGN'=>'RESIGNATION OF REGISTERED AGENT',
									'RSLP'=>'APPLICATION FOR RESERVATION OF LP NAME',
									'RVLB'=>'REVOCATION BY LICENSING BOARD',
									'SHRX'=>'SHARE EXCHANGE',
									'SSID'=>'ADMINISTRATIVE CORRECTION-SOSID',
									'SSPC'=>'REVENUE SUSPENSION POSTCARD',
									'SURV'=>'ARTICLES OF MERGER',
									'SUSP'=>'REVENUE SUSPENSION',
									'TAUT'=>'ARTICLES OF  INCORPORATION TRANSPORTATION AUTHORITY',
									'TDSG'=>'TOBACCO DESIGNATION OF REGISTERED AGENT',
									'TRAN'=>'TRANSFER OF RESERVED CORPORATE NAME',
									'TRLP'=>'TRANSFER OF RESERVED LIMITED PARTNERSHIP NAME',
									'VOID'=>'VOID WITHDRAWAL',
									'VSUR'=>'VOLUNTEER SURRENDER',
									'WDMG'=>'WITHDRAWAL BY MERGER',
									'WINC'=>'WATER AND SEWER ARTICLES OF INCORPORATION',
									'WITC'=>'WITHDRAWAL LLC',
									'WITH'=>'WITHDRAWAL',
									'WIPT'=>'WITHDRAWAL LLP',
									'WITP'=>'WITHDRAWAL LLC',  
									''		=>'',
									''
									);										
										
		EXPORT Addl_Info(STRING Managed,STRING Members,STRING CountyOfInc,STRING MemberManaged) := FUNCTION
		
			Title1         :=if(trim(Managed,left,right)='1','MANAGED','');
			Title2         :=if(trim(Members,left,right)='1','MEMBERS','');
			Title3         :=if(trim(CountyOfInc,left,right)<>'','HOME COUNTY: '+CountyOfInc,'');
			Title4         :=if(trim(MemberManaged,left,right)='1','MEMBER MANAGED','');
			concatFields	 :=trim(Title1,left,right) + ';' + trim(Title2,left,right) + ';' +  
											 trim(Title3,left,right) + ';' + trim(Title4,left,right)  ;
			tempExp				 := regexreplace('[;]*$',concatFields,'',NOCASE);
			tempExp2			 := regexreplace('^[;]*',tempExp,'',NOCASE);
			corp_addl_info := regexreplace('[;]+',tempExp2,';',NOCASE);
						 
			RETURN corp_addl_info;
				
	 End;
	 
	 Corp2_Raw_NC.Layouts.Temp_nc_addr addr_parse(Corp2_Raw_NC.Layouts.AddressesLayoutIn l):=transform
		
			list									:= ['UNKNOWN','OUT OF STATE'];
			self.o_addr1          := if(trim(l.AtypeID,left,right) not in['1','8','10','13'],l.addr1,'') ;
			self.o_addr2          := if(trim(l.AtypeID,left,right) not in['1','8','10','13'],l.addr2,'') ;
			self.o_addr3          := if(trim(l.AtypeID,left,right) not in['1','8','10','13'],l.addr3,'') ;
			self.o_city           := if(trim(l.AtypeID,left,right) not in['1','8','10','13'],l.city ,'') ;
			self.o_state          := if(trim(l.AtypeID,left,right) not in['1','8','10','13'],l.state,'') ;
			self.o_zip            := if(trim(l.AtypeID,left,right) not in['1','8','10','13'],l.zip,'') ;
			self.o_countyname     := if(trim(l.AtypeID,left,right) not in['1','8','10','13'] and corp2.t2u(l.countyname)not in list ,l.countyname,'') ;
			self.B_addr1          := if(trim(l.AtypeID,left,right) ='8',l.addr1,'') ;
			self.B_addr2          := if(trim(l.AtypeID,left,right) ='8',l.addr2,'') ;
			self.B_addr3          := if(trim(l.AtypeID,left,right) ='8',l.addr3,'') ;
			self.B_city           := if(trim(l.AtypeID,left,right) ='8',l.city ,'') ;
			self.B_state          := if(trim(l.AtypeID,left,right) ='8',l.state,'') ;
			self.B_zip            := if(trim(l.AtypeID,left,right) ='8',l.zip,'') ;
			self.B_countyname     := if(trim(l.AtypeID,left,right) ='8' and corp2.t2u(l.countyname)not in list ,l.countyname,'') ;
			self.M_addr1          := if(trim(l.AtypeID,left,right) ='1',l.addr1,'') ;
			self.M_addr2          := if(trim(l.AtypeID,left,right) ='1',l.addr2,'') ;
			self.M_addr3          := if(trim(l.AtypeID,left,right) ='1',l.addr3,'') ;
			self.M_city           := if(trim(l.AtypeID,left,right) ='1',l.city ,'') ;
			self.M_state          := if(trim(l.AtypeID,left,right) ='1',l.state,'') ;
			self.M_zip            := if(trim(l.AtypeID,left,right) ='1',l.zip,'') ;
			self.M_countyname     := if(trim(l.AtypeID,left,right) ='1' and corp2.t2u(l.countyname)not in list ,l.countyname,'') ;
			self.R_addr1          := if(trim(l.AtypeID,left,right) ='10',l.addr1,'') ;
			self.R_addr2          := if(trim(l.AtypeID,left,right) ='10',l.addr2,'') ;
			self.R_addr3          := if(trim(l.AtypeID,left,right) ='10',l.addr3,'') ;
			self.R_city           := if(trim(l.AtypeID,left,right) ='10',l.city ,'') ;
			self.R_state          := if(trim(l.AtypeID,left,right) ='10',l.state,'') ;
			self.R_zip            := if(trim(l.AtypeID,left,right) ='10',l.zip,'') ;
			self.R_countyname     := if(trim(l.AtypeID,left,right) ='10' and corp2.t2u(l.countyname)not in list ,l.countyname,'') ;
			self.RM_addr1         := if(trim(l.AtypeID,left,right) ='13',l.addr1,'') ;
			self.RM_addr2         := if(trim(l.AtypeID,left,right) ='13',l.addr2,'') ;
			self.RM_addr3         := if(trim(l.AtypeID,left,right) ='13',l.addr3,'') ;
			self.RM_city          := if(trim(l.AtypeID,left,right) ='13',l.city ,'') ;
			self.RM_state         := if(trim(l.AtypeID,left,right) ='13',l.state,'') ;
			self.RM_zip           := if(trim(l.AtypeID,left,right) ='13',l.zip,'') ;
			self.RM_countyname    := if(trim(l.AtypeID,left,right) ='13' and corp2.t2u(l.countyname)not in list ,l.countyname,'') ;
			self                  := l;
		
		end;

		EXPORT ds_addr_trns(dataset(Corp2_Raw_NC.Layouts.AddressesLayoutIn) pInAddresses)	:=project(pInAddresses,addr_parse(left));
	
END;