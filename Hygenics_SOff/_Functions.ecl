import ut;

export _functions := module

export statusToFilter := ['PLAINTIFF', 'JUVENILE CLASS: A','JUVENILE CLASS: N','JUVENILE CLASS: JA','JUVENILE CLASS: J'];


export is_company(string temp_name) := function 

	string1 v_bus_name_flag :=if(StringLib.StringFind(temp_name,'ANCHORAGE ',1)!=0 OR
					StringLib.StringFind(temp_name,'HARVESTING',1) !=0 OR                                      
					StringLib.StringFind(temp_name,'PRODUCTION',1) !=0 OR
					StringLib.StringFind(temp_name,'ENVIRONMENTAL',1) !=0 OR
					StringLib.StringFind(temp_name,'LANDSCAPE',1) !=0 OR
					StringLib.StringFind(temp_name,'FURNISHING',1) !=0 OR
					StringLib.StringFind(temp_name,'UNION ASPHALT',1) !=0 OR
					StringLib.StringFind(temp_name,'UPS GROUND',1) !=0 OR
					StringLib.StringFind(temp_name,' CENTRAL ',1) !=0 OR 											
					StringLib.StringFind(temp_name,' CONTINENTAL ',1) !=0 OR 									
					StringLib.StringFind(temp_name,' OPEN ERROR ',1) !=0 OR                                              
					StringLib.StringFind(temp_name,' PAINTINT ',1) !=0 OR 
					StringLib.StringFind(temp_name,' CLEANUP ',1) !=0 OR									
					StringLib.StringFind(temp_name,' PROGRESSIVE ',1) !=0 OR	
					StringLib.StringFind(temp_name,' CERTIFIED ',1) !=0 OR 
					StringLib.StringFind(temp_name,' WASTE ',1) !=0 OR	
					StringLib.StringFind(temp_name,' INDUSTRIES ',1) !=0 OR
					StringLib.StringFind(temp_name,' ADVANCED ',1) !=0 OR
					StringLib.StringFind(temp_name,' USE PID ',1) !=0 OR
					StringLib.StringFind(temp_name,' AUTHORITY ',1) !=0 OR
					StringLib.StringFind(temp_name,' CAMPGD ',1) !=0 OR
				 // StringLib.StringFind(temp_name,' CAMPGROUND ',1)!=0 OR
					StringLib.StringFind(temp_name,' CONTRACTORS ',1)!=0 OR
					StringLib.StringFind(temp_name,'SPORTSFISHING',1)!=0 OR
					StringLib.StringFind(temp_name,'SPORTFISHING',1)!=0 OR
				 // StringLib.StringFind(temp_name,' BROTHERS ',1) !=0 OR
					StringLib.StringFind(temp_name,'POWERSPORTS',1)!=0 OR
					StringLib.StringFind(temp_name,'POWER SPORTS',1) !=0 OR
					StringLib.StringFind(temp_name,' & SON',1)!=0 OR
					StringLib.StringFind(temp_name, 'PRECISION',1)!=0 OR
					StringLib.StringFind(temp_name,' ISLANDS  ',1)!=0 OR
					//StringLib.StringFind(temp_name,' ISLAND ',1)!=0 OR
				 //StringLib.StringFind(temp_name,' SPORT ',1)!=0 OR
      StringLib.StringFind(temp_name,' SPORTS ',1)!=0 OR
      StringLib.StringFind(temp_name,' ADVENTURES ',1)!=0 OR
      //StringLib.StringFind(temp_name,', N A',1)!=0 OR
      StringLib.StringFind(temp_name,', N. A.',1)!=0 OR
      StringLib.StringFind(temp_name, ' RENTALS ',1)!=0 OR
			StringLib.StringFind(temp_name, ' RENTAL ',1)!=0 OR 
     	StringLib.StringFind(temp_name,' ASSN ',1)!=0 OR
		  StringLib.StringFind(temp_name,' S&LA ',1)!=0 OR
		  StringLib.StringFind(temp_name,' S & LA ',1)!=0 OR
		  StringLib.StringFind(temp_name,' ASSN. ',1)!=0 OR
		  StringLib.StringFind(temp_name,' ASSOCIATION ',1)!=0 OR
			StringLib.StringFind(temp_name,'ASSOC ',1) != 0 OR
			StringLib.StringFind(temp_name,'ASSOC.',1) != 0 OR
		  StringLib.StringFind(temp_name,'ASSOCIATES L L P',1)!=0 OR
		  StringLib.StringFind(temp_name,'ASSOCIATES',1)!=0 OR
		  StringLib.StringFind(temp_name,' COMMONWEALTH ',1)!=0 OR
//////////////////////////////////////////////////////////////////////////////////									
				
		  StringLib.StringFind(temp_name,'CONCRETE ',1)!=0 OR
		  //StringLib.StringFind(temp_name,' CONDO ',1)!=0 OR
		  StringLib.StringFind(temp_name,' PRODUCTS ',1)!=0 OR
		  //StringLib.StringFind(temp_name,' FIRM ',1)!=0 OR
		  //StringLib.StringFind(temp_name,' PC ',1)!=0 OR
		  StringLib.StringFind(temp_name,' P.C. ',1)!=0 OR
		  StringLib.StringFind(temp_name,' DIST  ',1)!=0 OR
		  StringLib.StringFind(temp_name,' INS ',1)!=0 OR
		  StringLib.StringFind(temp_name,' INS. ',1)!=0 OR
		  StringLib.StringFind(temp_name,' INSURANCE ',1)!=0 OR			
		  //StringLib.StringFind(temp_name,' LEAGUE ',1)!=0 OR
		  StringLib.StringFind(temp_name,' LANDFILL ',1)!=0 OR
		  StringLib.StringFind(temp_name,'ELECTRICAL',1)!=0 OR
		  StringLib.StringFind(temp_name,'NETWORK',1)!=0 OR
		  StringLib.StringFind(temp_name,'MANUFACTUR',1)!=0 OR
		  StringLib.StringFind(temp_name,' WILDLIFE ',1)!=0 OR
		  StringLib.StringFind(temp_name,'COMMERCE',1)!=0 OR
		  StringLib.StringFind(temp_name,'MERCHANTS ',1)!=0 OR
		  StringLib.StringFind(temp_name,' LEARNING ',1)!=0 OR
		  StringLib.StringFind(temp_name,' SER. ',1)!=0 OR
		  StringLib.StringFind(temp_name,' CLUB ',1)!=0 OR
		  //StringLib.StringFind(temp_name,' HUNTING ',1)!=0 OR
		  //StringLib.StringFind(temp_name,' GAZETTE ',1)!=0 OR

		  StringLib.StringFind(temp_name,' AND KNEE',1)!=0 OR
		  StringLib.StringFind(temp_name,'SHIPPING',1)!=0 OR
		  StringLib.StringFind(temp_name,'TELECOM',1)!=0 OR
		  StringLib.StringFind(temp_name,'COMMUNICATION',1)!=0 OR
		  StringLib.StringFind(temp_name,'CORPORATE',1)!=0 OR
		  StringLib.StringFind(temp_name,'ACCOUNTS',1)!=0 OR
		  StringLib.StringFind(temp_name,'AMBULANCE',1)!=0 OR
		  StringLib.StringFind(temp_name,' ORTHO ',1)!=0 OR
		  StringLib.StringFind(temp_name,' ORTHOPEDIC ',1)!=0 OR
		  StringLib.StringFind(temp_name,'NEUROLOGICAL',1)!=0 OR
		  StringLib.StringFind(temp_name,'NEUROLOGY',1)!=0 OR
		  StringLib.StringFind(temp_name,'OPTHAMOLOGY',1)!=0 OR
		 ( StringLib.StringFind(temp_name,'EASTERN',1)!=0 and StringLib.StringFind(temp_name,',',1)=0) OR
		 ( StringLib.StringFind(temp_name,'EASTERN',1)!=0 and StringLib.StringFind(trim(temp_name),' ',5)> 0) OR
		 ( StringLib.StringFind(temp_name,'WESTERN',1)!=0 and StringLib.StringFind(temp_name,',',1)=0)OR
		 ( StringLib.StringFind(temp_name,'WESTERN',1)!=0 and StringLib.StringFind(trim(temp_name),' ',5)> 0) OR
		 ( StringLib.StringFind(temp_name,'NORTHERN',1)!=0 and StringLib.StringFind(temp_name,',',1)=0)OR
		 ( StringLib.StringFind(temp_name,'NORTHERN',1)!=0 and StringLib.StringFind(trim(temp_name),' ',5)> 0) OR
		 ( StringLib.StringFind(temp_name,'SOUTHERN',1)!=0 and StringLib.StringFind(temp_name,',',1)=0)OR
		 ( StringLib.StringFind(temp_name,'SOUTHERN',1)!=0 and StringLib.StringFind(trim(temp_name),' ',5)> 0) OR
		  StringLib.StringFind(temp_name,'ADMINISTRATION',1)!=0 OR
		  StringLib.StringFind(temp_name,'ALIGNMENT',1)!=0 OR
		  StringLib.StringFind(temp_name,'AMUSEMENT',1)!=0 OR
		  StringLib.StringFind(temp_name,' ANTIQUES ',1)!=0 OR
		  StringLib.StringFind(temp_name,' BUTANE ',1)!=0 OR
		  StringLib.StringFind(temp_name,' PETROLEUM ',1)!=0 OR
		  StringLib.StringFind(temp_name,'APARTMENTS',1)!=0 OR
		  StringLib.StringFind(temp_name,'APLC',1)!=0 OR
		  StringLib.StringFind(temp_name,'ARCHITECTU',1)!=0 OR
		  StringLib.StringFind(temp_name,'ARCHETECTU',1)!=0 OR
		  StringLib.StringFind(temp_name,'AIR CONDITIONING',1)!=0 OR
		  StringLib.StringFind(temp_name,'APPLIANCE',1)!=0 OR  
		  StringLib.StringFind(temp_name,'AS AGENT',1)!=0 OR
		  StringLib.StringFind(temp_name,'AUTOMOTIVE',1)!=0 OR
		  StringLib.StringFind(temp_name,'AVIATION',1)!=0 OR
		  StringLib.StringFind(temp_name,'AIRLINES',1)!=0 OR
		  StringLib.StringFind(temp_name,'BLUE CROSS',1)!=0 OR
		  StringLib.StringFind(temp_name,'BLUE SHIELD',1)!=0 OR
		  StringLib.StringFind(temp_name,'BOOKKEEPING',1)!=0 OR
		  //StringLib.StringFind(temp_name,'BOOKBINDER',1)!=0 OR
			( StringLib.StringFind(temp_name,'BOOKBINDER',1)!=0 and StringLib.StringFind(trim(temp_name),' ',5)> 0) OR
		  StringLib.StringFind(temp_name,' BOTTLING ',1)!=0 OR
		  //StringLib.StringFind(temp_name,' BAPTIST ',1)!=0 OR // added space
		  StringLib.StringFind(temp_name,'METHODIST',1)!=0 OR
		//  StringLib.StringFind(temp_name,' MILLING ',1)!=0 OR
		  StringLib.StringFind(temp_name,'BROKERAGE',1)!=0 OR
		  StringLib.StringFind(temp_name,' BROKERS ',1)!=0 OR
		  StringLib.StringFind(temp_name,' BUILDING ',1)!=0 OR
		  StringLib.StringFind(temp_name,' BUYERS ',1)!=0 OR
		  StringLib.StringFind(temp_name,'BUSINESS',1)!=0 OR
		  StringLib.StringFind(temp_name,'BOUTIQUE',1)!=0 OR
		  StringLib.StringFind(temp_name,'CHEMICAL',1)!=0 OR
		  StringLib.StringFind(temp_name,'COMPUTER',1)!=0 OR
		  StringLib.StringFind(temp_name,'CORPORATION',1)!=0 OR
		  StringLib.StringFind(temp_name,'CARBURETOR',1)!=0 OR
		  StringLib.StringFind(temp_name,'CASUALTY',1)!=0 OR
		  StringLib.StringFind(temp_name,'SECURITY',1)!=0 OR
		  StringLib.StringFind(temp_name,'CHIROPRACTIC',1)!=0 OR
		  //StringLib.StringFind(temp_name,' CHIRO ',1)!=0 OR
		  StringLib.StringFind(temp_name,'CHAPTER ',1)!=0 OR
		  StringLib.StringFind(temp_name,'CLEANING',1)!=0 OR
		  StringLib.StringFind(temp_name,'COMPANY',1)!=0 OR
		  StringLib.StringFind(temp_name,'CONSTRUCTION',1)!=0 OR
		  StringLib.StringFind(temp_name,'CONTRACTING',1)!=0 OR
		  StringLib.StringFind(temp_name,' FLYING ',1)!=0 OR
		  StringLib.StringFind(temp_name,'CONST.',1)!=0 OR
		  StringLib.StringFind(temp_name,'CONSULTANTS',1)!=0 OR
		  StringLib.StringFind(temp_name,'COOPERATIVE',1)!=0 OR
		  StringLib.StringFind(temp_name,'CABLEVISION',1)!=0 OR
		  StringLib.StringFind(temp_name,'COMMUNITY',1)!=0 OR
		  StringLib.StringFind(temp_name,'CMNTY',1)!=0 OR
		  StringLib.StringFind(temp_name,'COMMUNICATIONS',1)!=0 OR
		  StringLib.StringFind(temp_name,'COUNTRY CLUB',1)!=0 OR
		  //StringLib.StringFind(temp_name,' COUNTY ',1)!=0 OR
		 ( StringLib.StringFind(temp_name,'COUNTY',1)!=0 and StringLib.StringFind(temp_name,',',1)=0)OR
		 ( StringLib.StringFind(temp_name,'COUNTY',1)!=0 and StringLib.StringFind(trim(temp_name),' ',5)> 0) OR
		  StringLib.StringFind(temp_name,' CREDIT ',1)!=0 OR
		  StringLib.StringFind(temp_name,'DEPARTMENT',1)!=0 OR
		  StringLib.StringFind(temp_name,' DEPT ',1)!=0 OR
		  StringLib.StringFind(temp_name,' DEPT.',1)!=0 OR
		  StringLib.StringFind(temp_name,' DEPARTMT ',1)!=0 OR
		  StringLib.StringFind(temp_name,'DEVELOPMENT',1)!=0 OR
		  //StringLib.StringFind(temp_name,'DETROIT',1)!=0 OR
		  StringLib.StringFind(temp_name,'DVLPMNTL',1)!=0 OR
		  StringLib.StringFind(temp_name,'DISTRICT',1)!=0 OR
		  StringLib.StringFind(temp_name,'DISTRIBUTION',1)!=0 OR
		  StringLib.StringFind(temp_name,'DISTRIBUTING',1)!=0 OR
	   	StringLib.StringFind(temp_name,'DIVISION',1)!= 0 OR
		  StringLib.StringFind(temp_name,'ELEVATOR',1)!=0 OR
		  StringLib.StringFind(temp_name,'ENTERPRISE',1)!=0 OR
		  StringLib.StringFind(temp_name,'ENGINEERING',1)!=0 OR
		  StringLib.StringFind(temp_name,'ESTATES',1)!=0 OR
		  StringLib.StringFind(temp_name,'EQUIPMENT',1)!=0 OR
		  StringLib.StringFind(temp_name,'EQUITY',1)!=0 OR
		  StringLib.StringFind(temp_name,'EXCAVATING',1)!=0 OR
		  StringLib.StringFind(temp_name,'EXPRESS',1)!=0 OR
		  StringLib.StringFind(temp_name,'FINANCIAL ',1)!=0 OR
		  StringLib.StringFind(temp_name,'FINANCE ',1)!=0 OR
		  StringLib.StringFind(temp_name,'FABRICATORS',1)!=0 OR
		  StringLib.StringFind(temp_name,'FREIGHTLINER',1)!=0 OR
		  StringLib.StringFind(temp_name,'FREIGHT ',1)!=0 OR
		  StringLib.StringFind(temp_name,'FULLFILLMENT',1)!=0 OR
		  StringLib.StringFind(temp_name,'FULFILLMENT',1)!=0 OR
		  StringLib.StringFind(temp_name,'FUNERAL HOME',1)!=0 OR
		  StringLib.StringFind(temp_name,'FURNITURE',1)!=0 OR
		  StringLib.StringFind(temp_name,'GOVERNMENT',1)!=0 OR
		  StringLib.StringFind(temp_name,'GVRNMNT',1)!=0 OR
		  StringLib.StringFind(temp_name,' GROWERS ',1)!=0 OR
		  StringLib.StringFind(temp_name,'DEVELOPMENT',1)!=0 OR
		  StringLib.StringFind(temp_name,'DVLPMNTL',1)!=0 OR
		  StringLib.StringFind(temp_name,'FREIGHT',1)!=0 OR
		  StringLib.StringFind(temp_name,'HEALTHCARE',1)!=0 OR
		  StringLib.StringFind(temp_name,'INNOVATIVE',1)!=0 OR
		  StringLib.StringFind(temp_name,'HOSPICE',1)!=0 OR
		  StringLib.StringFind(temp_name,' HOSPITAL',1)!=0 OR
		  StringLib.StringFind(temp_name,' HOSP ',1)!=0 OR
		  StringLib.StringFind(temp_name,' HOSP.',1)!=0 OR
		  StringLib.StringFind(temp_name,'INSTITUTE',1)!=0 OR
		  StringLib.StringFind(temp_name,'INDUSTRIAL',1)!=0 OR
		  StringLib.StringFind(temp_name,'INTERNATIONAL',1)!=0 OR
		  StringLib.StringFind(temp_name,'INTERIORS',1)!=0 OR
		  StringLib.StringFind(temp_name,'INVESTMENTS',1)!=0 OR
		  StringLib.StringFind(temp_name,'LANDSCAPING',1)!=0 OR
		  StringLib.StringFind(temp_name,' LEASING ',1)!=0 OR
		 // StringLib.StringFind(temp_name,' LEASE ',1)!=0 OR
		 // StringLib.StringFind(temp_name,' LOAN ',1)!=0 OR
		  StringLib.StringFind(temp_name,'MACHINE',1)!=0 OR
		  StringLib.StringFind(temp_name,'MANAGEMENT',1)!=0 OR
		  // StringLib.StringFind(temp_name,'MATUSHITA',1)!=0 OR
		  // StringLib.StringFind(temp_name,'MATSUSHITA',1)!=0 OR
		  StringLib.StringFind(temp_name,'MISSIONARY',1)!=0 OR
		  StringLib.StringFind(temp_name,'MINISTRIES',1)!=0 OR
		  StringLib.StringFind(temp_name,'MNGMNT',1)!=0 OR
		  StringLib.StringFind(temp_name,'MOBILE PARK',1)!=0 OR
		  StringLib.StringFind(temp_name,'MOBILE HOME',1)!=0 OR
		  //StringLib.StringFind(temp_name,'MOUNTAIN',1)!=0 OR
		  StringLib.StringFind(temp_name,' NATIONAL ',1)!=0 OR
			StringLib.StringFind(temp_name,'NATIONAL, ',1)!=0 OR
		  //StringLib.StringFind(temp_name,' NATION ',1)!=0 OR
		  StringLib.StringFind(temp_name,' NAT\'L',1)!=0 OR
		  StringLib.StringFind(temp_name,' NATL ',1)!=0 OR
		  StringLib.StringFind(temp_name,' NATL. ',1)!=0 OR
		  StringLib.StringFind(temp_name,'OPTICAL',1)!=0 OR
		  StringLib.StringFind(temp_name,'PACKAGING',1)!=0 OR
		  StringLib.StringFind(temp_name,'PARTNERSHIP',1)!=0 OR
		  StringLib.StringFind(temp_name,'PEDIATRICS',1)!=0 OR
		  StringLib.StringFind(temp_name,' CONTROL ',1)!=0 OR
		  StringLib.StringFind(temp_name,' POLICE ',1)!=0 OR
		  StringLib.StringFind(temp_name,' ANIMAL ',1)!=0 OR
		  StringLib.StringFind(temp_name,' FIRE ',1)!=0 OR
		  StringLib.StringFind(temp_name,' MUNCIPAL ',1)!=0 OR
		  StringLib.StringFind(temp_name,' BUREAU ',1)!=0 OR
		  StringLib.StringFind(temp_name,'PEER REVIEW',1)!=0 OR
		  StringLib.StringFind(temp_name,'PHARMACY',1)!=0 OR
		  StringLib.StringFind(temp_name,'PHARMACEUTICAL',1)!=0 OR
		  StringLib.StringFind(temp_name,'PENSION PLAN',1)!=0 OR
		  StringLib.StringFind(temp_name,'PLUMBING',1)!=0 OR
		  StringLib.StringFind(temp_name,'PRODUCTIONS',1)!=0 OR
		  StringLib.StringFind(temp_name,'PROFESSIONAL',1)!=0 OR
		  StringLib.StringFind(temp_name,'PROPERTIES',1)!=0 OR
		  StringLib.StringFind(temp_name,'RAILROAD',1)!=0 OR
		  StringLib.StringFind(temp_name,'REALTY',1)!=0 OR
		  StringLib.StringFind(temp_name,'REBUILDERS',1)!=0 OR
		  StringLib.StringFind(temp_name,'REPAIR',1)!=0 OR
		  StringLib.StringFind(temp_name,'RESTARAUNT',1)!=0 OR
		  StringLib.StringFind(temp_name,'RESTAURANT',1)!=0 OR
		  StringLib.StringFind(temp_name,'SAVINGS',1)!=0 OR
		  StringLib.StringFind(temp_name,'SECURITIES',1)!=0 OR
		  StringLib.StringFind(temp_name,'SEAFOOD',1)!=0 OR
		  StringLib.StringFind(temp_name,'SOLUTION',1)!=0 OR
		  StringLib.StringFind(temp_name,'SPECIALTY',1)!=0 OR
		  StringLib.StringFind(temp_name,' SQUARE ',1)!=0 OR
		  StringLib.StringFind(temp_name,'SYSTEMS',1)!=0 OR
		  StringLib.StringFind(temp_name,'STATE BANK',1)!=0 OR
		  StringLib.StringFind(temp_name,'SPECIALIST',1)!=0 OR
		  StringLib.StringFind(temp_name,'SPRCNTR',1)!=0 OR
		  StringLib.StringFind(temp_name,'SUPERCENTER',1)!=0 OR
		  StringLib.StringFind(temp_name,'SUPPLY',1)!=0 OR
		  StringLib.StringFind(temp_name,'SURGERY',1)!=0 OR
		  StringLib.StringFind(temp_name,'TELEPHONE',1)!=0 OR
		  StringLib.StringFind(temp_name,'TRAVEL ',1)!=0 OR
		  StringLib.StringFind(temp_name,'TRADE NAME',1)!=0 OR
		  StringLib.StringFind(temp_name,' TRACTOR ',1)!=0 OR
		  StringLib.StringFind(temp_name,'TRUCKING',1)!=0 OR
		  StringLib.StringFind(temp_name,' TRANSPORT ',1)!=0 OR
		  StringLib.StringFind(temp_name,'TECHNOLOGY',1)!=0 OR
			StringLib.StringFind(temp_name,'TECHNOLOG',1) != 0 OR
		  StringLib.StringFind(temp_name,'TRANSPORTATION',1)!=0 OR
		  StringLib.StringFind(temp_name,'TRANSMISSION',1)!=0 OR
		  StringLib.StringFind(temp_name,' STORAGE ',1)!=0 OR
		  StringLib.StringFind(temp_name,' TRANSFER ',1)!=0 OR		  
		  StringLib.StringFind(temp_name,'VALLEY ',1)!=0 OR
		  StringLib.StringFind(temp_name,'WAREHOUSE',1)!=0 OR
		  StringLib.StringFind(temp_name,'WELLS FARGO',1)!=0 OR
		  StringLib.StringFind(temp_name,' AGENCY',1)!=0 OR
		  StringLib.StringFind(temp_name,' MARKET ',1)!=0 OR
		  StringLib.StringFind(temp_name,' SALES ',1)!=0 OR
		  StringLib.StringFind(temp_name,' RADIO',1)!=0 OR
		  StringLib.StringFind(temp_name,' COUNCIL ',1)!=0 OR
		  StringLib.StringFind(temp_name,' PARTNERS',1)!=0 OR
		 // StringLib.StringFind(temp_name,' PLAZA',1)!=0 OR
		  StringLib.StringFind(temp_name,' CLINIC',1)!=0 OR
		  StringLib.StringFind(temp_name,' CENTER ',1)!=0 OR
		  StringLib.StringFind(temp_name,' SERVICE ',1)!=0 OR
		  StringLib.StringFind(temp_name,' GROUP ',1)!=0 OR
		  StringLib.StringFind(temp_name,'TRUSTEES ',1)!=0 OR
		  StringLib.StringFind(temp_name,' TRUSTEE ',1)!=0 OR
		  StringLib.StringFind(temp_name,' TRUSTEE,',1)!=0 OR
		  StringLib.StringFind(temp_name,',TRUSTEE',1)!=0 OR
		  StringLib.StringFind(temp_name,'TRUSTEE,',1)!=0 OR
		  StringLib.StringFind(temp_name,' TRUST ',1)!=0 OR
			StringLib.StringFind(temp_name,',TRUST ',1)!=0 OR
		  StringLib.StringFind(temp_name,' TRUST,',1)!=0 OR
      StringLib.StringFind(temp_name,' TRST ' ,1)!=0 OR
		  StringLib.StringFind(temp_name,'REVOCAB',1)!=0 OR
		  StringLib.StringFind(temp_name,' INC ',1)!=0 OR
		  StringLib.StringFind(temp_name,' INC.',1)!=0 OR
		  StringLib.StringFind(temp_name,',INC ',1)!=0 OR
		  StringLib.StringFind(temp_name,',INC. ',1)!=0 OR
		  //StringLib.StringFind(temp_name,' LLC',1)!=0 OR
		  StringLib.StringFind(temp_name,' L L C',1)!=0 OR
		  StringLib.StringFind(temp_name,' LTD',1)!=0 OR
		  StringLib.StringFind(temp_name,' LTD ',1)!=0 OR
		  //StringLib.StringFind(temp_name,' LLP',1)!=0 OR
		  StringLib.StringFind(temp_name,' L L P',1)!=0 OR
      StringLib.StringFind(temp_name,',LLC',1)!=0 OR
			StringLib.StringFind(temp_name,'L.L.C.',1) != 0  OR
			StringLib.StringFind(temp_name,'L.L.P.',1) != 0 OR
			StringLib.StringFind(temp_name,'L.T.D.',1) != 0  OR
			StringLib.StringFind(temp_name,'.INC',1)!=0 OR
			StringLib.StringFind(temp_name,' LLC ',1) != 0 OR
			StringLib.StringFind(temp_name,' LLP ',1) != 0 OR
			StringLib.StringFind(temp_name,' LP ',1) != 0 OR
			StringLib.StringFind(temp_name,' L.P.',1)!=0 OR
			StringLib.StringFind(temp_name,' COOP ',1)!=0 OR
		  StringLib.StringFind(temp_name,' CO-OP ',1)!=0 OR
			StringLib.StringFind(temp_name,' CO ',1) != 0 OR
			StringLib.StringFind(temp_name,' CO.',1) != 0 OR
			StringLib.StringFind(temp_name,'CORP.',1)!=0 OR
		  StringLib.StringFind(temp_name,' CORP ',1)!=0 OR
	  	StringLib.StringFind(temp_name,' CITY  ',1)!= 0 OR
			StringLib.StringFind(temp_name,' STATE ',1)!= 0 OR
			StringLib.StringFind(temp_name,' PROVINCE ',1)!= 0 OR
	  	StringLib.StringFind(temp_name,'LIQUOR ',1)!=0 OR
		  
		  StringLib.StringFind(temp_name,' OFFICE ',1)!=0 OR
		  StringLib.StringFind(temp_name,' DELI ',1)!=0 OR
		  StringLib.StringFind(temp_name,' MOTEL ',1)!=0 OR
		  StringLib.StringFind(temp_name,' INN ',1)!=0 OR
		  StringLib.StringFind(temp_name,' USA ',1)!=0 OR
		  StringLib.StringFind(temp_name,' SCHOOL ',1)!=0 OR
		  StringLib.StringFind(temp_name,' DISTRICT ',1)!=0 OR
		  StringLib.StringFind(temp_name,'ORGANIZATION',1)!=0 OR
		  StringLib.StringFind(temp_name,'ORGANISATION',1)!=0 OR
		  
		  StringLib.StringFind(temp_name,' DBA ',1)!=0 OR
		  StringLib.StringFind(temp_name,' D/B/A ',1)!=0 OR
		  StringLib.StringFind(temp_name,' FEDERAL ',1)!=0 OR
		  StringLib.StringFind(temp_name,' UNIVERSITY',1)!=0 OR
      //StringLib.StringFind(temp_name,' PORT ',1)!=0 OR
			( StringLib.StringFind(temp_name,' PORT ',1)!=0 and StringLib.StringFind(temp_name,',',1)=0)OR
		  ( StringLib.StringFind(temp_name,' PORT ',1)!=0 and StringLib.StringFind(trim(temp_name),' ',5)> 0) OR
			( StringLib.StringFind(temp_name,' PARK ',1)!=0 and StringLib.StringFind(temp_name,',',1)=0)OR
		  ( StringLib.StringFind(temp_name,' PARK ',1)!=0 and StringLib.StringFind(trim(temp_name),' ',5)> 0) OR
		  StringLib.StringFind(temp_name,' TRAINING',1)!=0 OR
		  //StringLib.StringFind(temp_name,' AMERICA ',1)!=0 OR
      //StringLib.StringFind(temp_name,' CABLE',1)!=0 OR
			( StringLib.StringFind(temp_name,'CABLE',1)!=0 and StringLib.StringFind(temp_name,',',1)=0)OR
		  ( StringLib.StringFind(temp_name,'CABLE',1)!=0 and StringLib.StringFind(trim(temp_name),' ',5)> 0) OR
		  
      StringLib.StringFind(temp_name,' WATERPROOFING',1)!=0 OR
      StringLib.StringFind(temp_name,' TOWING',1)!=0 OR
      StringLib.StringFind(temp_name,' LIVING ',1)!=0 OR
      StringLib.StringFind(temp_name,' FAMILY',1)!=0 OR
		  StringLib.StringFind(temp_name,' AUTO ',1)!=0 OR
		  StringLib.StringFind(temp_name,' WELDING',1)!=0 OR
		  StringLib.StringFind(temp_name,' LEGISTICS',1)!=0 OR
		  StringLib.StringFind(temp_name,' SALVAGE',1)!=0 OR 
		  StringLib.StringFind(temp_name,' HEATING ',1)!=0 OR 
		  
		  StringLib.StringFind(temp_name,' SPECIALTIES ',1) !=0 OR  
			StringLib.StringFind(temp_name,'PONTOONS ',1)!=0 OR 
		  StringLib.StringFind(temp_name,'RECREATION',1)!=0 OR 		  
		  StringLib.StringFind(temp_name,' CAMPGRO ',1)!=0 OR 	
			StringLib.StringFind(temp_name,' AFB ',1)!=0 OR 
		  StringLib.StringFind(temp_name,' CREEK ',1)!=0 OR                    
      StringLib.StringFind(temp_name,' INCORP',1)!=0 OR
			StringLib.StringFind(temp_name,'ACADEMY ',1)!=0 OR
			StringLib.StringFind(temp_name,' ACADEMY$',1)!=0 OR
			StringLib.StringFind(temp_name,'ACCOUNTING',1) != 0 OR
			StringLib.StringFind(temp_name,'AFFORDABLE',1) != 0 OR
			StringLib.StringFind(temp_name,' ATTORNEYS',1) != 0 OR
			StringLib.StringFind(temp_name,'AUTORAMA',1) != 0 OR
			StringLib.StringFind(temp_name,' BOAT ',1) != 0 OR
			StringLib.StringFind(temp_name,' BOATS ',1) != 0 OR
      // StringLib.StringFind(temp_name,' MARINA ',1) != 0 OR
			StringLib.StringFind(temp_name,' SPORTSMAN',1) != 0 OR
			StringLib.StringFind(temp_name,'RECREATION ',1) != 0 OR
			StringLib.StringFind(temp_name,'WATERCRAFT',1) != 0 OR
			StringLib.StringFind(temp_name,'WATERSPORT',1) != 0 OR			
		
			StringLib.StringFind(temp_name,'BOUTIQUE',1) != 0 OR
			StringLib.StringFind(temp_name,' BROKERS',1) != 0 OR
			//StringLib.StringFind(temp_name,'BUREAU ',1) != 0 OR
			( StringLib.StringFind(temp_name,'BUREAU ',1)!=0 and StringLib.StringFind(temp_name,',',1)=0)OR
		  ( StringLib.StringFind(temp_name,'BUREAU ',1)!=0 and StringLib.StringFind(trim(temp_name),' ',5)> 0) OR
		  
			StringLib.StringFind(temp_name,'CABLEVISION',1) != 0 OR
			//StringLib.StringFind(temp_name,' CHAPTER ',1) != 0 OR
			( StringLib.StringFind(temp_name,' CHAPTER ',1)!=0 and StringLib.StringFind(temp_name,',',1)=0)OR
		  ( StringLib.StringFind(temp_name,' CHAPTER ',1)!=0 and StringLib.StringFind(trim(temp_name),' ',5)> 0) OR
		  
			StringLib.StringFind(temp_name,'CHARITIES',1) != 0 OR
			
			StringLib.StringFind(temp_name,'CITIBANK',1) != 0 OR
			StringLib.StringFind(temp_name,'CITIGROUP',1) != 0 OR
			StringLib.StringFind(temp_name,'COLLECT',1) != 0 OR
			StringLib.StringFind(temp_name,'COMMERCE',1) != 0 OR
			StringLib.StringFind(temp_name,'COMMUNICATION',1) != 0 OR
			StringLib.StringFind(temp_name,'COMMUNITY',1) != 0 OR
			StringLib.StringFind(temp_name,'COMPANY',1) != 0 OR
			StringLib.StringFind(temp_name,'COMPUTER',1) != 0 OR
			StringLib.StringFind(temp_name,'CONSUMER ',1) != 0 OR			
			StringLib.StringFind(temp_name,' DEVELOPERS ',1) != 0 OR
			StringLib.StringFind(temp_name,' DIST ',1) != 0 OR
			StringLib.StringFind(temp_name,'DISTRIBUTI',1) != 0 OR
			StringLib.StringFind(temp_name,' ESQS ',1) != 0 OR
			StringLib.StringFind(temp_name,' ESQS. ',1) != 0 OR
			StringLib.StringFind(temp_name,' FSB',1) != 0 OR
			//StringLib.StringFind(temp_name,'FARM ',1) != 0 OR
			( StringLib.StringFind(temp_name,' FARM ',1)!=0 and StringLib.StringFind(temp_name,',',1)=0)OR
		  ( StringLib.StringFind(temp_name,' FARM ',1)!=0 and StringLib.StringFind(trim(temp_name),' ',5)> 0) OR
		  
			StringLib.StringFind(temp_name,'FOUNDATION',1) != 0 OR 
		  StringLib.StringFind(temp_name,' GROCERY ',1) != 0 OR
			StringLib.StringFind(temp_name,' GYM ',1) != 0 OR
			StringLib.StringFind(temp_name,' HEALTH ',1) != 0 OR
			StringLib.StringFind(temp_name,' HOTEL',1) != 0 OR
			StringLib.StringFind(temp_name,'IMPROVEMENT',1) != 0 OR
			StringLib.StringFind(temp_name,'INTEREST',1) != 0 OR
			StringLib.StringFind(temp_name,'INVESTMENT',1) != 0 OR
			StringLib.StringFind(temp_name,'JPMORGAN ',1) != 0 OR
			StringLib.StringFind(temp_name,'LABORATORIES',1) != 0 OR
			StringLib.StringFind(temp_name,'LAUNDROMAT',1) != 0 OR
			StringLib.StringFind(temp_name,' LAWYERS ',1) != 0 OR
			//StringLib.StringFind(temp_name,' LEAGUE ',1) != 0 OR
			
			StringLib.StringFind(temp_name,'LIBRARY',1) != 0 OR
			StringLib.StringFind(temp_name,'LIMITED',1) != 0 OR
			StringLib.StringFind(temp_name,' LIQUOR ',1) != 0 OR
		//	StringLib.StringFind(temp_name,'LOGGING',1) != 0 OR
			StringLib.StringFind(temp_name,' MEDICAL ',1) != 0 OR
			StringLib.StringFind(temp_name,'MGMT',1) != 0 OR
			StringLib.StringFind(temp_name,'MUSEUM',1) != 0 OR
			StringLib.StringFind(temp_name,'NATIONSBANK',1) != 0 OR
			StringLib.StringFind(temp_name,'NCNB',1) != 0 OR
			StringLib.StringFind(temp_name,'OPTHAMOLOG',1) != 0 OR
			StringLib.StringFind(temp_name,'OPHTHAMOLOG',1) != 0 OR
			StringLib.StringFind(temp_name,'PETROLEUM',1) != 0 OR
			StringLib.StringFind(temp_name,'PHOTOGRAPHIC',1) != 0 OR
			StringLib.StringFind(temp_name,'PLANNED',1) != 0 OR
			StringLib.StringFind(temp_name,' PLASTIC ',1) != 0 OR
			//StringLib.StringFind(temp_name,' PLAZA',1) != 0 OR
			StringLib.StringFind(temp_name,'PNC ',1) != 0 OR
			StringLib.StringFind(temp_name,' POLICE ',1) != 0 OR
			StringLib.StringFind(temp_name,'PUBLICATIONS',1) != 0 OR
			StringLib.StringFind(temp_name,' QUARTER ',1) != 0 OR
			StringLib.StringFind(temp_name,' RAILWAY',1) != 0 OR
			StringLib.StringFind(temp_name,'REALTORS',1) != 0 OR
			StringLib.StringFind(temp_name,'REMODELING',1) != 0 OR
			StringLib.StringFind(temp_name,'REPUBLIC ',1) != 0 OR
			StringLib.StringFind(temp_name,'RESIDENTIAL',1) != 0 OR
			StringLib.StringFind(temp_name,'RESOURCES',1) != 0 OR
			StringLib.StringFind(temp_name,' RETAIL',1) != 0 OR
			StringLib.StringFind(temp_name,'RETIREMENT',1) != 0 OR
			StringLib.StringFind(temp_name,'SAVINGS',1) != 0 OR
			StringLib.StringFind(temp_name,'SERVICES',1) != 0 OR			
			StringLib.StringFind(temp_name,'SOCIETY',1) != 0 OR
			StringLib.StringFind(temp_name,'TELEPHON',1) != 0 OR
			//StringLib.StringFind(temp_name,'TRAVEL ',1) != 0 OR
			StringLib.StringFind(temp_name,'UNITED ',1) != 0 OR                  
			StringLib.StringFind(temp_name,' UNIV ',1) != 0 OR
			StringLib.StringFind(temp_name,'UNIVERSAL',1) != 0 OR			
			StringLib.StringFind(temp_name,'UNVERSITY',1) != 0 OR
			StringLib.StringFind(temp_name,'VOCATIONAL',1) != 0 OR			
			StringLib.StringFind(temp_name,' WARRANTY ',1) != 0 OR			
			StringLib.StringFind(temp_name,'WIRELESS',1) != 0 OR	
		  StringLib.StringFind(temp_name,'OPTOMETRISTS',1)!=0 OR
			StringLib.StringFind(temp_name,'PHOTOGRAPHY',1)!=0 OR	
			//StringLib.StringFind(temp_name,'RESCUE',1)!=0 OR
			StringLib.StringFind(temp_name,'SAILING ',1)!=0 OR		
			StringLib.StringFind(temp_name,'UTILITY',1)!=0 OR
			StringLib.StringFind(temp_name,'YACHT ',1)!=0 OR
			StringLib.StringFind(temp_name,'YACHT & RV',1)!=0 OR
//////////////////////////////////////////////////////////////////////////////////////////////
			StringLib.StringFind(temp_name,'BISHOP OF',1)!=0 OR
		  StringLib.StringFind(temp_name,'CHURCH OF',1)!=0 OR
		  StringLib.StringFind(temp_name,'CITY OF',1)!=0 OR
		  StringLib.StringFind(temp_name,'TOWN OF',1)!=0 OR
			StringLib.StringFind(temp_name,' BEEP OF ',1) != 0 OR
			StringLib.StringFind(temp_name,' LAND RENT',1)!=0 OR
			StringLib.StringFind(temp_name,' P S C',1) != 0 OR
			StringLib.StringFind(temp_name,'DAY CARE',1) != 0 OR
      StringLib.StringFind(temp_name,' & SONS',1)!=0 OR
			StringLib.StringFind(temp_name,'REAL ESTATE',1) != 0 OR
      StringLib.StringFind(temp_name,'OF AMERICA',1) != 0 OR
		  StringLib.StringFind(temp_name,'CHASE BANK',1) != 0 OR
			StringLib.StringFind(temp_name,'CAMP GROUND',1)!=0 OR 
		  StringLib.StringFind(temp_name,'REC ASSN',1)!=0 OR
			StringLib.StringFind(temp_name,'COUNTY OF ',1)!= 0 OR	  	  
	  	StringLib.StringFind(temp_name,'STATE OF ',1)!= 0 OR	  	 
	  	StringLib.StringFind(temp_name,'PROVINCE OF ',1)!= 0 OR
			StringLib.StringFind(temp_name,'REVOCBL TR',1)!=0 OR
		  StringLib.StringFind(temp_name,'REVOCBLE TR',1)!=0 OR
		  StringLib.StringFind(temp_name,'REVOCABLE TR',1)!=0 OR
		  StringLib.StringFind(temp_name,' FISH CAMP ',1)!=0 OR 
		  StringLib.StringFind(temp_name,' REC ARE ',1)!=0 OR
			StringLib.StringFind(temp_name,' AND KNEE',1) != 0 OR
			StringLib.StringFind(temp_name,' AND SONS',1) != 0 OR
			StringLib.StringFind(temp_name,'CHURCH OF ',1) != 0 OR
			StringLib.StringFind(temp_name,'CRESTAR BANK',1) != 0 OR
			StringLib.StringFind(temp_name,'BANK N.A.',1) != 0  OR
		  StringLib.StringFind(temp_name,'BANK NA',1) != 0 OR
		  StringLib.StringFind(temp_name,', N.A.',1)!=0 OR
		  StringLib.StringFind(temp_name,', N. A.',1)!=0 OR
		  StringLib.StringFind(temp_name,',N.A.',1)!=0 OR
		  StringLib.StringFind(temp_name,',N. A.',1)!=0 OR
		  StringLib.StringFind(temp_name,' PSC ',1)!=0 OR
		  StringLib.StringFind(temp_name,' P S C',1)!=0 OR
		  StringLib.StringFind(temp_name,' F S B',1)!=0 OR
		  StringLib.StringFind(temp_name,' U S A ',1)!=0 OR
		  StringLib.StringFind(temp_name,' AND SONS',1)!=0 OR
		  StringLib.StringFind(temp_name,'REVOLUTIONARY',1)!=0 OR
			StringLib.StringFind(temp_name,'PERFORMING ARTS',1) != 0 OR
			StringLib.StringFind(temp_name,'NATIONS BANK',1) != 0 OR
			StringLib.StringFind(temp_name,' NAT\'L ',1) != 0 OR
			StringLib.StringFind(temp_name,'NATURAL GAS',1) != 0 OR
			StringLib.StringFind(temp_name,'LAW FIRM',1) != 0 OR 
			StringLib.StringFind(temp_name,'LAW OFFICES',1) != 0 OR 
		  StringLib.StringFind(temp_name,'1ST BANK',1)!=0 OR
		  StringLib.StringFind(temp_name,'BANK OF',1)!=0 OR
		  StringLib.StringFind(temp_name,'FIRST BANK',1)!=0 OR
		  StringLib.StringFind(temp_name,'2ND BANK',1)!=0 OR
		  StringLib.StringFind(temp_name,'SECOND BANK',1)!=0 OR
			StringLib.StringFind(temp_name,'HOME LIFE',1) != 0 OR
			StringLib.StringFind(temp_name,'FIDELITY BANK',1) != 0 OR
			StringLib.StringFind(temp_name,'CITIZENS BANK',1) != 0 OR
			StringLib.StringFind(temp_name,' REC PARK',1) != 0 OR
			StringLib.StringFind(temp_name,'CHASE MANHATTAN BANK',1) != 0 OR
			StringLib.StringFind(temp_name,'FLEET BANK',1) != 0 OR
      StringLib.StringFind(temp_name,'SECOND BANK',1) != 0 OR
			StringLib.StringFind(temp_name,'STATE BANK',1) != 0 OR
			StringLib.StringFind(temp_name,'STATE OF ',1) != 0 OR
			StringLib.StringFind(temp_name,'TRADE NAME',1) != 0 OR
			StringLib.StringFind(temp_name,'TIRE & RUBBER',1) != 0 OR
			    StringLib.StringFind(temp_name,' FAMILY TRU',1) != 0 OR
          StringLib.StringFind(temp_name,'UNITED STATES',1) != 0 OR
          StringLib.StringFind(temp_name,'WELLS FARGO',1) != 0 OR
					StringLib.StringFind(temp_name,'RESRCH&PRSRVTION',1)!=0 OR
					StringLib.StringFind(temp_name,'BALL BEARINGS',1) != 0 OR
					StringLib.StringFind(temp_name,'BANK ONE',1) != 0 OR
					StringLib.StringFind(temp_name,'WACHOVIA BANK',1) != 0 OR
					StringLib.StringFind(temp_name,'BANK,NA',1) != 0 OR
					StringLib.StringFind(temp_name,'MARLBOROUGH COUNTRY',1) != 0 OR
					stringLib.StringFind(temp_name,'MELLON BANK',1) != 0 OR
				  StringLib.StringFind(temp_name,' U/A ',1)!=0 OR
					StringLib.StringFind(temp_name,' U/A/ ',1)!=0 OR
					StringLib.StringFind(temp_name,' U/A/D',1)!=0 OR
					StringLib.StringFind(temp_name,' U/A/D ',1)!=0 OR
					StringLib.StringFind(temp_name,' U/D ',1)!=0 OR
					StringLib.StringFind(temp_name,' U/D/T ',1)!=0 OR
					StringLib.StringFind(temp_name,' U/I OF',1)!=0 OR
					StringLib.StringFind(temp_name,' U/T/A ',1)!=0 OR
					StringLib.StringFind(temp_name,' U/T/D ',1)!=0 OR
					StringLib.StringFind(temp_name,' UAD ',1)!=0 OR
					StringLib.StringFind(temp_name,' & EQP ',1)!=0 OR
          StringLib.StringFind(temp_name,' & GRINDING',1)!=0 OR
					StringLib.StringFind(temp_name,'NATURES WAY AND TAXIDERMY',1)!=0 OR
					StringLib.StringFind(temp_name,'NEW YORK & NEW JERSEY',1)!=0 OR
					StringLib.StringFind(temp_name,'NURSE FINDERS',1)!=0 OR
					StringLib.StringFind(temp_name,'OPTOMETRISTS',1)!=0 OR
					StringLib.StringFind(temp_name,'P & J ENTERPRISES LLC',1)!=0 OR
					StringLib.StringFind(temp_name,'PACIFIC COUNC',1)!=0 OR
					StringLib.StringFind(temp_name,'PACIFIC COUNCIL',1)!=0 OR
					StringLib.StringFind(temp_name,'PAINT & DECOR',1)!=0 OR
					StringLib.StringFind(temp_name,'PAINT & WALLPAPER',1)!=0 OR
					StringLib.StringFind(temp_name,'PARENTS AND FRIENDS',1)!=0 OR
					StringLib.StringFind(temp_name,'PARK/MARINE',1)!=0 OR
					StringLib.StringFind(temp_name,'PARKS & LAND',1)!=0 OR
					StringLib.StringFind(temp_name,'PARKS & LANDS',1)!=0 OR
					StringLib.StringFind(temp_name,'PARKS & REC',1)!=0 OR
					StringLib.StringFind(temp_name,'PLUMBNG',1)!=0 OR
					StringLib.StringFind(temp_name,'PNTC LDS AND G',1)!=0 OR
					StringLib.StringFind(temp_name,'PORT OF ',1)!=0 OR
					StringLib.StringFind(temp_name,'PRENTICE HALL',1)!=0 OR 
					StringLib.StringFind(temp_name,'PK/MARINA',1)!=0 OR
					StringLib.StringFind(temp_name,'PLACID PRODUCTIO',1)!=0 OR
					StringLib.StringFind(temp_name,'PLEASANT VIEW',1)!=0 OR		
					StringLib.StringFind(temp_name,'PRODUCTS&SERVICE',1)!=0 OR
					StringLib.StringFind(temp_name,'PTRNSHP',1)!=0 OR
					StringLib.StringFind(temp_name,'PULP & PAPER',1)!=0 OR
					StringLib.StringFind(temp_name,'R & R INVESTMETS',1)!=0 OR
					StringLib.StringFind(temp_name,'REC ASSN',1)!=0 OR
					StringLib.StringFind(temp_name,'REED & REED',1)!=0 OR
					StringLib.StringFind(temp_name,'REFINING/DISTRIB',1)!=0 OR
					StringLib.StringFind(temp_name,'RENSSELAER AND POLYTECHNIC',1)!=0 OR			
					StringLib.StringFind(temp_name,'REV LIV TRS',1)!=0 OR
					StringLib.StringFind(temp_name,'REV LIV TRU',1)!=0 OR
					StringLib.StringFind(temp_name,'REV TR',1)!=0 OR
					StringLib.StringFind(temp_name,'REV TRS',1)!=0 OR
					StringLib.StringFind(temp_name,'REV TRST',1)!=0 OR
					StringLib.StringFind(temp_name,'REV TRT',1)!=0 OR
					StringLib.StringFind(temp_name,'REV TRU',1)!=0 OR
					StringLib.StringFind(temp_name,'REV TRUST',1)!=0 OR
					StringLib.StringFind(temp_name,'REV TST',1)!=0 OR
					StringLib.StringFind(temp_name,'REVISED TRU',1)!=0 OR
					StringLib.StringFind(temp_name,'REVOC LIVING',1)!=0 OR
					StringLib.StringFind(temp_name,'REVOC TST',1)!=0 OR
					StringLib.StringFind(temp_name,'REVOCALBE TR',1)!=0 OR
					StringLib.StringFind(temp_name,'REVOCALBE TRUS',1)!=0 OR
					StringLib.StringFind(temp_name,'RIVER BEND ',1)!=0 OR
					StringLib.StringFind(temp_name,'SAILING ',1)!=0 OR
					StringLib.StringFind(temp_name,'SAILING & YACHT',1)!=0 OR
					StringLib.StringFind(temp_name,'SAILS & RI',1)!=0 OR
					StringLib.StringFind(temp_name,'SAINT MARY AND CAPUCHIN ORDER',1)!=0 OR
					StringLib.StringFind(temp_name,'SALES&SERVICE',1)!=0 OR
					StringLib.StringFind(temp_name,'SALES&SRVCE',1)!=0 OR
					StringLib.StringFind(temp_name,'SALVATION ARMY',1)!=0 OR
					StringLib.StringFind(temp_name,'SAND & GRAVEL ',1)!=0 OR
					StringLib.StringFind(temp_name,'SAND AND GRAVEL',1)!=0 OR
					StringLib.StringFind(temp_name,'SARANACAND VLG',1)!=0 OR
					StringLib.StringFind(temp_name,'SCI & FORESTRY',1)!=0 OR
					StringLib.StringFind(temp_name,'SCIENCE&FORESTRY',1)!=0 OR
					StringLib.StringFind(temp_name,'SEARCH & RESCUE',1)!=0 OR
					StringLib.StringFind(temp_name,'SHORE AND JEEP EAGLE',1)!=0 OR
					StringLib.StringFind(temp_name,'SIGNS AND STUFF',1)!=0 OR
					StringLib.StringFind(temp_name,'SKANEATELES MRNA',1)!=0 OR
					StringLib.StringFind(temp_name,'STAIRWAY & MILLWORK',1)!=0 OR
					StringLib.StringFind(temp_name,'THE HOUSE OF',1)!=0 OR
					StringLib.StringFind(temp_name,'THE SOUTHRN PART',1)!=0 OR 
					StringLib.StringFind(temp_name,'TOWING & ROADSIDE',1)!=0 OR 
					StringLib.StringFind(temp_name,'TOWN&COUNTRY MOTORS',1)!=0 OR
					StringLib.StringFind(temp_name,'TRADE-WINDS AND ENVIRONMENTAL',1)!=0 OR
					StringLib.StringFind(temp_name,'TRIBES OF WARM SPRINGS',1)!=0 OR
					StringLib.StringFind(temp_name,'TRILER SVC',1)!=0 OR
					StringLib.StringFind(temp_name,'TTEES OF ',1)!=0 OR
					StringLib.StringFind(temp_name,'US ARMY',1)!=0 OR
					StringLib.StringFind(temp_name,'UTILITY',1)!=0 OR
					StringLib.StringFind(temp_name,'WATER & ELECTRIC',1)!=0 OR
					StringLib.StringFind(temp_name,'WATER & LIGHT',1)!=0 OR
					StringLib.StringFind(temp_name,'WATER & SEWE ',1)!=0 OR
					StringLib.StringFind(temp_name,'WATER SHOWS',1)!=0 OR
					StringLib.StringFind(temp_name,'WATER/ELECTRIC',1)!=0 OR
					StringLib.StringFind(temp_name,'WOODS & WATERS',1)!=0 OR
					//StringLib.StringFind(temp_name,'YACHT ',1)!=0 OR
					StringLib.StringFind(temp_name,'YACHT & RV',1)!=0 OR
/////////////////////////////////////////////////////////////////////////////////////////////////	
					regexfind('( WORLD$|^WORLD |^U OF |,PC$|^NAT L |^GROUP | GROUP$| FNB$|,FNB$|^FIRE | FIRE$| CHURCH$|^SKIFFS | SKIFFS |^OUTBOARD | OUTBOARD |'+
		' OUTFITTER|OUTFITTERS |^OUTFITTER|^OUTFITTERS|^MUTUAL | MUTUAL |ADVENTURES|EXPEDITION|EXCURSION|EXTINGUISHER|'+
		'^PERFORMANCE | PERFORMANCE | PROFITEERS |RIVER BEND |RIVERBEND | FACILITY |^FACILITY |'+
		'^MARINE |^IMPORT | IMPORT|^IMPORTS | IMPORTS|^[1-9]|^FIRST |^SECOND |^THIRD )',temp_name) //or 				
					          //StringLib.StringFind(temp_name,' THE ',1)!=0 
					          , 'Y' , ' ');

				return  if(trim(v_bus_name_flag,left,right)='',0 , 1);
			end;
