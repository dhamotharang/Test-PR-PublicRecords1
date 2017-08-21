IMPORT corp2, corp2_mapping, corp2_raw_mt;

EXPORT Functions := Module

		//****************************************************************************
		//ContTitle1Desc: returns the "cont_title1_desc".
		//****************************************************************************
		EXPORT ContTitle1Desc(STRING s) := FUNCTION

			RETURN map(corp2.t2u(s) = ''						 => '',
								 corp2.t2u(s) = 'A' 					 => 'LIMITED LIABILITY COMPANY INDIVIDUAL MANAGER',
								 corp2.t2u(s) in ['D','1','3'] => 'DIRECTOR',
								 corp2.t2u(s) = 'G' 					 => 'GENERAL PARTNER',
								 corp2.t2u(s) = 'L' 					 => 'LIMITED PARTNER',
								 corp2.t2u(s) = 'P'	 					 => 'PRESIDENT',
								 corp2.t2u(s) = 'Q' 					 => 'VICE PRESIDENT',
								 corp2.t2u(s) = 'S' 					 => 'SECRETARY',
								 corp2.t2u(s) = 'T' 					 => 'TREASURER',
								 corp2.t2u(s) = 'U'						 => 'OTHER',
								 corp2.t2u(s) = '2'						 => 'OFFICER',
								 corp2.t2u(s) = '4'						 => 'PARTNER',
								 corp2.t2u(s) = '5'						 => 'OWNER/PARTNER',
								 corp2.t2u(s) in ['6','7'] 		 => 'MANAGER',		
								 corp2.t2u(s) = 'RM'           => 'REGISTERED MANAGER',
								 '**|'+corp2.t2u(s)
								);
								
		END;	
		
		//****************************************************************************
		//CorpEntityDesc: returns the "corp_entity_desc".
		//****************************************************************************
		EXPORT CorpEntityDesc(STRING descriptionofgoods,
													STRING mannerofuse,
													STRING businesspurpose) := FUNCTION
			
													
				uc_descriptionofgoods := corp2.t2u(descriptionofgoods);
				uc_mannerofuse			  := corp2.t2u(mannerofuse);
				uc_businesspurpose  	:= corp2.t2u(businesspurpose);

				corpentitydesc := corp2.t2u(if(uc_descriptionofgoods <> '','DESCRIPTION OF GOODS: ' + uc_descriptionofgoods + '; ','') +
												            if(uc_mannerofuse <> '', uc_mannerofuse+'; ','') + 
												            if(uc_businesspurpose <> '','BUSINESS PURPOSE: ' + uc_businesspurpose,''));
				
				RETURN corp2.t2u(regexreplace(';$',corpentitydesc,''));

		END;
			
		//****************************************************************************
		//AddSlash2Date: returns a date CCYYMMDD to MM/DD/CCYY.
		//****************************************************************************
		EXPORT AddSlash2Date(STRING indate) := FUNCTION
				RETURN indate[5..6] + '/' + indate[7..8] + '/' + indate[1..4];
		END;
		
		//****************************************************************************
		//CorpAddlInfo: returns the "corp_addl_info".
		//****************************************************************************
		EXPORT CorpAddlInfo(STRING inPurpose,
												STRING involdissolintentdate,
												STRING dateoffirstusemt,
												STRING classcd1,
												STRING classcd2,
												STRING classcd3,
												STRING classcd4,
												STRING classcd5,
												STRING classcd6,
												STRING countyInfo) := FUNCTION
			
			uc_cd1 									 := corp2.t2u(classcd1);
			uc_cd2 									 := corp2.t2u(classcd2);
			uc_cd3 									 := corp2.t2u(classcd3);
			uc_cd4 									 := corp2.t2u(classcd4);
			uc_cd5 									 := corp2.t2u(classcd5);
			uc_cd6 									 := corp2.t2u(classcd6);
		
			purpose                  := if(corp2.t2u(inPurpose)<>'','NAME PURPOSE: '+ corp2.t2u(inPurpose)+'; ','');
		
			addlinfo1                := if(Corp2_mapping.fValidateDate(involdissolintentdate,'MMDDCCYY').PastDate <> '','INVOLUNTARY INTENT TO DISSOLVE DATE: ' + AddSlash2Date(Corp2_mapping.fValidateDate(involdissolintentdate,'MMDDCCYY').PastDate), '');
			addlinfo2                := if(Corp2_mapping.fValidateDate(dateoffirstusemt,'MMDDCCYY').PastDate <> '','DATE TM FIRST USED: ' + AddSlash2Date(Corp2_mapping.fValidateDate(dateoffirstusemt,'MMDDCCYY').PastDate), '');
			addlinfoall							 := if(addlinfo1 <> '' ,addlinfo1 + '; ' ,if(addlinfo2 <> '' ,addlinfo2 + '; ' ,''));
			
			classcddesc							 := if(uc_cd1 + uc_cd2 + uc_cd3 + uc_cd4 + uc_cd5 + uc_cd6 <>'','CLASS: ','');
			classcdall							 := if(uc_cd1<>'',uc_cd1+'; ','')+if(uc_cd2<>'',uc_cd2+'; ','')+if(uc_cd3<>'',uc_cd3+'; ','')+if(uc_cd4<>'',uc_cd4+'; ','')+if(uc_cd5<>'',uc_cd5+'; ','')+if(uc_cd6<>'',uc_cd6+'; ','');
			
			uc_countyinfo						 := if(corp2.t2u(countyinfo)<>'','AUTHORIZED COUNTIES: ' + corp2.t2u(countyInfo),'');
			
			RETURN regexreplace(';$', corp2.t2u(if(purpose       <> '' ,purpose ,'') +
																					if(addlinfoall   <> '' ,addlinfoall ,'') + 
																					if(classcdall    <> '' ,classcddesc + classcdall ,'') +
																					if(uc_countyinfo <> '' ,uc_countyinfo + '; ' ,''))  
													,'');

		END;

		//****************************************************************************
		//CorpOrigOrgStructureDesc: returns the "corp_orig_org_structure_desc".
		//****************************************************************************
		EXPORT CorpOrigOrgStructureDesc(STRING s) := FUNCTION

			code 	:= corp2.t2u(s);

			RETURN map(code = 'C' 		=> 'DOMESTIC LIMITED LIABILITY COMPANY',
								 code = 'D' 		=> 'DOMESTIC CORPORATION',
								 code = 'E' 		=> 'FOREIGN LIMITED LIABILITY COMPANY',
								 code = 'F' 		=> 'FOREIGN CORPORATION',
								 code = 'L' 		=> 'LIMITED PARTNERSHIP',
								 code = 'N' 		=> 'NONQUALIFIED FOREIGN ENTITY',
								 code = 'P' 		=> 'LIMITED LIABILITY PARTNERSHIP',
								 '');
		END;


		//****************************************************************************
		//CorpPurpose: returns "corp_purpose".
		//****************************************************************************
		EXPORT CorpPurpose(STRING s) := FUNCTION
				ValidDesc  := case((integer)s,
														0   =>'',
														7 	=>'IMPORT',
														8 	=>'AUTOMOBILE SALES',
														9 	=>'SPORTING SALES/SERVICE',
														10 	=>'MERCANTILE OR COMMERCIAL-GENERAL',
														11 	=>'AUTOMOTIVE SERVICE/PARTS',
														12 	=>'FURNITURE SALES',
														13 	=>'LUMBER AND/OR HARDWARE SALE',
														14 	=>'DRUG SALES',
														15 	=>'WHOLESALE',
														16 	=>'RETAIL',
														17 	=>'GROCERY SALES',
														18 	=>'CLOTHING SALES',
														19 	=>'APPLIANCE SALES/SERVICE',
														20 	=>'MANUFACTURING-GENERAL',
														21 	=>'MANUFACTURE OF METALS',
														22 	=>'SMELTER',
														23 	=>'MANUFACTURE OF FOODS',
														24 	=>'MANUFACTURE OF BEVERAGE-SOFT',
														25 	=>'MANUFACTURE OF BEVERAGE-HARD',
														26 	=>'MANUFACTURE OF EQUIPMENT',
														27 	=>'MANUFACTURE OF STOVES',
														28 	=>'MANUFACTURE OF GLASS',
														29 	=>'RECYCLING',
														30 	=>'MINING-GENERAL',
														31 	=>'COAL MINING',
														32 	=>'METAL MINING',
														33 	=>'PRECIOUS STONE MINING',
														34 	=>'MINERAL RIGHTS',
														40 	=>'MECHANICAL-GENERAL',
														41 	=>'MECHANICAL ENGINEERING',
														50 	=>'CHEMICAL-GENERAL',
														51 	=>'CHEMICAL ENGINEERING',
														60 	=>'FARMING AND RANCHING',
														61 	=>'FARM AND RANCH-LIVESTOCK',
														62 	=>'FARM AND RANCH-SUPPLIES',
														63 	=>'FARM AND RANCH-GRAIN',
														64 	=>'FARM AND RANCH-ELEVATOR',
														65 	=>'FARM AND RANCH-SEEDS',
														66 	=>'ORCHARD,FRUIT OR TREES',
														67 	=>'DAIRY',
														70 	=>'SECURITY HOLDING-GENERAL',
														71 	=>'SECURITY BROKER',
														72 	=>'SECURITY HOLDING COMPANY',
														75 	=>'TITLE AND/OR ABSTRACT COMPANY',
														80 	=>'INSURANCE UNDERWRITING',
														81  =>'CAPTIVE INSURANCE FORMED AS A CORPORATION',
														89 	=>'INSURANCE ADJUSTER',
														90 	=>'INSURANCE AGENCY',
														91 	=>'LIFE INSURANCE',
														92 	=>'AUTO INSURANCE',
														93 	=>'HOME INSURANCE',
														94 	=>'HEALTH INSURANCE',
														95 	=>'3RD PARTY ADMINISTRATOR',
														99 	=>'TRUST COMPANY',
														100 =>'BANKING',
														101 =>'COMMERCIAL BANK',
														102 =>'SAVING & LOAN',
														103 =>'CREDIT UNION',
														104 =>'BANK HOLDING COMPANY',
														105 =>'HOLDING COMPANY',
														110 =>'TRANSPORTATION-GENERAL',
														111 =>'TRANSPORTATION-AIRLINES',
														112 =>'TRANSPORTATION-BUS',
														113 =>'TRANSPORTATION-RAILROAD',
														114 =>'TRANSPORTATION-TAXI',
														115 =>'TRANSPORTATION-MOVING COMPANY',
														116 =>'TRANSPORTATION-FREIGHT COMPANY',
														117 =>'TRAVEL AGENCY',
														118 =>'CAR RENTAL',
														119 =>'TELECOMMUNICATIONS',
														120 =>'COMMUNICATIONS-GENERAL',
														121 =>'COMMUNICATIONS-TV',
														122 =>'COMMUNICATIONS-RADIO',
														123 =>'COMMUNICATIONS-NEWSPAPER',
														124 =>'COMMUNICATIONS-MAGAZINE',
														125 =>'COMMUNICATIONS-TELEPHONE COOP',
														126 =>'COMMUNICATIONS-TELEPHONE PRIVATE CO',
														127 =>'COMMUNICATIONS-TELEGRAM',
														128 =>'COMMUNICATIONS-CABLE COMPANY',
														129 =>'PRINTS AND/OR PUBLICATIONS',
														130 =>'SUPPLY OF WATER-GENERAL',
														131 =>'SUPPLY OF WATER-PRIVATE',
														132 =>'SUPPLY OF WATER-COOPERATIVE',
														133 =>'SUPPLY OF WATER-IRRIGATION',
														134 =>'SUPPLY OF WATER-MUNICIPAL',
														135 =>'SUPPLY OF WATER-DITCH COMPANY',
														136 =>'WATER USERS ASSOCIATION',
														137 =>'WATER AND SEWER DISTRICT',
														140 =>'SUPPLY OF ENERGY-GENERAL',
														141 =>'SUPPLY OF ENERGY-GAS,LIGHT,HEAT',
														142 =>'SUPPLY OF ENERGY-COOPERATIVE',
														143 =>'SUPPLY OF ENERGY-WIND',
														144 =>'SUPPLY OF ENERGY-SOLAR',
														145 =>'SUPPLY OF ENERGY-THERMAL',
														150 =>'CONSTRUCTION-GENERAL',
														151 =>'CONSTRUCTION-BUILDING',
														152 =>'CONSTRUCTION-ROAD',
														153 =>'CONSTRUCTION-EXCAVATION/BACKHOE',
														154 =>'CONSTRUCTION-TRANSMISSION LINE',
														155 =>'CONSTRUCTION-PLUMBING/HEATING',
														156 =>'CONSTRUCTION-ELECTRICAL',
														160 =>'REAL ESTATE-GENERAL',
														161 =>'REAL ESTATE AGENCY',
														162 =>'REAL ESTATE DEVELOPMENT',
														163 =>'REAL ESTATE INVESTMENT',
														164 =>'REAL ESTATE MANAGEMENT',
														165 =>'TRAILER COURT',
														166 =>'RENTAL',
														167 =>'REAL AND PERSONAL PROPERTY',
														170 =>'HOTEL OR MOTEL',
														171 =>'HOTEL/MOTEL AND BAR',
														172 =>'HOTEL/MOTEL AND RESTAURANT',
														173 =>'HOTEL/MOTEL WITH BAR AND RESTAURANT',
														180 =>'RESTAURANT OR CAFE',
														181 =>'RESTAURANT AND BAR',
														190 =>'TAVERN/BAR',
														195 =>'RESORT',
														196 =>'DUDE RANCH',
														200 =>'ANY LAWFUL BUSINESS',
														201 =>'NONE STATED',
														210 =>'MORTUARY',
														211 =>'CEMETERY-PRIVATE',
														212 =>'CEMETERY ASSOCIATION',
														213 =>'CREMATORY',
														220 =>'RELIGION',
														221 =>'CHURCH',
														222 =>'CHURCH YOUTH ORGANIZATION',
														223 =>'CHURCH BUILDING',
														224 =>'RELIGIOUS PROPERTY HOLDING COMPANY',
														230 =>'CLUBS-GENERAL',
														231 =>'SENIOR CITIZENS ORGANIZATION',
														232 =>'CHARITABLE OR FOUNDATION',
														233 =>'SERVICE ORGANIZATION',
														234 =>'FRATERNAL ORGANIZATION',
														235 =>'HISTORICAL PRESERVATION GROUP',
														236 =>'SOCIAL ORGANIZATION',
														237 =>'CHILDRENS ORGANIZATION',
														238 =>'VETERANS ORGANIZATION',
														240 =>'CHARITABLE',
														250 =>'EDUCATION-GENERAL',
														251 =>'EDUCATION-GRADE SCHOOL',
														252 =>'EDUCATION-HIGH SCHOOL',
														253 =>'EDUCATION-PRE SCHOOL',
														254 =>'EDUCATION-DAY CARE',
														255 =>'EDUCATION-COLLEGE',
														256 =>'EDUCATION-TRADE',
														257 =>'EDUCATION-VOCATIONAL & TECHNICAL',
														258 =>'EDUCATION-SPECIAL',
														259 =>'PUBLIC AWARENESS',
														260 =>'FRATERNAL',
														270 =>'RECREATION-GENERAL',
														271 =>'RECREATION-CLUB',
														272 =>'RECREATION-MARINA & SALES',
														273 =>'ATHLETIC CLUB',
														274 =>'RV SALES & SERVICE',
														275 =>'HEALTH CLUB',
														280 =>'SOCIAL',
														286 =>'DOMESTIC LIMITED LIABILITY COMPANY',
														287 =>'PROFESSIONAL SERVICE-ENGINEERS',
														288 =>'PROF SERVICE-PHYSICAL THERAPY',
														289 =>'PROF SERVICE-PHARMACIST',
														290 =>'PROF SERVICE-GENERAL',
														291 =>'PROF SERVICE-LAWYER',
														292 =>'PROF SERVICE-DOCTOR',
														293 =>'PROF SERVICE-DENTIST',
														294 =>'PROF SERVICE-ACCOUNTANT',
														295 =>'PROF SERVICE-CHIROPRACTOR',
														296 =>'PROF SERVICE-ARCHITECTURE',
														297 =>'PROF SERVICE-VETERINARY',
														298 =>'PROF SERVICE-OPTOMETRIST',
														299 =>'PROF SERVICE-NURSING',
														300 =>'CONSUMER OR SMALL LOAN',
														305 =>'LEASING COMPANY',
														310 =>'PROMOTIONAL-GENERAL',
														311 =>'PROMOTIONAL-ADVERTISING',
														312 =>'PROMOTIONAL-FUND RAISING',
														320 =>'GAS,OIL,PETROLEUM-GENERAL',
														321 =>'GAS,OIL,PETROLEUM-SERVICE AND REPAIR',
														322 =>'GAS,OIL,PETROLEUM-SALES',
														323 =>'GAS,OIL,PETROLEUM-INVESTMENT',
														324 =>'GAS,OIL,PETROLEUM-MANAGEMENT',
														325 =>'GAS,OIL,PETROLEUM-SUPPLY',
														326 =>'GAS,OIL,PETROLEUM-EXPLORATION',
														327 =>'GAS,OIL,PETROLEUM-DRILLING',
														328 =>'GAS,OIL,PETROLEUM-HOLE PLUGGING',
														329 =>'OIL AND GAS LEASES',
														330 =>'MEDICAL,HOSPITAL,NURSING FACILITY',
														331 =>'MEDICAL FACILITY-HOSPITAL',
														332 =>'MEDICAL FACILITY-NURSING HOME',
														333 =>'MEDICAL FACILITY-CLINIC',
														340 =>'PROFESSIONAL FACILITY-BUILDING',
														341 =>'HEALTH SERVICE-GENERAL',
														342 =>'HEALTH RESEARCH',
														343 =>'HEALTH REHABILITATION',
														344 =>'HEALTH-FAMILY COUNSELING',
														345 =>'HEALTH-CHEMICAL DEPENDENCY',
														346 =>'MENTAL HEALTH',
														347 =>'HOSPITAL MANAGEMENT SERVICE',
														350 =>'LOGGING,LUMBER,TIMBER-GENERAL',
														351 =>'LUMBER MILL',
														352 =>'LOGGING OPERATION-TRUCKS',
														353 =>'LOGGING OPERATION-HELICOPTER',
														354 =>'LOG HAULING',
														355 =>'TREE PLANTING',
														380 =>'COMPUTER-GENERAL',
														381 =>'COMPUTER-SALES AND SERVICE',
														382 =>'COMPUTER-SOFWARE',
														383 =>'COMPUTER-VIDE',
														384 =>'COMPUTER-CONSULTANT',
														389 =>'EMPLOYMENT SERVICE',
														390 =>'SERVICE-GENERAL',
														391 =>'OFFICE CLEANING AND MAINTENANCE',
														392 =>'LAUNDRY',
														393 =>'GARBAGE COLLECTION',
														394 =>'AUTOMOBILE REPAIR',
														395 =>'APPLIANCE REPAIR',
														396 =>'RESEARCH',
														397 =>'TOWING',
														398 =>'SURVEYING',
														399 =>'ENGINEERING',
														410 =>'TRADE OR PROFESSIONAL ASSOCIATION',
														411 =>'REALTOR ASSOCIATION',
														412 =>'LABOR ASSOCIATION',
														420 =>'WATER AND/OR SEWER DISTRICT',
														430 =>'CONDO ASSOCIATION',
														440 =>'HOME OWNERS ASSOCIATION',
														450 =>'PUBLIC-GENERAL',
														451 =>'TOWN/CITY CLASSIFICATION',
														452 =>'AIRPORT',
														453 =>'PUBLIC FACILITY',
														454 =>'TV DISTRICT',
														455 =>'CONSERVATION DISTRICT',
														456 =>'HOUSING AUTHORITY',
														480 =>'ENTERTAINMENT-GENERAL',
														481 =>'ENTERTAINMENT-VIDEO GAMES',
														482 =>'ENTERTAINMENT-MOVIES',
														483 =>'ENTERTAINMENT-STAGE',
														484 =>'ENTERTAINMENT-MUSICAL',
														485 =>'VIDEO-GENERAL',
														490 =>'HANDICRAFT-GENERAL',
														491 =>'HANDICRAFT-CERAMICS AND POTTERY',
														492 =>'HANDICRAFT-WOOD',
														500 =>'COMMUNITY SERVICE-GENERAL',
														501 =>'CRIME STOPPERS',
														502 =>'SEARCH AND RESCUE',
														503 =>'VOLUNTEER FIRE DEPT',
														504 =>'FIRE RELIEF ASSOCIATION',
														505 =>'LAW ENFORCEMENT ASSOCIATION',
														506 =>'CHAMBER OF COMMERCE',
														520 =>'MANAGEMENT AND/OR CONSULTANT',
														525 =>'INVESTMENT',
														526 =>'FINANCIAL SERVICE',
														550 =>'ASSOCIATION',
														'**|'+corp2.t2u(s) );
									 
				RETURN if(corp2.t2u(stringlib.stringfilterout(s,'0123456789'))<>'', '**|'+corp2.t2u(s), ValidDesc);
									 
		END;		
		
		//****************************************************************************
		//CorpOrigBusTypeDesc: returns the "corp_orig_bus_type_desc".
		//****************************************************************************
		EXPORT CorpOrigBusTypeDesc(STRING s, STRING DorF) := FUNCTION
		
				code := map(corp2.t2u(s) = '15' and DorF = 'D' => '15D',
				            corp2.t2u(s) = '15' and DorF = 'F' => '15F',
										corp2.t2u(s) = '81' and DorF = 'D' => '81D',
										corp2.t2u(s) = '81' and DorF = 'F' => '81F',
										corp2.t2u(s));
										
				RETURN case(corp2.t2u(code),
										'06' =>'LLC MANAGER/CONT AFTER DISSOC', 
										'07' =>'LLC MEM MANAGERS/CONT AFTER DISSOC',
										'08' =>'PROF LLC MANAGERS/CONT ON DISSOC',
										'09' =>'PROF LLC MEM/MAN CONT ON DISSOC',
										'11' =>'GENERAL BUSINESS',
										'12' =>'PROFESSIONAL SERVICE',
										'13' =>'DEVELOPMENT CREDIT',
										'14' =>'CLOSE CORPORATION',
										'15D'=>'DOMESTIC PROFIT CORPORATION',
										'15F'=>'FOREIGN PROFIT CORPORATION',
										'21' =>'RAILROAD COMPANY',
										'22' =>'STOCK INSURANCE COMPANY',
										'23' =>'BUSINESS TRUST',
										'24' =>'MOTOR CLUB SERVICE COMPANY',
										'25' =>'FARM MUTUAL INSURER',
										'26' =>'MUTUAL INSURANCE COMPANY',
										'27' =>'FOREIGN TRUST COMPANY',
										'28' =>'NONQUALIFIED FOREIGN ENTITY',
										'30' =>'SUBSIDIARY TRUST COMPANY',
										'31' =>'BANK',
										'32' =>'MORRIS PLAN COMPANY',
										'33' =>'BUILDING OR SAVINGS & LOAN ASSOC',
										'34' =>'CREDIT UNION',
										'35' =>'INVESTMENT COMPANY',
										'36' =>'TRUST COMPANY',
										'37' =>'CAPTIVE INSURANCE COMPANY',
										'41' =>'GENERAL COOPERATIVE',
										'42' =>'AGRICULTURAL COOP OR DISTRICT',
										'43' =>'COOPERATIVE MARKETING ASSOC',
										'44' =>'RURAL ELECTRIC OR TELEPHONE COOP',
										'45' =>'ELECTRICITY BUYING COOPERATIVE',
										'51' =>'GENERAL NONPROFIT CORP',
										'52' =>'PUBLIC BENEFIT WITH MEMBERS',
										'53' =>'PUBLIC BENEFIT WITHOUT MEMBERS',
										'54' =>'MUTUAL BENEFIT WITH MEMBERS',
										'55' =>'MUTUAL BENEFIT WITHOUT MEMBERS',
										'56' =>'RELIGIOUS WITH MEMBERS',
										'57' =>'RELIGIOUS WITHOUT MEMBERS',
										'58' =>'NONPROFIT WITH MEMBERS',
										'59' =>'NONPROFIT WITHOUT MEMBERS',
										'61' =>'RELIGIOUS CORPORATION SOLE',
										'66' =>'LLC MANAGED BY MANAGERS',
										'67' =>'LLC MANAGED BY MEMBER/MANAGERS',
										'68' =>'PROF LLC MANAGED BY MANAGERS',
										'69' =>'PROF LLC MANAGED BY MEMB/MGRS',
										'71' =>'STATE CONSERVATION DISTRICT',
										'72' =>'HOUSING AUTHORITY',
										'73' =>'COUNTY WATER AND SEWER DISTRICT',
										'74' =>'CEMETERY ASSOC',
										'75' =>'FIRE DEPT RELIEF ASSOC',
										'76' =>'CITY OR TOWN',
										'77' =>'PUBLIC TELEVISION DISTRICT',
										'78' =>'GRAZING CONSERVATION DISTRICT',
										'79' =>'RESORT AREA DISTRICT',
										'80' =>'REGIONAL WATER AUTHORITY',
										'81D'=>'DOMESTIC LIMITED PARTNERSHIP',
										'81F'=>'FOREIGN LIMITED PARTNERSHIP',										
										'82' =>'WATER USERS ASSOC (1902 FED)',
										'83' =>'CONGRESSIONAL CHARTERED CORP',
										'84' =>'SPECIAL DISTRICTS',
									  '');
		END;
	
		//****************************************************************************
		//CountyTable: returns the "corp_registered_counties".
		//****************************************************************************
		EXPORT CountyTable(STRING s) := FUNCTION
				
				uc_s := corp2.t2u(s);

        counties := if(uc_s[01] = 'Y'
				               ,'ALL'
											 ,corp2.t2u(if(uc_s[02] = 'Y','BEAVERHEAD' 				+ ', ', '') +
																	if(uc_s[03] = 'Y','BIG HORN'   				+ ', ', '') +
																	if(uc_s[04] = 'Y','BLAINE'     				+ ', ', '') +
																	if(uc_s[05] = 'Y','BROADWATER' 				+ ', ', '') +
																	if(uc_s[06] = 'Y','CARBON'   					+ ', ', '') +
																	if(uc_s[07] = 'Y','CARTER'   					+ ', ', '') +
																	if(uc_s[08] = 'Y','CASCADE'   				+ ', ', '') +
																	if(uc_s[09] = 'Y','CHOUTEAU'   				+ ', ', '') +
																	if(uc_s[10] = 'Y','CUSTER'   					+ ', ', '') +
																	if(uc_s[11] = 'Y','DANIELS'   				+ ', ', '') +
																	if(uc_s[12] = 'Y','DAWSON'   					+ ', ', '') +
																	if(uc_s[13] = 'Y','DEER LODGE'   			+ ', ', '') +
																	if(uc_s[14] = 'Y','FALLON'   					+ ', ', '') +
																	if(uc_s[15] = 'Y','FERGUS'   					+ ', ', '') +
																	if(uc_s[16] = 'Y','FLATHEAD'          + ', ', '') +
																	if(uc_s[17] = 'Y','GALLATIN'          + ', ', '') +
																	if(uc_s[18] = 'Y','GARFIELD'          + ', ', '') +
																	if(uc_s[19] = 'Y','GLACIER'           + ', ', '') +
																	if(uc_s[20] = 'Y','GOLDEN VALLEY'     + ', ', '') +
																	if(uc_s[21] = 'Y','GRANITE'           + ', ', '') +
																	if(uc_s[22] = 'Y','HILL'              + ', ', '') +
																	if(uc_s[23] = 'Y','JEFFERSON'         + ', ', '') +
																	if(uc_s[24] = 'Y','JUDITH BASIN'      + ', ', '') +
																	if(uc_s[25] = 'Y','LAKE'              + ', ', '') +
																	if(uc_s[26] = 'Y','LEWIS AND CLARK'   + ', ', '') +
																	if(uc_s[27] = 'Y','LIBERTY'   				+ ', ', '') +
																	if(uc_s[28] = 'Y','LINCOLN'   				+ ', ', '') +
																	if(uc_s[29] = 'Y','MC CONE'   				+ ', ', '') +
																	if(uc_s[30] = 'Y','MADISON'   				+ ', ', '') +
																	if(uc_s[31] = 'Y','MEAGHER'   				+ ', ', '') +
																	if(uc_s[32] = 'Y','MINERAL'   				+ ', ', '') +
																	if(uc_s[33] = 'Y','MISSOULA'   				+ ', ', '') +
																	if(uc_s[34] = 'Y','MUSSELSHELL'  			+ ', ', '') +
																	if(uc_s[35] = 'Y','PARK'   						+ ', ', '') +
																	if(uc_s[36] = 'Y','PETROLEUM'   			+ ', ', '') +
																	if(uc_s[37] = 'Y','PHILLIPS'   				+ ', ', '') +
																	if(uc_s[38] = 'Y','PONDERA'   				+ ', ', '') +
																	if(uc_s[39] = 'Y','POWDER RIVER'   		+ ', ', '') +
																	if(uc_s[40] = 'Y','POWELL'   					+ ', ', '') +
																	if(uc_s[41] = 'Y','PRAIRIE'   				+ ', ', '') +
																	if(uc_s[42] = 'Y','RAVALLI'   				+ ', ', '') +
																	if(uc_s[43] = 'Y','RICHLAND'   				+ ', ', '') +
																	if(uc_s[44] = 'Y','ROOSEVELT'   			+ ', ', '') +
																	if(uc_s[45] = 'Y','ROSEBUD'   				+ ', ', '') +
																	if(uc_s[46] = 'Y','SANDERS'   				+ ', ', '') +
																	if(uc_s[47] = 'Y','SHERIDAN'   				+ ', ', '') +
																	if(uc_s[48] = 'Y','SILVER BOW'   			+ ', ', '') +
																	if(uc_s[49] = 'Y','STILLWATER'   			+ ', ', '') +
																	if(uc_s[50] = 'Y','SWEET GRASS'   		+ ', ', '') +
																	if(uc_s[51] = 'Y','TETON'   					+ ', ', '') +
																	if(uc_s[52] = 'Y','TOOLE'   					+ ', ', '') +
																	if(uc_s[53] = 'Y','TREASURE'   				+ ', ', '') +
																	if(uc_s[54] = 'Y','VALLEY'   					+ ', ', '') +
																	if(uc_s[55] = 'Y','WHEATLAND'   			+ ', ', '') +
																	if(uc_s[56] = 'Y','WIBAUX'   					+ ', ', '') +
																	if(uc_s[57] = 'Y','YELLOWSTONE'   		+ ', ', '')) 
												);		 
													 
			  RETURN corp2.t2u(regexreplace(',$',counties,''));

		END;


		//****************************************************************************
		//StatusReasonCodeTable: returns the "corp_status_desc"/"corp_status_comment".
		//****************************************************************************
		EXPORT StatusReasonCodeTable(STRING s) := FUNCTION
				RETURN case(corp2.t2u(s),
										'CAN' =>'CANCELLATION',
										'CNV' =>'CONVERSION',
										'DED' =>'DELAYED EFFECTIVE DATE',
										'DIS' =>'DISSOLUTION',
										'DSC' =>'DISSOCIATION',
										'DSM' =>'DISSOCIATION OF MEMBER',
										'ERR' =>'ERROR CORRECTION',
										'EXP' =>'EXPIRED',
										'FOR' =>'FORFEITED',
										'GDS' =>'',
										'GSD' =>'',
										'INT' =>'INTENT TO DISSOLVE VOLUNTARILY',
										'INV' =>'INVOLUNTARY DISSOLUTION',
										'IVD' =>'INTENT TO DISSOLVE INVOLUNTARILY',
										'IVR' =>'INTENT TO REVOKE CERT OF AUTHORITY',
										'LGS' =>'ACTIVE GOOD STANDING',
										'MRF' =>'SURVIVOR; CORP/CO BELOW MERGED OUT',
										'MRN' =>'MERGED OUT TO UNQUALIFIED CORP/CO',
										'MRT' =>'SURVIVOR; MERGED WITH UNQUALIFIED CORP/CO',
										'PEX' =>'PENDING EXPIRATION', 
										'PGS' =>'PENDING GOOD STANDING',
										'PRN' =>'PENDING RENEWAL',    
										'REV' =>'REVIVED',
										'RGT' =>'REGISTERED', 
										'RNL' =>'LIMITED PARTNERSHIP EXPIRATION',
										'RSV' =>'RESERVATION',
										'RVK' =>'REVOCATION',
										'SSP' =>'SUSPENSION',
										'WDR' =>'WITHDRAWN',
									  '**|'+corp2.t2u(s) );
		END;

		//*********************************************************************************
		//TradeMarkClassCodeTable: returns the "corp_trademark_class_desc1 through _desc6".
		//*********************************************************************************
		EXPORT TradeMarkClassCodeTable(STRING s) := FUNCTION
				RETURN case(corp2.t2u(s),		
										'1'  	=>'CHEMICALS, RESINS, PLASTICS, MANURE',
										'2'   =>'PAINTS, VARNISHES, LACQUERS',
										'2A'	=>'RAW OR PARTLY PREPARED MATERIALS',
										'2AA' =>'HOROLOGICAL INSTRUMENTS',
										'2B' 	=>'RECEPTACLES',
										'2BB' =>'JEWELER AND PRECIOUS METAL WARE',
										'2C' 	=>'BAGGAGE,ANIM EQUIP,PTFOLIO,POCKETBK',
										'2CC' =>'BROOMS,BRUSHES,DUSTERS',  
										'2D' 	=>'ABRASIVE AND POLISHING MATERIALS',
										'2DD' =>'CROCKERY,EARTHENWARE,PORCELAIN',
										'2E' 	=>'ADHESIVES',
										'2EE' =>'FILTERS AND REFRIGERATORS',
										'2F' 	=>'CHEMICALS AND CHEMICAL COMPOSITIONS',
										'2FF' =>'FURNITURE AND UPHOLSTERY',
										'2G' 	=>'CORDAGE',
										'2GG' =>'GLASSWARE',
										'2H' 	=>'SMOKERS ARTICLES-NOT TOBACCO PROD',
										'2HH' =>'HEATING,LIGHTING,VENTILATING',
										'2I' 	=>'EXPLOSIVES,FIREARMS,PROJECTILES,ETC',
										'2II' =>'BELTING,HOSE,MACH PACKING,TIRES',
										'2J' 	=>'FERTILIZERS',
										'2JJ' =>'MUSICAL INSTRUMENTS & SUPPLIES',
										'2K' 	=>'INKS AND INKING MATERIALS',
										'2KK' =>'PAPER AND STATIONERY',
										'2L' 	=>'CONSTRUCTION MATERIALS',
										'2LL' =>'PRINTS AND PUBLICATIONS',
										'2M' 	=>'HARDWARE,PLUMBING & STEAMFITTING SUPP',
										'2MM' =>'CLOTHING',
										'2N' 	=>'METALS,METAL CASTING,FORGINGS',
										'2NN' =>'FANCY GOODS,FURNISHINGS,NOTIONS',
										'2O' 	=>'OILS AND GREASES',
										'2OO' =>'CANES,PARASOLS,UMBRELLAS',
										'2P' 	=>'PAINTS AND PAINTERS MATERIALS',
										'2PP' =>'KNITTED,NETTED,TEXTILE FABRICS & SUBS',
										'2Q' 	=>'TOBACCO PRODUCTS',
										'2QQ' =>'THREAD & YARN',
										'2R' 	=>'MEDICINES & PHARMACEUTICAL PREPARAT',
										'2RR' =>'DENTAL,MEDICAL,SURGICAL APPLIANCES',
										'2S' 	=>'VEHICLES',   
										'2SS' =>'SOFT DRINKS & CARBONATED WATERS',
										'2T' 	=>'LINOLEUM & OIL CLOTH',
										'2TT' =>'FOODS & INGREDIENTS OF FOOD',
										'2U' 	=>'ELECTRIC APPARATUS,MACHINES,SUPPLIES',
										'2UU' =>'WINES',
										'2V' 	=>'GAMES,TOYS & SPORTING GOODS',
										'2VV' =>'MALT BEVERAGES & LIQUORS',
										'2W' 	=>'CUTLERY,MACHINERY,TOOLS & PARTS OF',
										'2WW' =>'DISTILLED ALCOHOLIC LIQUORS',
										'2X' 	=>'LAUNDRY APPLIANCES & MACHINES',
										'2XX' =>'MERCHANDISE NOT OTHERWISE CLASSIFY',
										'2Y' 	=>'LOCKS AND SAFES',
										'2YY' =>'COSMETICS AND TOILET PREPARATIONS',
										'2Z' 	=>'MEASURING & SCIENTIFIC APPLIANCES',
										'2ZZ' =>'DETERGENTS AND SOAPS',
										'3' 	=>'BLEACHING, CLEANING, POLISH PREPARATION', 
										'3A' 	=>'MISCELLANEOUS',
										'3B' 	=>'ADVERTISING AND BUSINESS',
										'3C' 	=>'INSURANCE AND FINANCIAL', 
										'3D' 	=>'CONSTRUCTION AND REPAIR', 
										'3E' 	=>'COMMUNICATIONS',
										'3F' 	=>'TRANSPORTATION AND STORAGE',
										'3G' 	=>'MATERIAL TREATMENT', 
										'3H' 	=>'EDUCATION AND ENTERTAINMENT',
										'4' 	=>'INDUSTRIAL OILS/GREASES, LUBRICANTS,',
										'5' 	=>'PHARMACEUTICAL/VETERINARY PREP',
										'6' 	=>'COMMON METALS',      
										'7' 	=>'MACHINES & MACHINE TOOLS',
										'8' 	=>'HAND TOOLS, IMPLEMENTS, CUTLERY/RAZOR', 
										'9' 	=>'SCIENTIFIC APPARATUS & INSTRUMENTS',
										'10'  =>'MEDICAL APPARATUS & INSTRUMENTS',
										'11'  =>'LIGHTING, HEATING, COOKING APPARATUS',
										'12'  =>'LAND, AIR & WATER VEHICLES, LOCOMOTIVES',
										'13'  =>'FIREARMS, AMMO, EXPLOSIVES, FIREWORKS',
										'14'  =>'PRECIOUS METALS, JEWELRY, STONES',
										'15'  =>'MUSICAL INSTRUMENTS',
										'16'  =>'PAPER, CARDBOARD, STATIONERY, PHOTOS',
										'17'  =>'RUBBER, GUTTA PERCHA, GUM, ASBESTOS,MI',
										'18'  =>'LEATHER, SKINS, HIDES, WHIPS, SADDLERY',
										'19'  =>'BUILDING MATERIALS (NONMETALLIC)',  
										'20'  =>'FURNITURE, MIRRORS, FRAMES, WOOD, CORK',
										'21'  =>'HOUSEHOLD/KITCHEN UTENSILS & CONTAI',
										'22'  =>'ROPES, STRING, NET, TENTS, AWNINGS, SAIL',
										'23'  =>'YARNS, THREADS FOR TEXTILE',
										'24'  =>'TEXTILES, TEXTILE GOODS, BED/TABLE CO', 
										'25'  =>'CLOTHING, FOOTWEAR, HANDGEAR',
										'26'  =>'LACE, EMBROIDERY, RIBBONS, BUTTONS, PINS',
										'27'  =>'CARPETS, RUGS, MATS, LINOLEUM,WALL HANGINGS',
										'28'  =>'GAMES, PLAYTHINGS, GYMNASTIC/SPORT AR',
										'29'  =>'MEAT, FISH, POULTRY, GAME, FRUIT, VEGETABLES',
										'30'  =>'COFFEE, TEA, COCOA, SUGAR, RICE, FLOUR,B',
										'31'  =>'AGRICULTURAL, HORTICULTURAL, FORESTRY',
										'32'  =>'BEER, WATERS, NONALCOHOLIC/FRUIT DRINKS',
										'33'  =>'ALCOHOLIC BEVERAGES (EXCEPT BEER)',
										'34'  =>'TOBACCO, SMOKERS ARTICLES, MATCHES',
										'35'  =>'ADVERTISING, BUSINESS MANAGEMENT/ADM',
										'36'  =>'INSURANCE, FINANCIAL/MONETARY AFFAIR',
										'37'  =>'BUILDING CONSTRUCTION, REPAIR, INSTAL',
										'38'  =>'TELECOMMUNICATIONS',
										'39'  =>'TRANSPORT/PACKAGE/STORE GOODS/TRAVE',
										'40'  =>'TREATMENT OF MATERIALS',
										'41'  =>'EDUCATION, TRAINING, ENTERTAINMENT',
										'42'  =>'SCIENTIFIC/TECHNOLOGICAL SERVICES',
										'43'  =>'FOOD/DRINK SERVICES, ACCOMODATIONS',
										'44'  =>'MEDICAL/VETERNARY SERVICE, BEAUTY CA',
										'45'  =>'PERSONAL/SOCIAL/SECURITY SERVICES',
										'46'  =>'MULTIPLE CLASSES ON FILE WITH SOS',
										''    =>'',
									  '**|'+corp2.t2u(s)
									 );
		END;
		//****************************************************************************
		//StateCodeTranslation: returns the "corp_forgn_state_desc".
		//****************************************************************************
		EXPORT StateCodeTranslation(STRING s) := FUNCTION
				RETURN CASE(corp2.t2u(s),		
										'AK' =>'ALASKA',
										'AL' =>'ALABAMA',
										'AR' =>'ARKANSAS',
										'AZ' =>'ARIZONA',
										'CA' =>'CALIFORNIA',
										'CO' =>'COLORADO',
										'CT' =>'CONNECTICUT',
										'DC' =>'DISTRICT OF COLUMBIA',
										'DE' =>'DELAWARE',
										'FL' =>'FLORIDA',
										'GA' =>'GEORGIA',
										'HI' =>'HAWAII',
										'IA' =>'IOWA',
										'ID' =>'IDAHO',
										'IL' =>'ILLINOIS',
										'IN' =>'INDIANA',
										'KS' =>'KANSAS',
										'KY' =>'KENTUCKY',
										'LA' =>'LOUISIANA',
										'MA' =>'MASSACHUSETTS',
										'MD' =>'MARYLAND',
										'ME' =>'MAINE',
										'MI' =>'MICHIGAN',
										'MN' =>'MINNESOTA',
										'MO' =>'MISSOURI',
										'MS' =>'MISSISSIPPI',
										'MT' =>'MONTANA',
										'NC' =>'NORTH CAROLINA',
										'ND' =>'NORTH DAKOTA',
										'NE' =>'NEBRASKA',
										'NH' =>'NEW HAMPSHIRE',
										'NJ' =>'NEW JERSEY',
										'NM' =>'NEW MEXICO',
										'NV' =>'NEVADA',
										'NY' =>'NEW YORK',
										'OH' =>'OHIO',
										'OK' =>'OKLAHOMA',
										'OR' =>'OREGON',
										'PA' =>'PENNSYLVANIA',
										'RI' =>'RHODE ISLAND',
										'SC' =>'SOUTH CAROLINA',
										'SD' =>'SOUTH DAKOTA',
										'TN' =>'TENNESSEE',
										'TX' =>'TEXAS',
										'UT' =>'UTAH',
										'VA' =>'VIRGINIA',
										'VT' =>'VERMONT',
										'WA' =>'WASHINGTON',
										'WI' =>'WISCONSIN',
										'WV' =>'WEST VIRGINIA',
										'WY' =>'WYOMING',
										'AE' =>'ARMED FORCES EUROPE, THE MIDDLE EAST, AND CANADA',
										'AP' =>'ARMED FORCES PACIFIC',
										'AA' =>'ARMED FORCES AMERICAS EXCEPT CANADA',
										'FM' =>'FEDERATED STATES OF MICRONESIA',	
										'NT' =>'NORTHWEST TERRITORIES',
										'OC' =>'',
										''   =>'',
									  '**|'+corp2.t2u(s) );
		END;
		

		//****************************************************************************
		//StockClass: returns the "stock_class".
		//****************************************************************************
		EXPORT StockClass(STRING s) := FUNCTION
			
			uc_s 		:= corp2.t2u(s);
			clean_s := corp2.t2u(stringlib.stringfilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '));

		  PatternInvalidWords	:= 'NO PAR STATED|PV NONE GIVEN|PV NONE STATED|NOT STATED|NONE STATED|NO SHARES|^NONE|^NA|UNDESIGNATED';  

		  //If any word in "PatternInvalidWords" exists in the field, then blank out the field.
			RETURN if(regexfind(PatternInvalidWords,clean_s,0)<>'','',uc_s);		
		
		END;
		
END;		