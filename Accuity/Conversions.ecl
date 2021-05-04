export Conversions := module

//////////////////////////////////////////////////////////////////////////
export string EtypeCodetoDescr(string code) := 
map(
code =     '01'  =>       'Country',//'Government/Country',
code =     '02'  =>       'Principal City',
code =     '03'  =>       'Individual',
code =     '04'  =>       'Vessel',
code =     '05'  =>       'Business',//'Bank',
code =     '06'  =>       'Business',//'Other',
code =     '07'  =>       'Individual',//'Minister/Government Official',
code =     '08'  =>       'Business',
code =     '09'  =>       'Business',//'Political/Religious Organization'
    '');
	
export boolean IsPersonCode(string code) := code in ['03','07'];
export boolean IsBusinessCode(string code) := code in ['04','05','08','09'];

//////////////////////////////////////////////////////////////////////////
export string AlphatoNumericMonth(string date) := 
map(
regexfind('NK',stringlib.stringfilterout(stringlib.stringtouppercase(date),' ')) =>   '',
regexfind('JANUARY',stringlib.stringfilterout(stringlib.stringtouppercase(date),' ')) =>   regexreplace('JANUARY',stringlib.stringfilterout(stringlib.stringtouppercase(date),' '),'01/00/'),
regexfind('FEBRUARY',stringlib.stringfilterout(stringlib.stringtouppercase(date),' ')) =>   regexreplace('FEBRUARY',stringlib.stringfilterout(stringlib.stringtouppercase(date),' '),'02/00/'),
regexfind('MARCH',stringlib.stringfilterout(stringlib.stringtouppercase(date),' ')) =>   regexreplace('MARCH',stringlib.stringfilterout(stringlib.stringtouppercase(date),' '),'03/00/'),
regexfind('APRIL',stringlib.stringfilterout(stringlib.stringtouppercase(date),' ')) =>   regexreplace('APRIL',stringlib.stringfilterout(stringlib.stringtouppercase(date),' '),'04/00/'),
regexfind('MAY',stringlib.stringfilterout(stringlib.stringtouppercase(date),' ')) =>   regexreplace('MAY',stringlib.stringfilterout(stringlib.stringtouppercase(date),' '),'05/00/'),
regexfind('JUNE',stringlib.stringfilterout(stringlib.stringtouppercase(date),' ')) =>   regexreplace('JUNE',stringlib.stringfilterout(stringlib.stringtouppercase(date),' '),'06/00/'),
regexfind('JULY',stringlib.stringfilterout(stringlib.stringtouppercase(date),' ')) =>   regexreplace('JULY',stringlib.stringfilterout(stringlib.stringtouppercase(date),' '),'07/00/'),
regexfind('AUGUST',stringlib.stringfilterout(stringlib.stringtouppercase(date),' ')) =>   regexreplace('AUGUST',stringlib.stringfilterout(stringlib.stringtouppercase(date),' '),'08/00/'),
regexfind('SEPTEMBER',stringlib.stringfilterout(stringlib.stringtouppercase(date),' ')) => regexreplace('SEPTEMBER',stringlib.stringfilterout(stringlib.stringtouppercase(date),' '),'09/00/'),
regexfind('OCTOBER',stringlib.stringfilterout(stringlib.stringtouppercase(date),' ')) =>   regexreplace('OCTOBER',stringlib.stringfilterout(stringlib.stringtouppercase(date),' '),'10/00/'),
regexfind('NOVEMBER',stringlib.stringfilterout(stringlib.stringtouppercase(date),' ')) =>   regexreplace('NOVEMBER',stringlib.stringfilterout(stringlib.stringtouppercase(date),' '),'11/00/'),
regexfind('DECEMBER',stringlib.stringfilterout(stringlib.stringtouppercase(date),' ')) =>   regexreplace('DECEMBER',stringlib.stringfilterout(stringlib.stringtouppercase(date),' '),'12/00/'),

regexfind('JAN',stringlib.stringfilterout(stringlib.stringtouppercase(date),' ')) =>   regexreplace('JAN',stringlib.stringfilterout(stringlib.stringtouppercase(date),' '),'01/00/'),
regexfind('FEB',stringlib.stringfilterout(stringlib.stringtouppercase(date),' ')) =>   regexreplace('FEB',stringlib.stringfilterout(stringlib.stringtouppercase(date),' '),'02/00/'),
regexfind('MAR',stringlib.stringfilterout(stringlib.stringtouppercase(date),' ')) =>   regexreplace('MAR',stringlib.stringfilterout(stringlib.stringtouppercase(date),' '),'03/00/'),
regexfind('APR',stringlib.stringfilterout(stringlib.stringtouppercase(date),' ')) =>   regexreplace('APR',stringlib.stringfilterout(stringlib.stringtouppercase(date),' '),'04/00/'),
regexfind('MAY',stringlib.stringfilterout(stringlib.stringtouppercase(date),' ')) =>   regexreplace('MAY',stringlib.stringfilterout(stringlib.stringtouppercase(date),' '),'05/00/'),
regexfind('JUN',stringlib.stringfilterout(stringlib.stringtouppercase(date),' ')) =>   regexreplace('JUN',stringlib.stringfilterout(stringlib.stringtouppercase(date),' '),'06/00/'),
regexfind('JUL',stringlib.stringfilterout(stringlib.stringtouppercase(date),' ')) =>   regexreplace('JUL',stringlib.stringfilterout(stringlib.stringtouppercase(date),' '),'07/00/'),
regexfind('AUG',stringlib.stringfilterout(stringlib.stringtouppercase(date),' ')) =>   regexreplace('AUG',stringlib.stringfilterout(stringlib.stringtouppercase(date),' '),'08/00/'),
regexfind('SEPT',stringlib.stringfilterout(stringlib.stringtouppercase(date),' ')) =>  regexreplace('SEPT',stringlib.stringfilterout(stringlib.stringtouppercase(date),' '),'09/00/'),
regexfind('SEP',stringlib.stringfilterout(stringlib.stringtouppercase(date),' ')) =>   regexreplace('SEP',stringlib.stringfilterout(stringlib.stringtouppercase(date),' '),'09/00/'),
regexfind('OCT',stringlib.stringfilterout(stringlib.stringtouppercase(date),' ')) =>   regexreplace('OCT',stringlib.stringfilterout(stringlib.stringtouppercase(date),' '),'10/00/'),
regexfind('NOV',stringlib.stringfilterout(stringlib.stringtouppercase(date),' ')) =>   regexreplace('NOV',stringlib.stringfilterout(stringlib.stringtouppercase(date),' '),'11/00/'),
regexfind('DEC',stringlib.stringfilterout(stringlib.stringtouppercase(date),' ')) =>   regexreplace('DEC',stringlib.stringfilterout(stringlib.stringtouppercase(date),' '),'12/00/')
, date);


