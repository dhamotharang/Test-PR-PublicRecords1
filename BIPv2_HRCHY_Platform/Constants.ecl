import mdr;

EXPORT Constants := MODULE

EXPORT max_depth_supported := 20;	//if you want to change this, you have to find the references to this and update them.  changing it here only accounts for some functions.
EXPORT min_nodes_supported := 2;	//if a hrchy only has 1 node, then it isnt really a hrchy.

EXPORT Sources := MODULE

	export LNCA := 'L';
	export DUNS := 'D';
	export FRAN := 'F';

	//this is where you set the prefence.  lower number is more preferred
	shared _1 := LNCA;
	shared _2 := DUNS;
	shared _3 := FRAN;
	
	export Preferred(set of string1 sources_available) := 
	map(
		_1 in sources_available => _1,
		_2 in sources_available => _2,
		_3 in sources_available => _3,
		''
	);
	
	export PreferenceRanking(string1 source) := 
	case(
		source,
		_1 => 1,
		_2 => 2,
		_3 => 3,
		10
	);	
	
	export ConvertToHdrSrc(string1 source) :=
	case(
		source,
		LNCA => mdr.sourceTools.src_DCA,
		DUNS => mdr.sourceTools.src_Dunn_Bradstreet,
		FRAN => mdr.sourceTools.src_Frandx,
		''
	);
	
END;//Sources := MODULE

