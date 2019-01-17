import Codes;

/*
	*************************************************************************************

		** ROYALTY TYPES AND CODES ARE NOT SUPPOSED TO BE ARBITRARILY ADDED OR MODIFIED. **

		The royalty types and codes defined in this attribute **MUST** match the types and
	codes defined in the MBS RoyaltyType table.
		If you are working on a project that requires a new royalty type/code to be defined,
	those should be provided to you by MBS or product teams.

	*************************************************************************************

		We're not pulling any data from Codes V3 at this point, but I'm using the same layout
	to define each royalty type/code, in case we ever decide to load this from Codes V3.

	Codes V3 convention:

			string35      file_name;		-- ROYALTY
			string50      field_name;		-- ROYALTY_TYPE
			string5       field_name2; 	-- ROYALTY_TYPE_CODE
			string15      code; 				-- SRC (optional)
			string330     long_desc;		-- Description

	*************************************************************************************
*/
MasterLayout := record
	Codes.Layout_Codes_V3.file_name;
	Codes.Layout_Codes_V3.field_name;
	Codes.Layout_Codes_V3.field_name2;
	string1 source_type; // 'I' for inhouse, 'G' for gateway
	Codes.Layout_Codes_V3.code;
	Codes.Layout_Codes_V3.long_desc;
end;