//////////////////////////////////////////////////////////////////////////
export string sdfCodetoDescr(string sdf) := 
map(
sdf = 'AltAddress' => 'Alternate address',
sdf = 'AUTHORIZATION_DATE' => 'Authorization date for business activities',
sdf = 'BRANCH#' => 'Identification number assigned to branch',
sdf = 'CONTACT' => 'Company contact information',
sdf = 'DirectID' => 'Link to Online Compliance web application',
sdf = 'DocumentOfCompliance' => 'Vessel company responsible for ISM Code',
sdf = 'EffectiveDate' => 'Date regulation or sanction is effective',
sdf = 'EntityLevel' => 'Entity Level',
sdf = 'ExpirationDate' => 'Date regulation or sanction expires',
sdf = 'GovDesignation' => 'Categorization of records as given by regulatory body',
sdf = 'GroupBeneficialOwner' => 'Vessel Group Beneficial Owner',
sdf = 'LanguagesSpoken' => 'Languages spoken by the individual',
sdf = 'Legal_Basis' => 'Legal basis code',
sdf = 'LIC_EXP_DATE' => 'License expiration date',
sdf = 'LIC_START_DATE' => 'License start date',
sdf = 'LICENSE_TYPE' => 'Type of license',
sdf = 'Manager' => 'Vessel Manager',
sdf = 'MSB_SVCS' => 'MSB services offered',
sdf = 'NameSource' => 'Name of the source where entity originated',
sdf = 'OwnershipPercent' => 'Ownership Percent',
sdf = 'Operator' => 'Vessel Operator',
sdf = 'Org_PID' => 'ID of the primary entity assigned by the organization maintaining list',
sdf = 'Organization' => 'Organization to which the entity belongs',
sdf = 'OriginalID' => 'ID assigned by the source of the record',
//sdf = 'OtherInformation' => '',
//sdf = 'OtherInformation2' => '',
sdf = 'RegisteredOwner' => 'Vessel Registered Owner',
sdf = 'PlaceofIncorporation' => 'Details on business incorporation',
sdf = 'RelatedEntities' => 'Related entity details',
sdf = 'Relationship' => 'Type of relationship',
sdf = 'STATE_CODE_SVCS_OFFERED' => 'States where entity offers MSB services',
sdf = 'SubCategory' => 'Further categorization of entity',
sdf = 'TechnicalManager' => 'Vessel Technical Manager',
sdf = 'Typeofdenial' => 'Denial types',
sdf = 'Watch' => 'Negative News Alert'
,    sdf);

