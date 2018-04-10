IMPORT corp2, corp2_mapping, corp2_raw_mt, lib_stringlib;

EXPORT Functions := Module

	  //****************************************************************************
		//ContTitle1Desc: returns the "cont_title1_desc".
		//****************************************************************************
		EXPORT ContTitle1Desc(STRING s) := FUNCTION

			RETURN map(corp2.t2u(s) = 'ADVISOR/CONSULTANT' 				=> 'ADVISOR/CONSULTANT',
								 corp2.t2u(s) = 'CHAIR OF THE BOARD' 				=> 'CHAIR OF THE BOARD',
								 corp2.t2u(s) = 'CHIEF CORPORATE OFFICER' 	=> 'CHIEF CORPORATE OFFICER',
								 corp2.t2u(s) = 'COMMISSIONER' 					    => 'COMMISSIONER',
								 corp2.t2u(s) = 'DIRECTOR' 					        => 'DIRECTOR',
								 corp2.t2u(s) = 'ENTITY' 					          => 'ENTITY',
								 corp2.t2u(s) = 'GENERAL PARTNER' 					=> 'GENERAL PARTNER',
								 corp2.t2u(s) in ['INDIVIDUAL','OWNER_IND'] => 'INDIVIDUAL',
								 corp2.t2u(s) = 'INCORPORATOR' 					    => 'INCORPORATOR',
								 corp2.t2u(s) = 'LIMITED PARTNER' 				  => 'LIMITED PARTNER',
								 corp2.t2u(s) = 'MANAGER' 					        => 'MANAGER',
								 corp2.t2u(s) = 'MANAGER MEMBER' 					  => 'MANAGER MEMBER',
								 corp2.t2u(s) = 'MEMBER' 					          => 'MEMBER',
								 corp2.t2u(s) = 'MEMBER OF GOVERNING BODY'  => 'MEMBER OF GOVERNING BODY',
								 corp2.t2u(s) = 'OTHER' 					          => 'OTHER',
								 corp2.t2u(s) = 'OFFICER' 					        => 'OFFICER',
								 corp2.t2u(s) = 'OTHER OFFICER' 					  => 'OTHER OFFICER',
								 corp2.t2u(s) = 'PARTNER' 					        => 'PARTNER',
								 corp2.t2u(s) = 'PRESIDENT' 					      => 'PRESIDENT',
								 corp2.t2u(s) = 'PRESIDING OFFICER' 				=> 'PRESIDING OFFICER',
								 corp2.t2u(s) = 'SECRETARY' 					      => 'SECRETARY',
								 corp2.t2u(s) = 'SERIES MEMBER' 					  => 'SERIES MEMBER',
								 corp2.t2u(s) = 'SHAREHOLDER' 					    => 'SHAREHOLDER',
								 corp2.t2u(s) = 'SUPERVISORY COMMITTEE' 	  => 'SUPERVISORY COMMITTEE',
								 corp2.t2u(s) = 'TREASURER' 					      => 'TREASURER',
								 corp2.t2u(s) = 'TRUSTEE' 					        => 'TRUSTEE',
								 corp2.t2u(s) = 'VICE-PRESIDENT' 					  => 'VICE-PRESIDENT',
								 '**|'+corp2.t2u(s)
												);
												
			END;	
							
							
			
		//****************************************************************************
		//CorpForgnDomesticInd: returns the "corp_forgn_domestic_ind".
		//****************************************************************************
		EXPORT CorpForgnDomesticInd(STRING s) := FUNCTION
				 uc_s := corp2.t2u(s);
		     RETURN MAP(uc_s IN ['ASSOCIATION','AUTHORITY','CEMETERY ASSOCIATION','CITY OR TOWN','COOPERATIVE ASSOCIATION',
				                     'DEVELOPMENT CORPORATION','DISTRICT','DOMESTIC BUSINESS TRUST','DOMESTIC FARM MUTUAL INSURER',
														 'DOMESTIC FINANCIAL INSTITUTION','DOMESTIC LIMITED LIABILITY COMPANY','DOMESTIC LIMITED LIABILITY PARTNERSHIP',
														 'DOMESTIC LIMITED PARTNERSHIP','DOMESTIC MUTUAL INSURER','DOMESTIC NON PROFIT CORPORATION',
														 'DOMESTIC PROFIT CORPORATION','DOMESTIC RAILROAD COMPANY','DOMESTIC RELIGIOUS CORPORATION',
														 'DOMESTIC RURAL COOPERATIVE UTILITIES','DOMESTIC STOCK INSURER','FIRE DEPARTMENT RELIEF ASSOCIATION',
														 'WATER &/ OR SEWER DISTRICT']                                               													 => 'D',
		                uc_s IN ['FIDUCIARY FOREIGN TRUST COMPANY','FOREIGN BUSINESS TRUST','FOREIGN FINANCIAL INSTITUTION',
										         'FOREIGN LIMITED LIABILITY COMPANY','FOREIGN LIMITED LIABILITY PARTNERSHIP','FOREIGN LIMITED PARTNERSHIP',
														 'FOREIGN NONPROFIT CORPORATION','FOREIGN PROFIT CORPORATION','FOREIGN RAILROAD COMPANY',
														 'FOREIGN RELIGIOUS CORPORATION SOLE','FOREIGN RURAL COOPERATIVE UTILITIES', 
														 'FOREIGN STOCK INSURANCE COMPANY','NON-QUALIFIED FOREIGN BUSINESS EQUITY']                            => 'F',
										'');
										
	  END;
		//*********************************************************************************
		//TradeMarkClassCodeTable: returns the "corp_trademark_class_desc1 through _desc6".
		//*********************************************************************************
		EXPORT TradeMarkClassCodeTable(STRING s, integer cd_cnt,integer pos) := FUNCTION
		    str             := corp2.t2u(s);
				search_pattern1 := '(\\d[0-9A-Z]{1,2}[\\W\\s]+)';
				search_pattern2 := '(\\d[0-9A-Z]{1,2}[\\W\\s]+)([\\s]*\\d[0-9A-Z]{1,2}[\\W\\s]+)';
				search_pattern3 := '(\\d[0-9A-Z]{1,2}[\\W\\s]+)([\\s]*\\d[0-9A-Z]{1,2}[\\W\\s]+)([\\s]*\\d[0-9A-Z]{1,2}[\\W\\s]+)';
				search_pattern4 := '(\\d[0-9A-Z]{1,2}[\\W\\s]+)([\\s]*\\d[0-9A-Z]{1,2}[\\W\\s]+)([\\s]*\\d[0-9A-Z]{1,2}[\\W\\s]+)([\\s]*\\d[0-9A-Z]{1,2}[\\W\\s]+)';
				search_pattern5 := '(\\d[0-9A-Z]{1,2}[\\W\\s]+)([\\s]*\\d[0-9A-Z]{1,2}[\\W\\s]+)([\\s]*\\d[0-9A-Z]{1,2}[\\W\\s]+)([\\s]*\\d[0-9A-Z]{1,2}[\\W\\s]+)([\\s]*\\d[0-9A-Z]{1,2}[\\W\\s]+)';
				search_pattern6 := '(\\d[0-9A-Z]{1,2}[\\W\\s]+)([\\s]*\\d[0-9A-Z]{1,2}[\\W\\s]+)([\\s]*\\d[0-9A-Z]{1,2}[\\W\\s]+)([\\s]*\\d[0-9A-Z]{1,2}[\\W\\s]+)([\\s]*\\d[0-9A-Z]{1,2}[\\W\\s]+)([\\s]*\\d[0-9A-Z]{1,2}[\\W\\s]+)';
			 
				//TM Class Codes & Description string can have up to 6 in one string.  (i.e. this one has 2 '2VV - MALT BEVERAGES & LIQUORS, 3A - MISCELLANEOUS;')
			  code := case(cd_cnt, 1 => REGEXFIND(search_pattern1,str,pos),
				                     2 => REGEXFIND(search_pattern2,str,pos),
														 3 => REGEXFIND(search_pattern3,str,pos),
														 4 => REGEXFIND(search_pattern4,str,pos),
														 5 => REGEXFIND(search_pattern5,str,pos),
														      REGEXFIND(search_pattern6,str,pos));
  
				//Choose the code that is in the nth position.  Positions are 1-6.  For str = '041||035|| 3A|| 2MM||', when n=3, it will return 3A.
 				 
				RETURN case(lib_stringlib.StringLib.StringFilterOut(code,'|| '),		
										'001'  => 'CHEMICALS, RESINS, PLASTICS, MANURE',
										'002'  => 'PAINTS, VARNISHES, LACQUERS',
										'2A'	 => 'RAW OR PARTLY PREPARED MATERIALS',
										'2AA'  => 'HOROLOGICAL INSTRUMENTS',
										'2B' 	 => 'RECEPTACLES',
										'2BB'  => 'JEWELER AND PRECIOUS METAL WARE',
										'2C' 	 => 'BAGGAGE, ANIM EQUIP, PTFOLIO, POCKETBK',
										'2CC'  => 'BROOMS, BRUSHES, DUSTERS',  
										'2D' 	 => 'ABRASIVE & POLISHING MATERIALS',
										'2DD'  => 'CROCKERY, EARTHENWARE, PORCELAIN',
										'2E' 	 => 'ADHESIVES',
										'2EE'  => 'FILTERS & REFRIGERATORS',
										'2F' 	 => 'CHEMICALS & CHEMICAL COMPOSITIONS',
										'2FF'  => 'FURNITURE & UPHOLSTERY',
										'2G' 	 => 'CORDAGE',
										'2GG'  => 'GLASSWARE',
										'2H' 	 => 'SMOKERS\' ARTICLES-NOT TOBACCO PROD',
										'2HH'  => 'HEATING, LIGHTING, VENTILATING',
										'2I' 	 => 'EXPLOSIVES, FIREARMS, PROJECTILES, ETC',
										'2II'  => 'BELTING, HOSE, MACH PACKING, TIRES',
										'2J' 	 => 'FERTILIZERS',
										'2JJ'  => 'MUSICAL INSTRUMENTS & SUPPLIES',
										'2K' 	 => 'INKS & INKING MATERIALS',
										'2KK'  => 'PAPER & STATIONERY',
										'2L' 	 => 'CONSTRUCTION MATERIALS',
										'2LL'  => 'PRINTS & PUBLICATIONS',
										'2M' 	 => 'HARDWARE, PLUMBING & STEAMFITTING SUPPLIES',
										'2MM'  => 'CLOTHING',
										'2N' 	 => 'METALS, METAL CASTING, FORGINGS',
										'2NN'  => 'FANCY GOODS, FURNISHINGS, NOTIONS',
										'2O' 	 => 'OILS & GREASES',
										'2OO'  => 'CANES, PARASOLS, UMBRELLAS',
										'2P' 	 => 'PAINTS & PAINTERS\' MATERIALS',
										'2PP'  => 'KNITTED, NETTED, TEXTILE FABRICS & SUBS',
										'2Q' 	 => 'TOBACCO PRODUCTS',
										'2QQ'  => 'THREAD & YARN',
										'2R' 	 => 'MEDICINES & PHARMACEUTICAL PREPARAT',
										'2RR'  => 'DENTAL, MEDICAL, SURGICAL APPLIANCES',
										'2S' 	 => 'VEHICLES',   
										'2SS'  => 'SOFT DRINKS & CARBONATED WATERS',
										'2T' 	 => 'LINOLEUM & OIL CLOTH',
										'2TT'  => 'FOODS & INGREDIENTS OF FOOD',
										'2U' 	 => 'ELECTRIC APPARATUS,MACHINES,SUPPLIES',
										'2UU'  => 'WINES',
										'2V' 	 => 'GAMES, TOYS & SPORTING GOODS',
										'2VV'  => 'MALT BEVERAGES & LIQUORS',
										'2W' 	 => 'CUTLERY, MACHINERY, TOOLS & PARTS OF',
										'2WW'  => 'DISTILLED ALCOHOLIC LIQUORS',
										'2X' 	 => 'LAUNDRY APPLIANCES & MACHINES',
										'2XX'  => 'MERCHANDISE NOT OTHERWISE CLASSIFY',
										'2Y' 	 => 'LOCKS AND SAFES',
										'2YY'  => 'COSMETICS & TOILET PREPARATIONS',
										'2Z' 	 => 'MEASURING & SCIENTIFIC APPLIANCES',
										'2ZZ'  => 'DETERGENTS & SOAPS',
										'003'  => 'BLEACHING, CLEANING, POLISH PREPARATION', 
										'3A' 	 => 'MISCELLANEOUS',
										'3B' 	 => 'ADVERTISING & BUSINESS',
										'3C' 	 => 'INSURANCE & FINANCIAL', 
										'3D' 	 => 'CONSTRUCTION & REPAIR', 
										'3E' 	 => 'COMMUNICATIONS',
										'3F' 	 => 'TRANSPORTATION & STORAGE',
										'3G' 	 => 'MATERIAL TREATMENT', 
										'3H' 	 => 'EDUCATION & ENTERTAINMENT',
										'004'  => 'INDUSTRIAL OILS/GREASES, LUBRICANTS,',
										'005'  => 'PHARMACEUTICAL/VETERINARY PREP',
										'006'  => 'COMMON METALS',      
										'007'  => 'MACHINES & MACHINE TOOLS',
										'008'  => 'HAND TOOLS, IMPLEMENTS, CUTLERY/RAZOR', 
										'009'  => 'SCIENTIFIC APPARATUS & INSTRUMENTS',
										'010'  => 'MEDICAL APPARATUS & INSTRUMENTS',
										'011'  => 'LIGHTING, HEATING, COOKING APPARATUS',
										'012'  => 'LAND, AIR & WATER VEHICLES, LOCOMOTIVES',
										'013'  => 'FIREARMS, AMMO, EXPLOSIVES, FIREWORKS',
										'014'  => 'PRECIOUS METALS, JEWELRY, STONES',
										'015'  => 'MUSICAL INSTRUMENTS',
										'016'  => 'PAPER, CARDBOARD, STATIONERY, PHOTOS',
										'017'  => 'RUBBER, GUTTA PERCHA, GUM, ASBESTOS,MI',
										'018'  => 'LEATHER, SKINS, HIDES, WHIPS, SADDLERY',
										'019'  => 'BUILDING MATERIALS (NONMETALLIC)',  
										'020'  => 'FURNITURE, MIRRORS, FRAMES, WOOD, CORK',
										'021'  => 'HOUSEHOLD/KITCHEN UTENSILS & CONTAI',
										'022'  => 'ROPES, STRING, NET, TENTS, AWNINGS, SAIL',
										'023'  => 'YARNS, THREADS FOR TEXTILE',
										'024'  => 'TEXTILES, TEXTILE GOODS, BED/TABLE CO', 
										'025'  => 'CLOTHING, FOOTWEAR, HANDGEAR',
										'026'  => 'LACE, EMBROIDERY, RIBBONS, BUTTONS, PINS',
										'027'  => 'CARPETS, RUGS, MATS, LINOLEUM, WALL HANGINGS',
										'028'  => 'GAMES, PLAYTHINGS, GYMNASTIC/SPORT AR',
										'029'  => 'MEAT, FISH, POULTRY, GAME, FRUIT, VEGETABLES',
										'030'  => 'COFFEE, TEA, COCOA, SUGAR, RICE, FLOUR,B',
										'031'  => 'AGRICULTURAL, HORTICULTURAL, FORESTRY',
										'032'  => 'BEER, WATERS, NONALCOHOLIC/FRUIT DRINKS',
										'033'  => 'ALCOHOLIC BEVERAGES (EXCEPT BEER)',
										'034'  => 'TOBACCO, SMOKERS ARTICLES, MATCHES',
										'035'  => 'ADVERTISING, BUSINESS MANAGEMENT/ADM',
										'036'  => 'INSURANCE, FINANCIAL/MONETARY AFFAIR',
										'037'  => 'BUILDING CONSTRUCTION, REPAIR, INSTAL',
										'038'  => 'TELECOMMUNICATIONS',
										'039'  => 'TRANSPORT/PACKAGE/STORE GOODS/TRAVE',
										'040'  => 'TREATMENT OF MATERIALS',
										'041'  => 'EDUCATION, TRAINING, ENTERTAINMENT',
										'042'  => 'SCIENTIFIC/TECHNOLOGICAL SERVICES',
										'043'  => 'FOOD/DRINK SERVICES, ACCOMODATIONS',
										'044'  => 'MEDICAL/VETERNARY SERVICE, BEAUTY CA',
										'045'  => 'PERSONAL/SOCIAL/SECURITY SERVICES',
										'046'  => 'MULTIPLE CLASSES ON FILE WITH SOS',
										''     => '',
									  '**|'+corp2.t2u(code) 
										
									);
							 
		END;
		//****************************************************************************
		//StateCodeTranslation: returns the "corp_forgn_state_desc".
		//****************************************************************************
		EXPORT StateCodeTranslation(STRING s) := FUNCTION
				RETURN CASE(corp2.t2u(s),		
										'AK' => 'ALASKA',
										'AL' => 'ALABAMA',
										'AR' => 'ARKANSAS',
										'AZ' => 'ARIZONA',
										'CA' => 'CALIFORNIA',
										'CO' => 'COLORADO',
										'CT' => 'CONNECTICUT',
										'DC' => 'DISTRICT OF COLUMBIA',
										'DE' => 'DELAWARE',
										'FL' => 'FLORIDA',
										'GA' => 'GEORGIA',
										'HI' => 'HAWAII',
										'IA' => 'IOWA',
										'ID' => 'IDAHO',
										'IL' => 'ILLINOIS',
										'IN' => 'INDIANA',
										'KS' => 'KANSAS',
										'KY' => 'KENTUCKY',
										'LA' => 'LOUISIANA',
										'MA' => 'MASSACHUSETTS',
										'MD' => 'MARYLAND',
										'ME' => 'MAINE',
										'MI' => 'MICHIGAN',
										'MN' => 'MINNESOTA',
										'MO' => 'MISSOURI',
										'MS' => 'MISSISSIPPI',
										'MT' => 'MONTANA',
										'NC' => 'NORTH CAROLINA',
										'ND' => 'NORTH DAKOTA',
										'NE' => 'NEBRASKA',
										'NH' => 'NEW HAMPSHIRE',
										'NJ' => 'NEW JERSEY',
										'NM' => 'NEW MEXICO',
										'NV' => 'NEVADA',
										'NY' => 'NEW YORK',
										'OH' => 'OHIO',
										'OK' => 'OKLAHOMA',
										'OR' => 'OREGON',
										'PA' => 'PENNSYLVANIA',
										'RI' => 'RHODE ISLAND',
										'SC' => 'SOUTH CAROLINA',
										'SD' => 'SOUTH DAKOTA',
										'TN' => 'TENNESSEE',
										'TX' => 'TEXAS',
										'UT' => 'UTAH',
										'VA' => 'VIRGINIA',
										'VT' => 'VERMONT',
										'WA' => 'WASHINGTON',
										'WI' => 'WISCONSIN',
										'WV' => 'WEST VIRGINIA',
										'WY' => 'WYOMING',
										'AE' => 'ARMED FORCES EUROPE, THE MIDDLE EAST, AND CANADA',
										'AP' => 'ARMED FORCES PACIFIC',
										'AA' => 'ARMED FORCES AMERICAS EXCEPT CANADA',
										'FM' => 'FEDERATED STATES OF MICRONESIA',	
										'NT' => 'NORTHWEST TERRITORIES',
										'OC' => '',
										''   => '',
									  '**|'+corp2.t2u(s) );
		END;
		
		//****************************************************************************
		//StateJurisdictionCode: returns the "corp_forgn_state_cd".
		//****************************************************************************
		EXPORT StateJurisdictionCode(STRING s) := FUNCTION
				RETURN CASE(corp2.t2u(s),		
										'ALASKA'                                            => 'AK',
										'ALABAMA'                                           => 'AL',
										'ARKANSAS'                                          => 'AR',
										'ARIZONA'                                           => 'AZ',
										'CALIFORNIA'                                        => 'CA',
										'COLORADO'                                          => 'CO',
										'CONNECTICUT'                                       => 'CT',
										'DISTRICT OF COLUMBIA'                              => 'DC',
										'DELAWARE'                                          => 'DE',
										'FLORIDA'                                           => 'FL',
										'GEORGIA'                                           => 'GA',
										'HAWAII'                                            => 'HI',
										'IOWA'                                              => 'IA',
										'IDAHO'                                             => 'ID',
										'ILLINOIS'                                          => 'IL',
										'INDIANA'                                           => 'IN',
										'KANSAS'                                            => 'KS',
										'KENTUCKY'                                          => 'KY',
										'LOUISIANA'                                         => 'LA',
										'MASSACHUSETTS'                                     => 'MA',
										'MARYLAND'                                          => 'MD',
										'MAINE'                                             => 'ME',
										'MICHIGAN'                                          => 'MI',
										'MINNESOTA'                                         => 'MN',
										'MISSOURI'                                          => 'MO',
										'MISSISSIPPI'                                       => 'MS',
										'MONTANA'                                           => 'MT',
										'NORTH CAROLINA'                                    => 'NC',
										'NORTH DAKOTA'                                      => 'ND',
										'NEBRASKA'                                          => 'NE',
										'NEW HAMPSHIRE'                                     => 'NH',
										'NEW JERSEY'                                        => 'NJ',
										'NEW MEXICO'                                        => 'NM',
										'NEVADA'                                            => 'NV',
										'NEW YORK'                                          => 'NY',
										'OHIO'                                              => 'OH',
										'OKLAHOMA'                                          => 'OK',
										'OREGON'                                            => 'OR',
										'PENNSYLVANIA'                                      => 'PA',
										'RHODE ISLAND'                                      => 'RI',
										'SOUTH CAROLINA'                                    => 'SC',
										'SOUTH DAKOTA'                                      => 'SD',
										'TENNESSEE'                                         => 'TN',
										'TEXAS'                                             => 'TX',
										'UTAH'                                              => 'UT',
										'VIRGINIA'                                          => 'VA',
										'VERMONT'                                           => 'VT',
										'WASHINGTON'                                        => 'WA',
										'WISCONSIN'                                         => 'WI',
										'WEST VIRGINIA'                                     => 'WV',
										'WYOMING'                                           => 'WY',
										'ARMED FORCES EUROPE, THE MIDDLE EAST, AND CANADA'  => 'AE',
										'ARMED FORCES PACIFIC'                              => 'AP',
										'ARMED FORCES AMERICAS EXCEPT CANADA'               => 'AA',
										'FEDERATED STATES OF MICRONESIA'                    => 'FM',	
										'NORTHWEST TERRITORIES'                             => 'NT',
										'OC'                                                => '',
										''                                                  => '',
									  '**|'+corp2.t2u(s) );
		END;

		//****************************************************************************
		//StockType: returns the "stock_type".
		//****************************************************************************
		EXPORT StockType(STRING s) := FUNCTION
			
			uc_s 		:= corp2.t2u(s);
			clean_s := stringlib.stringfilter(uc_s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ ');

		  PatternInvalidWords	:= 'NOT ENTERED|NO PAR STATED|PV NONE GIVEN|PV NONE STATED|NOT STATED|NONE STATED|NONE STATED|NO SHARES|^NONE|^NA|UNDESIGNATED';  

		  //If any word in "PatternInvalidWords" exists in the field, then blank out the field.
			RETURN if(regexfind(PatternInvalidWords,clean_s,0) <> '','',uc_s);		
		
		END;
		
END;		