export LNCA := MODULE

	shared ds_type := 
	dataset([
	{1,'',TRUE,FALSE}
	,{2,'SUBSIDIARY',TRUE,FALSE}
	,{3,'NON-U.S. SUBSIDIARY',TRUE,TRUE}
	,{4,'DIVISION',FALSE,FALSE}
	,{5,'SHELL',TRUE,FALSE}
	,{6,'U.S. SUBSIDIARY',TRUE,FALSE}
	,{7,'PRV',TRUE,FALSE}
	,{8,'UNIT',FALSE,FALSE}
	,{9,'BRANCH',FALSE,FALSE}
	,{10,'HOLDING',TRUE,FALSE}
	,{11,'PLANT',FALSE,FALSE}
	,{12,'PUB',TRUE,FALSE}
	,{13,'INT',TRUE,TRUE}
	,{14,'NON-U.S. HOLDING',TRUE,TRUE}
	,{15,'JOINT VENTURE',TRUE,FALSE}
	,{16,'NON-U.S. JOINT VENTURE',TRUE,TRUE}
	,{17,'AFFILIATE',FALSE,FALSE}
	,{18,'NON-U.S. DIVISION',FALSE,TRUE}
	,{19,'NON-U.S. BRANCH',FALSE,TRUE}
	,{20,'NON-U.S. AFFILIATE',FALSE,TRUE}
	,{21,'NON-U.S. UNIT',FALSE,TRUE}
	,{22,'GROUP',FALSE,FALSE}
	,{23,'NON-U.S. PLANT',FALSE,TRUE}
	,{24,'U.S. DIVISION',FALSE,FALSE}
	,{25,'U.S. BRANCH',FALSE,FALSE}
	,{26,'U.S. HOLDING',TRUE,FALSE}
	,{27,'U.S. JOINT VENTURE',TRUE,FALSE}
	,{28,'U.S. UNIT',FALSE,FALSE}
	,{29,'NON-U.S. GROUP',FALSE,TRUE}
	,{30,'JOPUB VENTURE',TRUE,FALSE}
	,{31,'U.S. PLANT',FALSE,FALSE}
	,{32,'CO-HEADQUARTERS:',TRUE,FALSE}
	,{33,'NON-U.S. JOPUB VENTURE',TRUE,TRUE}
	,{34,'CORPORATE HEADQUARTERS:',FALSE,FALSE}
	,{35,'U.S. AFFILIATE',FALSE,FALSE}
	,{36,'UNITED STATES',FALSE,FALSE}
	,{37,'U.S. GROUP',FALSE,FALSE}
	,{38,'PARENT COMPANY OF:',TRUE,FALSE}
	,{39,'INTERPUBLIC ALIGNED COMPANY: (PART OF THE INTERPUBLIC GROUP)',FALSE,FALSE}
	,{40,'BRANCH:',FALSE,FALSE}
	,{41,'MCCANN-ERICKSON WORLDGROUP (PART OF THE INTERPUBLIC GROUP)',FALSE,FALSE}
	,{42,'ENTERTAINMENT, EVENT & SPORTS MARKETING',FALSE,FALSE}
	,{43,'U.S. JOPUB VENTURE',TRUE,FALSE}
	,{44,'OPERATING DIVISION',FALSE,FALSE}
	,{45,'FRANCE',FALSE,TRUE}
	,{46,'HEALTH CARE & MEDICAL AGENCIES',FALSE,FALSE}
	,{47,'PUBLIC RELATIONS',FALSE,FALSE}
	,{48,'NORTH AMERICA',FALSE,FALSE}
	,{49,'CONSTITUENCY MANAGEMENT: (PART OF THE INTERPUBLIC GROUP)',FALSE,FALSE}
	,{50,'BRANDING/CONSULTANT',FALSE,FALSE}
	,{51,'ASIA & OCEANIA',FALSE,TRUE}
	,{52,'NON-U.S. OPERATING DIVISION',FALSE,TRUE}
	,{53,'ADVERTISING',FALSE,FALSE}
	,{54,'UNITED KINGDOM',FALSE,TRUE}
	,{55,'DIRECT MARKETING/RELATIONSHIP MARKETING (CRM)',FALSE,FALSE}
	,{56,'SPECIALIZED COMMUNICATION SERVICES',FALSE,FALSE}
	,{57,'DRAFTFCB GROUP: (PART OF THE INTERPUBLIC GROUP)',FALSE,FALSE}
	,{58,'RETAIL/PROMOTIONAL MARKETING',FALSE,FALSE}
	,{59,'EUROPE',FALSE,TRUE}
	,{60,'AFFILIATED & SUBSIDIARY COMPANY',FALSE,FALSE}
	,{61,'EUROPE:',FALSE,TRUE}
	,{62,'INTERACTIVE SERVICES',FALSE,FALSE}
	,{63,'BELGIUM',FALSE,TRUE}
	,{64,'SPAIN',FALSE,TRUE}
	,{65,'PUBLIC RELATIONS & PUBLIC AFFAIRS',FALSE,FALSE}
	,{66,'NON-U.S. CORPORATE HEADQUARTERS:',FALSE,TRUE}
	,{67,'BRANDING & IDENTITY',FALSE,FALSE}
	,{68,'CANADA',FALSE,TRUE}
	,{69,'CO-HEADQUARTERS',TRUE,FALSE}
	,{70,'INTERNATIONAL BRANCH:',FALSE,TRUE}
	,{71,'OPERATION',FALSE,FALSE}
	,{72,'SPECIALIST COMMUNICATIONS',FALSE,FALSE}
	,{73,'NON-PROFIT MARKETING',FALSE,FALSE}
	,{74,'MULTICULTURAL MARKETING',FALSE,FALSE}
	,{75,'GERMANY',FALSE,TRUE}
	,{76,'FIELD MARKETING',FALSE,FALSE}
	,{77,'INDIA',FALSE,TRUE}
	,{78,'MAJOR DOMESTIC SUBSIDIARIES & AFFILIATES',FALSE,FALSE}
	,{79,'UNITED KINGDOM',FALSE,TRUE}
	,{80,'STOCKHOLM HEADQUARTERS',FALSE,TRUE}
	,{81,'NETHERLANDS',FALSE,TRUE}
	,{82,'INFORMATION & CONSULTANCY',FALSE,FALSE}
	,{83,'NETHERLANDS',FALSE,TRUE}
	,{84,'THE AMERICAS',FALSE,TRUE}
	,{85,'COLOMBIA',FALSE,TRUE}
	,{86,'RESEARCH',FALSE,FALSE}
	,{87,'DESIGN',FALSE,FALSE}
	,{88,'NORTH AMERICA BRANCH:',FALSE,TRUE}
	,{89,'ISRAEL',FALSE,TRUE}
	,{90,'DIRECT, PROMOTIONAL & RELATIONSHIP MARKETING',FALSE,FALSE}
	,{91,'POLAND',FALSE,TRUE}
	,{92,'GROUP AGENCIES',FALSE,FALSE}
	,{93,'BUSINESS-TO-BUSINESS ADVERTISING',FALSE,FALSE}
	,{94,'BRANCHES',FALSE,FALSE}
	,{95,'ITALY',FALSE,TRUE}
	,{96,'NEW ZEALAND',FALSE,TRUE}
	,{97,'BRAZIL',FALSE,TRUE}
	,{98,'SINGAPORE',FALSE,TRUE}
	,{99,'SWITZERLAND',FALSE,TRUE}
	,{100,'MEXICO',FALSE,TRUE}
	,{101,'U.S. CORPORATE HEADQUARTERS:',FALSE,FALSE}
	,{102,'JAPAN',FALSE,TRUE}
	,{103,'SAUDI ARABIA',FALSE,TRUE}
	,{104,'HEALTHCARE',FALSE,FALSE}
	,{105,'MEDIA INVESTMENT MANAGEMENT',FALSE,FALSE}
	,{106,'ARNOLD WORLDWIDE PARTNERS DIVISION',FALSE,FALSE}
	,{107,'U.S. CORPORATE HEADQUARTERS',FALSE,FALSE}
	,{108,'NON-U.S. REPRESENTATIVE OFFICE',FALSE,TRUE}
	,{109,'MALAYSIA',FALSE,TRUE}
	,{110,'VENEZUELA',FALSE,TRUE}
	,{111,'PANAMA',FALSE,TRUE}
	,{112,'HUNGARY',FALSE,TRUE}
	,{113,'U.S. HEADQUARTERS',FALSE,FALSE}
	,{114,'RUSSIA',FALSE,TRUE}
	,{115,'CHILE',FALSE,TRUE}
	,{116,'GREECE',FALSE,TRUE}
	,{117,'DENMARK',FALSE,TRUE}
	,{118,'CYPRUS',FALSE,TRUE}
	,{119,'TAIWAN',FALSE,TRUE}
	,{120,'NAGOYA HEAD OFFICE:',FALSE,TRUE}
	,{121,'PACIFIC:',FALSE,TRUE}
	,{122,'PORTUGAL',FALSE,TRUE}
	,{123,'AFFILIATE:',FALSE,FALSE}
	,{124,'SOUTH AFRICA',FALSE,TRUE}
	,{125,'CHINA',FALSE,TRUE}
	,{126,'NON-U.S. HEADQUARTERS:',FALSE,TRUE}
	,{127,'CORPORATE OFFICE',FALSE,FALSE}
	,{128,'NON-U.S. CANADIAN HEADQUARTERS',FALSE,TRUE}
	,{129,'NORTH AMERICAN HEADQUARTERS',FALSE,TRUE}
	,{130,'NON-U.S. EUROPEAN HEADQUARTERS:',FALSE,TRUE}
	,{131,'UNITED STATES',FALSE,FALSE}
	,{132,'U.S. OPERATION',FALSE,FALSE}
	,{133,'AFRICA:',FALSE,TRUE}
	,{134,'MIDDLE EAST:',FALSE,TRUE}
	,{135,'CUSTOM PUBLISHING',FALSE,FALSE}
	,{136,'HEADQUARTERS:',FALSE,FALSE}
	,{137,'COLOMBIA',FALSE,TRUE}
	,{138,'U.S. CO-HEADQUARTERS:',FALSE,FALSE}
	,{139,'CHINA',FALSE,TRUE}
	,{140,'U.S. REPRESENTATIVE OFFICE',FALSE,FALSE}
	,{141,'NON-U.S. CO-HEADQUARTERS:',FALSE,TRUE}
	,{142,'CZECH REPUBLIC',FALSE,TRUE}
	,{143,'AUSTRALIA',FALSE,TRUE}
	,{144,'HEALTH CARE-MANAGED CARE',FALSE,FALSE}
	,{145,'TELECOMMUNICATIONS',FALSE,FALSE}
	,{146,'PHILIPPINES',FALSE,TRUE}
	,{147,'CONSUMER & CORPORATE ADVERTISING',FALSE,FALSE}
	,{148,'PUBLIC RELATIONS DIVISION',FALSE,FALSE}
	,{149,'RECRUITMENT COMMUNICATIONS',FALSE,FALSE}
	,{150,'KOREA',FALSE,TRUE}
	,{151,'GUATEMALA',FALSE,TRUE}
	,{152,'COSTA RICA',FALSE,TRUE}
	,{153,'EL SALVADOR',FALSE,TRUE}
	,{154,'BBDO LATIN AMERICA',FALSE,TRUE}
	,{155,'IRELAND',FALSE,TRUE}
	,{156,'OPERATIONAL HEADQUARTERS',FALSE,FALSE}
	,{157,'TOKYO HEAD OFFICE:',FALSE,TRUE}
	,{158,'EURO RSCG WORLDWIDE DIVISION',FALSE,TRUE}
	,{159,'FINLAND',FALSE,TRUE}
	,{160,'MEDIA PLANNING GROUP DIVISION',FALSE,FALSE}
	,{161,'NON-U.S. HEAD OFFICE',FALSE,TRUE}
	,{162,'HEAD OFFICE:',FALSE,FALSE}
	,{163,'NON-U.S. CO-HEADQUARTERS',FALSE,TRUE}
	,{164,'CUSTOMER RELATIONSHIP MANAGEMENT',FALSE,FALSE}
	,{165,'HEADQUARTERS',FALSE,FALSE}
	,{166,'INTLIC RELATIONS & INTLIC AFFAIRS',FALSE,TRUE}
	,{167,'REPRESENTATIVE OFFICE',FALSE,FALSE}
	,{168,'PERU',FALSE,TRUE}
	,{169,'JORDAN',FALSE,TRUE}
	,{170,'SLOVENIA',FALSE,TRUE}
	,{171,'THAILAND',FALSE,TRUE}
	,{172,'EGYPT',FALSE,TRUE}
	,{173,'BANGLADESH',FALSE,TRUE}
	,{174,'KAZAKHSTAN',FALSE,TRUE}
	,{175,'TRINIDAD & TOBAGO',FALSE,TRUE}
	,{176,'LEBANON',FALSE,TRUE}
	,{177,'HONG KONG',FALSE,TRUE}
	,{178,'QATAR',FALSE,TRUE}
	,{179,'ARGENTINA',FALSE,TRUE}
	,{180,'AUSTRIA',FALSE,TRUE}
	,{181,'SLOVAKIA',FALSE,TRUE}
	,{182,'ROMANIA',FALSE,TRUE}
	,{183,'BOSNIA & HERZEGOVINA',FALSE,TRUE}
	,{184,'CROATIA',FALSE,TRUE}
	,{185,'PORTUGAL',FALSE,TRUE}
	,{186,'BAHRAIN',FALSE,TRUE}
	,{187,'SERBIA & MONTENEGRO',FALSE,TRUE}
	,{188,'LUXEMBOURG',FALSE,TRUE}
	,{189,'UKRAINE',FALSE,TRUE}
	,{190,'SOUTH AFRICA',FALSE,TRUE}
	,{191,'LITHUANIA',FALSE,TRUE}
	,{192,'KUWAIT',FALSE,TRUE}
	,{193,'BELARUS',FALSE,TRUE}
	,{194,'SWEDEN',FALSE,TRUE}
	,{195,'INDONESIA',FALSE,TRUE}
	,{196,'ASIA/PACIFIC',FALSE,TRUE}
	,{197,'UNITED ARAB EMIRATES',FALSE,TRUE}
	,{198,'URUGUAY',FALSE,TRUE}
	,{199,'TUNISIA',FALSE,TRUE}
	,{200,'MACEDONIA',FALSE,TRUE}
	,{201,'CUSTOM VEHICLE GRAPHICS/BRANDING',FALSE,FALSE}
	,{202,'UK HEADQUARTERS',FALSE,TRUE}
	,{203,'HEALTH CARE-PUBLIC RELATIONS',FALSE,FALSE}
	,{204,'DOMINICAN REPUBLIC',FALSE,TRUE}
	,{205,'PRVLIC RELATIONS',FALSE,FALSE}
	,{206,'CZECH REINTLIC',FALSE,TRUE}
	,{207,'CZECH REPUBLIC',FALSE,TRUE}
	,{208,'CZECH REPRVLIC',FALSE,TRUE}
	,{209,'DOMINICAN REINTLIC',FALSE,TRUE}
	,{210,'DOMINICAN REPUBLIC',FALSE,TRUE}

	],
	{unsigned3 itype, string100 decode, boolean isSELE, boolean isINTL}
	);


	export ctype_code(string ctype) := 
	FUNCTION
	
		ct := stringlib.stringtouppercase(ctype);
		
		return (string)ds_type(ct = decode)[1].itype;

	end;//function ctype_code
	
	export ctype_decode(string pctype_code) := 
	FUNCTION
	
		return ds_type((unsigned)pctype_code = itype)[1].decode;

	end;//function ctype_code	
	
	export ctype_code_is_SELE_level(string pctype_code) := exists(ds_type((unsigned)pctype_code = itype, isSELE));