//////////////////////////////////////////////////////////////////////////
export string SourceCodeToName(string code) := 
case(TRIM(code,ALL),
	'3111022'  =>       'Section 311',
	'ACB1040'  =>       'Austria Central Bank',
	'ARG1006'  =>       'Argentina',
	'ALL1180'  => 	    'Arab League',
	'AU27'  =>          'Austrac List',
	'BCW1074'  =>       'Central Bank of Bahamas Cumulative Warnings',
	'BEL1008'  =>       'Belgium Financial Sector Federation',
	'BIS28'  =>         'Bureau of Industry and Security',
	'BIT1086'  =>       'Bank of Italy Unauthorized Financial Activity',
	'BofE29'  =>        'Bank of England List',
	'CAC1146'  =>       'UN Children and Armed Conflict',
	'CBI1054'  =>       'CBI India',
	'CBI WN30'  =>      'Central Bank of Ireland Warning Notices',
	'CEL1082'  =>       'Canada Economic Sanctioned Entities',
	'CNA1044'  =>       'CHINESE MINISTRY',
	'CSL1080'  =>       'Canada DFAIT Economic UN Sanctions',
	'CSO1062'  =>       'CBS OFFSHORE BANKS',
	'CSSF1114'  =>      'Luxembourg CSSF',
	'CWL32'  =>         'OSFI Cumulative Warnings',
	'DB1088' =>			'Germany Federal Bank',
	'DNB1090'  =>       'Netherlands Bank',
	'DTC1030'  =>       'Defense Trade Controls',
	'ECO1144'  =>       'UK Export Control Organisation-Iran',
//	'ES1014'  =>        'Spain Ministry of Finance and Administration',
	'ESE1158'  =>       'Egypt Financial Supervisory Authority',
	'EU33'  =>          'European Union List',
	'EUE1170'  =>       'EU Enhancements',
'FBI35'  =>         'FBI Most Wanted',
	'FDJ1152'  =>       'FATF Deficient Jurisdictions - Entities',
//'FMU1126'  =>       'Ukraine Financial Monitoring',
	'FR1010'  =>	'France Ministry of Economy',
'GO36'  =>          'World Government Officials List',
'HK37'  =>          'Hong Kong Monetary Authority List',
'HMC1178'  =>      'HMT Country Regimes',
'HME1130'  =>       'HM Treasury Enhancements',
'IA1134'  =>        'INKSNA LIST',
'IND1048'  =>       'India Ministry of Home Affairs',
//'DTT1264' => 'Indonesian List of Suspected Terrorists and Terrorist Organizations',
'INTERPOL38'  =>    'INTERPOL List',
	'ISA1164'	=>	'Iran Sanctions Act',	
'ISN1052'  =>       'BUREAU OF INTERNATIONAL SECURITY & NONPROLIFERATION',
	'ITL1078'  =>	'Israel Ministry of Defense Terrorists',
'JMF1066'  =>       'JAPAN - MINISTRY OF FINANCE',
	'MEX1038'  =>	'Mexico Administrative Sanctions',
	'MFR1068'  =>	'Mauritius FSC Revocations',
'MSB1036'  =>       'Money Services Business (MSB) Agent List',
	'NEP1156'  =>	'Nepal Credit Information Bureau',
'NST *0'  =>        'NS-SDN',
	'NZ1140'  =>	'New Zealand Police',
'OCC39'  =>         'OCC List',
'OCF1122'  =>       'OCC Counterfeit',
'OCR1186'  =>       'OFAC Country Regimes',
'OFAC'  =>          'OFAC Enhancements',
'OFAC1072'  =>          'OFAC Enhancements',
	'OGO1072'  =>	'OFAC Enhancements - Entities',
'OSFI41'  =>        'OSFI Canadian List',
	'PRT1128'  =>	'Sanctioned Airports and Seaports',
	'RBL1072'  =>       'OFAC Restricted or Blocked Locations',
	'REG1072'  =>       'OFAC Federal Register',
	'RPL1176'  =>       'Russian Rosfinmonitoring Public',
	'RRM1116'  =>       'RUSSIAN ROSFINMONITORING LIST',
	'SAP1056'  =>       'South Africa Police',
	'SAR1032'  =>       'Saudi Arabia Most Wanted',
	'SECO42'  =>        'Switzerland SECO',
	'SGP43'  =>         'Monetary Authority of Singapore List',
	'SL1136'  =>        'Slovak Republic Government',
	'TEL1028'  =>       'Terrorist Exclusion List',
	'TFP1072'  =>       'OFAC Accuity Research',
	'TW1016'  =>        'Taiwan',
//	'UGO1120'  =>       'US Government Officials',
	'UK1046'  =>        'UK Home Office',
	'UN44'  =>          'United Nations Sanctions List',
	'UNE1172'  =>       'UN Enhancements',
	'UNT1064'  =>       'UN Travel Restrictions',
	'USM45'  =>         'US Marshals',
	'USSD1072'  =>      'OFAC Enhancements - Entities',
	'UST0'  =>          'OFAC US Treasury SDN List',
	'WBD1072'  =>       'OFAC Enhancements - Entities',
	'WMD REGS1072'  =>  'OFAC Weapons of Mass Destruction Regs',
	'WORLD BANK46'  =>  'World Bank Debarred List',   
	'GWL'						=>	'Accuity Global WatchList',
code);

