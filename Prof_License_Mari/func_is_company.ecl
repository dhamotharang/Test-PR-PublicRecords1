﻿export boolean func_is_company(string pInput) := regexfind(
															//Allow . after INC 5/6/13  
															//Allow . after INC 5/6/13
															'( & SONS| & SON$|, N A| INC[\\.]? |,INC[\\.]? |,INC[\\.]?$| & |@|' +
															' INC$| INC\\.$|1ST BANK|2ND BANK|ACADEMY | ACADEMY$|'+
															' INSPECTION$| INSPECTIONS$| INSPECTION | INSPECTIONS |'+
															'PRICEWATERHOUSECOOPERS|' +
															'ACCOUNTING|ACCOUNTS|ADMINISTRATION|ADMN|ADVOCATES| ADVOCATES$| AFL-CIO| AFFORDABLE|AGENCY|AGCY|AIR CONDITIONING|'+
															'AIRLINES|ALASKA|ALIGNMENT|AMBULANCE|AMERICAN|AMERICA\'S|^AMERI|AMUSEMENT| AND CO$| AND KNEE| AND SONS| AND SON$|'+
															' ANIMAL |ANTIQUE|APARTMENT|APC|APLC|APPLIANCE|APPRAISAL|APPRAISER|APPRAISING| APPR|ARCHETECT|ARCHITECT|ARKANSAS|AS AGENT|'+
															'ASSESSOR| ASSC| ASSN| ASSOC |ASSOCIATES|ASSOCIATION| ASSOC| ATTORNEYS|AUTOLOAN|AUTOMOTIVE|AUTORAMA|AUTHORITY|'+
															//Need \\ in front of .
															//'AVIATION|BALL BEARINGS|BANC CORP|BANK CORP|BANK OF|BANK ONE|BANK N.A.|BANK NA| BANK$| BARBER SHOP| BEAUTY SALON| BEEP OF |'+
															'AVIATION|BALL BEARINGS|BANC CORP|BANK CORP|BANK OF|BANK ONE|BANK N\\.A\\.|BANK NA| BANK$| BARBER SHOP| BEAUTY SALON| BEEP OF |'+
															'BLUE CROSS|BLUE SHIELD|BOOKBINDER|BOOKKEEPING|BOTANICAL|BOTTLING|BOUTIQUE|BPO|BROADCASTING|'+
															' BRK|BRNCH|BROKERAGE| BROKER|BLDG|BUILDING|BUREAU |BUREAU$|BUSINESS| BUTANE |BUYERS |'+
															'CABLEVISION|CANISIUS COLLEGE|CAPITAL|APITAL AMERICANCARBURETOR|CASUALTY|CATHOLIC |CB RICHARD ELLIS| CENTER |^CENTER | CENTER$|CENTURY 21|CFAB|'+
															' CHAPTER |^CHAPTER | CHAPTER$|CHARITIES|CHARTER*|CHASE BANK|CHASE MANHATTAN BANK|'+
															'CHEMICAL|CHILDREN\'S | CHIRO |CHIROPRACTIC|CHURCH OF |CITIBANK|CITIGROUP|'+
															//Include 'CO.,'
															'CITIZENS BANK| CITIZENS | CITY |^CITY |CLEANING| CLINIC| CLUB |CMNTY| CO[\\.]? | CO[\\.]?, | CO[\\.]?$| CO-OP | COALITION |COCA COLA|'+
															'COLDWELL BANKER|COLLECT|COLLEGE|COLONIAL BANK|COMMERCE|COMMERCIAL|COMMERCIAL BANK|COMMERCIAL CREDIT|COMMERCIAL FINANCE|COMMITTEE|'+
															'COMMUNITIES|COMMUNICATION|COMMUNITY|COMPANY|COMPANIES|COMPLIANCE|COMPUTER| CONDO | CONDOMINIUM | CONFERENCE| CONCRETE |'+
															'CONSTRUCTION|CONSULTING|CONSULTANTS|CONSUMER |CONTRACTING| CONTROL |^COOP | COOP |'+
															//Allow .  and , after CORP 5/6/13
															'COOPERATIVE|CORP[\\.] |CORPS | CORPORATE|CORPORATION| CORP[\\.]?$| CORP[\\.]?[,]? |CORRECTIONAL| COUNCIL | COUNTRY CLUB|'+
															' COUNTY |COUNTY OF |COURTHOUSE|COURT HOUSE|CRED |^CREDIT | CREDIT |CRESTAR BANK|^CU | D/B/A |DAY CARE| DBA |'+
															' DELI |DEPARTMENT| DEPARTMT | DEPT| DEPT[\\.]|DETROIT| DEVELOPERS |'+
															//|DIV.| should be replace by | DIV\\. | DIV\\.$|
															//'DEVELOPMENT| DIST |DISTRIBUTI|DISTRICT|DIVISION|DIV.|DVLPMNTL|EASTERN|DEVELOPEMENT|'+
															'DEVELOPMENT| DIST |DISTRIBUTI|DISTRICT|DIVISION| DIV\\. | DIV\\.$|DVLPMNTL|EASTERN|DEVELOPEMENT|'+
															'ELECTRICAL|ELEVATOR|EMPLOYEE|ENGINEERING|ENGINEERS|ENTERPR*|ENTRPRS| ENVIRONMENTAL |EQUIPMENT|EQUITY|EQUITIES|ESTATES|'+
															//Replace |FCU| by |^FCU | FCU$| FCU |^FCU$|
															//' ESQS |EXCAVATING|EXPRESS|^FAMILY| F S B| FSB|FABRICATORS| FARM |FCU| FEDERAL| FEDERATION$|'+
															' ESQS |EXCAVATING|EXPRESS|^FAMILY| F S B| FSB|FABRICATORS| FARM |^FCU | FCU$| FCU |^FCU$| FEDERAL| FEDERATION$|'+
															'FIDELITY BANK| FINANCE$|FINANCIAL$| FINANCIAL |FIRE |^FIRE | FIRE$| FIRM |'+
															' FIRM$|FISH |^FIRST |FIRST BANK|FLEET BANK| FLYING | FLYING$|^FNB |'+
															' FNB$|,FNB$|FOUNDATION|FREIGHT|FREMONT BANK|FULFILLMENT|FULLFILLMENT|FUND$|FUNDING|FUNERAL HOME|'+
															'FURNITURE| GAZETTE | GAZETTE$|GOVERNMENT|GOVT|GREATER |GREYHOUND| GROCERY | GROUP |^GROUP |'+
															' GROUP$| GRP| GROWERS |GVRNMNT| GYM | GYM$|HDQTR$|HEADQUARTER$| HEALTH | HEALTH$|HEALTHCARE|^HEALTH |'+
															'HERITAGE HOMES|HOLDERS|HOME EXPERT|HOME LENDING|HOME LIFE|HOME LOAN|HOUSETECH| HOSP | HOSP\\.|HOSP$| HOTEL|HOSPICE|HOSPITAL|HWY | HUNTING | HUNTING$|'+
															'IMPROVEMENT| INDEPENDIENTE |INC[\\.]|INCORPORATED|INDUSTRIAL|INDUSTRIES| INN | INN$|INNOVATIVE| INS |INSPECTION'+
															//Replace |LLC| by | LLC | LLC$|^LLC | and add | L.L.C. | L.L.C.$| 2/14/13 Cathy Tio
															//'INSTITUTE| INSURANCE|INTEREST|INTERIORS|INVESTMENT|JPMORGAN |JOINT VENTURE| L L C|LLC|'+
															'INSTITUTE| INSURANCE|INTEREST|INTERIORS|INVESTMENT|JPMORGAN |JOINT VENTURE| L L C| LLC | LLC$|^LLC | L\\.L\\.C\\. | L\\.L\\.C\\.$| L\\. L\\. C\\.$| CO\\. | CO\\.$|'+
															' LLC\\.,| LLC\\.$|' +
															' L L P| LANDFILL |LABORATORY|LABORATORIES|^LANDFILL |'+
															' LANDFILL$|LANDSCAPING|LAUNDROMAT|LAW FIRM|LAW OFFICES| LAWYERS |LEAGUE| LEAGUE |'+
															//Remove LLC. It has been defined earlier, and replace LLP by | LLP | LLP$|^LLP | and do the same for lender as well
															//'LEARNING| LEASE | LEASING |LENDER|LENDING GROUP|LEGEND CLASSIC|LIBERTY BANK|LIBRARY|LIMITED|LIQUOR|LLC|LLP|LOAN |LOGGING|'+
															'LEARNING| LEASE | LEASING | LENDER |$LENDER | LENDER$|LENDING GROUP|LEGEND CLASSIC|LIBERTY BANK|LIBRARY|LIMITED|LIQUOR| LLP | LLP$| LP$|^LLP |^LOAN | LOAN |LOGGING|'+
															//'|MARINE| is replaced by | MARINE | MARINE$|
															' L\\.P\\.|LTD|MACHINE| MANDATORY |MANAGEMENT|MANUFACTUR| MARINE | MARINE$| MARKET | MARKET$|MARLBOROUGH COUNTRY|'+
															'MATSUSHITA|MATUSHITA| MEDICAL |^MEDICAL |MELLON BANK|MERCHANTS |MEMORIAL GARDENS|MEMORIAL PARK|METHODIST|'+
															'MFR|MFG|MGMT|MGT| MILLING |MINISTRIES|MISSIONARY|MNCPL|MNGMNT|MOBILE HOME|MOBILE PARK|MORTGAGE|'+
															' MOTEL | MOTEL$|MOUNTAIN| MTG|MUNCIPAL |MUSEUM|MULTIFAMILY|NATION |NATIONAL|NATIONSBANK|'+
															'NATIONS BANK| NAT\'L |^NAT\'L | NATL |^NATL | NATL\\. |^NATL\\. |NATURAL GAS|'+
															//'| NORTHERN|' is replaced by ' NORTHERN ' 5/3/13
															'NCNB|NETWORK|NEW YORKERS |NEUROLOGICAL|NEUROLOGY| NORTH AMERICA| NORTHERN | OF |OF AMERICA|OFFICE|OPTHAMOLOG|OPHTHAMOLOG|'+
															'OPPORTUNITIES|OPTICAL|ORGANISATION|ORGANIZATION| ORTHO | ORTHOPEDIC | P S C|PACKAGING|PARAMEDICS |'+
															//Pattern | PARTN*| will treat part and partner as a match. Replace it by | PARTN | PARTN$|
															//' PARTN*|^PARTNERS |PARTNERSHIP|, P[.]C[.]$| PC$|,PC$|PEDIATRICS|PEER REVIEW|PENSION PLAN|'+
															' PARTN | PARTN$|^PARTNERS |PARTNERSHIP|, P[\\.]C[\\.]$| PC$|,PC$|PEDIATRICS|PEER REVIEW|PENSION PLAN|'+
															'PERFORMING ARTS|PETROLEUM|PHARMACEUTICAL|PHARMACY|PHOTOGRAPHIC|PLANNED|'+
															' PLASTIC | PLANTATION| PLAZA|PLUMBING|PNC | POLICE |PRENTICE HALL|PRODUCTIONS|PROFESSIONAL|PROGRESSIVE|'+
															//'| PSC|' is replaced by '| PSC | PSC$|' 5/3/13
															'PROPERTIES|PROPERTY| PROVINCE |PROVINCE OF | PSC | PSC$|PRTNRSHP|PUBLIC|PUBLICATIONS|PRUDENTIAL| QUARTER |'+
															//' RADIO' is replaced by ' RADIO |RADIO$
															' RADIO | RADIO$|RAILROAD| RAILWAY|REAL ESTATE|REALTORS|REALTY|REBUILDERS|REFERRAL$|REGIONS BANK|RE MAX |RE\\/MAX|REMAX|REMODELING|'+
															'RENTAL |REPAIR|REPUBLIC |RESEARCH|RESIDENTIAL|RESOURCES|RESTARAUNT|RESTAURANT|'+
															' RETAIL|RETIREMENT|REVOLUTIONARY|RLTY|RLTR| SALES | SALES$|SAVINGS| SCHOOL|SEAFOOD*|'+
															'^SECOND|SECOND BANK|SECURITIES|SECURITY|SEC\'Y| SERVICE |SERVICE|SERVICING|SHIPPING|SHIP AND ALT|'+
															'SOCIETY|SOLUTION|SOUTHERN|SOUTHWEST|SPECIALIST|SPECIALTY|SPRCNTR| STATE |STATE BANK|'+
															'STATE OF | STORAGE | STRATEGIES |SUPERCENTER|SUPPLY|SURGERY|SYSTEMS|TECHNOLOG| TECH |TELECOM|'+
															'TELEPHON| TENANTS |TENNESSEE VALLEY| THE |TIRE & RUBBER| TOURISM | TOWN |^TOWN | TRACTOR |TRADE NAME| TRANSFER |'+
															'TRANSMISSION| TRANSPORT |TRANSPORTATION|TRAVEL |TRUCKING| TRUST |TRUSTEES |'+
															' U S A |UNITED |UNITED STATES| UNIV |^UNIV |UNIVERSAL|UNIVERSITY|UNIV$|^UPS|^U OF |'+
															' USA |US ARMY |US EMBASSY|US MINT| UTILITY| UTILITIES|VALUATION|VENTURES|VOCATIONAL|WACHOVIA BANK|WAREHOUSE| WARRANTY |WASHINGTON MUTUAL|WELLS FARGO|WESTERN|'+
															//Add new known company names 2/14/13 Cathy Tio
															'^INTRAWEST ULC$| LAND AND HOMES$|^SELLS HOMES EVERYWHERE$|' +
															'WILDLIFE|WIRELESS| WORLD |^WORLD | WORLD$|^VA LOAN[S]?|UNDERWRITING|ORIGINATION[S]?)|'+
															//Add new company names 07/27/17 tgeorge
															'A-Z TURN KEY HOMES|HOUSES TO HOMES|HOUSING TO-DAY|^.* LP$|MAIN STREET-USA|RED BIRCH HOMES|SIMPLY SELL NOW|LANDLORD HELPER|REALESTATE56.COM|SOBOTIMESHARERESALES.COMLLC'	
									  		 ,StringLib.StringToUpperCase(pInput));