/*					regexfind('(FIRM$| INC$| WORLD$|^WORLD |BUREAU$|^U OF |^UNIV |^TOWN |^SECOND| SALES$|'+ 
					'^PARTNERS | PC$|,PC$|^NAT L |^NATL | MOTEL$|^MEDICAL | LP$| MARKET$|'+
					'^LANDFILL | LANDFILL$| INN$| HUNTING$| HEALTH$| GYM$|^GROUP | GROUP$| GAZETTE$|'+
					' FLYING$| FNB$|,FNB$|^FIRE | FIRE$|^FIRST |^CITY | CHURCH$| CHAPTER$|^CHAPTER |'+
					' CENTER$|^CENTER |BUREAU$|^BOAT |^BOATS |^YACHTS |,INC$|'+
					' INC$|^SEA | SEA | FUND |^SKIFFS | SKIFFS |^OUTBOARD | OUTBOARD |^LAKE |'+
					' LAKE |^PARK |^[1-9]|^FIRST|^SECOND|^THIRD|^CREDIT |^FNB |'+
					'^ADVENTURES | ^ISLAND |^ISLANDS|^SPORT |^SPORTS |^BROTHERS | OUTFITTER|OUTFITTERS |'+
					'^OUTFITTER|^OUTFITTERS|^MUTUAL | MUTUAL |ADVENTURES|EXPEDITION|EXCURSION|EXTINGUISHER|'+
					'^PERFORMANCE | PERFORMANCE | PROFITEERS |RIVER BEND |RIVERBEND | FACILITY |^FACILITY |'+
					'^MARINE | HARBOR |^IMPORT | IMPORT|^IMPORTS | IMPORTS| ISLAND| ISLANDS|'+  //MARINE |
					'^ISLAND|^ISLANDS|^CAMPGD |^CAMPGROUND|^AUTHORITY )',temp_name)*/