//////////////////////////////////////////////////////////////////////////
export unicode SourceCodetoDescr(string code) := 
case(TRIM(code,ALL),
'3111022'  =>       'Section 311',
	'ACB1040'  =>	'Terrorist organizations and individuals involved in terrorism designated under the Foreign Exchange Act 2004',
  'ARG1006'  =>       'Argentina',
	'ALL1180'  =>	'Persons designated by the Arab Ministerial Committee whose assets must be frozen and are banned from traveling to Arab league member countries',
  'AU27'  =>          'Austrac List',
	'BCW1074'  =>	'Individuals and companies that may be operating in breach of the Banks and Trust Companies Regulations Act, 2000, or other laws of the Bahamas',
	'BEL1008'  =>	'Entities in the French EU Official Journal regulations and  decisions posted by the Service Public Federal des Finances',
  'BIS28'  =>         'Bureau of Industry and Security',
  'BIT1086'  =>       'Financial institutions and individuals unauthorized to conduct banking and financial activity in Italy',
  'BofE29'  =>        'Bank of England List',
	'CAC1146'  =>	'Organizations committing grave violations and abuses against children in situations of armed conflict',
	'CBI1054'  =>	'Entities in the Central Bureau of Investigation Wanted List and Interpol Red Notices reposted by CBI',
  'CBI WN30'  =>      'Central Bank of Ireland Warning Notices',
	'CEL1082'  =>	u'Entities under economic sanctions. Does not include companies, organizations, or individuals listed under UN resolutions, OSFI, or SEMA. Enhanced by Accuity® with financial institutions in country and SWIFT/BICs.',
  'CNA1044'  =>       'CHINESE MINISTRY',
	'CSL1080'  =>	'Entities subject to Canadian Economic Sanctions implemented under the UN Act, SEMA, and FACFOA',
  'CSO1062'  =>       'CBS OFFSHORE BANKS',
	'CSSF1114'  =>	'Individuals and companies not granted authorization to offer financial services in Luxembourg or other areas',
	'CWL32'  =>		'Banks and companies not authorized to operate as banks in Canada by the OSFI',
	'DB1088' =>		'Entities designated under UN, EU, and German national sanctions',
	'DNB1090'  =>	'Individuals, companies, and organizations sanctioned by the Dutch government for supporting terrorism',
  'DTC1030'  =>       'Defense Trade Controls',
	'ECO1144'  =>	'Entities and organizations in Iran that present a potential concern on WMD End-Use Control grounds, based on previous licensing decisions',
	//'ES1014'  =>	'Entities sanctioned under EU regulations implemented by Spain\'s Ministerio de Economia',
	'ESE1158'  =>	'Persons, groups, and entities subject to an assets freeze',
  'EU33'  =>          'European Union List',
	'EUE1170'  =>	u'Entities Accuity® considers to be sanctioned based on EU regulations, but not included in the EU List. Enhanced by Accuity® with locations and SWIFT/BICs.',
  'FBI35'  =>         'FBI Most Wanted',
	'FDJ1152'  =>	u'Entities associated with jurisdictions and principal cities subject to FATF counter-measures to protect against money laundering and terrorist financing. Enhanced by Accuity® with locations and SWIFT/BICs.',
//	'FMU1126'  =>	'Entities related to terrorist activity or persons subject to international sanctions derived from UN',
	'FR1010'  =>	'Entities subject to French national and EU financial sanctions as posted in the French EU Official Journal',
  'GO36'  =>          'World Government Officials List',
  'HK37'  =>          'Hong Kong Monetary Authority List',
  'HMC1178'  =>      'HMC 1178',
	'HME1130'  =>	u'Entities Accuity® considers to be sanctioned based on HM Treasury regulations, but not included in the HM Treasury List. Enhanced by Accuity® with locations and SWIFT/BICs.',
  'IA1134'  =>        'INKSNA LIST',
	'IND1048'  =>	'Organizations declared as terrorists under the Unlawful Activities (Prevention) Act, 1967. Recommend scanning in conjunction with UN list.',
  'INTERPOL38'  =>    'INTERPOL List',
	'ISA1164'	=>	'Companies sanctioned under the Iran Sanction Act, as amended by the Comprehensive Iran Sanctions, Accountability, and Divestment Act',	
  'ISN1052'  =>       'BUREAU OF INTERNATIONAL SECURITY & NONPROLIFERATION',
	'ITL1078'  =>	'Entities declared unlawful by the Ministry of Defense and subject to seizure of funds. Recommend scanning in conjunction with UN list.',
  'JMF1066'  =>       'JAPAN - MINISTRY OF FINANCE',
	'MEX1038'  =>	'Entities, companies, and individuals who have violated Mexico\'s securities and investments laws',
	'MFR1068'  =>	'Businesses with revoked licenses due to involvement in illegal, dishonorable, and improper practices, market abuse, or financial fraud',
  'MSB1036'  =>       'Money Services Business (MSB) Agent List',
	'NEP1156'  =>	'Blacklisted borrowers maintained by the Nepal CIB',
  'NST *0'  =>        'NS-SDN',
	'NZ1140'  =>	'Companies, individuals, and organizations designated by the New Zealand Police under the Terrorism Suppression Act. Recommend scanning in conjunction with UN list.',
  'OCC39'  =>         'OCC List',
	'OCF1122'  =>	'Companies and banks reported by the OCC as involved in counterfeit or stolen instruments in connection with various scams or financial fraud',
  'OCR1186'  =>       'OCR 1186',
  'OFAC'  =>          'OFAC Enhancements',
	'OGO1072'  =>	u'Entities Accuity® considers to be sanctioned based on OFAC regulations (subsidiaries, designated vessels, members of designated terrorist groups), but not included in OFAC\'s SDN list. Enhanced by Accuity® with locations and SWIFT/BICs.',
  'OSFI41'  =>        'OSFI Canadian List',
	'PRT1128'  =>	'Airports and seaports located in countries with comprehensive OFAC sanctions, including port codes when available',
	'RBL1072'  =>	u'Entities Accuity® considers to be sanctioned based on OFAC regulations (subsidiaries, designated vessels, members of designated terrorist groups), but not included in OFAC\'s SDN list. Enhanced by Accuity® with locations and SWIFT/BICs.',
  'REG1072'  =>       'OFAC Federal Register',
	'RPL1176'  =>	'Organizations and individuals the Russian Federation government recognizes as involved in terrorism or related activities. Recommend scanning in conjunction with UN list.',
  'RRM1116'  =>       'RUSSIAN ROSFINMONITORING LIST',
	'SAP1056'  =>	'All individuals listed on the South African Police Wanted Persons list',
	'SAR1032'  =>	'Individuals listed on the Saudi Arabia Wanted Terrorists lists issued by the Ministry of Interior',
	'SECO42'  =>	'Entities sanctioned SECO and Swiss Confederation and derived from the EU and UN lists',
  'SGP43'  =>         'Monetary Authority of Singapore List',
	'SL1136'  =>	'Individuals and organizations listed under regulation number 397/2005 (International Sanctions Ensuring International Peace and Security)',
  'TEL1028'  =>       'Terrorist Exclusion List',
	'TFP1072'  =>	u'Entities Accuity® considers to be sanctioned based on OFAC regulations (subsidiaries, designated vessels, members of designated terrorist groups), but not included in OFAC\'s SDN list. Enhanced by Accuity® with locations and SWIFT/BICs.',
  'TW1016'  =>        'Taiwan',
	//'UGO1120'  =>	'Members of the US Cabinet and White House staff',
	'UK1046'  =>	'Terrorist groups and organizations banned under UK law',
  'UN44'  =>          'United Nations Sanctions List',
	'UNE1172'  =>	u'Entities Accuity® considers to be sanctioned based on UN regulations, but not specifically include in the UN List. Enhanced by Accuity® with locations and SWIFT/BICs.',
	'UNT1064'  =>	'Individuals with travel restrictions but no asset freezing as designated by the UN Security Council Sanctions Committees',
	'USM45'  =>		'15 Most Wanted fugitives by the US Marshals',
	'USSD1072'  =>	u'Entities Accuity® considers to be sanctioned based on OFAC regulations (subsidiaries, designated vessels, members of designated terrorist groups), but not included in OFAC\'s SDN list. Enhanced by Accuity® with locations and SWIFT/BICs.',
  'UST0'  =>          'OFAC US Treasury SDN List',
	'WBD1072'  =>	u'Entities Accuity® considers to be sanctioned based on OFAC regulations (subsidiaries, designated vessels, members of designated terrorist groups), but not included in OFAC\'s SDN list. Enhanced by Accuity® with locations and SWIFT/BICs.',
  'WMD REGS1072'  =>  'OFAC Weapons of Mass Destruction Regs',
  'WORLD BANK46'  =>  'World Bank Debarred List',   
	'GWL'						=>	'Accuity Global Watchlist',
code);