END;//LNCA := MODULE

export DUNS := MODULE
		
	shared ds_type :=
	dataset([
	{'0','SINGLE LOCATION',TRUE,FALSE}
	,{'1','HEADQUARTERS',TRUE,FALSE}
	,{'2','BRANCH',FALSE,FALSE}
	,{'3','SUBSIDIARY AND HEADQUARTERS',TRUE,FALSE}
	,{'4','SUBSIDIARY AND SINGLE LOCATION',TRUE,FALSE}
	,{'5','DIVISION',FALSE,FALSE}
	],
	{unsigned3 itype, string100 decode, boolean isSELE, boolean isINTL}
	);		
		
	export ctype_code(string ctype) := 
	FUNCTION
	
		ct := stringlib.stringtouppercase(ctype);
		
		return (string)ds_type(ct = decode)[1].itype;

	end;//function ctype_code
	
	export ctype_decode(string pctype_code) := 
	FUNCTION
	
		return ds_type((unsigned)pctype_code = itype)[1].decode;

	end;//function ctype_code	
	
	export ctype_code_is_SELE_level(string pctype_code) := exists(ds_type((unsigned)pctype_code = itype, isSELE));
	
END;//DUNS := MODULE


export FRAN := MODULE

		
	shared ds_type_plus :=
	dataset([
	{0,'U','BRANCH',FALSE,FALSE}
	,{1,'H','HEADQUARTERS',TRUE,FALSE}
	],
	{unsigned3 itype, string5 stype, string100 decode, boolean isSELE, boolean isINTL}
	);		
	
	export get_itype(string5 p_stype) := 
	FUNCTION
	
		return (string)ds_type_plus(p_stype = stype)[1].itype;

	end;//function ctype_code	
	
	shared ds_type := project(ds_type_plus, {unsigned3 itype, string100 decode, boolean isSELE, boolean isINTL});
		
	export ctype_code(string ctype) := 
	FUNCTION
	
		ct := stringlib.stringtouppercase(ctype);
		
		return (string)ds_type(ct = decode)[1].itype;

	end;//function ctype_code
	
	export ctype_decode(string pctype_code) := 
	FUNCTION
	
		return ds_type((unsigned)pctype_code = itype)[1].decode;

	end;//function ctype_code	
	
	export ctype_code_is_SELE_level(string pctype_code) := exists(ds_type((unsigned)pctype_code = itype, isSELE));
	