export fn_dateMMMDDYYYY(string pdate) := function
	findMonth 	:= MAP(regexfind('JAN',trim(StringLib.StringToUpperCase(pdate),left,right)[1..3],0)<>'' and regexfind('\\/', trim(pdate,left,right)[4],0)='' => '01',
							regexfind('FEB',trim(StringLib.StringToUpperCase(pdate),left,right)[1..3],0)<>'' and regexfind('\\/', trim(pdate,left,right)[4],0)='' => '02',
							regexfind('MAR',trim(StringLib.StringToUpperCase(pdate),left,right)[1..3],0)<>'' and regexfind('\\/', trim(pdate,left,right)[4],0)='' => '03',
							regexfind('APR',trim(StringLib.StringToUpperCase(pdate),left,right)[1..3],0)<>'' and regexfind('\\/', trim(pdate,left,right)[4],0)='' => '04',
							regexfind('MAY',trim(StringLib.StringToUpperCase(pdate),left,right)[1..3],0)<>'' and regexfind('\\/', trim(pdate,left,right)[4],0)='' => '05',
							regexfind('JUN',trim(StringLib.StringToUpperCase(pdate),left,right)[1..3],0)<>'' and regexfind('\\/', trim(pdate,left,right)[4],0)='' => '06',
							regexfind('JUL',trim(StringLib.StringToUpperCase(pdate),left,right)[1..3],0)<>'' and regexfind('\\/', trim(pdate,left,right)[4],0)='' => '07',
							regexfind('AUG',trim(StringLib.StringToUpperCase(pdate),left,right)[1..3],0)<>'' and regexfind('\\/', trim(pdate,left,right)[4],0)='' => '08',
							regexfind('SEP',trim(StringLib.StringToUpperCase(pdate),left,right)[1..3],0)<>'' and regexfind('\\/', trim(pdate,left,right)[4],0)='' => '09',
							regexfind('OCT',trim(StringLib.StringToUpperCase(pdate),left,right)[1..3],0)<>'' and regexfind('\\/', trim(pdate,left,right)[4],0)='' => '10',
							regexfind('NOV',trim(StringLib.StringToUpperCase(pdate),left,right)[1..3],0)<>'' and regexfind('\\/', trim(pdate,left,right)[4],0)='' => '11',
							regexfind('DEC',trim(StringLib.StringToUpperCase(pdate),left,right)[1..3],0)<>'' and regexfind('\\/', trim(pdate,left,right)[4],0)='' => '12',
							regexfind('JAN',trim(StringLib.StringToUpperCase(pdate),left,right)[5..7],0)<>'' and regexfind('\\/', trim(pdate,left,right)[4],0)<>'' => '01',
							regexfind('FEB',trim(StringLib.StringToUpperCase(pdate),left,right)[5..7],0)<>'' and regexfind('\\/', trim(pdate,left,right)[4],0)<>'' => '02',
							regexfind('MAR',trim(StringLib.StringToUpperCase(pdate),left,right)[5..7],0)<>'' and regexfind('\\/', trim(pdate,left,right)[4],0)<>'' => '03',
							regexfind('APR',trim(StringLib.StringToUpperCase(pdate),left,right)[5..7],0)<>'' and regexfind('\\/', trim(pdate,left,right)[4],0)<>'' => '04',
							regexfind('MAY',trim(StringLib.StringToUpperCase(pdate),left,right)[5..7],0)<>'' and regexfind('\\/', trim(pdate,left,right)[4],0)<>'' => '05',
							regexfind('JUN',trim(StringLib.StringToUpperCase(pdate),left,right)[5..7],0)<>'' and regexfind('\\/', trim(pdate,left,right)[4],0)<>'' => '06',
							regexfind('JUL',trim(StringLib.StringToUpperCase(pdate),left,right)[5..7],0)<>'' and regexfind('\\/', trim(pdate,left,right)[4],0)<>'' => '07',
							regexfind('AUG',trim(StringLib.StringToUpperCase(pdate),left,right)[5..7],0)<>'' and regexfind('\\/', trim(pdate,left,right)[4],0)<>'' => '08',
							regexfind('SEP',trim(StringLib.StringToUpperCase(pdate),left,right)[5..7],0)<>'' and regexfind('\\/', trim(pdate,left,right)[4],0)<>'' => '09',
							regexfind('OCT',trim(StringLib.StringToUpperCase(pdate),left,right)[5..7],0)<>'' and regexfind('\\/', trim(pdate,left,right)[4],0)<>'' => '10',
							regexfind('NOV',trim(StringLib.StringToUpperCase(pdate),left,right)[5..7],0)<>'' and regexfind('\\/', trim(pdate,left,right)[4],0)<>'' => '11',
							regexfind('DEC',trim(StringLib.StringToUpperCase(pdate),left,right)[5..7],0)<>'' and regexfind('\\/', trim(pdate,left,right)[4],0)<>'' => '12',
							'');

	findDay		:= if(length(trim(pdate[stringlib.stringfind(pdate, ' ', 1)..stringlib.stringfind(pdate, ',', 1)-1], left, right))=1,
						'0'+trim(pdate[stringlib.stringfind(pdate, ' ', 1)..stringlib.stringfind(pdate, ',', 1)-1], left, right),
					if(length(trim(pdate[stringlib.stringfind(pdate, ' ', 1)..stringlib.stringfind(pdate, ',', 1)-1], left, right))=2,
						trim(pdate[stringlib.stringfind(pdate, ' ', 1)..stringlib.stringfind(pdate, ',', 1)-1], left, right),
						''));
					
	findYear	:= if(length(trim(pdate[length(pdate)-3..length(pdate)], left, right))=4 and trim(pdate[length(pdate)-3..length(pdate)-2], left, right) in ['19', '20'],
						trim(pdate[length(pdate)-3..length(pdate)], left, right),
						'');
						
	return findYear+findMonth+findDay;