//////////////////////////////////////////////////////////////////////////
export string SourceCodetoBridgerSourceID(string code) := 
map(
code= 'ALL1180' => '25C34AD7-A09C-4E6D-8A68-C9CDC4B8E727', //ARAB LEAGUE LIST
code= 'ARG1006' => '16917F27-D0F8-4411-915E-4EFFE6FD8275', //Argentinean List
code= 'ACB1040' => 'EA6786A0-4451-4EC5-BE68-F0BBD6CEDA1A', //AUSTRIAN CENTRAL BANK
code= 'BIT1086' => '0E57C9FB-4D58-4E5F-9614-653B6E76D50E', //BANK OF ITALY UNAUTHORIZED FINANCIAL ACTIVITY LIST
code= 'BEL1008' => '6E9526E7-A4D0-4AF3-8E47-A017273590F5', //Belgium List
code= 'CEL1082' => '9287A5F6-3537-4A97-A900-B4AF5F5138E3', //Canadian Economic Sanctioned Countries List
code= 'CSL1080' => 'B556567B-3D37-470E-8FB6-51F01141E200', //CANADIAN ECONOMIC UN SANCTIONS LIST
code= 'CBI1054' => 'BEFB7F8F-2002-4C1E-A3F9-9020951D5785', //CBI INDIA
code= 'BCW1074' => '21DE3441-F3DD-401F-A046-7EF662422BB9', //Central Bank of the Bahamas - CWL
code= 'CWL32'   => '19740E5A-C374-4783-BBBE-D4B4799DF48E', //Cumulative Warning List
code= 'DNB1090' => '9A7C935C-7FB2-4E5D-9EAB-397905D59305', //DUTCH BANK
code= 'ESE1158' => '8710DD38-83AB-4965-BDCC-2A805D732124', //EGYPT FINANCIAL SUPERVISORY AUTHORITY
code= 'EUE1170' => 'EF0A10E0-5D25-4FED-92E1-FC1C48ABBDB0', //European Union Enhancements List
code= 'ECO1144' => '922E16C8-EB37-4AB3-843D-5D21752A6D46', //EXPORT CONTROL ORGANISATION UK - IRAN LIST
code= 'FDJ1152' => '2F09FE84-2105-4090-9811-876F698797C5', //FATF DEFICIENT JURISDICTIONS LIST
code= 'FR1010'  => '42954D03-BB16-49CE-84AB-262C59DC5670', //France
code= 'DB1088'  => '664EC531-0D58-41E3-889F-9249CE66D4A7', //German Federal Bank
code= 'HME1130' => '0CD3E3E5-4A87-426A-AEDF-65E8DF0433B9', //HMT ENHANCEMENT LIST
code= 'IND1048' => '7FDD87E4-CEDF-41A2-8196-C1D6F814BCF9', //INDIAN MINISTRY OF HOME AFFAIRS
code= 'ISA1164' => '5064F825-1DC9-4895-8217-B257EDD31072', //IRAN SANCTIONS ACT
code= 'ITL1078' => '25CCA6DA-7E23-48F7-B000-C15FDA653B2C', //ISRAELI MOD TERROR LIST
code= 'CSSF1114'=> 'B53DD88F-CCD2-482F-B91F-1B26CE8F39F2', //LUXEMBOURG CSSF
code= 'MFR1068' => 'FDE39736-0521-4A9D-8E33-BFCC49AEECD2', //MAURITIUS FSC REVOCATIONS
code= 'MEX1038' => '6667BE28-3C62-407B-88A3-48A960D435A0', //Mexican Administrative Sanctions
code= 'NEP1156' => 'CA745682-AC6E-417F-B2C7-D1161A4CC38F', //NEPAL CREDIT INFORMATION BUREAU
code= 'NZ1140'  => 'A86F5033-10F9-4BB4-A777-B68DF4B5A479', //NEW ZEALAND POLICE
code= 'OCF1122' => '34E3556B-4D6E-4E1B-B9CD-25F5FD1BF445', //OCC Counterfeit List
/*
code= 'OCR1186' => 'F0DC7701-F071-4923-9AE6-A2A32B440BCC', //OFAC COUNTRY REGIMES
code= 'TFP1072' => '14AE347F-8FFD-431F-A3E4-E5881B5CD8DA', //OFAC Accuity Research
code= 'OGO1072' => 'CF35A7C3-29C5-4C89-8BBC-E92C8FA9F0FF', //OFAC Government Officials
code= 'RBL1072' => 'D69E8661-1249-4838-BB28-5DDE77D1D111', //OFAC Restricted or Blocked Locations
code= 'USSD1072'=> 'CA37870E-9228-49D7-9005-9CDFD688343D', //OFAC US State Department
code= 'WBD1072' => '2063C78B-7865-4AFC-B4BD-2C82061FD737', //OFAC World Bank Directory
*/
//Per Bridger request to combine ofac files
code= 'OFAC' => '14AE347F-8FFD-431F-A3E4-E5881B5CD8DA', //OFAC ALL
code= 'OCR1186' => '14AE347F-8FFD-431F-A3E4-E5881B5CD8DA', //OFAC COUNTRY REGIMES
code= 'TFP1072' => '14AE347F-8FFD-431F-A3E4-E5881B5CD8DA', //OFAC Accuity Research
code= 'OGO1072' => '14AE347F-8FFD-431F-A3E4-E5881B5CD8DA', //OFAC Government Officials
code= 'RBL1072' => '14AE347F-8FFD-431F-A3E4-E5881B5CD8DA', //OFAC Restricted or Blocked Locations
code= 'USSD1072'=> '14AE347F-8FFD-431F-A3E4-E5881B5CD8DA', //OFAC US State Department
code= 'WBD1072' => '14AE347F-8FFD-431F-A3E4-E5881B5CD8DA', //OFAC World Bank Directory

code= 'RRM1116' => 'EA7314C3-AA87-4308-B525-4C8C906A5418', //RUSSIAN ROSFINMONITORING LIST
code= 'RPL1176' => '80DCAF0A-466B-4783-967D-3BB7C27B146C', //RUSSIAN ROSFINMONITORING PUBLIC
code= 'PRT1128' => 'DD7BE72D-F3E7-47B0-AD77-2EAE260993E0', //Sanctioned Airport and Seaport List
code= 'SAR1032' => '0AE318D8-D530-4088-9478-8225CF6B38A3', //SAUDI ARABIA - Most Wanted List
code= 'SL1136'  => '7A27F697-1CE8-4F7A-89DB-36433539B105', //SLOVAKIAN LIST
code= 'SAP1056' => '78EB65FC-BDD4-4599-A2E2-AC2BC1804878', //SOUTH AFRICAN POLICE WANTED
//code= 'ES1014'  => '0DD1F6D8-37DF-4DF4-B6C3-DC58698A909B', //Spain
code= 'SECO42'  => '75DFF111-309D-4613-BE9C-9ED39FD725C1', //Swiss State Secretariat for Economic Affairs
code= 'TW1016'  => 'B639C576-74D1-4B5A-AE5D-E73A0A75FC25', //Taiwan List
//code= 'UGO1120' => 'E142C34B-6F6D-46D3-A02B-9E1CF4EF3B87', //U.S. Government Officials
code= 'UK1046'  => 'E7B08E71-FC3B-4180-AEC8-89BADF913545', //UK HOME OFFICE
//code= 'FMU1126' => '5B409771-F615-49D0-80E2-418AC07A1F5E', //UKRAINE FINANCIAL MONITORING
code= 'CAC1146' => '5DD0626C-8099-4A21-99B6-47FFB535409D', //UN CHILDREN AND ARMED CONFLICT LIST
//code= 'UNT1064' => '10833C06-58F1-43BE-A4D8-A1EFC070F174', //UN TRAVEL RESTRICTIONS
//code= 'UN1064'  => 'C0FB78C0-A3B6-41C3-B6DA-89876B5D4289', //UNITED NATIONS
//Per Bridger request to combine UN files
code= 'UN' => '10833C06-58F1-43BE-A4D8-A1EFC070F174', //UN ALL
code= 'UNT1064' => '10833C06-58F1-43BE-A4D8-A1EFC070F174', //UN TRAVEL RESTRICTIONS
code= 'UN1064'  => '10833C06-58F1-43BE-A4D8-A1EFC070F174', //UNITED NATIONS

code= 'UNE1172' => 'A0B533C2-1956-46EC-9B30-AB0EF999F968', //United Nations Enhancements List
code= 'USM45'   => '5FBFAB06-9E20-4C01-B8EC-0DF7AD62F8C6', //US Marshals
code= 'GWL'			=> '4AD62758-EF7D-4E1B-B804-0873FA883214',
'');