END;//DUNS := MODULE


export ctype_decode(string pctype_code, string1 src_code) := 
	map(
		src_code = Sources.LNCA => LNCA.ctype_decode(pctype_code),
		src_code = Sources.DUNS => DUNS.ctype_decode(pctype_code),
		src_code = Sources.FRAN => FRAN.ctype_decode(pctype_code),
		''
	);
export ctype_code_is_SELE_level(string pctype_code, string1 src_code) := 
	map(
		src_code = Sources.LNCA => LNCA.ctype_code_is_SELE_level(pctype_code),
		src_code = Sources.DUNS => DUNS.ctype_code_is_SELE_level(pctype_code),
		src_code = Sources.FRAN => FRAN.ctype_code_is_SELE_level(pctype_code),
		false
	);
	
END;//Constants := MODULE

/*
//test code for lnca and duns
// BIPv2_HRCHY_Platform_Dev.Constants.LNCA.ctype_code('HOLDING');
// BIPv2_HRCHY_Platform_Dev.Constants.LNCA.ctype_code(BIPv2_HRCHY_Platform_Dev.Constants.LNCA.ctype_decode(BIPv2_HRCHY_Platform_Dev.Constants.LNCA.ctype_code('HOLDING')));
// BIPv2_HRCHY_Platform_Dev.Constants.LNCA.ctype_decode(BIPv2_HRCHY_Platform_Dev.Constants.LNCA.ctype_code('HOLDING'));
// BIPv2_HRCHY_Platform_Dev.Constants.LNCA.ctype_code_is_SELE_level(BIPv2_HRCHY_Platform_Dev.Constants.LNCA.ctype_code('DIVISION'));
// BIPv2_HRCHY_Platform_Dev.Constants.LNCA.ctype_code_is_SELE_level(BIPv2_HRCHY_Platform_Dev.Constants.LNCA.ctype_code('SUBSIDIARY'));

BIPv2_HRCHY_Platform_Dev.Constants.duns.ctype_code('HEADQUARTERS');
BIPv2_HRCHY_Platform_Dev.Constants.duns.ctype_code(BIPv2_HRCHY_Platform_Dev.Constants.duns.ctype_decode(BIPv2_HRCHY_Platform_Dev.Constants.duns.ctype_code('HEADQUARTERS')));
BIPv2_HRCHY_Platform_Dev.Constants.duns.ctype_decode(BIPv2_HRCHY_Platform_Dev.Constants.duns.ctype_code('HEADQUARTERS'));
BIPv2_HRCHY_Platform_Dev.Constants.duns.ctype_code_is_SELE_level(BIPv2_HRCHY_Platform_Dev.Constants.duns.ctype_code('DIVISION'));
BIPv2_HRCHY_Platform_Dev.Constants.duns.ctype_code_is_SELE_level(BIPv2_HRCHY_Platform_Dev.Constants.duns.ctype_code('HEADQUARTERS'));
*/