end;
export fn_standarddize_race(string race) := function
  inputrace := stringlib.stringtouppercase(trim(race));
	
  stdrace := MAP(inputrace='A' => 'ASIAN/PACIFIC ISLAND',
                inputrace IN ['[ASIAN OR AMERICAN NA','AMERASIAN','ASIAN/ORTL','PACIFIC ISLANDER/HAW','PACIFIC ISLANDER','NATIVE HAWAIIAN OR P','VIETNAMESE',
								              'FLIPINO','PHILLIPINO', 'ASIAN/CHINESE/JAPANE','ORIENTAL','ORNENTAL','PACIFIC ISLANDE','CHINESE','JAPANESE'] =>  'ASIAN/PACIFIC ISLAND',
								inputrace in ['B','BB','B]','AF/AMERICAN','BK','GLACK'] => 'BLACK',
								inputrace[1..3] IN ['AFR','BLA','BLC','BLK','BAL'] => 'BLACK',
								inputrace in ['HISP/BLACK'] => 'HISPANIC BLACK',
								inputrace      ='H' => 'HISPANIC',
								inputrace[1..3]IN ['HIS','MEX']=> 'HISPANIC',
								inputrace IN ['SPANISH OR HISPANIC'] => 'HISPANIC',
								inputrace[1..2]='LA' => 'HISPANIC',
								inputrace      ='L' => 'HISPANIC',								
								inputrace in ['NATIVE INDIAN','AM. INDIAN','NATIVE AMER.','NAT AM/ALASKAN','NA INDIAN','INDAM','AMIND','I','AMER.IND.',
								               'AMER. IND','NATIVE AMERICAN','AMERICAN NATIVE','AMERICAN INDIAN OR P','AMERICAN I',
															 'AMER INDIAN','AM INDIAN','ALASKAN NATIVE',
								               'INDIAN','INDIAN (NATIVE AMERI'] => 'AMER INDIAN/ALASKAN',								
								inputrace='W' => 'WHITE',
								inputrace='MULTI-RACIAL OR OTHE' => 'MIXED',
								inputrace[1..3]='WHI' => 'WHITE',
								inputrace in ['EUROPEAN/N.AM./AUSTR','FRENCH','W`','W/NH','WGHITE','WH ITE','WHI','WH','.W',']W','WW','WWHITE',';WHITE','W.','WGHITE','WH ITE','WHI',
								                 'WHITE/S S A','WHITEE','WHITRE','WHITYE','WHIUTE','WHJITE','WHOITE','WHIT','WHIT E','WHITE',
																 'WHT','WHTIE','WHYITE','WITE','WJITE','WM','WW','WWHITE','W\\H','WHI TE','WHIE','WHIRE'] => 'WHITE',
                inputrace in ['ARAB','ARABIC'] => 'MIDDLE EASTERN',              

								inputrace='AMER INDIAN/ALASKAN' => 'AMER INDIAN/ALASKAN', 
								inputrace='AMERICAN INDIAN OR A' => 'AMER INDIAN/ALASKAN',
								inputrace='AMER IND' => 'AMER INDIAN/ALASKAN',            
								inputrace='AMER INDIAN/ALASKAN' => 'AMER INDIAN/ALASKAN', 
								inputrace='AMERICAN INDIAN' => 'AMER INDIAN/ALASKAN',     
								inputrace='AMERICAN INDIAN / AL' => 'AMER INDIAN/ALASKAN',
								inputrace='AMERICAN INDIAN OR A' => 'AMER INDIAN/ALASKAN',
								inputrace='AMERICAN INDIAN/ALAS' => 'AMER INDIAN/ALASKAN',
								inputrace='ASIAN' => 'ASIAN/PACIFIC ISLAND',
								inputrace='ASIAN OR PACIFIC ISL' => 'ASIAN/PACIFIC ISLAND',
								inputrace='ASIAN/PACIFIC ISLAND' => 'ASIAN/PACIFIC ISLAND',
								inputrace='ASIAN OR PACIFIC ISL' => 'ASIAN/PACIFIC ISLAND',
								inputrace='ASIAN/PAC.ISLD' => 'ASIAN/PACIFIC ISLAND',      
								inputrace='ASIAN/PACIFIC ISLAND' => 'ASIAN/PACIFIC ISLAND',
								inputrace='BLACK' => 'BLACK',
								inputrace='BLACK OR AFRICAN AME' => 'BLACK',
								inputrace='AFRICAN AMERICAN' => 'BLACK',
								inputrace='CAUCASIAN' => 'WHITE',
								inputrace='WHITE/CAUCASIAN' => 'WHITE',
								length(inputrace)>3 and regexfind('[0-9]',race,0)='' and 
								inputrace not in ['RACE','MALE','OTHER OR UNKNOWN','ALL OTHERS','OTHER','NULL','UNKWN',
								                   'ALL OTHERS/UNKNOWN','UNKNOWN','BUSINESS','MISSING','INACTIVE','UNASSIGNED',
																	 'ACTIVE'] => inputrace,
								'');