export Master := dataset(
		[
			{'ROYALTY', 'QSENT'						, '100'		, 'I', ''			, 'In House QSENT Phones'},
			{'ROYALTY', 'QSENT_GW_IQ411'	, '101'		, 'G', ''			, 'QSENT IQ411 Gateway)'},
			{'ROYALTY', 'QSENT_GW_PVS'		, '102'		, 'G', ''			, 'QSENT PVS Gateway'},
			{'ROYALTY', 'TARGUS'					, '110'		, 'G', ''			, 'Targus'},
			{'ROYALTY', 'TARGUS_PDE'			, '111'		, 'G', ''			, 'Targus PDE'},
			{'ROYALTY', 'TARGUS_WCS'			, '112'		, 'G', ''			, 'Targus Wireless Connection Search'},
			{'ROYALTY', 'TARGUS_VE'				, '113'		, 'G', ''			, 'Targus Verify Express'},
			{'ROYALTY', 'TARGUS_NV'				, '114'		, 'G', ''			, 'Targus Name Verification'},
			{'ROYALTY', 'METRONET'				, '120'		, 'G', ''			, 'Metronet (Equifax) Gateway'},
			{'ROYALTY', 'POLK'						, '130'		, 'G', ''			, 'MVR Polk'},
			// RESERVED: 140-149 - Experian
			{'ROYALTY', 'EXPERIAN'				, '140'		, 'G', ''			, 'VIN Experian'},
			{'ROYALTY', 'EN_HEADER_FCRA'	, '141'		, 'I', ''			, 'Experian FCRA Credit Header'},
			{'ROYALTY', 'EN_RTPERSON_SRCH', '142'		, 'G', ''			, 'Experian Realtime Person Search'},
			{'ROYALTY', 'EXP_NC_CRIM',      '143'		, 'G', ''			, 'Experian North Carolina Criminal Records'},
			{'ROYALTY', 'EXPERIAN_PLATE_VIN', '144'		, 'G', ''		, 'Experian plate to VIN'},
			{'ROYALTY', 'EXPERIAN_AUTO_CHECK', '145'	, 'G', ''		, 'Experian AutoCheck auto history'},
			// RESERVED: 150-159 - Inview Business Report
			{'ROYALTY', 'INVIEW_DEFAULT'		, '150', 'G', ''			, 'Business InView - Default'},
			{'ROYALTY', 'INVIEW_REPORT'			, '151', 'G', ''			, 'Business InView - BCRCI, BFRLEVL, BCIR Custom'},
			{'ROYALTY', 'INVIEW_BCRCI_BFRL'	, '152', 'G', ''			, 'Business InView - BCRCI, BFRLEVL'},
			{'ROYALTY', 'INVIEW_BCRCI_BCIR'	, '153', 'G', ''			, 'Business InView - BCRCI, BCIR Custom'},
			{'ROYALTY', 'INVIEW_BFRL_BCIR'	, '154', 'G', ''			, 'Business InView - BFRLEVL, BCIR Custom'},
			{'ROYALTY', 'INVIEW_BCRCI'			, '155', 'G', ''			, 'Business InView - Business Credit Risk Class'},
			{'ROYALTY', 'INVIEW_BFRL'				, '156', 'G', ''			, 'Business InView - Business Failure Risk Level'},
			{'ROYALTY', 'INVIEW_BCIR'				, '157', 'G', ''			, 'Business InView - BCIR Custom'},
			// 160: not used (500-520 has been alocated for GDC)
			{'ROYALTY', 'GDCVERIFY'				, '160', 'G', ''			, 'Global Data Company Gateway'},
			{'ROYALTY', 'NETACUITY'				, '170', 'G', ''			, 'Digital Envoy Gateway'},
			{'ROYALTY', 'ERC'							, '180', 'G', ''			, ''},
			{'ROYALTY', 'ATTUS'						, '190', 'G', ''			, ''},
			{'ROYALTY', 'FARES'						, '200', 'G', ''			, 'In House Property data'},
			{'ROYALTY', 'WR'							, '220', 'I', ''			, 'Last Resort (Phones)'},
			{'ROYALTY', 'EFX_DATA_MART'		, '225', 'I', ''			, 'Equifax Data Mart (Phones)'},
			{'ROYALTY', 'DMXML'						, '230', 'I', ''			, 'Direct Marketing/Total Source (Equifax) data'},
			{'ROYALTY', 'TEASERSCHAPPDATA', '240', 'I', ''			, ''},
			{'ROYALTY', 'FDN_DL_DATA'			, '250', 'I', ''			, 'Fraud Defense Network/DL Data'},
			{'ROYALTY', 'SBFE'						, '260', 'I', ''			, 'SBFE Data'},
			{'ROYALTY', 'SBFE_PDF'						, '261', 'I', ''			, 'SBFE PDF Data'},
			{'ROYALTY', 'EMAIL'						, '300', 'I', 'ET'		, 'Email: Entiera/Virtual DBS'},
			{'ROYALTY', 'EMAIL_AW'				, '301', 'I', 'AW'		, 'Email: Accquire Web'},
			{'ROYALTY', 'EMAIL_M1'				, '302', 'I', 'M1'		, 'Email: Media One'},
			{'ROYALTY', 'EMAIL_OM'				, '303', 'I', 'OM'		, 'Email: Outward Media'},
			{'ROYALTY', 'EMAIL_TM'				, '304', 'I', 'TM'		, 'Email: Thrive LT (non-royalty)'},
			{'ROYALTY', 'EMAIL_T$'				, '305', 'I', 'T$'		, 'Email: Thrive PD (non-royalty)'},
			{'ROYALTY', 'EMAIL_IB'				, '306', 'I', 'IB'		, 'Email: IBehavior (non-royalty)'},
			{'ROYALTY', 'EMAIL_IM'				, '307', 'I', 'IM'		, 'Email: Impulse (non-royalty)'},
			{'ROYALTY', 'EMAIL_W@'				, '308', 'I', 'W@'		, 'Email: Wired Assets (non-royalty)'},
			{'ROYALTY', 'EMAIL_AO'				, '309', 'I', 'AO'		, 'Email: Alloy Media (non-royalty)'},
			{'ROYALTY', 'EMAIL_DG'				, '310', 'I', 'DG'		, 'Email: DATAGENCE (V12)'},
			{'ROYALTY', 'EMAIL_SC'				, '311', 'I', 'SC'		, 'Email: Sales Channel'},
			{'ROYALTY', 'WORKPLACE'				, '320', 'I', ''			, 'Workplace'},
			{'ROYALTY', 'WORKPLACE_OC'		, '321', 'I', 'OC'		, 'Workplace: Oneclick'},
			{'ROYALTY', 'WORKPLACE_TT'		, '322', 'I', 'TT'		, 'Workplace: Teletrack'},
			{'ROYALTY', 'WORKPLACE_SC'		, '323', 'I', 'SC'		, 'Workplace: Sales Channel'},
			{'ROYALTY', 'WORKPLACE_TM'		, '324', 'I', 'TM'		, 'Workplace: Thrive Mortgage'},
			{'ROYALTY', 'WORKPLACE_T$'		, '325', 'I', 'T$'		, 'Workplace: Thrive Pay Day'},
			{'ROYALTY', 'WORKPLACE_SP_OC'	, '326', 'I', 'OC'		, 'Workplace: One click - Spouse'},
			{'ROYALTY', 'WORKPLACE_SP_TT'	, '327', 'I', 'TT'		, 'Workplace: Teletrack - Spouse'},
			{'ROYALTY', 'WORKPLACE_SP_SC'	, '328', 'I', 'SC'		, 'Workplace: Sales Channel - Spouse'},
			{'ROYALTY', 'WORKPLACE_SP_TM'	, '329', 'I', 'TM'		, 'Workplace: Thrive Mortgage - Spouse'},
			{'ROYALTY', 'WORKPLACE_SP_T$'	, '330', 'I', 'T$'		, 'Workplace: Thrive Pay Day - Spouse'},
			{'ROYALTY', 'WORLD'						, '350', 'I', ''			, 'Worldcheck'},
			{'ROYALTY', 'EAH_EQ'					, '360', 'I', ''			, 'Executive At Home (Equifax data)'},
			{'ROYALTY', 'EAH_DB_SALES'		, '361', 'I', ''			, ''},
			{'ROYALTY', 'EAH_DB_EMPS'			, '362', 'I', ''			, ''},
			{'ROYALTY', 'DNB_DMI'					, '370', 'I', ''			, 'Dunn & Bradstreet - DMI'},
			// RESERVED: 380-390 - Early Warning Systems Report (ESP only)
			{'ROYALTY', 'EWSREPORT'				, '380', 'G', ''			, 'Early Warning Systems Report'},
			// RESERVED: 390-399 - Delaware Corporation (ESP only)
			{'ROYALTY', 'DELCORP_SRCH2'		, '390', 'G', ''			, 'Delaware Corporation'},
			{'ROYALTY', 'DELCORP_RPT2'		, '391', 'G', ''			, 'Delaware Corporation'},
			// RESERVED: 400-409 - Social Media Locator - Social Intelligence - AFI Social Media Locator Search – Project #2503 (ESP only)
			{'ROYALTY', 'SMLOCATOR'				, '400', 'G', ''			, 'Social Media Locator (Social Intelligence)'},
			{'ROYALTY', 'SMLOCATOR_DEMO'	, '401', 'G', ''			, 'Social Media Locator (Social Intelligence) - DEMO'},
			// RESERVED: 410-419 - Worldview Validate - Global Data Consortium (ESP only)
			{'ROYALTY', 'WVV_DEFAULT'			, '410', 'G', ''			, 'Worldview Default'},
			{'ROYALTY', 'WVV_ENRICH_ADDR'	, '411', 'G', ''			, 'Worldview Validate Enrich Address'},
			{'ROYALTY', 'WVV_SCORE'				,	'412', 'G', ''			, 'Worldview Validate Score'},
			{'ROYALTY', 'WVV_ENRICH'			,	'413', 'G', ''			, 'Worldview Validate Enrich'},
			{'ROYALTY', 'WVV_SCORE_NID'		,	'414', 'G', ''		  , 'Worldview Validate Score with National ID'},
			{'ROYALTY', 'WVV_ENRICH_NID'	,	'415', 'G', ''		  , 'Worldview Validate Enrich with National ID'},
			// RESERVED: 420-429 - Multiple Equifax reports (ESP gateway only)
			{'ROYALTY', 'EFX_DEFAULT'			, '420', 'G', ''			, 'Equifax Default'},
			{'ROYALTY', 'EFX_ACCVERIFY'		, '421', 'G', ''			, 'Equifax Account Verify'},
			{'ROYALTY', 'EFX_ACROFILE'		, '422', 'G', ''			, 'Equifax Acrofile Report'},
			{'ROYALTY', 'EFX_DTEC'				, '423', 'G', ''			, 'Equifax Dtec Report'},
			{'ROYALTY', 'EFX_DTEC_LMTD'		, '424', 'G', ''			, 'Equifax Dtec Report Limited'},
			{'ROYALTY', 'EFX_IDREPORT'		, '425', 'G', ''			, 'Equifax ID Report'},
			{'ROYALTY', 'EFX_IDREPORT_LMTD', '426', 'G', ''			, 'Equifax ID Report Limited'},
			{'ROYALTY', 'EFX_FINDERS'			, '427', 'G', ''			, 'Equifax Finders'},
			{'ROYALTY', 'EFX_ADRS'				, '428', 'G', ''			, 'Equifax Powerview'},
			{'ROYALTY', 'EFX_FICO_XD'			, '429', 'G', ''			, 'Equifax FICO Score XD'},
			// RESERVED: 430-439 - Multiple Transunion reports (ESP Gateway only)
			{'ROYALTY', 'TU_DEFAULT'			, '430', 'G', ''			, 'Transunion Default'},
			{'ROYALTY', 'TU_FRAUD_ALERT'	, '431', 'G', ''			, 'Transunion Fraud Alert'},
			{'ROYALTY', 'TU_CREDITREPORT'	, '432', 'G', ''			, 'Transunion Credit Report'},
			{'ROYALTY', 'TU_SSNSEARCH'		, '433', 'G', ''			, 'Transunion SSN Search'},
			{'ROYALTY', 'TU_SSNREPORT'		, '434', 'G', ''			, 'Transunion SSN Report '},
			{'ROYALTY', 'TU_IDSEARCH'			, '435', 'G', ''			, 'Transunion ID Search'},
			{'ROYALTY', 'TU_IDREPORT'			, '436', 'G', ''			, 'Transunion ID Report'},
			{'ROYALTY', 'TU_COLREPORT'		, '437', 'G', ''			, 'Transunion Collection Report'},
			// RESERVED: 450-499 (GG2)
			{'ROYALTY', 'GG2'							, '450', 'G', ''				, 'Default GG2 Gateway'},
			{'ROYALTY', 'GG2_AUSTRALIA'		, '451', 'G', 'AU'			, 'GG2 Gateway - Australia'},
			{'ROYALTY', 'GG2_AUSTRIA'			, '452', 'G', 'AT'			, 'GG2 Gateway - Austria'},
			{'ROYALTY', 'GG2_CANADA'			, '453', 'G', 'CA'			, 'GG2 Gateway - Canada'},
			{'ROYALTY', 'GG2_CHINA'				, '454', 'G', 'CN'			, 'GG2 Gateway - China'},
			{'ROYALTY', 'GG2_GERMANY'			, '455', 'G', 'DE'			, 'GG2 Gateway - Germany'},
			{'ROYALTY', 'GG2_HONGKONG'		, '456', 'G', 'HK'			, 'GG2 Gateway - Hong Kong'},
			{'ROYALTY', 'GG2_IRELAND'			, '457', 'G', 'IE'			, 'GG2 Gateway - Ireland'},
			{'ROYALTY', 'GG2_JAPAN'				, '458', 'G', 'JP'			, 'GG2 Gateway - Japan'},
			{'ROYALTY', 'GG2_LUXEMBOURG'	, '459', 'G', 'LU'			, 'GG2 Gateway - Luxembourg'},
			{'ROYALTY', 'GG2_MEXICO'			, '460', 'G', 'MX'			, 'GG2 Gateway - Mexico'},
			{'ROYALTY', 'GG2_NETHERLANDS'	, '461', 'G', 'NL'			, 'GG2 Gateway - Netherlands'},
			{'ROYALTY', 'GG2_NEWZEALAND'	, '462', 'G', 'NZ'			, 'GG2 Gateway - New Zealand'},
			{'ROYALTY', 'GG2_SINGAPORE'		, '463', 'G', 'SG'			, 'GG2 Gateway - Singapore'},
			{'ROYALTY', 'GG2_SOUTHAFRICA'	, '464', 'G', 'ZA'			, 'GG2 Gateway - South Africa'},
			{'ROYALTY', 'GG2_SWITZERLAND'	, '465', 'G', 'CH'			, 'GG2 Gateway - Switzerland'},
			{'ROYALTY', 'GG2_UK'					, '466', 'G', 'GB'			, 'GG2 Gateway - United Kingdom'},
			{'ROYALTY', 'GG2_BRAZIL'			, '467', 'G', 'BR'			, 'GG2 Gateway - Brazil'},
			// RESERVED: 500-520 (GDC)
			{'ROYALTY', 'GDC'							, '500', 'G', ''				, 'Default GDC Gateway'},
			{'ROYALTY', 'GDC_AUSTRALIA'		, '501', 'G', 'AU'			, 'GDC Gateway - Australia'},
			{'ROYALTY', 'GDC_AUSTRIA'			, '502', 'G', 'AT'			, 'GDC Gateway - Austria'},
			{'ROYALTY', 'GDC_CANADA'			, '503', 'G', 'CA'			, 'GDC Gateway - Canada'},
			{'ROYALTY', 'GDC_CHINA'				, '504', 'G', 'CN'			, 'GDC Gateway - China'},
			{'ROYALTY', 'GDC_GERMANY'			, '505', 'G', 'DE'			, 'GDC Gateway - Germany'},
			{'ROYALTY', 'GDC_HONGKONG'		, '506', 'G', 'HK'			, 'GDC Gateway - Hong Kong'},
			{'ROYALTY', 'GDC_IRELAND'			, '507', 'G', 'IE'			, 'GDC Gateway - Ireland'},
			{'ROYALTY', 'GDC_JAPAN'				, '508', 'G', 'JP'			, 'GDC Gateway - Japan'},
			{'ROYALTY', 'GDC_LUXEMBOURG'	, '509', 'G', 'LU'			, 'GDC Gateway - Luxembourg'},
			{'ROYALTY', 'GDC_MEXICO'			, '510', 'G', 'MX'			, 'GDC Gateway - Mexico'},
			{'ROYALTY', 'GDC_NETHERLANDS'	, '511', 'G', 'NL'			, 'GDC Gateway - Netherlands'},
			{'ROYALTY', 'GDC_NEWZEALAND'	, '512', 'G', 'NZ'			, 'GDC Gateway - New Zealand'},
			{'ROYALTY', 'GDC_SINGAPORE'		, '513', 'G', 'SG'			, 'GDC Gateway - Singapore'},
			{'ROYALTY', 'GDC_SOUTHAFRICA'	, '514', 'G', 'ZA'			, 'GDC Gateway - South Africa'},
			{'ROYALTY', 'GDC_SWITZERLAND'	, '515', 'G', 'CH'			, 'GDC Gateway - Switzerland'},
			{'ROYALTY', 'GDC_UK'					, '516', 'G', 'GB'			, 'GDC Gateway - United Kingdom'},
			// RESERVED: 520 - 524 (Infutor)
			{'ROYALTY', 'INFUTOR_CPO'			, '520', 'G', ''				, 'Infutor Gateway - Cell Phone Ownership'},		// Phone Ownership Identification Batch (no ESP, no ESP)
			{'ROYALTY', 'SSA_VERIFY'			, '525', 'G', ''				, 'SSA Gateway - Social Security Administration'}, // ESP only
			// RESERVED: 530 - 539 (AVM Gateway)
			{'ROYALTY', 'AVM'							, '530', 'G', ''				, 'Default AVM Gateway - Corelogic Valuation Models'}, // ESP only
			// RESERVED: 540 - 544 (Softech)
			{'ROYALTY', 'SOFTECH_MVR_RPT'	, '540', 'G', ''				, 'Softech MVR Report'}, // ESP only
			// RESERVED: 550 - 554 (AT&T)
			{'ROYALTY', 'ATT_LIDB'				, '550', 'G', ''				, 'AT&T LIDB (Line Information Database) Gateway'}, // Batch (Thor) only
			{'ROYALTY', 'ATT_LIDB_DE1'		, '551', 'G', ''				, 'AT&T LIDB Data Element 1'}, // Batch (Thor) only
			{'ROYALTY', 'ATT_LIDB_DE2'		, '552', 'G', ''				, 'AT&T LIDB Data Element 2'}, // Batch (Thor) only
			{'ROYALTY', 'ATT_LIDB_DE3'		, '553', 'G', ''				, 'AT&T LIDB Data Element 3'}, // Batch (Thor) only
			{'ROYALTY', 'ATT_LIDB_DE4'		, '554', 'G', ''				, 'AT&T LIDB Data Element 4'}, // Batch (Thor) only
			// RESERVED: 560-564 (TMETRIX)
			{'ROYALTY', 'TMETRIX_LOGIN'		, '560', 'G', ''				, 'TrustDefender/ThreatMetrix Gateway'}, // ESP Only
			{'ROYALTY', 'TMETRIX_PAYMENT'	, '561', 'G', ''				, 'TrustDefender/ThreatMetrix Gateway '}, // ESP Only
			{'ROYALTY', 'TMETRIX_ACCOUNT'	, '562', 'G', ''				, 'TrustDefender/ThreatMetrix Gateway '}, // ESP Only
			// RESERVED: 565-570 (IDM)
			{'ROYALTY', 'IDM_VERIFY'			, '565', 'G', ''				, 'IDM Instant Verify'}, // ESP Only
			{'ROYALTY', 'IDM_AUTH'				, '566', 'G', ''				, 'IDM Instant Authenticate'}, // ESP Only
			// RESERVED: 570 - 590 Collateral Analytics
			{'ROYALTY', 'CA_VALUE_AVM',                     '570', 'G', ''				, 'CA Value AVM'},
			{'ROYALTY', 'CA_VALUE_AVM_PLUS',                '571', 'G', ''				, 'CA Value AVM Plus'},
			{'ROYALTY', 'CA_VALUE_AVM_INTERACTIVE',         '572', 'G', ''				, 'CA Value AVM Interactive '},
			{'ROYALTY', 'CA_VALUE_AVM_INTERACTIVE_PLUS',    '573', 'G', ''				, 'CA Value AVM Interactive Plus '},
			{'ROYALTY', 'CA_VALUE_RANGE_AVM',               '574', 'G', ''				, 'CA Value Range AVM'},
			{'ROYALTY', 'CA_VALUE_RANGE_AVM_PLUS',          '575', 'G', ''				, 'CA Value Range AVM Plus'},
			{'ROYALTY', 'CA_VALUE_RANGE_AVM_EXPRESS',       '576', 'G', ''				, 'CA Value Range AVM Express '},
			{'ROYALTY', 'CA_VALUE_AVM_EXPRESS',             '577', 'G', ''				, 'CA Value AVM Express'},
			{'ROYALTY', 'CA_VALUE_AVM_EXPRESS_PLUS',        '578', 'G', ''				, 'CA Value AVM Express Plus'},
			{'ROYALTY', 'CA_NEIGHBORHOOD_VALUE_RANGE',      '579', 'G', ''				, 'CA Neighborhood Value Range'},
			{'ROYALTY', 'CA_NEIGHBORHOOD_VALUE_RANGE_PLUS', '580', 'G', ''				, 'CA Neighborhood Value Range Plus'},
			{'ROYALTY', 'CA_COMPLEXITY_PROFILER',           '581', 'G', ''				, 'CA Complexity Profiler'},
			{'ROYALTY', 'CA_COMPLEXITY_PROFILER_PLUS',      '582', 'G', ''				, 'CA Complexity Profiler Plus'},
			{'ROYALTY', 'CA_MARKET_CONDITION',              '583', 'G', ''				, 'CA Market Condition'},
			{'ROYALTY', 'CA_RISK_PROFILER',                 '584', 'G', ''				, 'CA Risk Profiler'},
			// RESERVED: 590 - 599 more Equifax codes
			{'ROYALTY', 'EFX_MLA',                          '590', 'G', ''        , 'EFX Military Lending Act'},
			{'ROYALTY', 'ZUMIGO_DEFAULT',                   '600', 'G', '' , 'Default Zumigo phone gateway'},
			{'ROYALTY', 'ZUMIGO_IDENTITY',                  '601', 'G', '' , 'Zumigo get line id gateway'},
			{'ROYALTY', 'IAP_DEFAULT',                      '610', 'G', '' , 'ATT phones default'},
			{'ROYALTY', 'IAP_DQ_IRS',                       '611', 'G', '' , 'ATT phones Information Retrieval Service'},
			{'ROYALTY', 'IAP_DQ_COMCHECK',                  '612', 'G', '' , 'ATT Services Communication Check'},
			{'ROYALTY', 'EFX_CCR',                          '620', 'G', '' , 'Equifax Consumer Credit Report'},
			{'ROYALTY', 'EFX_TWN_VOE',                      '621', 'G', '' , 'Equifax TWN Verification of Employment'},
			{'ROYALTY', 'EFX_TWN_VOI',                      '622', 'G', '' , 'Equifax TWN Verification of Income'},
			{'ROYALTY', 'EFX_TWN_EI',                       '623', 'G', '' , 'Equifax TWN Employment Indicator'},
			{'ROYALTY', 'EFX_TWN_EI_ENH',                   '624', 'G', '' , 'Equifax TWN Enhanced Employment Indicator'},
			{'ROYALTY', 'EFX_ATTR',                         '625', 'G', '' , 'Equifax Data Attributes model 5391'},
			{'ROYALTY', 'EFX_TWN_VOE_GW',                   '626', 'G', '' , 'Equifax TWN Verification of Employment Online'},
			{'ROYALTY', 'EFX_TWN_VOI_GW',                   '627', 'G', '' , 'Equifax TWN Verification of Income Online'},
			{'ROYALTY', 'EFX_EMS',                          '628', 'G', '' , 'Equifax Trimerge credit report Gateway'},
			{'ROYALTY', 'DMD',                              '640', 'I', '' , 'Health Care Practitioner email addresses'},
			{'ROYALTY', 'FDNCORR',                          '650', 'I', '' , 'LexisNexis internal FDN logging'},
			{'ROYALTY', 'DHC',                              '660', 'I', '' , 'DHC affiliations dataset'},
			{'ROYALTY', 'DHC_IDN',                          '661', 'I', '' , 'DHC affiliations where facility type is IDN'},
			{'ROYALTY', 'DHC_ACO',                          '662', 'I', '' , 'DHC affiliations where facility type is ACO'},
			{'ROYALTY', 'DHC_GPO',                          '663', 'I', '' , 'DHC affiliations where facility type is GPO'},
			{'ROYALTY', 'AHA_EXEC_CONTACTS',                '670', 'I', '' , 'HCO executive contacts where the data source is AHA'},
			{'ROYALTY', 'AHA_HOSP_PROFILER',                '671', 'I', '' , 'AHA hospital profiler dataset'},
			{'ROYALTY', 'AHA_HOSP_PROFILER',                '672', 'I', '' , 'AHA full profile dataset'},
			{'ROYALTY', 'MCH_EXEC_CONTACTS',                '676', 'I', '' , 'HCO executive contacts where the data source is MCH'},
			{'ROYALTY', 'HLD',                              '678', 'I', '' , 'HLD email addresses'},
			{'ROYALTY', 'AMA_ID',                           '680', 'I', '' , 'AMA ID dataset where the data source is DMD'},
			{'ROYALTY', 'ABMS',                             '682', 'I', '' , 'ABMS distinct LNPID dataset'},
			{'ROYALTY', 'ACCUITY_BANK_ROUTING',             '690', 'I', '' , 'Accuity Bank Routing Data'},
			{'ROYALTY', 'CORTERA_REPORT',                   '700', 'G', '' , 'Cortera business info gateway'},
			{'ROYALTY', 'CORTERA_FILE',                     '701', 'I', '' , 'Cortera inhouse business info'},
			{'ROYALTY', 'ACCUDATA_DEFAULT',                 '710', 'G', '' , 'Accudata standard request'},
			{'ROYALTY', 'ACCUDATA_CNAM_CNM2',               '711', 'G', '' , 'Accudata phone number calling name'},
			{'ROYALTY', 'ACCUDATA_OCN_LNP',                 '712', 'G', '' , 'Accudata local number portability data'}
		]
		, MasterLayout);