export string GeoSourceCodetoBridgerSourceID(string code) := 
	CASE(code,
		'CEL 1082' => 	'0619E668-EA84-4B66-B184-19BC2FDE48AC',
		'OFAC 1072' =>	'D69E8661-1249-4838-BB28-5DDE77D1D111',
		'FDJ 1152' =>	'5915497D-1E35-45CF-859E-A882E5E5E453',
		'RBL 1072' =>	'D69E8661-1249-4838-BB28-5DDE77D1D111',
		'TFP 1072' =>	'D69E8661-1249-4838-BB28-5DDE77D1D111',
		'');
		
export string GeoSourceCodeToName(string code) := 
case(TRIM(code,ALL),
	'CEL1082' => 	'Canada Economic Sanctioned Countries',
	'FDJ1152'  =>	'FATF Deficient Jurisdictions - Countries',
	'RBL1072'  =>	'OFAC Enhancements - Countries',
	'TFP1072'  =>	'OFAC Enhancements - Countries',
	code);

export unicode GeoSourceCodeToDescr(string code) := 
case(TRIM(code,ALL),
	'CEL1082' => 	u'Countries where economic sanctions are imposed. Does not include companies, organizations, or individuals listed under UN resolutions, OSFI, or SEMA.',
	'FDJ1152'  =>	u'Jurisdictions and principal cities subject to FATF counter-measures to protect against money laundering and terrorist financing. Enhanced by Accuity® with locations and SWIFT/BICs.',
	'RBL1072'  =>	u'Locations Accuity® considers to be sanctioned based on OFAC regulations (subsidiaries, designated vessels, members of designated terrorist groups), but not included in OFAC\'s SDN list. Enhanced by Accuity® with locations and SWIFT/BICs.',
	'TFP1072'  =>	u'Locations Accuity® considers to be sanctioned based on OFAC regulations (subsidiaries, designated vessels, members of designated terrorist groups), but not included in OFAC\'s SDN list. Enhanced by Accuity® with locations and SWIFT/BICs.',
	code);