return stdrace;

end;

export fn_standardize_haircolor(string haircolor) := function
  stdhair := map(
                 haircolor='B' => '',
								 haircolor='BLACK' => 'BLACK',
								 haircolor in ['WHT','WHITE','WHI','W'] => 'WHITE',
								 haircolor in ['TOTAL BALD','BLD','BAL','BALD'] => 'BALD',
								 haircolor in ['BLK','BLA','BLC'] => 'BLACK',
								 haircolor in ['BLN','BLOND','BLO','BLONDE'] => 'BLOND',
								 haircolor in ['STRAWBERRY','BLONDE OR','BLOND, STR','BLOND/STRA','BLONDE/STR','BLOND OR S'] => 'BLOND OR STRAWBERRY',
		  					 haircolor='BLU' => 'BLUE',
								 haircolor='BLUE' => 'BLUE',
								 haircolor IN ['BROWN','BR0','BRO','BRN','BR'] => 'BROWN',
								 haircolor IN ['LBR'] => 'LIGHT BROWN',
								 haircolor IN ['DBR'] => 'DARK BROWN',
								 haircolor in ['GRAY','GRA'] => 'GRAY',
								 haircolor in ['BL/G/SILVE','GRAY, ETC.','SALT & PEP','SALT AND P','SALT/PEPPR','PARTIAL GR','PARTIALLY','GRAY/PARTI','GRAY OR PA','BR/G/SILVE'] => 'GRAY OR PARTIALLY GRAY',
								 haircolor in ['GRY','GREY'] => 'GRAY',
								 haircolor in ['GRN','GRE','GREEN'] => 'GREEN',
								 haircolor='H' => '',
								 haircolor in ['HAZ','HZL','HAZEL','HZL'] => 'HAZEL',
								 haircolor='LT BLOND' => 'LT BLOND',
								 haircolor in ['MUL','MULT','MIX','MIXED'] => 'MULTIPLE',
								 haircolor IN ['RED','RD'] => 'RED',
								 haircolor in ['RED, AUBUR','RED/AUBURN','RED OR AUB','AUB','AUBURN'] => 'RED OR AUBURN',
								 haircolor in ['SANDY','SDY','SND','SNY'] => 'SANDY',
								 haircolor in ['PNK','PINK']=> 'PINK',
								 haircolor<>'' and regexfind('[0-9]',haircolor) => '',
								 haircolor<>'' and length(trim(haircolor)) >3 and 
								 haircolor not in ['UNKNOWN','UNKNOWN OR','OTHER']=>haircolor ,'');
return stdhair;

end;

export fn_standardize_eyecolor(string eyecolor) := function
  stdeye := map(eyecolor='1' => '',
								 eyecolor='2' => '',
								 eyecolor='BLACK' => 'BLACK',
								 eyecolor='BLK' => 'BLACK',
								 eyecolor='BLA' => 'BLACK',
								 eyecolor='BLN' => '',
								 eyecolor='BLO' => '',
								 eyecolor='BLU' => 'BLUE',
								 eyecolor='BLUE' => 'BLUE',
								 eyecolor='BRN' => 'BROWN', 
								 eyecolor='BRO' => 'BROWN',
								 eyecolor='BROWN' => 'BROWN',
								 eyecolor in ['GREEN','GRN'] => 'GREEN',
								 eyecolor in ['GREY','GRAY','GRY','GRA'] => 'GRAY',
								 eyecolor in ['HAZ','HZL','HAZEL'] => 'HAZEL',
								 eyecolor in ['MULTI-COLO','MULTIPLE C','MULTICOLOR'] => 'MIXED',
								 eyecolor in ['PNK','PINK']=> 'PINK',
								 eyecolor='RED' => 'RED',
								 eyecolor='UNKNOWN' => '',
								 eyecolor<>'' and regexfind('[0-9]',eyecolor) => '',
								 eyecolor<>'' and length(trim(eyecolor)) >3 and 
								 eyecolor not in ['NOT REPORT','UNKNOWN OR','OTHER'] =>eyecolor ,
								 '');
								 
return stdeye;

end;

export fn_height_to_inches(string pheight) := function
	idx_quote := stringlib.stringfind(pheight,'"',1);
		idx_inches := MAP(stringlib.stringfind(stringlib.StringToUpperCase(pheight),'IN',1) > 0  => 1,
	                  stringlib.stringfind(pheight,'\'',1) >0 =>1,
										0);
	inches := if(idx_quote<>0 or idx_inches<>0,
					(integer)pheight[1..1]*12 + (integer) stringlib.stringfilter(pheight[3..],'0123456789'),
					0);	
	return if(inches>36 and inches<96, intformat(inches,3,1),'');
end;

export fn_offender_key(string2 pvendor, string precordid, string pcaseid, string pfileddate) := function
  cln_recordid := MAP(regexfind('DOCPAR',precordid) => 'H'+'R'+precordid[9..],
                      regexfind('DOCPRO',precordid) => 'H'+'B'+precordid[9..],
										  regexfind('DOCALT',precordid) => 'H'+'A'+precordid[9..],
										  regexfind('DOC',precordid)    => 'H'+'D'+precordid[6..],
											regexfind('PAR',precordid)    => 'H'+'R'+precordid[6..],
											'HD'+precordid
										);
										
	voffender_key:=trim(trim(trim(pvendor)+trim(cln_recordid)+IF(pcaseid<> '',pcaseid, ' '))+IF(length(trim(pfileddate,left,right))>=4 and trim(pfileddate,left)[1..2] in ['19','20'], pfileddate, ''));
	return voffender_key;
end;

export fn_choose_def_number (string2 pstatecode, string precordid, string pstateidnumber, string pdocnumber, string pinmatenumber) := function
cln_docnum := MAP( regexfind('[1-9]',pdocnumber) => pdocnumber,
                   '');
cln_recordid := MAP(regexfind('DOCPAR',precordid) => precordid[9..],
                    regexfind('DOCPRO',precordid) => precordid[9..],
										regexfind('DOCALT',precordid) => precordid[9..],
										precordid[6..]
										);
cln_stateid  := MAP(pstateidnumber ='R000' => '',
                    pstateidnumber);
def_number := MAP( pstatecode = 'NJ' => cln_recordid,
                   pstatecode ='TX' and cln_stateid <> '' => cln_stateid,	
									 pstatecode ='KY' and cln_stateid <> '' => cln_stateid,	
									 cln_docnum[1..3]='000' and regexfind('[1-9]',cln_docnum) => cln_docnum[4..],
                   cln_docnum  <> ''      and regexfind('[1-9]',cln_docnum) => cln_docnum,
									 pinmatenumber[1..3]='000' and regexfind('[1-9]',pinmatenumber) => pinmatenumber[4..],
	                 pinmatenumber  <> ''      and regexfind('[1-9]',pinmatenumber) => pinmatenumber,
									 cln_stateid <> '' and  
									 regexfind('[1-9]',cln_stateid) and
									 regexreplace('-',cln_stateid,'') <> '' and 
									 regexreplace('-',cln_stateid,'') <> '0' => trim(regexreplace('-',cln_stateid,''),left,right),
									 cln_recordid
	                )	;
	return trim(def_number);
end;
export fn_offender_key_Alternate(string source, string IDS, string DOB) := function
  ls_source := regexreplace('DOC',
	             regexreplace('WA_DC_DOC',
	             regexreplace('DOC_PROB',
							 regexreplace('DOC_ALT',
	             regexreplace('DOC_PAROLE',source,'DR'),'DA'),'DB'),'DC_DO'),'DO');
	voffender_key:=trim('H'+trim(ls_source[1..2])+trim(ls_source[4..])+trim(IDS)+trim(DOB),all);
	return voffender_key;
end;

