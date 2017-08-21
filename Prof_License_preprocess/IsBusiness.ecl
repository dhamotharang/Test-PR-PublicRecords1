/*2016-04-26T19:43:34Z (skasavajjala)
C:\Users\KasavaSX\AppData\Roaming\HPCC Systems\eclide\skasavajjala\newdataland\Prof_License_preprocess\IsBusiness\2016-04-26T19_43_34Z.ecl
*/
import lib_stringlib;
                                                                                      

EXPORT IsBusiness(string name )  :=   function 

return if ( trim(name) in [ 'VISKOVIC MARINA','ESTRADA MARINA','JANAZZO MARINA'],'P',                                                                                       
      if (
                  StringLib.StringFind(name,'BLUE WAVE',1) <>  0 or 
                  StringLib.StringFind(name,'TEST',1) <>  0 or 
                  StringLib.StringFind(name,'BEVERAGE',1) <>  0 or 
                  StringLib.StringFind(name,'REFINISHER',1) <>  0 or 
                  StringLib.StringFind(name,'DECORATOR',1) <>  0 or 
                  StringLib.StringFind(name,'DECORATING',1) <>  0 or 
                  StringLib.StringFind(name,'INTL',1) <>  0 or 
                  StringLib.StringFind(name,'HATCHERY',1) <>  0 or 
                  StringLib.StringFind(name,'ANCHORAGE',1) <>  0 or 
                  StringLib.StringFind(name,'APPRAISAL',1) <>  0 or 
                  StringLib.StringFind(name,'APPRAISE',1) <>  0 or 
                  StringLib.StringFind(name,'APPRAISING',1) <>  0 or 
                  StringLib.StringFind(name,'APPRAISOR',1) <>  0 or 
                  StringLib.StringFind(name,'.COM',1) <>  0 or 
                  StringLib.StringFind(name,'.NET',1) <>  0 or 
                  StringLib.StringFind(name,'AUTHORITY ',1) <>  0 or 
                  regexfind('\\bAUTHORITY\\b',name,0) <>  '' or 
                  StringLib.StringFind(name,'CAMPGD ',1) <>  0 or 
                  StringLib.StringFind(name,' CAMPGROUND ',1) <>  0 or 
                  regexfind('\\bCAMPGD\\b',name,0) <>  '' or 
                  regexfind('\\bCAMPGROUND\\b',name,0) <>  '' or 
                  StringLib.StringFind(name,'CONTRACTORS',1) <>  0 or 
                  StringLib.StringFind(name,'SPORTSFISHING',1) <>  0 or 
                  StringLib.StringFind(name,'SPORTFISHING',1) <>  0 or 
                  StringLib.StringFind(name,'BROTHERS ',1) <>  0 or 
                  StringLib.StringFind(name,'ASSOCIATE',1) <>  0 or 
                  StringLib.StringFind(name,'ASSOCIA',1) <>  0 or 
                  StringLib.StringFind(name,'ADVISORY',1) <>  0 or 
                  StringLib.StringFind(name,'ADVISORS',1) <>  0 or 
                  StringLib.StringFind(name,'AGENC',1) <>  0 or 
                  StringLib.StringFind(name,'ASSET',1) <>  0 or 
                  StringLib.StringFind(name,'VALUATIONS',1) <>  0 or 
                 StringLib.StringFind(name,'ASSESMENT',1) <>  0 or 
                 StringLib.StringFind(name,'ENVIRONMENTAL',1) <>  0 or 
                 StringLib.StringFind(name,'MORTGAGE',1) <>  0 or 
                 StringLib.StringFind(name,'MTG',1) <>  0 or 
                 StringLib.StringFind(name,'APPR',1) <>  0 or 
                 StringLib.StringFind(name,'RLTY ',1) <>  0 or 
                 StringLib.StringFind(name,'CERTIFIED',1) <>  0 or 
                 StringLib.StringFind(name,'GENERAL',1) <>  0 or 
                  regexfind('\\bOUTFITTER',name,0) <>  '' or 
                regexfind('\\bMUTUAL\\b'   ,name,0) <> '' or 
                  regexfind('\\bADVENTURE\\b'  ,name ,0) <> '' or 
                  regexfind('\\bEXPEDITION\\b' ,name,0) <> '' or 
                  regexfind('\\bEXCURSION\\b'   ,name ,0) <> '' or 
                  regexfind('\\bEXTINGUISHER\\b',name ,0) <> '' or 
                  regexfind('\\bPERFORMANCE',name ,0) <> '' or 
                  regexfind('\\bPROFITEER',name ,0) <> '' or 
                  regexfind('\\bRIVER BEND' ,name ,0) <> '' or 
                  regexfind('\\bRIVERBEND' ,name,0) <> '' or 
                  regexfind('\\bFACILITY'  ,name ,0) <> '' or 
                  regexfind('\\bMARINE\\b'    ,name ,0) <> '' or 
                  regexfind('\\bHARBOR\\b'    ,name ,0) <> '' or 
                  regexfind('\\bIMPORT'    ,name ,0) <> '' or 
                  regexfind('\\bISLAND'   ,name ,0) <> '' or 
                  StringLib.StringFind(name,'POWERSPORTS',1) <>  0 or 
                  StringLib.StringFind(name,'POWER SPORTS',1) <>  0 or 
                  StringLib.StringFind(name,'& SONS',1) <>  0 or 
                  StringLib.StringFind(name, 'PRECISION',1) <>  0 or 
                  StringLib.StringFind(name,'ISLANDS  ',1) <>  0 or 
                  StringLib.StringFind(name,'ISLAND',1) <>  0 or 
                  StringLib.StringFind(name,' SPORT ',1) <>  0 or 
                  StringLib.StringFind(name,' SPORTS ',1) <>  0 or 
                  StringLib.StringFind(name,' ADVENTURES ',1) <>  0 or 
                  StringLib.StringFind(name,', N A',1) <>  0 or 
                  StringLib.StringFind(name,', N. A.',1) <>  0 or 
                  StringLib.StringFind(name, ' RENTALS ',1) <>  0 or 
                  StringLib.StringFind(name,', N.A.',1) <>  0 or 
                  StringLib.StringFind(name,' INC ',1) <>  0 or 
                  StringLib.StringFind(name,' INC.',1) <>  0 or 
                  StringLib.StringFind(name,',INC ',1) <>  0 or 
                  StringLib.StringFind(name,',INC.',1) <>  0 or 
                  StringLib.StringFind(name,' INCORP',1) <>  0 or 
                  StringLib.StringFind(name,',INCORP',1) <>  0 or 
                  StringLib.StringFind(name,' INC.',1) <>  0 or 
                  StringLib.StringFind(name,',N. A.',1) <>  0 or 
                  StringLib.StringFind(name,',N.A.',1) <>  0 or 
                  StringLib.StringFind(name,'1ST BANK',1) <>  0 or 
                  StringLib.StringFind(name,'2ND BANK',1) <>  0 or 
                  StringLib.StringFind(name,'ACADEMY ',1) <>  0 or 
                  StringLib.StringFind(name,' ACADEMY$',1) <>  0 or 
                  StringLib.StringFind(name,'ACCOUNTING',1) <>  0 or 
                  StringLib.StringFind(name,'ACCOUNTS',1) <>  0 or 
                  StringLib.StringFind(name,'ADMINISTRATION',1) <>  0 or 
                  StringLib.StringFind(name,'AFFORDABLE',1) <>  0 or 
                  StringLib.StringFind(name,'AGENCY',1) <>  0 or 
                  StringLib.StringFind(name,'AIR CONDITIONING',1) <>  0 or 
                  StringLib.StringFind(name,'AIRLINES',1) <>  0 or 
                  StringLib.StringFind(name,'ALIGNMENT',1) <>  0 or 
                  StringLib.StringFind(name,'AMBULANCE',1) <>  0 or 
                  StringLib.StringFind(name,'AMERICAN',1) <>  0 or 
                  StringLib.StringFind(name,'AMUSEMENT',1) <>  0 or 
                  StringLib.StringFind(name,'AND KNEE',1) <>  0 or 
                  StringLib.StringFind(name,'AND SONS',1) <>  0 or 
                  StringLib.StringFind(name,'ANIMAL ',1) <>  0 or 
                  StringLib.StringFind(name,'ANTIQUE',1) <>  0 or 
                  StringLib.StringFind(name,'APARTMENT',1) <>  0 or 
                  StringLib.StringFind(name,'APLC',1) <>  0 or 
                  StringLib.StringFind(name,'APPLIANCE',1) <>  0 or 
                  StringLib.StringFind(name,'ARCHETECT',1) <>  0 or 
                  StringLib.StringFind(name,'ARCHITECT',1) <>  0 or 
                  StringLib.StringFind(name,'AS AGENT',1) <>  0 or 
                  StringLib.StringFind(name,'ASSOC ',1) <>  0 or 
                  StringLib.StringFind(name,'ASSOC.',1) <>  0 or 
                  StringLib.StringFind(name,'ASSOCIATES',1) <>  0 or 
                  StringLib.StringFind(name,'ASSOCIATION',1) <>  0 or 
                  StringLib.StringFind(name,'ATTORNEYS',1) <>  0 or 
                  StringLib.StringFind(name,'AUTOMOTIVE',1) <>  0 or 
                  StringLib.StringFind(name,'AUTORAMA',1) <>  0 or 
                  StringLib.StringFind(name,'AVIATION',1) <>  0 or 
                  StringLib.StringFind(name,'BALL BEARINGS',1) <>  0 or 
                  StringLib.StringFind(name,'BANK OF',1) <>  0 or 
                  StringLib.StringFind(name,'BANK ONE',1) <>  0 or 
                  StringLib.StringFind(name,'BANK N.A.',1) <>  0 or 
                  StringLib.StringFind(name,'BANK NA',1) <>  0 or 
                  StringLib.StringFind(name,'BOAT',1) <>  0 or 
                  StringLib.StringFind(name,'BOATS',1) <>  0 or 
                  StringLib.StringFind(name,'MARINA',1) <>  0 or 
                  StringLib.StringFind(name,'SPORTSMAN',1) <>  0 or 
                  StringLib.StringFind(name,'REC PARK',1) <>  0 or 
                  StringLib.StringFind(name,'RECREATION ',1) <>  0 or 
                  StringLib.StringFind(name,'WATERCRAFT',1) <>  0 or 
                  StringLib.StringFind(name,'WATERSPORT',1) <>  0 or 
                  StringLib.StringFind(name,' BEEP OF ',1) <>  0 or 
                  StringLib.StringFind(name,'BLUE CROSS',1) <>  0 or 
                  StringLib.StringFind(name,'BLUE SHIELD',1) <>  0 or 
                  StringLib.StringFind(name,'BOOKBINDER',1) <>  0 or 
                  StringLib.StringFind(name,'BOOKKEEPING',1) <>  0 or 
                  StringLib.StringFind(name,'BOTTLING',1) <>  0 or 
                  StringLib.StringFind(name,'BOUTIQUE',1) <>  0 or 
                  StringLib.StringFind(name,'BROKERAGE',1) <>  0 or 
                  StringLib.StringFind(name,' BROKERS',1) <>  0 or 
                  StringLib.StringFind(name,'BUILDING',1) <>  0 or 
                  StringLib.StringFind(name,'BUREAU ',1) <>  0 or 
                  StringLib.StringFind(name,'BUSINESS',1) <>  0 or 
                  StringLib.StringFind(name,'BUTANE ',1) <>  0 or 
                  StringLib.StringFind(name,'BUYERS ',1) <>  0 or 
                  StringLib.StringFind(name,'CABLEVISION',1) <>  0 or 
                  StringLib.StringFind(name,'CARBURETOR',1) <>  0 or 
                  StringLib.StringFind(name,'CASUALTY',1) <>  0 or 
                  StringLib.StringFind(name,' CENTER ',1) <>  0 or 
                  StringLib.StringFind(name,' CHAPTER ',1) <>  0 or 
                  StringLib.StringFind(name,'CHARITIES',1) <>  0 or 
                  StringLib.StringFind(name,'CHASE BANK',1) <>  0 or 
                  StringLib.StringFind(name,'CHASE MANHATTAN BANK',1) <>  0 or 
                  StringLib.StringFind(name,'CHEMICAL',1) <>  0 or 
                  StringLib.StringFind(name,' CHIRO ',1) <>  0 or 
                  StringLib.StringFind(name,'CHIROPRACTIC',1) <>  0 or 
                  StringLib.StringFind(name,'CHURCH OF ',1) <>  0 or 
                  StringLib.StringFind(name,'CITIBANK',1) <>  0 or 
                  StringLib.StringFind(name,'CITIGROUP',1) <>  0 or 
                  StringLib.StringFind(name,'CITIZENS BANK',1) <>  0 or 
                  StringLib.StringFind(name,' CITY ',1) <>  0 or 
                  StringLib.StringFind(name,'CLEANING',1) <>  0 or 
                  StringLib.StringFind(name,' CLINIC',1) <>  0 or 
                  StringLib.StringFind(name,' CLUB ',1) <>  0 or 
                  StringLib.StringFind(name,'CMNTY',1) <>  0 or 
                  StringLib.StringFind(name,' CO ',1) <>  0 or 
                  StringLib.StringFind(name,' CO-OP ',1) <>  0 or 
                  StringLib.StringFind(name,'CO.',1) <>  0 or 
                  StringLib.StringFind(name,'COLLECT',1) <>  0 or 
                  StringLib.StringFind(name,'COMMERCE',1) <>  0 or 
                  StringLib.StringFind(name,'COMMUNICATION',1) <>  0 or 
                  StringLib.StringFind(name,'COMMUNITY',1) <>  0 or 
                  StringLib.StringFind(name,'COMPANY',1) <>  0 or 
                  StringLib.StringFind(name,'COMPUTER',1) <>  0 or 
                  StringLib.StringFind(name,' CONCRETE ',1) <>  0 or 
                  StringLib.StringFind(name,'CONST.',1) <>  0 or 
                  StringLib.StringFind(name,'CONSTRUCTION',1) <>  0 or 
                  StringLib.StringFind(name,'CONSULTANTS',1) <>  0 or 
                  StringLib.StringFind(name,'CONSULTING',1) <>  0 or 
                  StringLib.StringFind(name,'CONSULTANT',1) <>  0 or 
           StringLib.StringFind(name,'INSPECTION',1) <>  0 or 
                  StringLib.StringFind(name,'LENDER',1) <>  0 or 
                  StringLib.StringFind(name,'CUTTING EDGE',1) <>  0 or 
                  StringLib.StringFind(name,'APPAISAL PLANNING',1) <>  0 or 
                  StringLib.StringFind(name,'BANK',1) <>  0 or 
                  StringLib.StringFind(name,'ALLIANCE',1) <>  0 or 
                  StringLib.StringFind(name,'APPRAISCO',1) <>  0 or 
                  StringLib.StringFind(name,'APPRAISINC',1) <>  0 or 
                  StringLib.StringFind(name,'APPRAISYS',1) <>  0 or 
                  StringLib.StringFind(name,'ASSESSMENT',1) <>  0 or 
                  StringLib.StringFind(name,'CONSUMER ',1) <>  0 or 
                  StringLib.StringFind(name,'CONTRACTING',1) <>  0 or 
                  StringLib.StringFind(name,' CONTROL ',1) <>  0 or 
                  StringLib.StringFind(name,' COOP ',1) <>  0 or 
                  StringLib.StringFind(name,'COOPERATIVE',1) <>  0 or 
                  StringLib.StringFind(name,' CORP ',1) <>  0 or 
                  StringLib.StringFind(name,'CORP.',1) <>  0 or 
                  StringLib.StringFind(name,'CORPORATE',1) <>  0 or 
                  StringLib.StringFind(name,'CORPORATION',1) <>  0 or 
                  StringLib.StringFind(name,' COUNCIL ',1) <>  0 or 
                  StringLib.StringFind(name,'COUNTRY CLUB',1) <>  0 or 
                  StringLib.StringFind(name,' COUNTY ',1) <>  0 or 
                  StringLib.StringFind(name,'COUNTY OF ',1) <>  0 or 
                  StringLib.StringFind(name,' CREDIT ',1) <>  0 or 
                  StringLib.StringFind(name,'CRESTAR BANK',1) <>  0 or 
                  StringLib.StringFind(name,' D/B/A ',1) <>  0 or 
                  StringLib.StringFind(name,'DAY CARE',1) <>  0 or 
                  StringLib.StringFind(name,' DBA ',1) <>  0 or 
                  StringLib.StringFind(name,' DELI ',1) <>  0 or 
                  StringLib.StringFind(name,'DEPARTMENT',1) <>  0 or 
                  StringLib.StringFind(name,' DEPARTMT ',1) <>  0 or 
                  StringLib.StringFind(name,' DEPT ',1) <>  0 or 
                  StringLib.StringFind(name,' DEPT.',1) <>  0 or 
                  StringLib.StringFind(name,'DETROIT',1) <>  0 or 
                  StringLib.StringFind(name,' DEVELOPERS ',1) <>  0 or 
                  StringLib.StringFind(name,'DEVELOPMENT',1) <>  0 or 
                  StringLib.StringFind(name,' DIST ',1) <>  0 or 
                  StringLib.StringFind(name,'DISTRIBUTI',1) <>  0 or 
                  StringLib.StringFind(name,'DISTRICT',1) <>  0 or 
                  StringLib.StringFind(name,'DIVISION',1) <>  0 or 
                  StringLib.StringFind(name,'DVLPMNTL',1) <>  0 or 
                  StringLib.StringFind(name,'EASTERN',1) <>  0 or 
                  StringLib.StringFind(name,'ELECTRICAL',1) <>  0 or 
                  StringLib.StringFind(name,'ELEVATOR',1) <>  0 or 
                  StringLib.StringFind(name,'ENGINEERING',1) <>  0 or 
      StringLib.StringFind(name,'ENTERPRISE',1) <>  0 or 
                  StringLib.StringFind(name,'EQUIPMENT',1) <>  0 or 
                  StringLib.StringFind(name,'EQUITY',1) <>  0 or 
                  StringLib.StringFind(name,'ESTATES',1) <>  0 or 
                  StringLib.StringFind(name,' ESQS ',1) <>  0 or 
                  StringLib.StringFind(name,' ESQS. ',1) <>  0 or 
                  StringLib.StringFind(name,'EXCAVATING',1) <>  0 or 
                  StringLib.StringFind(name,'EXPRESS',1) <>  0 or 
                  StringLib.StringFind(name,' F S B',1) <>  0 or 
                  StringLib.StringFind(name,' FSB',1) <>  0 or 
                  StringLib.StringFind(name,'FABRICATORS',1) <>  0 or 
                  StringLib.StringFind(name,'FARM ',1) <>  0 or 
                  StringLib.StringFind(name,'FIDELITY BANK',1) <>  0 or 
                  StringLib.StringFind(name,'FINANCE ',1) <>  0 or 
                  StringLib.StringFind(name,'FINANCIAL ',1) <>  0 or 
                  StringLib.StringFind(name,'FIRE',1) <>  0 or 
                  StringLib.StringFind(name,'FIRM',1) <>  0 or 
                  StringLib.StringFind(name,'FIRST BANK',1) <>  0 or 
                  StringLib.StringFind(name,'FLEET BANK',1) <>  0 or 
                  StringLib.StringFind(name,' FLYING ',1) <>  0 or 
                  StringLib.StringFind(name,'FOUNDATION',1) <>  0 or 
                  StringLib.StringFind(name,'FREIGHT',1) <>  0 or 
                  StringLib.StringFind(name,'FULFILLMENT',1) <>  0 or 
                  StringLib.StringFind(name,'FULLFILLMENT',1) <>  0 or 
                  StringLib.StringFind(name,'FUNERAL HOME',1) <>  0 or 
                  StringLib.StringFind(name,'FURNITURE',1) <>  0 or 
                  StringLib.StringFind(name,' GAZETTE ',1) <>  0 or 
                  StringLib.StringFind(name,'GOVERNMENT',1) <>  0 or 
                  StringLib.StringFind(name,'GROCERY ',1) <>  0 or 
                  StringLib.StringFind(name,'GROUP',1) <>  0 or 
                  StringLib.StringFind(name,'GROWERS',1) <>  0 or 
                  StringLib.StringFind(name,'GVRNMNT',1) <>  0 or 
                  StringLib.StringFind(name,'GYM',1) <>  0 or 
                  StringLib.StringFind(name,'HEALTH ',1) <>  0 or 
                  StringLib.StringFind(name,'HEALTHCARE',1) <>  0 or 
                  StringLib.StringFind(name,'HOME LIFE',1) <>  0 or 
                  StringLib.StringFind(name,'HOSP',1) <>  0 or 

       StringLib.StringFind(name,' HOTEL',1) <>  0 or 
                  StringLib.StringFind(name,'HOSPICE',1) <>  0 or 
                  StringLib.StringFind(name,' HOSPITAL',1) <>  0 or 
                  StringLib.StringFind(name,' HUNTING ',1) <>  0 or 
                  StringLib.StringFind(name,'IMPROVEMENT',1) <>  0 or 
                  StringLib.StringFind(name,'INDUSTRIAL',1) <>  0 or 
                  StringLib.StringFind(name,'INDUSTRIES',1) <>  0 or 
                  StringLib.StringFind(name,' INN ',1) <>  0 or 
                  StringLib.StringFind(name,'INNOVATIVE',1) <>  0 or 
                  StringLib.StringFind(name,' INS ',1) <>  0 or 
                  StringLib.StringFind(name,' INS. ',1) <>  0 or 
                  StringLib.StringFind(name,'INSTITUTE',1) <>  0 or 
                  StringLib.StringFind(name,'INSURANCE',1) <>  0 or 
                  StringLib.StringFind(name,'INTEREST',1) <>  0 or 
                  StringLib.StringFind(name,'INTERIORS',1) <>  0 or 
                  StringLib.StringFind(name,'INVESTMENT',1) <>  0 or 
                  StringLib.StringFind(name,'JPMORGAN',1) <>  0 or 
                  StringLib.StringFind(name,' L L C',1) <>  0 or 
                  StringLib.StringFind(name,' L L P',1) <>  0 or 
                  StringLib.StringFind(name,'L.L.C.',1)  <>  0 or 
                  StringLib.StringFind(name,'L.L.P.',1) <>  0 or 
                  StringLib.StringFind(name,' L.P.',1) <>  0 or 
                  StringLib.StringFind(name,'L.T.D.',1)  <>  0 or 
                  StringLib.StringFind(name,'LANDFILL',1) <>  0 or 
                  StringLib.StringFind(name,'LABORATORIES',1) <>  0 or 
                  StringLib.StringFind(name,'LANDSCAPING',1) <>  0 or 
                  StringLib.StringFind(name,'LAUNDROMAT',1) <>  0 or 
                  StringLib.StringFind(name,'LAW FIRM',1) <>  0 or 
                  StringLib.StringFind(name,'LAW OFFICES',1) <>  0 or 
                  StringLib.StringFind(name,'LAWYERS ',1) <>  0 or 
                  StringLib.StringFind(name,'LEAGUE ',1) <>  0 or 
                  StringLib.StringFind(name,'LEARNING',1) <>  0 or 
                  StringLib.StringFind(name,'LEASE ',1) <>  0 or 
                  StringLib.StringFind(name,'LEASING ',1) <>  0 or 
                  StringLib.StringFind(name,'LIBRARY',1) <>  0 or 
                  StringLib.StringFind(name,'LIMITED',1) <>  0 or 
                  StringLib.StringFind(name,'LIQUOR',1) <>  0 or 
                  StringLib.StringFind(name,'LLC',1) <>  0 or 
                  StringLib.StringFind(name,'LLP',1) <>  0 or 
                  StringLib.StringFind(name,'LOGGING',1) <>  0 or 
                  StringLib.StringFind(name,' LP ',1) <>  0 or 
                  StringLib.StringFind(name,' LTD',1) <>  0 or 
                  StringLib.StringFind(name,'MACHINE',1) <>  0 or 
                  StringLib.StringFind(name,'MANAGEMENT',1) <>  0 or 
                  StringLib.StringFind(name,'MANUFACTUR',1) <>  0 or 
                  StringLib.StringFind(name,' MARKET ',1) <>  0 or 
                  StringLib.StringFind(name,'MARLBOROUGH COUNTRY',1) <>  0 or 
                  StringLib.StringFind(name,'MATSUSHITA',1) <>  0 or 
                  StringLib.StringFind(name,'MATUSHITA',1) <>  0 or 
                  StringLib.StringFind(name,'MEDICAL ',1) <>  0 or 
                  StringLib.StringFind(name,'MELLON BANK',1) <>  0 or 
                  StringLib.StringFind(name,'MERCHANTS ',1) <>  0 or 
                  StringLib.StringFind(name,'METHODIST',1) <>  0 or 
                  StringLib.StringFind(name,'MGMT',1) <>  0 or 
                  StringLib.StringFind(name,'MGT',1) <>  0 or 
                  StringLib.StringFind(name,' MILLING ',1) <>  0 or 
                  StringLib.StringFind(name,'MINISTRIES',1) <>  0 or 
                  StringLib.StringFind(name,'MISSIONARY',1) <>  0 or 
                  StringLib.StringFind(name,'MNGMNT',1) <>  0 or 
                  StringLib.StringFind(name,'MOBILE HOME',1) <>  0 or 
                  StringLib.StringFind(name,'MOBILE PARK',1) <>  0 or 
                  StringLib.StringFind(name,'MOTEL ',1) <>  0 or 
                  StringLib.StringFind(name,'MOUNTAIN',1) <>  0 or 
                  StringLib.StringFind(name,'MUNCIPAL ',1) <>  0 or 
                  StringLib.StringFind(name,'MUSEUM',1) <>  0 or 
                  StringLib.StringFind(name,'NATION ',1) <>  0 or 
                  StringLib.StringFind(name,'NATIONAL',1) <>  0 or 
                  StringLib.StringFind(name,'NATIONSBANK',1) <>  0 or 
                  StringLib.StringFind(name,'NATIONS BANK',1) <>  0 or 
                  StringLib.StringFind(name,'NAT\'L ',1) <>  0 or 
                  StringLib.StringFind(name,'NATL ',1) <>  0 or 
                  StringLib.StringFind(name,'NATL. ',1) <>  0 or 
                  StringLib.StringFind(name,'NATURAL GAS',1) <>  0 or 
                  StringLib.StringFind(name,'NCNB',1) <>  0 or 
                  StringLib.StringFind(name,'NETWORK',1) <>  0 or 
                  StringLib.StringFind(name,'NEUROLOGICAL',1) <>  0 or 
                  StringLib.StringFind(name,'NEUROLOGY',1) <>  0 or 
                  StringLib.StringFind(name,'NORTHERN',1) <>  0 or 
                  StringLib.StringFind(name,'OF AMERICA',1) <>  0 or 
                  StringLib.StringFind(name,'OFFICE',1) <>  0 or 
                  StringLib.StringFind(name,'OPTHAMOLOG',1) <>  0 or 
                  StringLib.StringFind(name,'OPHTHAMOLOG',1) <>  0 or 
                  StringLib.StringFind(name,'OPTICAL',1) <>  0 or 
                  StringLib.StringFind(name,'ORGANISATION',1) <>  0 or 
                  StringLib.StringFind(name,'ORGANIZATION',1) <>  0 or 
                  StringLib.StringFind(name,' ORTHO ',1) <>  0 or 
                  StringLib.StringFind(name,' ORTHOPEDIC ',1) <>  0 or 
                  StringLib.StringFind(name,' P S C',1) <>  0 or 
   StringLib.StringFind(name,'PACKAGING',1) <>  0 or 
                  StringLib.StringFind(name,' PARTNERS',1) <>  0 or 
                  StringLib.StringFind(name,'PARTNERSHIP',1) <>  0 or 
                  regexfind(' PC$|,PC$',trim(name),0) <>  '' or 
                  StringLib.StringFind(name,'PEDIATRICS',1) <>  0 or 
                  StringLib.StringFind(name,'PEER REVIEW',1) <>  0 or 
                  StringLib.StringFind(name,'PENSION PLAN',1) <>  0 or 
                  StringLib.StringFind(name,'PERFORMING ARTS',1) <>  0 or 
                  StringLib.StringFind(name,'PETROLEUM',1) <>  0 or 
                  StringLib.StringFind(name,'PHARMACEUTICAL',1) <>  0 or 
                  StringLib.StringFind(name,'PHARMACY',1) <>  0 or 
                  StringLib.StringFind(name,'PHOTOGRAPHIC',1) <>  0 or 
                  StringLib.StringFind(name,'PLANNED',1) <>  0 or 
                  StringLib.StringFind(name,' PLASTIC ',1) <>  0 or 
                  StringLib.StringFind(name,' PLAZA',1) <>  0 or 
                  StringLib.StringFind(name,'PLUMBING',1) <>  0 or 
                  StringLib.StringFind(name,'PNC ',1) <>  0 or 
                  StringLib.StringFind(name,' POLICE ',1) <>  0 or 
                  StringLib.StringFind(name,'PRENTICE HALL',1) <>  0 or 
                  StringLib.StringFind(name,'PRODUCTIONS',1) <>  0 or 
                  StringLib.StringFind(name,'PROFESSIONAL',1) <>  0 or 
                  StringLib.StringFind(name,'PROPERTIES',1) <>  0 or 
                  StringLib.StringFind(name,'PROPERTY',1) <>  0 or 
                  StringLib.StringFind(name,'PROVINCE',1) <>  0 or 
                  StringLib.StringFind(name,'PSC',1) <>  0 or 
                  StringLib.StringFind(name,'PUBLICATIONS',1) <>  0 or 
                  StringLib.StringFind(name,'QUARTER',1) <>  0 or 
                  StringLib.StringFind(name,'RADIO',1) <>  0 or 
                  StringLib.StringFind(name,'RAILROAD',1) <>  0 or 
                  StringLib.StringFind(name,' RAILWAY',1) <>  0 or 
                  StringLib.StringFind(name,'REAL ESTATE',1) <>  0 or 
                  StringLib.StringFind(name,'REAL ESTAT',1) <>  0 or 
                  StringLib.StringFind(name,'REAL EST',1) <>  0 or 
                  StringLib.StringFind(name,'REALTORS',1) <>  0 or 
                  StringLib.StringFind(name,'REALTOR',1) <>  0 or 
                  StringLib.StringFind(name,'REALTY',1) <>  0 or 
                  StringLib.StringFind(name,'REBUILDERS',1) <>  0 or 
                  StringLib.StringFind(name,'REMODELING',1) <>  0 or 
                  StringLib.StringFind(name,'RENTAL ',1) <>  0 or 
                  StringLib.StringFind(name,'REPAIR',1) <>  0 or 
                  StringLib.StringFind(name,'REPUBLIC ',1) <>  0 or 
                  StringLib.StringFind(name,'RESIDENTIAL',1) <>  0 or 
                  StringLib.StringFind(name,'RESOURCES',1) <>  0 or 
                  StringLib.StringFind(name,'RESTARAUNT',1) <>  0 or 
    StringLib.StringFind(name,'RESTAURANT',1) <>  0 or 
                  StringLib.StringFind(name,' RETAIL',1) <>  0 or 
                  StringLib.StringFind(name,'RETIREMENT',1) <>  0 or 
                  StringLib.StringFind(name,'REVOLUTIONARY',1) <>  0 or 
                  StringLib.StringFind(name,' SALES ',1) <>  0 or 
                  StringLib.StringFind(name,'SAVINGS',1) <>  0 or 
                  StringLib.StringFind(name,' SCHOOL ',1) <>  0 or 
                  StringLib.StringFind(name,'SEAFOOD',1) <>  0 or 
                  StringLib.StringFind(name,'SECOND BANK',1) <>  0 or 
                  StringLib.StringFind(name,'SECURITIES',1) <>  0 or 
                  StringLib.StringFind(name,'SECURITY',1) <>  0 or 
                  StringLib.StringFind(name,'SER.',1) <>  0 or 
                  StringLib.StringFind(name,'SERVICE',1) <>  0 or 
                  StringLib.StringFind(name,'SHIPPING',1) <>  0 or 
                  StringLib.StringFind(name,'SOCIETY',1) <>  0 or 
                  StringLib.StringFind(name,'SOLUTION',1) <>  0 or 
                  StringLib.StringFind(name,'SOUTHERN',1) <>  0 or 
                  StringLib.StringFind(name,'SPECIALIST',1) <>  0 or 
                  StringLib.StringFind(name,'SPECIALTY',1) <>  0 or 
                  StringLib.StringFind(name,'SPRCNTR',1) <>  0 or 
                  StringLib.StringFind(name,'STATE',1) <>  0 or 
                  StringLib.StringFind(name,'STATE BANK',1) <>  0 or 
                  StringLib.StringFind(name,'STATE OF ',1) <>  0 or 
                  StringLib.StringFind(name,' STORAGE ',1) <>  0 or 
                  StringLib.StringFind(name,'SUPERCENTER',1) <>  0 or 
                  StringLib.StringFind(name,'SUPPLY',1) <>  0 or 
                  StringLib.StringFind(name,'SURGERY',1) <>  0 or 
                  StringLib.StringFind(name,'SYSTEMS',1) <>  0 or 
                  StringLib.StringFind(name,'TECHNOLOG',1) <>  0 or 
                  StringLib.StringFind(name,'TELECOM',1) <>  0 or 
                  StringLib.StringFind(name,'TELEPHON',1) <>  0 or 
            //      StringLib.StringFind(name,'THE',1) <>  0 or 
                  StringLib.StringFind(name,'TIRE & RUBBER',1) <>  0 or 
       //           StringLib.StringFind(name,'TOWN',1) <>  0 or 
                  StringLib.StringFind(name,'TRACTOR',1) <>  0 or 
                  StringLib.StringFind(name,'TRADE NAME',1) <>  0 or 
                  StringLib.StringFind(name,'TRANSFER',1) <>  0 or 
                  StringLib.StringFind(name,'TRANSMISSION',1) <>  0 or 
                  StringLib.StringFind(name,'TRANSPORT',1) <>  0 or 
                  StringLib.StringFind(name,'TRAVEL',1) <>  0 or 
                  StringLib.StringFind(name,'TRUCKING',1) <>  0 or 
                  StringLib.StringFind(name,'TRUST',1) <>  0 or 
                  StringLib.StringFind(name,'U S A',1) <>  0 or 
                  StringLib.StringFind(name,'UNITED ',1) <>  0 or 
                  StringLib.StringFind(name,'UNITED STATES',1) <>  0 or 
                  StringLib.StringFind(name,' UNIV ',1) <>  0 or 
                  StringLib.StringFind(name,'UNIVERSAL',1) <>  0 or 
                  StringLib.StringFind(name,'UNIVERSITY',1) <>  0 or 
                  StringLib.StringFind(name,'USA',1) <>  0 or 
                  StringLib.StringFind(name,'VOCATIONAL',1) <>  0 or 
                  StringLib.StringFind(name,'WACHOVIA BANK',1) <>  0 or 
                  StringLib.StringFind(name,'WAREHOUSE',1) <>  0 or 
                  StringLib.StringFind(name,' WARRANTY ',1) <>  0 or 
                  StringLib.StringFind(name,'WELLS FARGO',1) <>  0 or 
                  StringLib.StringFind(name,'WESTERN',1) <>  0 or 
                  StringLib.StringFind(name,'WILDLIFE',1) <>  0 or 
                  StringLib.StringFind(name,'WIRELESS',1) <>  0 or 
                  StringLib.StringFind(name,' WORLD ',1) <>  0 or 
									regexfind('\\bTHE\\b',name,0) <>  '' or 
                   regexfind('\\bISLAND',name,0) <>  '' or 
                  regexfind('\\bSPORT',name,0) <>  '' or 
				   regexfind('\\bADVENTURE',name,0) <>  '' or 
                  regexfind( '\\bRENTAL',name,0) <>  '' or 
                  regexfind('\\b,INC',name,0) <>  '' or 
                 regexfind('\\bBOAT',name,0) <>  '' or 
                  regexfind('\\bYACHT',name,0) <>  '' or 
                  regexfind('\\bMARINA',name,0) <>  '' or 
                  regexfind('\\bSPORTSMAN',name,0) <>  '' or 
                  regexfind('\\bBUREAU\\b',name,0) <>  '' or 
                  regexfind('\\bCENTER',name,0) <>  '' or 
                  regexfind('\\bCHURCH',name,0) <>  '' or 
                  regexfind('\\bCITY',name,0) <>  '' or 
                  regexfind('\\bCHAPTER',name,0) <>  '' or 
                  regexfind('\\bCHAPTER',name,0) <>  '' or 				  
                  regexfind('CITY\\b',name,0) <>  '' or 
                  regexfind('CREDIT',name,0) <>  '' or 
                  regexfind('\\bFIRE',name,0) <>  '' or 
                 regexfind('FIRM',name,0) <>  '' or 
                  regexfind('\\bFIRST',name,0) <>  '' or 				  
                 regexfind('FLYING$',name,0) <>  '' or 
                  regexfind('\\bFNB',name,0) <>  '' or 
	              regexfind('\\bGAZETTE',name,0) <>  '' or 
                regexfind('\\bGROUP',name,0) <>  '' or 
                 regexfind('GYM',name,0) <>  '' or 				                   
				 regexfind('\\bHEALTH',name,0) <>  '' or 
                  regexfind('HUNTING',name,0) <>  '' or 
                  regexfind('\\bINN',name,0) <>  '' or 
                  regexfind('\\bLANDFILL',name,0) <>  '' or 
                  regexfind('\\bLP',name,0) <>  '' or 
                 regexfind('MARKET',name,0) <>  '' or 
                  regexfind('MEDICAL',name,0) <>  '' or 
                  regexfind('MOTEL',name,0) <>  '' or 
                  regexfind('NAT\'L',name,0) <>  '' or 
                  regexfind('NATL',name,0) <>  '' or 
                  regexfind('NATL/.',name,0) <>  '' or 
                  regexfind('PARTNERS ',name,0) <>  '' or 
                  regexfind('\\bSALES',name,0) <>  '' or 
                  regexfind('\\bSECOND',name,0) <>  '' or 
                  regexfind('\\bTOWN\\b',name,0) <>  '' or 
                  regexfind('\\bUNIV',name,0) <>  '' or 
                  regexfind('U OF',name,0) <>  '' or 
                 regexfind('\\bWORLD',name,0) <>  '' or 
                  regexfind('^[1-9]',name,0 ) <> '' ,'B','P'));   
									
end;