export string ConvertRoutingCode(string code) := 
case(code,
	'CHIPS UID' => 'ChipsUID',
	'BIC' => 'SwiftBIC',
	'Natl_Routing_Code' => 'BankIdentifierCode',
	'SWIFT' => 'SwiftBEI',
	'other'
);

export string ConvertIDType(string code) := 
case(stringlib.stringtolowercase(code),
	'bic' => 'BankIdentifierCode',
	'cedula no' => 'Cedula',
	'chips uid' => 'ChipsUID',
	'driver\'s license number' => 'DriversLicense',
	'federalregistercitation' => 'Other',
	'file #' => 'Other', 
	'italian_fiscal_code' => 'National',
	'kenyanidno' => 'National',
	'License #' => 'Other',
	'national no' => 'National',
	'natl_routing_code' => 'BankIdentifierCode',
	'nie' => 'Other',
	'nit #' => 'NIT',
	'otherid' => 'Other',
	'passport' => 'Passport',
	'ref #' => 'Other',
	'r.f.c.' => 'TaxID',
	'ruc #' => 'National',
	'serialno' => 'Other',
	'spanishidnumber' => 'National',
	'ssn' => 'SSN',
	'swift' => 'SwiftBIC',
	'us fein' => 'EIN',
	'vat no.' => 'TaxID',
	'vessel_reg_id' => 'Other',
	IF(Sets.IsValidIdType(code), code, 'Other')
);

export string ConvertIDTypeToLabel(string code) := 
case(stringlib.stringtolowercase(code),
	'federalregistercitation' => 'FederalRegisterCitation',
	'file #' => 'MSB registration number',
	'License #' => 'License number',
	'ref#' => 'Entity reference number',
	'otherid' => '',
	IF(ConvertIDType(code)='Other', code, '')
);

export string ConvertIDTypeToComment(string code) := 
case(stringlib.stringtolowercase(code),
	'italian_fiscal_code' => 'Italian Fiscal Code',
	'spanishidnumber' => 'Spanish ID Number',
	'kenyanidno' => 'Kenyan ID Number',
//	'vessel_reg_id' => 'Vessel Reg ID',
	'');


end;