export fn_shorten_sourcename(string psourcename) := function
		result1 :=  regexreplace('ARRESTS',
					regexreplace('COUNTY',
					regexreplace('CIRCUIT_COURTS',
					regexreplace('TRAFFIC_COURT',
					regexreplace('MUNICIPAL_COURT',
					regexreplace('MUNICIPAL_TRAFFIC_COURT',
					//regexreplace('BROWN_MUNICIPAL',	
					regexreplace('DEPARTMENT_OF_CORRECTIONS',
					regexreplace('DEPARTMENT_OF_CORRECTIONS_PROBATION',
					regexreplace('DEPARTMENT_OF_CORRECTIONS_PAROLE',	
					regexreplace('DEPARTMENT_OF_CORRECTIONS_ALTERNATE',
					regexreplace('DEPARTMENT_OF_CORRECTIONS_ALTERNATE_FILE',
					regexreplace('ADMINISTRATOR_OF_THE_COURTS',psourcename,'AOC'),'DOC_ALT'),'DOC_ALT'),'DOC_PAROLE'),'DOC_PROB'),'DOC'),'MTC'),'MC'),'TC'),'CRC'),'CTY'),'ARR');
	space_count := 
	if(stringlib.stringfind(psourcename,'NEW_YORK',1)<>0 or
	   stringlib.stringfind(psourcename,'NEW_JERSEY',1)<>0 or
		 stringlib.stringfind(psourcename,'NEW_HAMPSHIRE',1)<>0 or
	   stringlib.stringfind(psourcename,'WEST_VIRGINIA',1)<>0 or
	   stringlib.stringfind(psourcename,'NORTH_CAROLINA',1)<>0 or
	   stringlib.stringfind(psourcename,'SOUTH_CAROLINA',1)<>0 or
	   stringlib.stringfind(psourcename,'NORTH_DAKOTA',1)<>0 or
	   stringlib.stringfind(psourcename,'SOUTH_DAKOTA',1)<>0 or
		 stringlib.stringfind(psourcename,'RHODE_ISLAND',1)<>0 or
	   stringlib.stringfind(psourcename,'NEW_MEXICO',1)<>0 ,2, 1);
	state_end :=  stringlib.stringfind(psourcename,'_',space_count)-1;
	
	state_name := regexreplace('_', psourcename[1..state_end], ' ');
	state_name2 := psourcename[1..state_end];
	state_abbrev := ut.st2abbrev(state_name);
	result2 := if(state_abbrev<>'', regexreplace(state_name2, result1, state_abbrev),result1);
	
	result3 := MAP(psourcename = 'ARIZONA_MARICOPA_COUNTY_GILBERT_MUNICIPAL_COURT'   => 'AZMARICOP_GILBRT_MC',
	               psourcename = 'CALIFORNIA_RIVERSIDE_COUNTY_CITY_OF_INDIO'         => 'CA_RIVERSIDE_INDIO',
								 psourcename = 'CALIFORNIA_SAN_BERNARDINO_COUNTY'                  => 'CA_SAN_BERNARDINOCTY',
								 psourcename = 'OHIO_ALLEN_COUNTY_LIMA_MUNICIPAL_COURT'            => 'OH_ALLEN_CTY_LIMA_MC',                                                               
								 psourcename = 'OHIO_SUMMIT_COUNTY_CUYAHOGA_FALLS_MUNICIPAL_COURT'  => 'OHSUMCUYAHOGA_FLS_MC',                                                    
								 psourcename = 'OHIO_MONTGOMERY_COUNTY_DAYTON_MUNICIPAL_COURT'     => 'OHMONTGOMRY_DAYTN_MC',                                                        
								 psourcename = 'OHIO_WARREN_COUNTY_MASON_MUNICIPAL_COURT'          => 'OH_WARREN_MASON_MC',                                                             
								 psourcename = 'OHIO_FRANKLIN_COUNTY_MUNICIPAL_COURT'              => 'OH_FRANKLIN_CTY_MC',  
								 psourcename = 'OHIO_LAWRENCE_COUNTY_MUNICIPAL_COURT'              => 'OH_LAWRENCE_CTY_MC',
								 psourcename = 'OHIO_GREENE_COUNTY_XENIA_MUNICIPAL_COURT'          => 'OH_GREENE_XENIA_MC',
								 psourcename = 'OHIO_SUMMIT_COUNTY_BARBERTON_MUNICIPAL_COURT'      => 'OH_SUMM_BARBERTON_MC',                                                         
								 psourcename = 'OHIO_ROSS_COUNTY_CHILLICOTHE_MUNICIPAL_COURT'      => 'OH_ROS_CHILICOTHE_MC',                                                         
								 psourcename = 'OHIO_CUYAHOGA_COUNTY_EUCLID_MUNICIPAL_COURT'       => 'OH_CUYHOGA_EUCLID_MC',                                                          
								 psourcename = 'OHIO_TRUMBULL_COUNTY_NEWTON_FALLS_MUNICIPAL_COURT' => 'OHTRMBULL_NEWTNFLSMC',                                                    
								 psourcename = 'OHIO_MONTGOMERY_COUNTY_VANDALIA_MUNICIPAL_COURT'   => 'OHMNTGMRY_VANDALIAMC',                                                      
								 psourcename = 'OHIO_SUMMIT_COUNTY_AKRON_MUNICIPAL_COURT'          => 'OH_SUMMIT_AKRON_MC',                                                             
								 psourcename = 'OHIO_STARK_COUNTY_COMMON_PLEAS_COURT'              => 'OH_STARK_CTY_CP',                                                                 
								 psourcename = 'OHIO_MONTGOMERY_COUNTY_NEW_LEBANON_COUNTY_COURT'   => 'OHMNGMRY_N_LEBNON_CC',                                                      
								 psourcename = 'OHIO_CUYAHOGA_COUNTY_BEREA_MUNICIPAL_COURT'        => 'OH_CUYHOGA_BEREA_MC',                                                           
								 psourcename = 'OHIO_MONTGOMERY_COUNTY_HUBER_HEIGHTS_COUNTY_COURT' => 'OH_MNGMRY_HUBRHTS_CC',                                                    
								 psourcename = 'OHIO_MONTGOMERY_COUNTY_KETTERING_MUNICIPAL_COURT'  => 'OH_MNGMRY_KETERIN_MC',                                                     
								 psourcename = 'OHIO_ATHENS_COUNTY_ATHENS_MUNICIPAL_COURT'         => 'OH_ATHENS_CTY_MC',                                                            
								 psourcename = 'OHIO_BROWN_COUNTY_BROWN_MUNICIPAL_COURT'           => 'OH_BROWN_CTY_MC', 
	               result2);
	return result3;
end;

