export Sets := module
export Include := module

export source_ofac := [
'OCR 1186',//	OFAC COUNTRY REGIMES	 
'OGO 1072',//	OFAC: Government Officials
'RBL 1072',//	OFAC: Restricted or Blocked Locations
'TFP 1072',//	OFAC: Accuity Research
'USSD 1072',//OFAC: US State Department
'WBD 1072' //	OFAC: World Bank Directory
];

export source_listID := [

'OCR 1186',//	OFAC COUNTRY REGIMES	 
'OGO 1072',//	OFAC: Government Officials
'RBL 1072',//	OFAC: Restricted or Blocked Locations
'TFP 1072',//	OFAC: Accuity Research
'USSD 1072',//OFAC: US State Department
'WBD 1072',//	OFAC: World Bank Directory
///////////////////////////////////////////////////////////////

'ACB 1040',//	AUSTRIAN CENTRAL BANK
'ALL 1180',//	*ARAB LEAGUE LIST
'ARG 1006',//	Argentinean List
'BCW 1074',//	Central Bank of the Bahamas - CWL
'BEL 1008',//	Belgium List
'BIT 1086',//	BANK OF ITALY UNAUTHORIZED FINANCIAL ACTIVITY LIST
'BofE 29',	//Bank of England List
'CAC 1146',//	UN CHILDREN AND ARMED CONFLICT LIST
'CBI 1054',//	CBI INDIA
'CEL 1082',//	Canadian Economic Sanctioned Countries List
'CSL 1080',//	CANADIAN ECONOMIC UN SANCTIONS LIST
'CSSF 1114',//LUXEMBOURG CSSF
'CWL 32',//	  Cumulative Warning List
'DNB 1090',//	DUTCH BANK
'ECO 1144',//	EXPORT CONTROL ORGANISATION UK - IRAN LIST
//'ES 1014',//	Spain
'ESE 1158',//	EGYPT FINANCIAL SUPERVISORY AUTHORITY
'EU 33',		// EUROPEAN UNION
'EUE 1170',//	European Union Enhancements List
'FDJ 1152',//	FATF DEFICIENT JURISDICTIONS LIST
//'FMU 1126',//	UKRAINE FINANCIAL MONITORING
'FR 1010',//	France
'HMC 1178',//	*HMT COUNTRY REGIMES
'HME 1130',//	HMT ENHANCEMENT LIST
'IND 1048',//	INDIAN MINISTRY OF HOME AFFAIRS
'INTERPOL 38',
'ISA 1164',//	*IRAN SANCTIONS ACT
'ITL 1078',//	ISRAELI MOD TERROR LIST
'MEX 1038',//	Mexican Administrative Sanctions
'MFR 1068',//	MAURITIUS FSC REVOCATIONS
'MSB 1036', 
'NEP 1156',//	NEPAL CREDIT INFORMATION BUREAU
'NST * 0',	// NS-SDN
'NZ 1140',//	NEW ZEALAND POLICE
'OCF 1122',//	OCC Counterfeit List
'OCR 1186',//	*OFAC COUNTRY REGIMES
'PRT 1128',//	Sanctioned Airport and Seaport List
'RPL 1176',//	*RUSSIAN ROSFINMONITORING PUBLIC
'SAP 1056',//	SOUTH AFRICAN POLICE WANTED
'SAR 1032',//	SAUDI ARABIA - Most Wanted List
'SECO 42',//	Swiss State Secretariat for Economic Affairs
'SL 1136',//	SLOVAKIAN LIST
'TW 1016',//	Taiwan List
'UGO 1120',//	U.S. Government Officials
'UK 1046',//	UK HOME OFFICE
'UN 44',	    //United Nations Sanctions List
'UN 1064',//	*UNITED NATIONS
'UNE 1172',//	United Nations Enhancements List
'UNT 1064',//	UN TRAVEL RESTRICTIONS
'USM 45',	//	  US Marshals
'UST 0'    //US Treasury SDN List (OFAC)
]; 
end;

export source := [
'ACB',
'ALL',
'ARG',
'BCW',
'BEL',
'BIT',
'CAC',
'CBI',
'CEL',
'CSL',
'CSSF',
'CWL',
'DNB',
'ECO',
'ES',
'ESE',
'EUE',
'FDJ',
'FMU',
'FR',
'HMC',
'HME',
'IND',
'ISA',
'ITL',
'MEX',
'MFR',
'NEP',
'NZ',
'OCF',
'OCR',
'OGO',
'PRT',
'RBL',
'RPL',
'SAP',
'SAR',
'SECO',
'SL',
'TFP',
'TW',
'UGO',
'UK',
'UN',
'UNE',
'UNT',
'USM',
'USSD',
'WBD'
];

export listid := [
'32',
'42',
'45',
'1006',
'1008',
'1010',
'1014',
'1016',
'1032',
'1038',
'1040',
'1046',
'1048',
'1054',
'1056',
'1064',
'1068',
'1074',
'1078',
'1080',
'1082',
'1086',
'1090',
'1114',
'1120',
'1122',
//'1126',
'1128',
'1130',
'1136',
'1140',
'1144',
'1146',
'1152',
'1156',
'1158',
'1164',
'1170',
'1172',
'1176',
'1178',
'1180',
'1186'
];
			 
export Exclude := module
	export source_listID := [''];
	export source := [''];
	export listid := [''];
end;

export IDTypes := [
	'abarouting',
    'account',
    'alienregistration',
    'bankidentifiercode',
    'bankpartyid',
    'cedula',
    'chipsuid',
    'customerNumber',
    'driversLicense',
    'duns',
    'eftcode',
    'ein',
    'gln',
    'iban',
    'ibei',
    'member',
    'military',
    'national',
    'nit',
    'other',
    'passport',
    'proprietaryuid',
    'ssn',
    'swiftbei',
    'swiftbic',
    'taxid',
    'visa' 
];

export boolean IsValidIdType(string id) := stringlib.stringtolowercase(id) IN IDTypes;

end;