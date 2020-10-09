import	ut;

export	Functions	:= module

	// Drop zip4 if it exists
	export	fDropZip4(string	pLineLast)	:=	regexreplace('(^| )([0-9]{5})[-]?[0-9]{4}($| .*)',pLineLast,'\\1\\2\\3');
	
	// Clean name
	export	fCleanName(string	pName)			:=	map(	ut.CleanSpacesAndUpper(pName)[1..3]	=	'SG'	=>	ut.CleanSpacesAndUpper(pName)[4..],
																									ut.CleanSpacesAndUpper(pName)				=	'SG'	=>	'',
																									ut.CleanSpacesAndUpper(pName)
																								);
	
	// Clean fields
	export	CleanFields(pInputFile,pOutputFile)	:= macro
		LOADXML('<xml/>');

		#EXPORTXML(doCleanFieldMetaInfo,recordof(pInputFile))

		#uniquename(myCleanFunction)
		string	%myCleanFunction%(string	x)	:=	ut.CleanSpacesAndUpper(stringlib.stringcleanspaces(regexreplace('[^ -~]+',x,' ')));

		#uniquename(tra)
		pInputFile	%tra%(pInputFile	le)	:=
		TRANSFORM
			#IF(%'doCleanFieldText'%='')
				#DECLARE(doCleanField)
				#DECLARE(doCleanFieldText)
			#END
			
			#SET(doCleanField,true)
			#SET(doCleanFieldText,false)
			
			#FOR(doCleanFieldMetaInfo)
				#FOR(Field)
					#IF(regexfind('[0-9]+',%'@isDataset'%))
						#SET(doCleanField,false)
						#APPEND(doCleanFieldText,'')
					#ELSEIF(regexfind('[0-9]+',%'@isEnd'%))
						#SET(doCleanField,true)
						#APPEND(doCleanFieldText,'')
					#ELSEIF(%doCleanField%	and	%'@type'%	=	'string')
						#SET(doCleanFieldText,'SELF.'	+	%'@name'%)
						#APPEND(doCleanFieldText,'	:=	'	+	%'myCleanFunction'%	+	'(le.')
						#APPEND(doCleanFieldText,%'@name'%)
						#APPEND(doCleanFieldText,')')
						%doCleanFieldText%;
					#ELSE
						#APPEND(doCleanFieldText,'')
					#END
				#END
			#END
			SELF	:=	le;
		END;
		
		pOutputFile	:=	PROJECT(pInputFile,%tra%(LEFT));
	endmacro;
	
	export fRemLeadZeros(string ds) := 
				if(ds[1]='0' and ds[1..2]<>'00',
						ds[2..],
					if(ds[1..2]='00' and ds[1..3]<>'000',
						ds[3..],
					if(ds[1..3]='000' and ds[1..4]<>'0000',
						ds[4..],
					if(ds[1..4]='0000' and ds[1..5]<>'00000',
						ds[5..],
					if(ds[1..5]='00000' and ds[1..6]<>'000000',
						ds[6..],
					if(ds[1..6]='000000' and ds[1..7]<>'0000000',
						ds[7..],
					if(ds[1..7]='0000000' and ds[1..8]<>'00000000',
						ds[8..],
					if(ds[1..8]='00000000' and ds[1..9]<>'000000000',
						ds[9..],
					if(ds[1..9]='000000000' and ds[1..10]<>'0000000000',
						ds[10..],
					if(ds[1..10]='0000000000',
						ds[11..],
						ds))))))))));
						
	export boolean fIsCompany(string pInput) := regexfind(
		  '& SONS|'+
			', N A|'+
			' INC |'+
			',INC |'+
			',INC$|'+
			'INC$|'+
			'1ST BANK|'+
			'2ND BANK|'+
			'ACADEMY |'+
			' ACADEMY$|'+
			'ACCOUNTING|'+
			'ACCOUNTS|'+
			'ADMINISTRATION|'+
			'ADVOCATES|'+
			' ADVOCATES$|'+
			' AFL-CIO|'+
			' AFFORDABLE|'+
			'AGENCY|'+
			'AIR CONDITIONING|'+
			'AIRLINES|'+
			'ALIGNMENT|'+
			'AMBULANCE|'+
			'AMERICAN|'+
			'AMERIQUEST|'+
			'AMUSEMENT|'+
			' AND KNEE|'+
			' AND SONS|'+
			' ANIMAL |'+
			'ANTIQUE|'+
			'APARTMENT|'+
			'APLC|'+
			'APPLIANCE|'+
			'ARCHETECT|'+
			'ARCHITECT|'+
			'ARKANSAS|'+
			'AS AGENT|'+
			'ASSOC |'+
			'ASSOCIATES|'+
			'ASSOCIATION|'+
			' ATTORNEYS|'+
			'AUTOMOTIVE|'+
			'AUTORAMA|'+
			'AVIATION|'+
			'BALL BEARINGS|'+
			'BANK |'+
			'BANK OF|'+
			'BANK ONE|'+
			'BANK N.A.|'+
			'BANK NA|'+
			' BEEP OF |'+
			'BLUE CROSS|'+
			'BLUE SHIELD|'+
			'BOOKBINDER|'+
			'BOOKKEEPING|'+
			'BOTANICAL|'+
			'BOTTLING|'+
			'BOUTIQUE|'+
			'BOYS & GIRLS|'+
			'BROKERAGE|'+
			' BROKERS|'+
			'BUILDING|'+
			'BUREAU |'+
			'BUREAU$|'+
			'BUSINESS|'+
			' BUTANE |'+
			'BUYERS |'+
			'CABLEVISION|'+
			'CANISIUS COLLEGE|'+
			'CARBURETOR|'+
			'CASUALTY|'+
			'CATHOLIC |'+
			' CENTER |'+
			'^CENTER |'+
			' CENTER$|'+
			' CHAPTER |'+
			'^CHAPTER |'+
			' CHAPTER$|'+
			'CHARITIES|'+
			'CHASE BANK|'+
			'CHASE MANHATTAN|'+
			'CHEESE & WINE|'+
			'CHEMICAL|'+
			'CHILDREN\'S |'+
			' CHIRO |'+
			'CHIROPRACTIC|'+
			'CHURCH OF |'+
			' CHURCH$|'+
			'CITIBANK|'+
			'CITIGROUP|'+
			'CITIZENS BANK|'+
			' CITIZENS |'+
			' CITY |'+
			'^CITY |'+
			'CLEANING|'+
			' CLINIC|'+
			' CLUB |'+
			'CMNTY|'+
			' CO |'+
			' CO-OP |'+
			' COALITION |'+
			'COLE TAYLOR BANK|'+
			'COLLECT|'+
			'COMMERCE|'+
			'COMMITTEE|'+
			'COMMUNICATION|'+
			'COMMUNITY|'+
			'COMPANY|'+
			'COMPUTER|'+
			' CONFERENCE|'+
			' CONCRETE |'+
			'CONSTRUCTION|'+
			'CONSULTING|'+
			'CONSULTANTS|'+
			'CONSUMER |'+
			'CONTRACTING|'+
			' CONTROL |'+
			' COOP |'+
			'COOPERATIVE|'+
			' CORP |'+
			' CORPORATE|'+
			'CORPORATION|'+
			' COUNCIL |'+
			' COUNTRY CLUB|'+
			'COUNTRYWIDE FUNDING|'+
			' COUNTY |'+
			'COUNTY OF |'+
			'^CREDIT |'+
			' CREDIT |'+
			'CRESTAR BANK|'+
			' D/B/A |'+
			'DAY CARE|'+
			' DBA |'+
			' DELI |'+
			'DEPARTMENT|'+
			' DEPARTMT |'+
			' DEPT |'+
			'DETROIT|'+
			' DEVELOPERS |'+
			'DEVELOPMENT|'+
			' DIST |'+
			'DISTRIBUTI|'+
			'DISTRICT|'+
			'DIVISION|'+
			'DVLPMNTL|'+
			'EASTERN|'+
			'ELECTRICAL|'+
			'ELEVATOR|'+
			'ENGINEERING|'+
			'ENTERPRISE|'+
			' ENVIRONMENTAL |'+
			'EQUIPMENT|'+
			'EQUITY|'+
			'ESTATES|'+
			' ESQS |'+
			'EXCAVATING|'+
			'EXPRESS|'+
			'^FAMILY|'+
			' F S B|'+
			' FSB|'+
			'FABRICATORS|'+
			' FARM |'+
			' FEDERATION$|'+
			'FIDELITY BANK|'+
			'FINANCE |'+
			'FINANCIAL |'+
			' FINISHING |'+
			' FIRE |'+
			'^FIRE |'+
			' FIRE$|'+
			' FIRM |'+
			' FIRM$|'+
			'^FIRST |'+
			'FIRST BANK|'+
			'FLEET BANK|'+
			' FLYING |'+
			' FLYING$|'+
			'^FNB |'+
			' FNB$|'+
			',FNB$|'+
			'FOUNDATION|'+
			'FREIGHT|'+
			'FULFILLMENT|'+
			'FULLFILLMENT|'+
			' FUND$|'+
			'FUNERAL HOME|'+
			'FURNITURE|'+
			' GAZETTE |'+
			' GAZETTE$|'+
			'GOVERNMENT|'+
			'GREATER |'+
			'GREYHOUND|'+
			' GROCERY |'+
			' GROUP |'+
			'^GROUP |'+
			' GROUP$|'+
			' GROWERS |'+
			'GVRNMNT|'+
			' GYM |'+
			' GYM$|'+
			' HEALTH |'+
			' HEALTH$|'+
			'HEALTHCARE|'+
			'^HEALTH |'+
			' HOLDINGS$|'+
			'HOME LIFE|'+
			'HOMESTEAD LAND DEVELOPMENT|'+
			' HOSP |'+
			' HOSP.|'+
			' HOTEL|'+
			'HOSPICE|'+
			'HOSPITAL|'+
			' HUNTING |'+
			' HUNTING$|'+
			'IMPROVEMENT|'+
			' INDEPENDIENTE |'+
			'INC[.]|'+
			'INDUSTRIAL|'+
			'INDUSTRY|'+
			'INDUSTRI|'+
			'INDUSTRIES|'+
			' INN |'+
			' INN$|'+
			'INNOVATIVE|'+
			' INS |'+
			'INSTITUTE|'+
			' INSURANCE |'+
			'INTEREST|'+
			'INTERIORS|'+
			'INVESTMENT|'+
			'JPMORGAN |'+
			' L L C|'+
			' L L P|'+
			' LANDFILL |'+
			'LABORATORIES|'+
			'^LANDFILL |'+
			' LANDFILL$|'+
			'LANDSCAPING|'+
			'LAUNDROMAT|'+
			'LAW FIRM|'+
			'LAW OFFICES|'+
			' LAWYERS |'+
			'LEAGUE|'+
			' LEAGUE |'+
			'LEARNING|'+
			' LEASE |'+
			' LEASING |'+
			'LIBRARY|'+
			'LIMITED|'+
			'LIQUOR|'+
			'LLC|'+
			'LLP|'+
			'LOGGING|'+
			' LP |'+
			' LP$|'+
			' LTD|'+
			'MACHINE|'+
			'MAGAZINE|'+
			' MANDATORY |'+
			'MANAGEMENT|'+
			'MANUFACTUR|'+
			' MARKET |'+
			' MARKET$|'+
			'MARLBOROUGH COUNTRY|'+
			'MATSUSHITA|'+
			'MATUSHITA|'+
			' MEDICAL |'+
			'^MEDICAL |'+
			'MELLON BANK|'+
			'MERCHANTS |'+
			'METHODIST|'+
			'MGMT|'+
			'MGT|'+
			' MILLING |'+
			'MINISTRIES|'+
			'MISSIONARY|'+
			'MNGMNT|'+
			'MOBILE HOME|'+
			'MOBILE PARK|'+
			'MONASTERY|'+
			'MORTGAGE ELECTRONIC|'+
			' MOTEL |'+
			' MOTEL$|'+
			'MOUNTAIN|'+
			' MUFFLERS |'+
			' MUNCIPAL |'+
			'MUSEUM|'+
			' NATION |'+
			'NATIONAL|'+
			'NATIONSBANK|'+
			'NATIONS BANK|'+
			' NAT\'L |'+
			'^NAT\'L |'+
			' NATL |'+
			'^NATL |'+
			' NATL. |'+
			'^NATL\\. |'+
			'NATURAL GAS|'+
			'NCNB|'+
			'NETWORK|'+
			'NEW YORKERS |'+
			'NEUROLOGICAL|'+
			'NEUROLOGY|'+
			' NORTH AMERICA|'+
			' NORTHERN|'+
			' OF |'+
			'OF AMERICA|'+
			'OFFICE|'+
			'OPTHAMOLOG|'+
			'OPHTHAMOLOG|'+
			'OPTICAL|'+
			'ORGANISATION|'+
			'ORGANIZATION|'+
			' ORTHO |'+
			' ORTHOPEDIC |'+
			' P S C|'+
			'PACKAGING|'+
			'PARAMEDICS |'+
			' PARTNERS|'+
			'^PARTNERS |'+
			'PARTNERSHIP|'+
			', P[.]C[.]$|'+
			' PC$|'+
			',PC$|'+
			'PEDIATRICS|'+
			'PEER REVIEW|'+
			'PENSION PLAN|'+
			'PERFORMING ARTS|'+
			'PETROLEUM|'+
			'PHARMACEUTICAL|'+
			'PHARMACY|'+
			'PHOTOGRAPHIC|'+
			' PICTURES |'+
			'PLANNED|'+
			' PLASTIC |'+
			' PLAZA|'+
			'PLUMBING|'+
			'PNC |'+
			' POLICE |'+
			'PRENTICE HALL|'+
			'PRODUCTIONS|'+
			'PROFESSIONAL|'+
			'PROGRESSIVE|'+
			'PROPERTIES|'+
			'PROPERTY|'+
			' PROVINCE |'+
			'PROVINCE OF |'+
			' PSC|'+
			'PUBLIC|'+
			'PUBLICATIONS|'+
			' QUARTER |'+
			' RADIO|'+
			'RAILROAD|'+
			' RAILWAY|'+
			'REAL ESTATE|'+
			'REALTORS|'+
			'REALTY|'+
			'REBUILDERS|'+
			'REMODELING|'+
			'RENTAL |'+
			'REPAIR|'+
			'REPUBLIC |'+
			'RESIDENTIAL|'+
			'RESOURCES|'+
			'RESTAURANT|'+
			'RESTAURANT|'+
			' RETAIL|'+
			'RETIREMENT|'+
			'REVOLUTIONARY|'+
			' SALES |'+
			' SALES$|'+
			'SAVINGS|'+
			' SCHOOL |'+
			'SEAFOOD|'+
			'^SECOND|'+
			'SECOND BANK|'+
			'SECURITIES|'+
			'SECURITY|'+
			' SERVICE |'+
			'SERVICES|'+
			'SERVICING|'+
			'SHIPPING|'+
			'SOCIETY|'+
			'SOLUTION|'+
			'SOUTHERN|'+
			'SPECIALIST|'+
			'SPECIALTY|'+
			'SPECIALTIES|'+
			'SPRCNTR|'+
			' STATE |'+
			'STATE BANK|'+
			'STATE OF |'+
			' STONEWORKS |'+
			' STORAGE |'+
			' STRATEGIES |'+
			'SUPERCENTER|'+
			'SUPERVISOR|'+
			'SUPPLY|'+
			'SURGERY|'+
			'SYSTEMS|'+
			'TECHNOLOG|'+
			'TELECOM|'+
			'TELEPHON|'+
			' TENANTS |'+
			' THE |'+
			'TIRE & RUBBER|'+
			' TITLE|'+
			' TOURISM |'+
			' TOWN |'+
			'^TOWN |'+
			' TRACTOR |'+
			'TRADE NAME|'+
			' TRANSFER |'+
			'TRANSMISSION|'+
			' TRANSPORT |'+
			'TRANSPORTATION|'+
			'TRAVEL |'+
			'TRUCKING|'+
			' TRUST |'+
			' TRUSTEE|'+
			'TRUSTEES |'+
			' U S A |'+
			'UNITED |'+
			'UNITED STATES|'+
			' UNIV |'+
			'^UNIV |'+
			'UNIVERSAL|'+
			'UNIVERSITY|'+
			'^UPS|'+
			'^U OF |'+
			' USA |'+
			'VENTURES|'+
			'VOCATIONAL|'+
			'WACHOVIA BANK|'+
			'WAREHOUSE|'+
			' WARRANTY |'+
			'WASHINGTON MUTUAL|'+
			'WELLS FARGO|'+
			'WESTERN|'+
			'WILDLIFE|'+
			'WIRELESS|'+
			' WORLD |'+
			'^WORLD |'+
			' WORLD$|'+
			'^[1-9]', StringLib.StringToUpperCase(pInput));

end;