export fn_sourcename_to_vendor(string psourcename, string2 statecode ) := function
string2 vendor := 
map(
 //AOC	
	psourcename = 'ARIZONA_ADMINISTRATOR_OF_THE_COURTS' 				=> 'Z1',
	psourcename = 'ALASKA_ADMINISTRATOR_OF_THE_COURTS' 					=> 'AD',
	psourcename = 'ARKANSAS_ADMINISTRATOR_OF_THE_COURTS' 				=> 'AE',
	psourcename = 'CONNECTICUT_ADMINISTRATOR_OF_THE_COURTS' 			=> 'CP',
	psourcename = 'FLORIDA_ADMINISTRATOR_OF_THE_COURTS' 				=> 'FV',
	psourcename = 'GEORGIA_BUREAU_OF_INVESTIGATION' 					=> 'GD',
	psourcename = 'HAWAII_STATE_JUDICIARY' 								=> 'HA',
	psourcename = 'INDIANA_ADMINISTRATOR_OF_THE_COURTS' 				=> 'ID',
	psourcename = 'IOWA_ADMINISTRATOR_OF_THE_COURTS' 					=> 'IC',
	psourcename = 'MARYLAND_ADMINISTRATOR_OF_THE_COURTS' 				=> 'MF',
	psourcename = 'MINNESOTA_DEPARTMENT_OF_PUBLIC_SAFETY' 				=> 'MH',
	psourcename = 'MISSOURI_ADMINISTRATOR_OF_THE_COURTS' 				=> 'MG',
	psourcename = 'NEW_JERSEY_ADMINISTRATOR_OF_THE_COURTS' 				=> 'NA',
	psourcename = 'NEW_MEXICO_ADMINISTRATOR_OF_THE_COURTS' 				=> 'NB',
	psourcename = 'NORTH_CAROLINA_ADMINISTRATIVE_OFFICE_OF_THE_COURTS' 	=> 'NF',
	psourcename = 'NORTH_DAKOTA_ADMINISTRATOR_OF_THE_COURTS' 			=> 'NG',
	psourcename = 'OKLAHOMA_ADMINISTRATOR_OF_THE_COURTS' 				=> 'PS',
	psourcename = 'OREGON_ADMINISTRATOR_OF_THE_COURTS' 					=> 'PT',
	psourcename = 'PENNSYLVANIA_ADMINISTRATOR_OF_THE_COURTS' 			=> 'PU',
	psourcename = 'PENNSYLVANIA_ADMINISTRATOR_OF_THE_COURTS_COURT_OF_COMMON_PLEAS' => 'PV',
	psourcename = 'RHODE_ISLAND_ADMINISTRATOR_OF_THE_COURTS' 			=> 'RA',
	psourcename = 'RHODE_ISLAND_ADMINISTRATOR_OF_THE_COURTS_TRAFFIC' 	=> 'RB',
	psourcename = 'TEXAS_DEPARTMENT_OF_PUBLIC_SAFETY' 					=> 'TB',
	psourcename = 'TENNESSEE_ADMINISTRATOR_OF_THE_COURTS' 				=> 'TA',
	psourcename = 'UTAH_ADMINISTRATOR_OF_THE_COURTS' 					=> 'UA',
	psourcename = 'VIRGINIA_ADMINISTRATOR_OF_THE_COURTS' 				=> 'VB',
	psourcename = 'WISCONSIN_ADMINISTRATOR_OF_THE_COURTS' 				=> 'WB',
 /**************************************************************/	
 //DOC	
	//stringlib.stringfind(psourcename,'DEPARTMENT_OF_CORRECTIONS',1) >0 	=> statecode,
	psourcename = 'ALABAMA_DEPARTMENT_OF_CORRECTIONS' 								=> 'DA',
	psourcename = 'MICHIGAN_DEPARTMENT_OF_CORRECTIONS_ALTERNATE_FILE' => 'DB',
	psourcename = 'IDAHO_DEPARTMENT_OF_CORRECTIONS' 									=> 'DD',
	psourcename = 'MAINE_DEPARTMENT_OF_CORRECTIONS' 									=> 'DE',
	psourcename = 'FLORIDA_DEPARTMENT_OF_CORRECTIONS' 								=> 'DF',
	psourcename = 'MICHIGAN_DEPARTMENT_OF_CORRECTIONS' 								=> 'DG',
	psourcename = 'HAWAII_DEPARTMENT_OF_CORRECTIONS' 									=> 'DH',
	psourcename = 'IOWA_DEPARTMENT_OF_CORRECTIONS' 										=> 'DI',
	psourcename = 'MONTANA_DEPARTMENT_OF_CORRECTIONS' 								=> 'DJ',
	psourcename = 'KANSAS_DEPARTMENT_OF_CORRECTIONS' 									=> 'DK',
	psourcename = 'NORTH_CAROLINA_DEPARTMENT_OF_CORRECTIONS' 					=> 'DL',
	psourcename = 'MARYLAND_DEPARTMENT_OF_CORRECTIONS' 								=> 'DM',
	psourcename = 'INDIANA_DEPARTMENT_OF_CORRECTIONS' 								=> 'DN',
	psourcename = 'COLORADO_DEPARTMENT_OF_CORRECTIONS' 								=> 'DO',
	psourcename = 'MISSISSIPPI_DEPARTMENT_OF_CORRECTIONS' 						=> 'DP',
	psourcename = 'ARKANSAS_DEPARTMENT_OF_CORRECTIONS' 								=> 'DQ',
	psourcename = 'GEORGIA_DEPARTMENT_OF_CORRECTIONS' 								=> 'DR',
	psourcename = 'MINNESOTA_DEPARTMENT_OF_CORRECTIONS' 							=> 'DS',
	psourcename = 'CONNECTICUT_DEPARTMENT_OF_CORRECTIONS' 						=> 'DT',
	psourcename = 'MISSOURI_DEPARTMENT_OF_CORRECTIONS' 								=> 'DU',
	psourcename = 'KENTUCKY_DEPARTMENT_OF_CORRECTIONS' 								=> 'DV',
	psourcename = 'NORTH_DAKOTA_DEPARTMENT_OF_CORRECTIONS' 						=> 'DW',
	psourcename = 'NEBRASKA_DEPARTMENT_OF_CORRECTIONS' 								=> 'DX',
	psourcename = 'NEW_HAMPSHIRE_DEPARTMENT_OF_CORRECTIONS' 					=> 'DY',
	psourcename = 'ARIZONA_DEPARTMENT_OF_CORRECTIONS' 								=> 'DZ',
	psourcename = 'GEORGIA_PAROLE' 																		=> 'GP',
	psourcename = 'IOWA_DEPARTMENT_OF_CORRECTIONS_PROBATION' 					=> 'IP',
	psourcename = 'LOUISIANA_DEPARTMENT_OF_CORRECTIONS_PAROLE' 				=> 'LP',
	psourcename = 'NEW_JERSEY_DEPARTMENT_OF_CORRECTIONS' 							=> 'EA',
	psourcename = 'NEW_MEXICO_DEPARTMENT_OF_CORRECTIONS' 							=> 'EB',
	psourcename = 'NEVADA_DEPARTMENT_OF_CORRECTIONS' 									=> 'EC',
	psourcename = 'NEW_YORK_DEPARTMENT_OF_CORRECTIONS' 								=> 'ED',
	psourcename = 'OHIO_DEPARTMENT_OF_CORRECTIONS' 										=> 'EE',
	psourcename = 'OKLAHOMA_DEPARTMENT_OF_CORRECTIONS' 								=> 'EF',
	psourcename = 'OREGON_DEPARTMENT_OF_CORRECTIONS' 									=> 'EG',
	psourcename = 'PENNSYLVANIA_DEPARTMENT_OF_CORRECTIONS' 						=> 'EH',
	psourcename = 'RHODE_ISLAND_DEPARTMENT_OF_CORRECTIONS' 						=> 'EI',
	psourcename = 'SOUTH_CAROLINA_DEPARTMENT_OF_CORRECTIONS' 					=> 'EJ',
	psourcename = 'TENNESSEE_DEPARTMENT_OF_CORRECTIONS' 							=> 'EK',
	psourcename = 'TEXAS_DEPARTMENT_OF_CORRECTIONS' 									=> 'EL',
	psourcename = 'UTAH_DEPARTMENT_OF_CORRECTIONS' 										=> 'EM',
	psourcename = 'VIRGINIA_DEPARTMENT_OF_CORRECTIONS' 								=> 'EN',
	psourcename = 'VERMONT_DEPARTMENT_OF_CORRECTIONS' 								=> 'EO',
	psourcename = 'WASHINGTON_DEPARTMENT_OF_CORRECTIONS' 							=> 'EP',
	psourcename = 'WASHINGTON_DC_DEPARTMENT_OF_CORRECTIONS' 					=> 'EQ',
	psourcename = 'WISCONSIN_DEPARTMENT_OF_CORRECTIONS' 							=> 'ER',
	psourcename = 'WEST_VIRGINIA_DEPARTMENT_OF_CORRECTIONS' 					=> 'ES',
	psourcename = 'WEST_VIRGINIA_DEPARTMENT_OF_CORRECTIONS_ALTERNATE' => 'ET',
	
 /**************************************************************/
 //County
	psourcename = 'ARIZONA_MARICOPA_COUNTY_GILBERT_MUNICIPAL_COURT' 	=> 'AA',                                                     
	psourcename = 'ARIZONA_MARICOPA_COUNTY' 							=> 'AB',                                                                              
	psourcename = 'ARIZONA_PIMA_COUNTY' 								=> 'AC',                                                                                  
	psourcename = 'CALIFORNIA_MARIN_COUNTY' 							=> 'CB',                                                                              
	psourcename = 'CALIFORNIA_RIVERSIDE_COUNTY_CITY_OF_INDIO' 			=> 'CC',                                                           
	psourcename = 'CALIFORNIA_SANTA_CRUZ_COUNTY' 						=> 'CD',                                                                         
	psourcename = 'CALIFORNIA_SAN_DIEGO_COUNTY' 						=> 'CE',                                                                          
	psourcename = 'CALIFORNIA_SANTA_BARBARA_COUNTY' 					=> 'CF',                                                                      
	psourcename = 'CALIFORNIA_CONTRA_COSTA_COUNTY' 						=> 'CG',                                                                       
	psourcename = 'CALIFORNIA_ORANGE_COUNTY' 							=> 'CH',                                                                             
	psourcename = 'CALIFORNIA_FRESNO_COUNTY' 							=> 'CI',                                                                             
	psourcename = 'CALIFORNIA_SANTA_CLARA_COUNTY' 						=> 'CJ',                                                                        
	psourcename = 'CALIFORNIA_SAN_BERNARDINO_COUNTY' 					=> 'CK',                                                                     
	psourcename = 'CALIFORNIA_RIVERSIDE_COUNTY' 						=> 'CL',                                                                          
	psourcename = 'CALIFORNIA_VENTURA_COUNTY' 							=> 'CM',   
	psourcename = 'CALIFORNIA_LOS_ANGELES_COUNTY' 						=> 'CN',                                                                         
	psourcename = 'FLORIDA_HIGHLANDS_COUNTY' 							=> 'FA',                                                                             
	psourcename = 'FLORIDA_SARASOTA_COUNTY' 							=> 'FB',                                                                              
	psourcename = 'FLORIDA_LEE_COUNTY' 									=> 'FC',                                                                                   
	psourcename = 'FLORIDA_PALM_BEACH_COUNTY' 							=> 'FD',                                                                            
	psourcename = 'FLORIDA_BROWARD_COUNTY' 								=> 'FE',                                                                               
	psourcename = 'FLORIDA_HILLSBOROUGH_COUNTY' 						=> 'FG',                                                                          
	psourcename = 'FLORIDA_ALACHUA_COUNTY' 								=> 'FH',                                                                               
	psourcename = 'FLORIDA_BAY_COUNTY' 									=> 'FI',                                                                                   
	psourcename = 'FLORIDA_OSCEOLA_COUNTY' 								=> 'FJ',                                                                               
	psourcename = 'FLORIDA_CHARLOTTE_COUNTY' 							=> 'FK',                                                                             
	psourcename = 'FLORIDA_LEON_COUNTY' 								=> 'FM',                                                                                  
	psourcename = 'FLORIDA_DUVAL_COUNTY' 								=> 'FN',                                                                                 
	psourcename = 'FLORIDA_DADE_COUNTY' 								=> 'FO',                                                                                  
	psourcename = 'FLORIDA_BREVARD_COUNTY' 								=> 'FP',                                                                               
	psourcename = 'FLORIDA_HERNANDO_COUNTY' 							=> 'FQ',                                                                              
	psourcename = 'FLORIDA_ORANGE_COUNTY' 								=> 'FR',                                                                                
	psourcename = 'FLORIDA_PINELLAS_COUNTY' 							=> 'FS',                                                                              
	psourcename = 'FLORIDA_MONROE_COUNTY' 								=> 'FT',                                                                                
	psourcename = 'FLORIDA_MARION_COUNTY' 								=> 'FU',                                                                                
	psourcename = 'GEORGIA_COBB_COUNTY' 								=> 'GB',                                                                                  
	psourcename = 'GEORGIA_GWINNETT_COUNTY' 							=> 'GC',                                                                              
	psourcename = 'ILLINOIS_COOK_COUNTY' 								=> 'IB',                                                                                 
	psourcename = 'LOUISIANA_ST_TAMMANY_COUNTY' 						=> 'LB',                                                                          
	psourcename = 'MICHIGAN_WAYNE_COUNTY' 								=> 'MB',                                                                                
	psourcename = 'MISSISSIPPI_HINDS_COUNTY' 							=> 'MC',                                                                             
	psourcename = 'OHIO_ALLEN_COUNTY_LIMA_MUNICIPAL_COURT' 				=> 'OA',                                                               
	psourcename = 'OHIO_SUMMIT_COUNTY_CUYAHOGA_FALLS_MUNICIPAL_COURT' 	=> 'OB',                                                    
	psourcename = 'OHIO_MONTGOMERY_COUNTY_DAYTON_MUNICIPAL_COURT' 		=> 'OC',                                                        
	psourcename = 'OHIO_WARREN_COUNTY_MASON_MUNICIPAL_COURT' 			=> 'OD',                                                             
	psourcename = 'OHIO_FRANKLIN_COUNTY_MUNICIPAL_COURT' 				=> 'OE',                                                                 
	psourcename = 'OHIO_WARREN_COUNTY' 									=> 'OF',                                                                                   
	psourcename = 'OHIO_CLINTON_COUNTY' 								=> 'OG',                                                                                  
	psourcename = 'OHIO_COLUMBIANA_COUNTY' 								=> 'OI',                                                                               
	psourcename = 'OHIO_LAWRENCE_COUNTY_MUNICIPAL_COURT' 				=> 'OJ',                                                                 
	psourcename = 'OHIO_TRUMBULL_COUNTY' 								=> 'OL',                                                                                 
	psourcename = 'OHIO_ALLEN_COUNTY' 									=> 'OM',                                                                                    
	psourcename = 'OHIO_PORTAGE_COUNTY' 								=> 'ON',                                                                                  
	psourcename = 'OHIO_LICKING_COUNTY' 								=> 'OO',                                                                                  
	psourcename = 'OHIO_GREENE_COUNTY_XENIA_MUNICIPAL_COURT' 			=> 'OP',                                                             
	psourcename = 'OHIO_CLERMONT_COUNTY' 								=> 'OQ',                                                                                 
	psourcename = 'OHIO_SUMMIT_COUNTY_BARBERTON_MUNICIPAL_COURT' 		=> 'OR',                                                         
	psourcename = 'OHIO_ROSS_COUNTY' 									=> 'OS',                                                                                     
	psourcename = 'OHIO_GREENE_COUNTY' 									=> 'OT',                                                                                   
	psourcename = 'OHIO_TUSCARAWAS_COUNTY' 								=> 'OU',                                                                               
	psourcename = 'OHIO_SUMMIT_COUNTY' 									=> 'OV',                                                                                   
	psourcename = 'OHIO_ROSS_COUNTY_CHILLICOTHE_MUNICIPAL_COURT' 		=> 'OW',                                                         
	psourcename = 'OHIO_CUYAHOGA_COUNTY_EUCLID_MUNICIPAL_COURT' 		=> 'OX',                                                          
	psourcename = 'OHIO_MONTGOMERY_COUNTY' 								=> 'OY',                                                                               
	psourcename = 'OHIO_TRUMBULL_COUNTY_NEWTON_FALLS_MUNICIPAL_COURT' 	=> 'OZ',                                                    
	psourcename = 'OHIO_BUTLER_COUNTY' 									=> 'PB',                                                                                   
	psourcename = 'OHIO_MONTGOMERY_COUNTY_VANDALIA_MUNICIPAL_COURT'		=> 'PC',                                                      
	psourcename = 'OHIO_DELAWARE_COUNTY' 								=> 'PD',                                                                                 
	psourcename = 'OHIO_WARREN_COUNTY_COURT' 							=> 'PE',                                                                             
	psourcename = 'OHIO_SUMMIT_COUNTY_AKRON_MUNICIPAL_COURT' 			=> 'PF',                                                             
	psourcename = 'OHIO_FRANKLIN_COUNTY' 								=> 'PG',                                                                                 
	psourcename = 'OHIO_STARK_COUNTY_COMMON_PLEAS_COURT' 				=> 'PH',                                                                 
	psourcename = 'OHIO_MONTGOMERY_COUNTY_NEW_LEBANON_COUNTY_COURT' 	=> 'PI',                                                      
	psourcename = 'OHIO_CUYAHOGA_COUNTY_BEREA_MUNICIPAL_COURT' 			=> 'PJ',                                                           
	psourcename = 'OHIO_MONTGOMERY_COUNTY_HUBER_HEIGHTS_COUNTY_COURT' 	=> 'PK',                                                    
	psourcename = 'OHIO_MONTGOMERY_COUNTY_KETTERING_MUNICIPAL_COURT' 	=> 'PL',                                                     
	psourcename = 'OHIO_ATHENS_COUNTY_ATHENS_MUNICIPAL_COURT' 			=> 'PM',                                                            
	psourcename = 'OHIO_FULTON_COUNTY' 									=> 'PN',                                                                                   
	psourcename = 'OHIO_STARK_COUNTY' 									=> 'PO',                                                                                    
	psourcename = 'OHIO_BROWN_COUNTY_BROWN_MUNICIPAL_COURT' 			=> 'PQ',     
	psourcename = 'SOUTH_CAROLINA_RICHLAND_COUNTY_CIRCUIT_COURTS' => 'SA',                                                       
  psourcename = 'TEXAS_BEXAR_COUNTY'         => 'TB',                                                                          
  psourcename = 'TEXAS_BRAZORIA_COUNTY'      => 'TC',                                                                          
  psourcename = 'TEXAS_COLLIN_COUNTY'        => 'TD',                                                                                 
  psourcename = 'TEXAS_DALLAS_COUNTY'        => 'TE',                                                                                 
  psourcename = 'TEXAS_DENTON_COUNTY'        => 'TF',                                                                                 
  psourcename = 'TEXAS_EL_PASO_COUNTY'       => 'TG',                                                                                
  psourcename = 'TEXAS_FORT_BEND_COUNTY'     => 'TH',                                                                              
  psourcename = 'TEXAS_GREGG_COUNTY'         => 'TI',                                                                                    
  psourcename = 'TEXAS_HARRIS_COUNTY'        => 'TJ',                                                                                 
  psourcename = 'TEXAS_JEFFERSON_COUNTY'     => 'TK',                                                                              
  psourcename = 'TEXAS_JOHNSON_COUNTY'       => 'TL',                                                                                
  psourcename = 'TEXAS_MIDLAND_COUNTY'       => 'TM',                                                                                
  psourcename = 'TEXAS_POTTER_COUNTY'        => 'TP',                                                                                 
  psourcename = 'TEXAS_VICTORIA_COUNTY'      => 'TO',  
	psourcename = 'TEXAS_MONTGOMERY_COUNTY'    => 'TQ', 
	psourcename = 'VIRGINIA_FAIRFAX_COUNTY' 							=> 'PR', 
	
	//soff
	// psourcename = '	ALASKA_SEX_OFFENDER_'  => 'SA'
// psourcename = 'ALABAMA_SEX_OFFENDER'  => 'SB'
// psourcename = 'ARKANSAS_SEX_OFFENDE'  => 'SC'
// psourcename = 'ARIZONA_SEX_OFFENDER'  => 'SD'
// psourcename = 'CALIFORNIA_SEX_OFFEN'  => 'SE'
// psourcename = 'COLORADO_SEX_OFFENDE'  => 'SF'
// psourcename = 'CONNECTICUT_SEX_OFFE'  => 'SG'
// psourcename = 'DISTRICT_OF_COLUMBIA'  => 'SH'
// psourcename = 'DELAWARE_SEX_OFFENDE'  => 'SI'
// psourcename = 'FLORIDA_SEX_OFFENDER'  => 'SJ'
// psourcename = 'GEORGIA_SEX_OFFENDER'  => 'SK'
// psourcename = 'HAWAII_SEX_OFFENDER_'  => 'SL'
// psourcename = 'IOWA_SEX_OFFENDER_RE'  => 'SM'
// psourcename = 'IDAHO_SEX_OFFENDER_R'  => 'SN'
// psourcename = 'ILLINOIS_SEX_OFFENDE'  => 'SO'
// psourcename = 'INDIANA_SEX_OFFENDER'  => 'SP'
// psourcename = 'KANSAS_SEX_OFFENDER_'  => 'SQ'
// psourcename = 'KENTUCKY_SEX_OFFENDE'  => 'SR'
// psourcename = 'LOUISIANA_SEX_OFFEND'  => 'SS'
// psourcename = 'MASSACHUSETTS_SEX_OF'  => 'ST'
// psourcename = 'MARYLAND_SEX_OFFENDE'  => 'SU'
// psourcename = 'MAINE_SEX_OFFENDER_R'  => 'SV'
// psourcename = 'MICHIGAN_SEX_OFFENDE'  => 'SW'
// psourcename = 'MINNESOTA_SEX_OFFEND'  => 'SX'
// psourcename = 'MISSOURI_SEX_OFFENDE'  => 'SY'
// psourcename = 'MISSISSIPPI_SEX_OFFE'  => 'SZ'
// psourcename = 'MONTANA_SEX_OFFENDER'  => 'XA'
// psourcename = 'NORTH_DAKOTA_SEX_OFF'  => 'XB'
// psourcename = 'NEBRASKA_SEX_OFFENDE'  => 'XC'
// psourcename = 'NEW_HAMPSHIRE_SEX_OF'  => 'XD'
// psourcename = 'NEW_JERSEY_SEX_OFFEN'  => 'XE'
// psourcename = 'NEW_MEXICO_SEX_OFFEN'  => 'XF'
// psourcename = 'NEVADA_SEX_OFFENDER_'  => 'XG'
// psourcename = 'NEW_YORK_SEX_OFFENDE'  => 'XH'
// psourcename = 'OHIO_SEX_OFFENDER_RE'  => 'XI'
// psourcename = 'OKLAHOMA_SEX_OFFENDE'  => 'XJ'
// psourcename = 'OREGON_SEX_OFFENDER_'  => 'XK'
// psourcename = 'PENNSYLVANIA_SEX_OFF'  => 'XL'
// psourcename = 'RHODE_ISLAND_SEX_OFF'  => 'XM'
// psourcename = 'SOUTH_CAROLINA_SEX_O'  => 'XN'
// psourcename = 'SOUTH_DAKOTA_SEX_OFF'  => 'XO'
// psourcename = 'TENNESSEE_SEX_OFFEND'  => 'XP'
// psourcename = 'TEXAS_SEX_OFFENDER_R'  => 'XQ'
// psourcename = 'UTAH_SEX_OFFENDER_RE'  => 'XR'
// psourcename = 'VIRGINIA_SEX_OFFENDE'  => 'XS'
// psourcename = 'VERMONT_SEX_OFFENDER'  => 'XT'
// psourcename = 'WASHINGTON_SEX_OFFEN'  => 'XU'
// psourcename = 'WISCONSIN_SEX_OFFEND'  => 'XV'
// psourcename = 'WEST_VIRGINIA_SEX_OF'  => 'XW'

	
 /**************************************************************/
 //Arrests
	psourcename = 'CALIFORNIA MARIN COUNTY ARRESTS' => 'A1',
	psourcename = 'CALIFORNIA SAN BERNARDINO COUNTY ARRESTS' => 'A2',
	psourcename = 'CALIFORNIA SANTA MONICA COUNTY ARRESTS' => 'A3',
	psourcename = 'FLORIDA SARASOTA COUNTY ARRESTS' => 'A4',
	psourcename = 'FLORIDA BREVARD COUNTY ARRESTS' => 'A5',
	psourcename = 'TENNESSEE SHELBY COUNTY ARRESTS' => 'A6',
	psourcename = 'WASHINGTON OKANOGAN COUNTY ARRESTS' => 'A7',
	psourcename = 'CALIFORNIA PLACER COUNTY ARRESTS' => 'A8',
	psourcename = 'FLORIDA ESCAMBIA COUNTY ARRESTS' => 'A9',
	psourcename = 'FLORIDA ESCAMBIA COUNTY ARRESTS BLOTTER FILE' => 'A9',
	psourcename = 'TEXAS HARRIS COUNTY ARRESTS' => 'AA',
	psourcename = 'FLORIDA VOLUSIA COUNTY ARRESTS' => 'AB',
	psourcename = 'MONTANA YELLOWSTONE COUNTY ARRESTS' => 'AC',
	psourcename = 'ALABAMA CALHOUN COUNTY ARRESTS' => 'AD',
	psourcename = 'TEXAS ECTOR COUNTY ARRESTS' => 'AE',
	psourcename = 'NEW MEXICO BERNALILLO COUNTY ARRESTS' => 'AF',
	psourcename = 'NEW MEXICO SAN JUAN COUNTY ARRESTS' => 'AF',
	psourcename = 'CALIFORNIA LOS ANGELES COUNTY ARRESTS' => 'AG',
	psourcename = 'TEXAS BEXAR COUNTY ARRESTS' => 'AH',
	psourcename = 'FLORIDA BROWARD COUNTY ARRESTS' => 'AI',
	psourcename = 'ALABAMA JEFFERSON COUNTY ARRESTS' => 'AJ',
	psourcename = 'FLORIDA PALM BEACH COUNTY ARRESTS' => 'AM',
	psourcename = 'GEORGIA GWINNETT COUNTY ARRESTS' => 'AN',
	psourcename = 'TEXAS LUBBOCK COUNTY ARRESTS' => 'AP',
	psourcename = 'ARIZONA MARICOPA COUNTY ARRESTS' => 'AQ',
	psourcename = 'CALIFORNIA SAN DIEGO COUNTY ARRESTS' => 'AS',
	psourcename = 'FLORIDA DADE COUNTY ARRESTS' => 'AT',
	psourcename = 'ARKANSAS BENTON COUNTY ARRESTS' => 'AU',
	psourcename = 'FLORIDA HILLSBOROUGH COUNTY ARRESTS' => 'AV',
	psourcename = 'GEORGIA CHATHAM COUNTY ARRESTS' => 'AW',
	psourcename = 'GEORGIA FULTON COUNTY ARRESTS' => 'AX',
	psourcename = 'ILLINOIS COOK COUNTY ARRESTS' => 'AY',
	psourcename = 'OREGON JOSEPHINE COUNTY ARRESTS' => 'B2',
	psourcename = 'OREGON LANE COUNTY ARRESTS' => 'B3',
	psourcename = 'OREGON LINCOLN COUNTY ARRESTS' => 'B4',
	psourcename = 'OREGON WASHINGTON COUNTY ARRESTS' => 'B5',
	psourcename = 'OREGON MARION COUNTY ARRESTS' => 'B6',
	psourcename = 'CALIFORNIA SAN JOAQUIN ARRESTS' => 'B7',
	psourcename = 'CALIFORNIA SOLANO ARRESTS' => 'B8',
	psourcename = 'ILLINOIS WILL COUNTY ARRESTS' => 'B9',
	psourcename = 'ILLINOIS PEORIA COUNTY ARRESTS' => 'C0',
	psourcename = 'MISSOURI ST FRANCOIS COUNTY ARRESTS' => 'C1',
	psourcename = 'ALABAMA BALDWIN COUNTY ARRESTS' => 'C3',
	psourcename = 'ALABAMA HOUSTON COUNTY ARRESTS' => 'C4',
	psourcename = 'ALABAMA MOBILE COUNTY ARRESTS' => 'C5',
	psourcename = 'ALABAMA SHELBY COUNTY ARRESTS' => 'C6',
	psourcename = 'ALABAMA TUSCALOOSA COUNTY ARRESTS' => 'C7',
	psourcename = 'NORTH CAROLINA CABARRUS COUNTY ARRESTS' => 'C8',
	psourcename = 'NORTH CAROLINA MECKLENBURG COUNTY ARRESTS' => 'D0',
	psourcename = 'NORTH CAROLINA ROWAN COUNTY ARRESTS' => 'D1',
	psourcename = 'MICHIGAN KENT COUNTY ARRESTS' => 'D2',
	psourcename = 'MICHIGAN OAKLAND COUNTY ARRESTS' => 'D4',
	psourcename = 'OHIO FAYETTE COUNTY ARRESTS' => 'D5',
	psourcename = 'OHIO HIGHLAND COUNTY ARRESTS' => 'D6',
	psourcename = 'GEORGIA DAWSON COUNTY ARRESTS' => 'D7',
	psourcename = 'COLORADO PITKIN COUNTY ARRESTS' => 'D8',
	psourcename = 'COLORADO WELD COUNTY ARRESTS' => 'D9',
	psourcename = 'CALIFORNIA KINGS COUNTY ARRESTS' => 'E1',
	psourcename = 'CALIFORNIA TEHAMA COUNTY ARRESTS' => 'E2',
	psourcename = 'WEST VIRGINIA REGIONAL ARRESTS' => 'E3',
	psourcename = 'CALIFORNIA FRESNO COUNTY ARRESTS' => 'E4',
	psourcename = 'CALIFORNIA ORANGE COUNTY ARRESTS' => 'E5',
	psourcename = 'FLORIDA MARTIN COUNTY ARRESTS' => 'E7',
	psourcename = 'FLORIDA LAKE COUNTY ARRESTS' => 'E8',
	psourcename = 'OREGON YAMHILL COUNTY ARRESTS' => 'E9',
	psourcename = 'GEORGIA BIBB COUNTY ARRESTS' => 'F1',
	psourcename = 'TEXAS MIDLAND COUNTY ARRESTS' => 'F2',
	psourcename = 'TEXAS MONTGOMERY COUNTY ARRESTS' => 'F3',
	psourcename = 'TEXAS BRAZORIA COUNTY ARRESTS' => 'F4',
	psourcename = 'IDAHO ADA COUNTY ARRESTS' => 'F5',
	psourcename = 'IDAHO CANYON COUNTY ARRESTS' => 'F6',
	psourcename = 'TEXAS DENTON COUNTY ARRESTS' => 'F7',
	psourcename = 'LOUISIANA LAFAYETTE COUNTY ARRESTS' => 'F8',
	psourcename = 'WASHINGTON CLARK COUNTY ARRESTS' => 'F9',
	psourcename = 'WASHINGTON KITSAP COUNTY ARRESTS' => 'G1',
	psourcename = 'WASHINGTON PIERCE COUNTY ARRESTS' => 'G2',
	psourcename = 'OREGON LINN COUNTY ARRESTS' => 'G3',
	psourcename = 'WASHINGTON THURSTON COUNTY ARRESTS' => 'G4',
	psourcename = 'OREGON MULTNOMAH COUNTY ARRESTS' => 'G5',
	psourcename = 'OREGON CLACKAMAS COUNTY ARRESTS' => 'G6',
	psourcename = 'OKLAHOMA CARTER COUNTY ARRESTS' => 'G8',
	psourcename = 'ALABAMA MONTGOMERY COUNTY ARRESTS' => 'Z1',
	psourcename = 'ARKANSAS WASHINGTON COUNTY ARRESTS' => 'Z2',
	psourcename = 'ARKANSAS UNION COUNTY ARRESTS' => 'Z3',
	psourcename = 'ARIZONA PIMA COUNTY ARRESTS' => 'Z4',
	psourcename = 'CALIFORNIA SACRAMENTO COUNTY ARRESTS' => 'Z5',
	psourcename = 'CALIFORNIA RIVERSIDE COUNTY ARRESTS' => 'Z6',
	psourcename = 'CALIFORNIA KERN COUNTY ARRESTS' => 'Z7',
	psourcename = 'COLORADO PUEBLO COUNTY ARRESTS' => 'Z8',
	psourcename = 'COLORADO MESA COUNTY ARRESTS' => 'Z9',
	psourcename = 'CONNECTICUT MADISON COUNTY ARRESTS' => 'Y1',
	psourcename = 'FLORIDA INDIAN RIVER COUNTY ARRESTS' => 'Y2',
	psourcename = 'FLORIDA CHARLOTTE COUNTY ARRESTS' => 'Y3',
	psourcename = 'FLORIDA HERNANDO COUNTY ARRESTS' => 'Y4',
	psourcename = 'FLORIDA SEMINOLE COUNTY ARRESTS' => 'Y5',
	psourcename = 'FLORIDA SUWANNEE COUNTY ARRESTS' => 'Y6',
	psourcename = 'FLORIDA OSCEOLA COUNTY ARRESTS' => 'Y7',
	psourcename = 'FLORIDA CITRUS COUNTY ARRESTS' => 'Y8',
	psourcename = 'FLORIDA DESOTO COUNTY ARRESTS' => 'Y9',
	psourcename = 'FLORIDA HARDEE COUNTY ARRESTS' => 'X1',
	psourcename = 'FLORIDA MONROE COUNTY ARRESTS' => 'X2',
	psourcename = 'FLORIDA ORANGE COUNTY ARRESTS' => 'X3',
	psourcename = 'FLORIDA PUTNAM COUNTY ARRESTS' => 'X4',
	psourcename = 'FLORIDA POLK COUNTY ARRESTS' => 'X5',
	psourcename = 'FLORIDA LEE COUNTY ARRESTS' => 'X6',
	psourcename = 'GEORGIA CLARKE COUNTY ARRESTS' => 'X7',
	psourcename = 'IOWA BUENA VISTA COUNTY ARRESTS' => 'X8',
	psourcename = 'IOWA DALLAS COUNTY ARRESTS' => 'X9',
	psourcename = 'KANSAS WYANDOTTE COUNTY ARRESTS' => 'W1',
	psourcename = 'KANSAS JOHNSON COUNTY ARRESTS' => 'W2',
	psourcename = 'KENTUCKY MCCACKEN COUNTY ARRESTS' => 'W3',
	psourcename = 'KENTUCKY FULTON COUNTY ARRESTS' => 'W4',
	psourcename = 'KENTUCKY BOONE COUNTY ARRESTS' => 'W5',
	psourcename = 'LOUISIANA EAST BATON ROUGE COUNTY ARRESTS' => 'W6',
	psourcename = 'LOUISIANA LAFOURCHE COUNTY ARRESTS' => 'W7',
	psourcename = 'LOUISIANA OUACHITA COUNTY ARRESTS' => 'W8',
	psourcename = 'LOUISIANA BOSSIER COUNTY ARRESTS' => 'W9',
	psourcename = 'LOUISIANA ORLEANS COUNTY ARRESTS' => 'V1',
	psourcename = 'MASSACHUSETTS WALTHAM COUNTY ARRESTS' => 'V2',
	psourcename = 'MASSACHUSETTS ORLEANS POLICE ARRESTS' => 'V3',
	psourcename = 'MASSACHUSETTS BILLERICA POLICE ARRESTS' => 'V4',
	psourcename = 'MICHIGAN WAYNE COUNTY ARRESTS' => 'V5',
	psourcename = 'MINNESOTA HENNEPIN COUNTY ARRESTS' => 'V6',
	psourcename = 'MINNESOTA OLMSTED COUNTY ARRESTS' => 'V7',
	psourcename = 'MINNESOTA DAKOTA COUNTY ARRESTS' => 'V8',
	psourcename = 'MISSOURI CLAY COUNTY ARRESTS' => 'V9',
	psourcename = 'MISSISSIPPI LEE COUNTY ARRESTS' => 'U1',
	psourcename = 'MONTANA MISSOULA COUNTY ARRESTS' => 'U2',
	psourcename = 'NORTH CAROLINA GUILFORD COUNTY ARRESTS' => 'U3',
	psourcename = 'NORTH CAROLINA RANDOLPH COUNTY ARRESTS' => 'U4',
	psourcename = 'NORTH CAROLINA CATAWBA COUNTY ARRESTS' => 'U5',
	psourcename = 'NORTH CAROLINA LINCOLN COUNTY ARRESTS' => 'U6',
	psourcename = 'NORTH CAROLINA DURHAM COUNTY ARRESTS' => 'U7',
	psourcename = 'NORTH CAROLINA UNION COUNTY ARRESTS' => 'U8',
	psourcename = 'NEBRASKA HALL COUNTY ARRESTS' => 'U9',
	psourcename = 'NEW JERSEY HUNTERDON COUNTY ARRESTS' => 'T1',
	psourcename = 'NEW MEXICO SANTA FE COUNTY ARRESTS' => 'T2',
	psourcename = 'NEVADA HUMBOLDT COUNTY ARRESTS' => 'T3',
	psourcename = 'NEVADA CLARK COUNTY ARRESTS' => 'T4',
	psourcename = 'NEW YORK ONONDAGA COUNTY ARRESTS' => 'T5',
	psourcename = 'NEW YORK ONEIDA COUNTY ARRESTS' => 'T6',
	psourcename = 'NEW YORK FULTON POLICE ARRESTS' => 'T7',
	psourcename = 'OHIO MONTGOMERY COUNTY ARRESTS' => 'T8',
	psourcename = 'OHIO WASHINGTON COUNTY ARRESTS' => 'T9',
	psourcename = 'OHIO SOUTHEAST COUNTY ARRESTS' => 'S1',
	psourcename = 'OHIO HAMILTON COUNTY ARRESTS' => 'S2',
	psourcename = 'OHIO SANDUSKY COUNTY ARRESTS' => 'S3',
	psourcename = 'OHIO LICKING COUNTY ARRESTS' => 'S4',
	psourcename = 'OHIO GALLIA COUNTY ARRESTS' => 'S5',
	psourcename = 'OHIO SHELBY COUNTY ARRESTS' => 'S6',
	psourcename = 'OHIO LOGAN COUNTY ARRESTS' => 'S7',
	psourcename = 'OKLAHOMA OSAGE COUNTY ARRESTS' => 'S8',
	psourcename = 'OREGON DESCHUTES COUNTY ARRESTS' => 'S9',
	psourcename = 'OREGON UMATILLA COUNTY ARRESTS' => 'R1',
	psourcename = 'OREGON DOUGLAS COUNTY ARRESTS' => 'R2',
	psourcename = 'OREGON JACKSON COUNTY ARRESTS' => 'R3',
	psourcename = 'OREGON MORROW COUNTY ARRESTS' => 'R4',
	psourcename = 'OREGON POLK COUNTY ARRESTS' => 'R5',
	psourcename = 'PENNSYLVANIA LANCASTER COUNTY ARRESTS' => 'R6',
	psourcename = 'SOUTH CAROLINA CHEROKEE COUNTY ARRESTS' => 'R7',
	psourcename = 'SOUTH CAROLINA RICHLAND COUNTY ARRESTS' => 'R8',
	psourcename = 'SOUTH CAROLINA HORRY COUNTY ARRESTS' => 'R9',
	psourcename = 'SOUTH CAROLINA YORK COUNTY ARRESTS' => 'Q1',
	psourcename = 'TENNESSEE MONTGOMERY COUNTY ARRESTS' => 'Q2',
	psourcename = 'TENNESSEE DAVIDSON COUNTY ARRESTS' => 'Q3',
	psourcename = 'TEXAS TOM GREEN COUNTY ARRESTS' => 'Q4',
	psourcename = 'TEXAS CAMERON COUNTY ARRESTS' => 'Q5',
	psourcename = 'TEXAS RANDALL COUNTY ARRESTS' => 'Q6',
	psourcename = 'TEXAS PARKER COUNTY ARRESTS' => 'Q7',
	psourcename = 'TEXAS POTTER COUNTY ARRESTS' => 'Q8',
	psourcename = 'TEXAS GREGG COUNTY ARRESTS' => 'Q9',
	psourcename = 'TEXAS SMITH COUNTY ARRESTS' => 'P1',
	psourcename = 'TEXAS WISE COUNTY ARRESTS' => 'P2',
	psourcename = 'TEXAS ARLINGTON POLICE ARRESTS' => 'P3',
	psourcename = 'UTAH WASHINGTON COUNTY ARRESTS' => 'P4',
	psourcename = 'UTAH SALT LAKE COUNTY ARRESTS' => 'P5',
	psourcename = 'UTAH SAN PETE COUNTY ARRESTS' => 'P6',
	psourcename = 'UTAH DAVIS COUNTY ARRESTS' => 'P7',
	psourcename = 'UTAH IRON COUNTY ARRESTS' => 'P8',
	psourcename = 'UTAH UTAH COUNTY ARRESTS' => 'P9',
	psourcename = 'VIRGINIA WASHINGTON COUNTY ARRESTS' => 'P1',
	psourcename = 'VIRGINIA FAIRFAX COUNTY ARRESTS' => 'P2',
	psourcename = 'VIRGINIA DANVILLE POLICE ARRESTS' => 'P3',
	psourcename = 'WASHINGTON JEFFERSON COUNTY ARRESTS' => 'P4',
	psourcename = 'WASHINGTON COWLITZ COUNTY ARRESTS' => 'P5',
	psourcename = 'WASHINGTON WHATCOM COUNTY ARRESTS' => 'P6',
	psourcename = 'WASHINGTON LEWIS COUNTY ARRESTS' => 'P7', '??');
return vendor;
end;

end;

