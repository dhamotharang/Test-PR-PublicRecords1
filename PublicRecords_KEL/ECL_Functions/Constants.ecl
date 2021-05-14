IMPORT Business_Risk_BIP, MDR, STD, BIPV2, Header, PublicRecords_KEL, risk_indicators;

/*
-99999: No LexID or input needed is not populated
-99998: No data returned from search
-99997: Records available but unable to calculate due to missing values or missing associated/child data
*/
EXPORT Constants := MODULE
	EXPORT STRING MISSING_INPUT_DATA := '-99999';
	EXPORT STRING NO_DATA_FOUND := '-99998';
	EXPORT STRING RECS_AVAIL_BUT_CANNOT_CALCULATE := '-99997';
	
	EXPORT INTEGER MISSING_INPUT_DATA_INT := -99999;
	EXPORT INTEGER NO_DATA_FOUND_INT := -99998;
  
	EXPORT INTEGER  BUSINESS_CONTACT_PROPERTY_LIMIT := 10000;
	
	EXPORT INTEGER BUSINESS_HEADER_LIMIT := 25000;
	EXPORT INTEGER PROPERTY_DID_JOIN_LIMIT := 1000;
	EXPORT INTEGER PROPERTY_ADDRESS_JOIN_LIMIT := 1000;
	EXPORT INTEGER PROPERTY_KFETCH_JOIN_LIMIT := 2000;
	EXPORT INTEGER VEHICLE_JOIN_LIMIT := 5000;
	EXPORT INTEGER HHID_Join_LIMIT := 100;
	EXPORT INTEGER Limit_Inquiries_Kfetch := 5000;
	export INTEGER MAX_OVERRIDE_LIMIT := 1000;
	export INTEGER MAX_OVERRIDE_LIMIT_SLIM := 100;
	
	EXPORT INTEGER Default_Atmost_1000 := 1000;
	EXPORT INTEGER Default_Atmost_100 := 100;
	EXPORT INTEGER Default_Atmost_2000 := 2000;
	EXPORT INTEGER Default_Atmost_3000 := 3000;
	EXPORT INTEGER Default_Atmost_10000 := 10000;
	

	EXPORT INTEGER PROPERTY_JOIN_LIMIT := 10;
	EXPORT INTEGER PROPERTY_SEARCH_FID_JOIN_LIMIT := 50;
	
	EXPORT STRING HouseHoldCORE := 'CORE';
	EXPORT STRING HouseHoldCOREVNOSSN := 'COREVNOSSN';
	

	//These were made up by MAS
	EXPORT CCW_Source_MAS :=	'CCW';//conceal carry
	EXPORT Hunt_Fish_Source_MAS :=	'HFL'; //hunthing fishing license
	EXPORT CityStateZip :=	'CSZ';
	EXPORT ADL :=	'ADL';
	EXPORT AVM :=	'AVM';
	EXPORT CFBPSurname :=	'CFS';
	EXPORT CFBPGeolinks :=	'CFG';
	EXPORT Hotlist :=	'USP';//usps hotlist
	EXPORT HouseHoldKeys :=	'HHI';
	EXPORT FraudPoint3Source := 'FP3';
	EXPORT DoNotMail := 'DNM';
	EXPORT HighRiskIndustries := 'HRI';
	EXPORT Watchdog_NonEN_FCRA := 'NEN';
	EXPORT Watchdog_NonEQ_FCRA := 'NEQ';
	EXPORT PersonContext := 'PCX';
	EXPORT VehicleDI := 'DI'; // This source appears in our vehicle data
	EXPORT CorrelationRiskGong := 'GH'; // This source appears in the correlation risk keys
	EXPORT src_Dunn_Data_Email := 'DX'; // This source appears in email data
	EXPORT src_MA_Census := 'UM'; // This source appears in the person header 
	
	EXPORT Type_Set := ['PERSONAL','SSN ONLY','UCC','TRANS CLOSURE'];
	EXPORT HIGH := 'HIGH';
	
	EXPORT 	rel_filter := '(right.Type IN PublicRecords_KEL.ECL_Functions.Constants.Type_Set AND right.Personal = TRUE AND right.Business = FALSE AND right.Confidence = PublicRecords_KEL.ECL_Functions.Constants.HIGH AND ((right.Title >= 1 AND right.Title < 43) OR (COUNT(RIGHT.rels) > 1 AND SUM(RIGHT.rels, Cnt) > 1 AND right.Title IN [43, 44])))';				

	
	// This is a set of the explicitly allowed Marketing Sources for use within the Analytic Library.  If a record doesn't belong to one of these sources, it will be blocked from usage in Marketing Products
	EXPORT SET OF STRING3 ALLOWED_MARKETING_SOURCES :=	
	//additional rules ucc,marketing relatives are applied in fn_kel_dpmbitmap & FDC
	//these 2 keys are no in codesv3 as of 3/23/2020 DF-26237 will add ucc market sources later 
	[MDR.SourceTools.src_UCCV2] + 	
	[MDR.sourceTools.src_Marketing_Relatives_Data]+	
	[MDR.SourceTools.src_Best_Person]+
	[MDR.SourceTools.src_Best_Business]+//best business already allowed but for consistency
	[MDR.SourceTools.src_Cortera_Tradeline]+//royalties!
	[CCW_Source_MAS]+
	[Hunt_Fish_Source_MAS];

	
	EXPORT VALIDATE_DATE_RANGE_LOW_DEFAULT := 1800;
	EXPORT VALIDATE_DATE_RANGE_HIGH_DEFAULT := STD.Date.AdjustDate(STD.Date.Today(), 100);
	
	EXPORT VALIDATE_DATE_RANGE_LOW_ARCHIVEDATE := ((INTEGER)(((STRING8)STD.Date.Today())[1..4]) - 120);
	EXPORT VALIDATE_DATE_RANGE_HIGH_ARCHIVEDATE := STD.Date.Today();

	// Generic marketing restrictions for UCCV2 keys, these will not be needed once DF-26237 is completed
	EXPORT Marketing_Allowed_UCC := ['TXD', 'TXH', 'CA', 'IL', 'NYC', 'MA', 'TX'];
	EXPORT Marketing_Allowed2 := ['CA', 'IL', 'MA', 'TX'];
	EXPORT Marketing_Allowed3 := ['TXD', 'TXH', 'NYC'];
	
	EXPORT FetchAll											:= BIPV2.IDconstants.Fetch_Level_UltID;		// By fetching all records at the Highest ID's you automatically get all records for child (lower) ID's
	EXPORT FetchPowID										:= BIPV2.IDconstants.Fetch_Level_PowID;		// 'W' - Pow
	EXPORT FetchProxID									:= BIPV2.IDconstants.Fetch_Level_ProxID;	// 'P' - Pow + Prox
	EXPORT FetchSeleID									:= BIPV2.IDconstants.Fetch_Level_SeleID;	// 'S' - Pow + Prox + Sele
	EXPORT FetchOrgID										:= BIPV2.IDconstants.Fetch_Level_OrgID;		// 'O' - Pow + Prox + Sele + Org
	EXPORT FetchUltID										:= BIPV2.IDconstants.Fetch_Level_UltID;		// 'U' - Pow + Prox + Sele + Org + Ult
	
	EXPORT LinkSearch := ENUM(
													Default = 0,	// 0 = Use Search Levels Set Per Attribute
													PowID,				// 1 = Universally Use PowID for Attributes
													ProxID,				// 2 = Universally Use ProxID for Attributes
													SeleID,				// 3 = Universally Use SeleID for Attributes
													OrgID,				// 4 = Universally Use OrgID for Attributes
													UltID					// 5 = Universally Use UltID for Attributes
													);
													
	EXPORT UltIDSet := [LinkSearch.UltID];
	EXPORT UltOrgIDSet := UltIDSet + [LinkSearch.OrgID];
	EXPORT UltOrgSeleIDSet := UltOrgIDSet + [LinkSearch.SeleID, LinkSearch.Default];
	EXPORT UltOrgSeleProxIDSet := UltOrgSeleIDSet + [LinkSearch.ProxID];					
	
	export masked_header_sources(string DataRestriction, boolean isFCRA) := function
		en := if((~isFCRA and DataRestriction[risk_indicators.iid_constants.posExperianRestriction]=risk_indicators.iid_constants.sTrue) or (isFCRA and DataRestriction[risk_indicators.iid_constants.posExperianFCRARestriction] in [risk_indicators.iid_constants.sTrue,'']), ['EN'], []);
		eq := if(DataRestriction[risk_indicators.iid_constants.posEquifaxRestriction]=risk_indicators.iid_constants.sTrue, ['EQ'], []);
		cy := if(DataRestriction[risk_indicators.iid_constants.posCertegyRestriction]=risk_indicators.iid_constants.sTrue, ['CY'], []);
		tn := if(DataRestriction[risk_indicators.iid_constants.posTransUnionRestriction]=risk_indicators.iid_constants.sTrue, ['TN'], []);
		fares := if(DataRestriction[risk_indicators.iid_constants.posFaresRestriction]=risk_indicators.iid_constants.sTrue, [MDR.sourceTools.src_Fares_Deeds_from_Asrs, MDR.sourceTools.src_LnPropV2_Fares_Asrs, MDR.sourceTools.src_LnPropV2_Fares_Deeds], []);
		all_restrictions := en + eq + cy + tn + fares;
		return all_restrictions;
end;
	
	EXPORT SetLinkSearchLevel (INTEGER LinkSearchLevel) := CASE(LinkSearchLevel,
																							LinkSearch.PowID	=> FetchPowID,
																							LinkSearch.ProxID	=> FetchProxID,
																							LinkSearch.SeleID	=> FetchSeleID,
																							LinkSearch.OrgID	=> FetchOrgID,
																							LinkSearch.UltID	=> FetchUltID,
																											FetchSeleID); // Defaulting to SeleID per Heather	
	

	EXPORT PreGLBRegulatedRecord(STRING Source_Column, UNSIGNED3 Date_Last_Seen_Column, UNSIGNED3 Date_First_Seen_Column) := 
				Source_Column IN MDR.SourceTools.set_GLB AND Header.isPreGLB_LIB(Date_Last_Seen_Column, Date_First_Seen_Column, Source_Column, '00000000000000000000000000000000000000000000000000');

	EXPORT GetDPPAState(STRING Source_Column) := MDR.SourceTools.DPPAOriginState(Source_Column);

	EXPORT Regulated    := TRUE;
	EXPORT NotRegulated := FALSE;
	EXPORT BlankString  := '';

	EXPORT SetQuickHeaderSource(STRING Source_Column) := IF(Source_Column  IN ['QH','WH'], MDR.sourceTools.src_Equifax, Source_Column);

	EXPORT LN_Property_State := ['ID', 'IL', 'KS', 'NM', 'SC', 'WA'];

	EXPORT Set_Liens_Sources(STRING TMSID) := MAP(
					TMSID[1..2] = 'MA' => mdr.sourcetools.src_Liens_v2_MA,
					TMSID[1..2] = 'HG' => mdr.sourcetools.src_Liens_v2_Hogan,
					TMSID[1..2] = 'CL' => mdr.sourcetools.src_Liens_v2_Chicago_Law,
					TMSID[1..2] = 'IL' => mdr.sourcetools.src_Liens_v2_ILFDLN,
					TMSID[1..2] = 'NY' => mdr.sourcetools.src_Liens_v2_NYC ,
					TMSID[1..2] = 'CJ' => mdr.sourcetools.src_Liens_v2_NYFDLN, MDR.sourceTools.src_Liens_v2);

	EXPORT Allowed_Business_Header_SRC := 
						[Business_Risk_BIP.Constants.Src_BusinessRegistration]+
						[Business_Risk_BIP.Constants.Src_CorpV2]+
						[Business_Risk_BIP.Constants.Src_DunnBradstreet]+
						[Business_Risk_BIP.Constants.Src_DunnBradstreetFEIN]+
						[Business_Risk_BIP.Constants.Src_Bureau]+
						[Business_Risk_BIP.Constants.Src_FBN]+
						[Business_Risk_BIP.Constants.Src_Frandx]+
						[Business_Risk_BIP.Constants.Src_Liens]+
						[Business_Risk_BIP.Constants.Src_DCA]+
						[Business_Risk_BIP.Constants.Src_UCC]+
						[Business_Risk_BIP.Constants.Src_Aircrafts]+
						[Business_Risk_BIP.Constants.Src_Bankruptcy]+
						[Business_Risk_BIP.Constants.Src_BBB_Member]+
						[Business_Risk_BIP.Constants.Src_BBB_Non_Member]+
						[Business_Risk_BIP.Constants.Src_CalBus]+
						[Business_Risk_BIP.Constants.Src_CreditUnions]+
						[Business_Risk_BIP.Constants.Src_DEA]+
						[Business_Risk_BIP.Constants.Src_ExperianCRDB]+
						[Business_Risk_BIP.Constants.Src_ExperianFEIN]+
						[Business_Risk_BIP.Constants.Src_FDIC]+
						[Business_Risk_BIP.Constants.Src_IRS5500]+
						[Business_Risk_BIP.Constants.Src_IRS_Non_Profit]+
						[Business_Risk_BIP.Constants.Src_Vehicles]+
						[Business_Risk_BIP.Constants.Src_OSHA]+
						[Business_Risk_BIP.Constants.Src_Prolic]+
						[Business_Risk_BIP.Constants.Src_Property]+
						[Business_Risk_BIP.Constants.Src_SKA]+
						[Business_Risk_BIP.Constants.Src_TXBUS]+
						[Business_Risk_BIP.Constants.Src_INFOUSA_ABIUS_USABIZ]+
						[Business_Risk_BIP.Constants.Src_Watercraft]+
						[Business_Risk_BIP.Constants.Src_Yellow_Pages]+
						[Business_Risk_BIP.Constants.Src_INFOUSA_DEAD_COMPANIES]+
						[Business_Risk_BIP.Constants.Src_Diversity_Cert]+
						[Business_Risk_BIP.Constants.Src_FCC_Radio_Licenses]+
						[Business_Risk_BIP.Constants.Src_GSA]+
						[Business_Risk_BIP.Constants.Src_Gong]+
						[Business_Risk_BIP.Constants.Src_LaborActions_WHD]+
						[Business_Risk_BIP.Constants.Src_SEC_Broker_Dealer]+
						[Business_Risk_BIP.Constants.Src_Workers_Compensation]+
						[Business_Risk_BIP.Constants.Src_ACF]+
						[Business_Risk_BIP.Constants.Src_AMS]+
						[Business_Risk_BIP.Constants.Src_Atf]+
						[Business_Risk_BIP.Constants.Src_Bankruptcy_Attorney]+
						[Business_Risk_BIP.Constants.Src_Ingenix_Sanctions]+
						[Business_Risk_BIP.Constants.Src_CA_Sales_Tax]+
						[Business_Risk_BIP.Constants.Src_CLIA]+
						[Business_Risk_BIP.Constants.Src_Edgar]+
						[Business_Risk_BIP.Constants.Src_Employee_Directories]+
						[Business_Risk_BIP.Constants.Src_FDIC]+
						[Business_Risk_BIP.Constants.Src_Foreclosures]+
						[Business_Risk_BIP.Constants.Src_Garnishments]+
						[Business_Risk_BIP.Constants.Src_Insurance_Certification]+
						[Business_Risk_BIP.Constants.Src_IA_Sales_Tax]+
						[Business_Risk_BIP.Constants.Src_MartinDale_Hubbell]+
						[Business_Risk_BIP.Constants.Src_MS_Worker_Comp]+
						[Business_Risk_BIP.Constants.Src_NaturalDisaster_Readiness]+
						[Business_Risk_BIP.Constants.Src_NCPDP]+
						[Business_Risk_BIP.Constants.Src_NPPES]+
						[Business_Risk_BIP.Constants.Src_OIG]+
						[Business_Risk_BIP.Constants.Src_OR_Worker_Comp]+
						[Business_Risk_BIP.Constants.Src_CrashCarrier]+	
						[Business_Risk_BIP.Constants.Src_Sheila_Greco]+
						[Business_Risk_BIP.Constants.Src_Spoke]+
						[Business_Risk_BIP.Constants.Src_Targus_Gateway]+
						[Business_Risk_BIP.Constants.Src_Utility_sources]+
						[Business_Risk_BIP.Constants.Src_Vickers]+
						[Business_Risk_BIP.Constants.Src_PhonesPlus]+
						[Business_Risk_BIP.Constants.Src_Business_Credit]+
						[MDR.sourceTools.src_Cortera]+
						[MDR.sourceTools.src_Equifax_Business_Data]+
						[MDR.sourceTools.src_Infutor_NARB]+
						[MDR.sourceTools.src_DataBridge];
						
	// Consumer header sources allowed for use. All sources in this list are allowed for NonFCRA. Sources marked with IsFCRA = TRUE are allowed for FCRA.
	EXPORT Allowed_Consumer_Header_SRC := DATASET([
						{MDR.sourceTools.src_AK_Perm_Fund, TRUE},	// AK
						{MDR.sourceTools.src_Airmen, TRUE},	// AM
						{MDR.sourceTools.src_Aircrafts, TRUE},	// AR
						{MDR.sourceTools.src_Bankruptcy, TRUE},	// BA
						{MDR.sourceTools.src_US_Coastguard, TRUE},	// CG
						{MDR.sourceTools.src_Certegy, FALSE},	// CY
						{MDR.sourceTools.src_DE_Experian_DL, FALSE},	// 2X
						{MDR.sourceTools.src_ID_Experian_DL, FALSE},	// 3X
						{MDR.sourceTools.src_IL_Experian_DL, FALSE},	// 4X
						{MDR.sourceTools.src_KY_Experian_DL, FALSE},	// 5X
						{MDR.sourceTools.src_MS_Experian_DL, FALSE},	// 8X
						{MDR.sourceTools.src_ME_DL, FALSE},	// AD
						{MDR.sourceTools.src_MI_DL, FALSE},	// CD
						{MDR.sourceTools.src_FL_DL, FALSE},	// FD
						{MDR.sourceTools.src_ID_DL, FALSE},	// ID
						{MDR.sourceTools.src_KY_DL, FALSE},	// KD
						{MDR.sourceTools.src_MO_DL, FALSE},	// MD
						{MDR.sourceTools.src_MN_DL, FALSE},	// ND
						{MDR.sourceTools.src_OH_DL, FALSE},	// OD
						{MDR.sourceTools.src_MA_DL, FALSE},	// PD
						{MDR.sourceTools.src_NC_DL, FALSE},	// QD
						{MDR.sourceTools.src_TN_DL, FALSE},	// SD
						{MDR.sourceTools.src_TX_DL, FALSE},	// TD
						{MDR.sourceTools.src_WI_DL, FALSE},	// WD
						{MDR.sourceTools.src_SC_Experian_DL, FALSE},	// XX
						{MDR.sourceTools.src_WY_DL, FALSE},	// YD
						{MDR.sourceTools.src_DEA, TRUE},	// DA
						{MDR.sourceTools.src_Death_NV, TRUE},	// D!
						{MDR.sourceTools.src_Death_VA, TRUE},	// D%
						{MDR.sourceTools.src_Death_CA, TRUE},	// D0
						{MDR.sourceTools.src_Death_FL, TRUE},	// D2
						{MDR.sourceTools.src_Death_GA, TRUE},	// D3
						{MDR.sourceTools.src_Death_MI, TRUE},	// D7
						{MDR.sourceTools.src_Death_MT, TRUE},	// D9
						{MDR.sourceTools.src_Death_OH, TRUE},	// D@
						{MDR.sourceTools.src_Death_Master, TRUE},	// DE
						{MDR.sourceTools.src_Death_State, TRUE},	// DS
						{MDR.sourceTools.src_Death_Obituary, TRUE},	// OB
						{MDR.sourceTools.src_OKC_Probate, TRUE},	// OP
						{MDR.sourceTools.src_Death_Tributes, TRUE},	// TR
						{MDR.sourceTools.src_EMerge_Boat, TRUE},	// EB
						{MDR.sourceTools.src_Experian_Phones, FALSE},	// EL
						{MDR.sourceTools.src_EMerge_Hunt, TRUE},	// E1
						{MDR.sourceTools.src_EMerge_Fish, TRUE},	// E2
						{MDR.sourceTools.src_EMerge_CCW, TRUE},	// E3
						{MDR.sourceTools.src_EMerge_Cens, TRUE},	// E4
						{MDR.sourceTools.src_EMerge_Master, TRUE},	// EM
						{MDR.sourceTools.src_Experian_Credit_Header, TRUE},	// EN
						{MDR.sourceTools.src_Equifax, TRUE},	// EQ
						{MDR.sourceTools.src_Equifax_Quick, TRUE},	// QH
						{MDR.sourceTools.src_Equifax_Weekly, TRUE},	// WH
						{MDR.sourceTools.src_Federal_Explosives, TRUE},	// FE
						{MDR.sourceTools.src_Federal_Firearms, TRUE},	// FF
						{MDR.sourceTools.src_Foreclosures, FALSE},	// FR
						{MDR.sourceTools.src_Liens_v2, TRUE},	// L2
						{MDR.sourceTools.src_Liens, FALSE},	// LI
						{MDR.sourceTools.src_MS_Worker_Comp, TRUE},	// MW
						{MDR.sourceTools.src_Foreclosures_Delinquent, FALSE},	// NT
						{MDR.sourceTools.src_LnPropV2_Fares_Asrs, FALSE},	// FA
						{MDR.sourceTools.src_LnPropV2_Fares_Deeds, FALSE},	// FP
						{MDR.sourceTools.src_LnPropV2_Lexis_Asrs, TRUE},	// LA
						{MDR.sourceTools.src_LnPropV2_Lexis_Deeds_Mtgs, TRUE},	// LP
						{MDR.sourceTools.src_Fares_Deeds_from_Asrs, FALSE}, // FP
						{MDR.sourceTools.src_AlloyMedia_student_list, TRUE},	// AY
						{MDR.sourceTools.src_American_Students_List, TRUE},	// SL
						{MDR.sourceTools.src_OKC_Students_List, FALSE},	// S1
						{MDR.sourceTools.src_TU_CreditHeader, FALSE},	// TN
						{MDR.sourceTools.src_TUCS_Ptrack, FALSE},	// TS
						{MDR.sourceTools.src_Lexis_Trans_Union, FALSE},	// LT
						{MDR.sourceTools.src_TransUnion, FALSE},	// TU
						{MDR.sourceTools.src_Mixed_Utilities, TRUE},	// MU
						{MDR.sourceTools.src_Utilities, FALSE},	// UT
						{MDR.sourceTools.src_Util_Work_Phone, FALSE},	// UW
						{MDR.sourceTools.src_ZUtil_Work_Phone, FALSE},	// ZK
						{MDR.sourceTools.src_ZUtilities, FALSE},	// ZT
						{MDR.sourceTools.src_OH_Experian_Veh, FALSE},	// !E
						{MDR.sourceTools.src_WY_Experian_Veh, FALSE},	// #E
						{MDR.sourceTools.src_DE_Experian_Veh, FALSE},	// $E
						{MDR.sourceTools.src_DC_Experian_Veh, FALSE},	// &E
						{MDR.sourceTools.src_TX_Experian_Veh, FALSE},	// .E
						{MDR.sourceTools.src_SD_Experian_Veh, FALSE},	// 70
						{MDR.sourceTools.src_AR_Experian_Veh, FALSE},	// 71
						{MDR.sourceTools.src_AZ_Experian_Veh, FALSE},	// 73
						{MDR.sourceTools.src_IA_Experian_Veh, FALSE},	// 74
						{MDR.sourceTools.src_KS_Experian_Veh, FALSE},	// 75
						{MDR.sourceTools.src_NC_Experian_Veh, FALSE},	// 76
						{MDR.sourceTools.src_RI_Experian_Veh, FALSE},	// 77
						{MDR.sourceTools.src_VT_Experian_Veh, FALSE},	// 79
						{MDR.sourceTools.src_ND_Experian_Veh, FALSE},	// @E
						{MDR.sourceTools.src_AK_Experian_Veh, FALSE},	// AE
						{MDR.sourceTools.src_ME_Veh, FALSE},	// AV
						{MDR.sourceTools.src_AL_Experian_Veh, FALSE},	// BE
						{MDR.sourceTools.src_CO_Experian_Veh, FALSE},	// EE
						{MDR.sourceTools.src_NE_Veh, FALSE},	// EV
						{MDR.sourceTools.src_FL_Veh, FALSE},	// FV
						{MDR.sourceTools.src_FL_Experian_Veh, FALSE},	// GE
						{MDR.sourceTools.src_NE_Experian_Veh, FALSE},	// HE
						{MDR.sourceTools.src_IL_Experian_Veh, FALSE},	// IE
						{MDR.sourceTools.src_ID_Veh, FALSE},	// IV
						{MDR.sourceTools.src_ID_Experian_Veh, FALSE},	// JE
						{MDR.sourceTools.src_KY_Experian_Veh, FALSE},	// KE
						{MDR.sourceTools.src_KY_Veh, FALSE},	// KV
						{MDR.sourceTools.src_LA_Experian_Veh, FALSE},	// LE
						{MDR.sourceTools.src_MT_Veh, FALSE},	// LV
						{MDR.sourceTools.src_GA_Experian_Veh, FALSE},	// M
						{MDR.sourceTools.src_MD_Experian_Veh, FALSE},	// ME
						{MDR.sourceTools.src_MS_Veh, FALSE},	// MV
						{MDR.sourceTools.src_MA_Experian_Veh, FALSE},	// NE
						{MDR.sourceTools.src_MN_Veh, FALSE},	// NV
						{MDR.sourceTools.src_OK_Experian_Veh, FALSE},	// OE
						{MDR.sourceTools.src_OH_Veh, FALSE},	// OV
						{MDR.sourceTools.src_MI_Experian_Veh, FALSE},	// PE
						{MDR.sourceTools.src_NY_Experian_Veh, FALSE},	// QE
						{MDR.sourceTools.src_ME_Experian_Veh, FALSE},	// RE
						{MDR.sourceTools.src_NC_Veh, FALSE},	// RV
						{MDR.sourceTools.src_SC_Experian_Veh, FALSE},	// SE
						{MDR.sourceTools.src_MO_Veh, FALSE},	// SV
						{MDR.sourceTools.src_TN_Experian_Veh, FALSE},	// TE
						{MDR.sourceTools.src_TX_Veh, FALSE},	// TV
						{MDR.sourceTools.src_UT_Experian_Veh, FALSE},	// UE
						{MDR.sourceTools.src_MN_Experian_Veh, FALSE},	// VE
						{MDR.sourceTools.src_WI_Experian_Veh, FALSE},	// WE
						{MDR.sourceTools.src_WI_Veh, FALSE},	// WV
						{MDR.sourceTools.src_MS_Experian_Veh, FALSE},	// XE
						{MDR.sourceTools.src_MO_Experian_Veh, FALSE},	// YE
						{MDR.sourceTools.src_WY_Veh, FALSE},	// YV
						{MDR.sourceTools.src_MT_Experian_Veh, FALSE},	// ZE
						{MDR.sourceTools.src_Voters_v2, TRUE},	// VO
						{MDR.sourceTools.src_AK_Fishing_boats, TRUE},	// ^W
						{MDR.sourceTools.src_AK_Watercraft, TRUE},	// #W
						{MDR.sourceTools.src_WA_Watercraft, TRUE},	// %W
						{MDR.sourceTools.src_MN_Watercraft, TRUE},	// 1W
						{MDR.sourceTools.src_MS_Watercraft, TRUE},	// 2W
						{MDR.sourceTools.src_MT_Watercraft, TRUE},	// 3W
						{MDR.sourceTools.src_NE_Watercraft, TRUE},	// 5W
						{MDR.sourceTools.src_UT_Watercraft, TRUE},	// 9W
						{MDR.sourceTools.src_WY_Watercraft, TRUE},	// @W
						{MDR.sourceTools.src_MO_Watercraft, TRUE},	// BW
						{MDR.sourceTools.src_FL_Watercraft, TRUE},	// FW
						{MDR.sourceTools.src_GA_Watercraft, TRUE},	// GW
						{MDR.sourceTools.src_KS_Watercraft, TRUE},	// HW
						{MDR.sourceTools.src_MA_Watercraft, TRUE},	// JW
						{MDR.sourceTools.src_KY_Watercraft, TRUE},	// KW
						{MDR.sourceTools.src_AL_Watercraft, TRUE},	// LW
						{MDR.sourceTools.src_NC_Watercraft, TRUE},	// NW
						{MDR.sourceTools.src_OH_Watercraft, TRUE},	// OW
						{MDR.sourceTools.src_IL_Watercraft, TRUE},	// PW
						{MDR.sourceTools.src_ME_Watercraft, TRUE},	// QW
						{MDR.sourceTools.src_AR_Watercraft, TRUE},	// RW
						{MDR.sourceTools.src_SC_Watercraft, TRUE},	// SW
						{MDR.sourceTools.src_TN_Watercraft, TRUE},	// TW
						{MDR.sourceTools.src_WI_Watercraft, TRUE},	// WW
						{MDR.sourceTools.src_MI_Watercraft, TRUE},	// XW
						{MDR.sourceTools.src_NY_Watercraft, TRUE},	// YW
						{MDR.sourceTools.src_AZ_Watercraft, TRUE},	// ZW
						{MDR.sourceTools.src_TX_Watercraft, TRUE},	// [W
						{MDR.sourceTools.src_Targus_White_pages, TRUE},	// WP
						{MDR.sourceTools.src_Professional_License, TRUE}], // PL
									{STRING2 src, BOOLEAN IsFCRA});

	EXPORT SourceGroup_AK_Perm_Fund := 'AK';
	EXPORT SourceGroup_Airmen := 'AM';
	EXPORT SourceGroup_Aircrafts := 'AR';
	EXPORT SourceGroup_Bankruptcy := 'BA';
	EXPORT SourceGroup_US_Coastguard := 'CG';
	EXPORT SourceGroup_Certegy := 'CY';
	EXPORT SourceGroup_DL := 'D ';
	EXPORT SourceGroup_DEA := 'DA';
	EXPORT SourceGroup_Death := 'DE';
	EXPORT SourceGroup_EMerge_Boat := 'EB';
	EXPORT SourceGroup_Experian_Phones := 'EL';
	EXPORT SourceGroup_EMerge := 'EM';
	EXPORT SourceGroup_Experian_Credit_Header := 'EN';
	EXPORT SourceGroup_Equifax := 'EQ';
	EXPORT SourceGroup_Federal_Explosives := 'FE';
	EXPORT SourceGroup_Federal_Firearms := 'FF';
	EXPORT SourceGroup_Foreclosures := 'FR';
	EXPORT SourceGroup_Liens_v2 := 'L2';
	EXPORT SourceGroup_MS_Worker_Comp := 'MW';
	EXPORT SourceGroup_Foreclosures_Delinquent := 'NT';
	EXPORT SourceGroup_LnPropV2 := 'P ';
	EXPORT SourceGroup_Professional_License := 'PL';
	EXPORT SourceGroup_StudentList := 'SL';
	EXPORT SourceGroup_OKC_Students_List := 'S1';
	EXPORT SourceGroup_TU_CreditHeader := 'TN';
	EXPORT SourceGroup_TUCS_Ptrack := 'TS';
	EXPORT SourceGroup_TransUnion := 'TU';
	EXPORT SourceGroup_Utilities := 'U ';
	EXPORT SourceGroup_Vehicle := 'V ';
	EXPORT SourceGroup_Voters_v2 := 'VO';
	EXPORT SourceGroup_Watercraft := 'W ';
	EXPORT SourceGroup_Targus_White_pages := 'WP';

	EXPORT Layout_Allowed_Sources := RECORD
		STRING3 Source;
	END;
	
	// This is every source we are aware of
	//the below sources that are commented out we are not using in mas, if you need to turn on of these back on you will need to un comment the source from below, in 
	//Entities and PublicRecords_KEL.ECL_Functions.Fn_KEL_DPMBitmap.  if the source is added to header in order to see the source you also 
	//need to add the source to the consumer/bip header allowed sources lists in PublicRecords_KEL.ECL_Functions.Common_Functions	

	EXPORT DEFAULT_ALLOWED_SOURCES := DATASET([
		// {MDR.SourceTools.src_ABMS},
		// {MDR.SourceTools.src_ACA},
		// {MDR.SourceTools.src_Accidents_FL},
		{MDR.SourceTools.src_Accidents_ECrash},
		// {MDR.SourceTools.src_Accidents_ECrash_CRU},
		{MDR.SourceTools.src_Accurint_Arrest_Log},
		{MDR.SourceTools.src_Accurint_Crim_Court},
		{MDR.SourceTools.src_Accurint_DOC},
		// {MDR.SourceTools.src_Accurint_Sex_offender},
		// {MDR.SourceTools.src_Accurint_Trade_Show},
		{MDR.SourceTools.src_ACF},
		{MDR.SourceTools.src_Acquiredweb},
		{MDR.SourceTools.src_Acquiredweb_plus},
		{MDR.SourceTools.src_advo_valassis},
		// {MDR.SourceTools.src_AHA},
		{MDR.SourceTools.src_Aircrafts},
		{MDR.SourceTools.src_Airmen},
		// {MDR.SourceTools.src_AK_Busreg},
		{MDR.SourceTools.src_AK_Fishing_boats},
		{MDR.SourceTools.src_AK_Perm_Fund},
		// {MDR.SourceTools.src_ALC},
		{MDR.SourceTools.src_AlloyMedia_consumer},
		{MDR.SourceTools.src_AlloyMedia_student_list},
		{MDR.SourceTools.src_American_Students_List},
		{MDR.SourceTools.src_OKC_Students_List},
		// {MDR.SourceTools.src_AMIDIR},
		// {MDR.SourceTools.src_AMS},
		{MDR.SourceTools.src_Anchor},
		// {MDR.SourceTools.src_Bair_Analytics},
		{MDR.SourceTools.src_Bankruptcy},
		// {MDR.SourceTools.src_Bankruptcy_Attorney},
		// {MDR.SourceTools.src_Bankruptcy_Trustee},
		{MDR.SourceTools.src_BBB_Member},
		{MDR.SourceTools.src_BBB_Non_Member},
		{MDR.SourceTools.src_Best_Business},
		{MDR.SourceTools.src_Best_Person},
		// {MDR.SourceTools.src_Business_Credit},
		{MDR.SourceTools.src_Business_Registration},
		{MDR.SourceTools.src_Calbus},
		// {MDR.SourceTools.src_Cellphones_kroll},
		// {MDR.SourceTools.src_Cellphones_nextones},
		// {MDR.SourceTools.src_Cellphones_traffix},
		{MDR.SourceTools.src_Certegy},
		{MDR.SourceTools.src_Consumer_Disclosure_feed},
		// {MDR.SourceTools.src_CClue},
		// {MDR.SourceTools.src_FL_CH},
		// {MDR.SourceTools.src_GA_CH},
		// {MDR.SourceTools.src_PA_CH},
		// {MDR.SourceTools.src_UT_CH},
		// {MDR.SourceTools.src_Clarity},
		// {MDR.SourceTools.src_CLIA},
		// {MDR.SourceTools.src_CNLD_Facilities},
		// {MDR.SourceTools.src_CNLD_Practitioner},
		{MDR.SourceTools.src_AK_Corporations},
		{MDR.SourceTools.src_AL_Corporations},
		{MDR.SourceTools.src_AR_Corporations},
		{MDR.SourceTools.src_AZ_Corporations},
		{MDR.SourceTools.src_CA_Corporations},
		{MDR.SourceTools.src_CO_Corporations},
		{MDR.SourceTools.src_CT_Corporations},
		{MDR.SourceTools.src_DC_Corporations},
		{MDR.SourceTools.src_FL_Corporations},
		{MDR.SourceTools.src_GA_Corporations},
		{MDR.SourceTools.src_HI_Corporations},
		{MDR.SourceTools.src_IA_Corporations},
		{MDR.SourceTools.src_ID_Corporations},
		{MDR.SourceTools.src_IL_Corporations},
		{MDR.SourceTools.src_IN_Corporations},
		{MDR.SourceTools.src_KS_Corporations},
		{MDR.SourceTools.src_KY_Corporations},
		{MDR.SourceTools.src_LA_Corporations},
		{MDR.SourceTools.src_MA_Corporations},
		{MDR.SourceTools.src_MD_Corporations},
		{MDR.SourceTools.src_ME_Corporations},
		{MDR.SourceTools.src_MI_Corporations},
		{MDR.SourceTools.src_MN_Corporations},
		{MDR.SourceTools.src_MO_Corporations},
		{MDR.SourceTools.src_MS_Corporations},
		{MDR.SourceTools.src_MT_Corporations},
		{MDR.SourceTools.src_NC_Corporations},
		{MDR.SourceTools.src_ND_Corporations},
		{MDR.SourceTools.src_NE_Corporations},
		{MDR.SourceTools.src_NH_Corporations},
		{MDR.SourceTools.src_NJ_Corporations},
		{MDR.SourceTools.src_NM_Corporations},
		{MDR.SourceTools.src_NV_Corporations},
		{MDR.SourceTools.src_NY_Corporations},
		{MDR.SourceTools.src_OH_Corporations},
		{MDR.SourceTools.src_OK_Corporations},
		{MDR.SourceTools.src_OR_Corporations},
		{MDR.SourceTools.src_PA_Corporations},
		{MDR.SourceTools.src_RI_Corporations},
		{MDR.SourceTools.src_SC_Corporations},
		{MDR.SourceTools.src_SD_Corporations},
		{MDR.SourceTools.src_TN_Corporations},
		{MDR.SourceTools.src_TX_Corporations},
		{MDR.SourceTools.src_UT_Corporations},
		{MDR.SourceTools.src_VA_Corporations},
		{MDR.SourceTools.src_VT_Corporations},
		{MDR.SourceTools.src_WA_Corporations},
		{MDR.SourceTools.src_WI_Corporations},
		{MDR.SourceTools.src_WV_Corporations},
		// {MDR.SourceTools.src_WV_Hist_Corporations},
		{MDR.SourceTools.src_WY_Corporations},
		// {MDR.SourceTools.src_Correctional_Facilities},
		{MDR.SourceTools.src_Cortera},
		{MDR.SourceTools.src_Cortera_Tradeline},
		// {MDR.SourceTools.src_CrashCarrier},
		{MDR.SourceTools.src_Credit_Unions},
		{MDR.SourceTools.src_DataBridge},
		{MDR.SourceTools.src_Datagence},
		{MDR.SourceTools.src_DCA},
		{MDR.SourceTools.src_DEA},
		// {MDR.SourceTools.src_Death_Michigan},
		{MDR.SourceTools.src_Death_Master},
		{MDR.SourceTools.src_Death_Restricted},
		{MDR.SourceTools.src_Death_State},
		{MDR.SourceTools.src_Death_Tributes},
		{MDR.SourceTools.src_Death_Obituary},
		{MDR.SourceTools.src_Death_CA},
		// {MDR.SourceTools.src_Death_CT},
		{MDR.SourceTools.src_Death_FL},
		{MDR.SourceTools.src_Death_GA},
		// {MDR.SourceTools.src_Death_KY},
		// {MDR.SourceTools.src_Death_MA},
		// {MDR.SourceTools.src_Death_ME},
		{MDR.SourceTools.src_Death_MI},
		// {MDR.SourceTools.src_Death_MN},
		{MDR.SourceTools.src_Death_MT},
		// {MDR.SourceTools.src_Death_NC},
		{MDR.SourceTools.src_Death_NV},
		{MDR.SourceTools.src_Death_OH},
		{MDR.SourceTools.src_Death_VA},
		// {MDR.SourceTools.src_Debt_Settlement},
		{MDR.SourceTools.src_Diversity_Cert},
		// {MDR.SourceTools.src_Divorce},
		{MDR.SourceTools.src_CT_DL},
		{MDR.SourceTools.src_FL_DL},
		// {MDR.SourceTools.src_IA_DL},
		{MDR.SourceTools.src_ID_DL},
		{MDR.SourceTools.src_KY_DL},
		{MDR.SourceTools.src_MA_DL},
		{MDR.SourceTools.src_ME_DL},
		{MDR.SourceTools.src_MI_DL},
		{MDR.SourceTools.src_MN_DL},
		{MDR.SourceTools.src_MO_DL},
		{MDR.SourceTools.src_NC_DL},
		// {MDR.SourceTools.src_NE_DL},
		{MDR.SourceTools.src_NM_DL},
		{MDR.SourceTools.src_NV_DL},
		{MDR.SourceTools.src_LA_DL},
		{MDR.SourceTools.src_OH_DL},
		// {MDR.SourceTools.src_OR_DL},
		{MDR.SourceTools.src_TN_DL},
		{MDR.SourceTools.src_TX_DL},
		// {MDR.SourceTools.src_UT_DL},
		{MDR.SourceTools.src_WI_DL},
		{MDR.SourceTools.src_WV_DL},
		{MDR.SourceTools.src_WY_DL},
		{MDR.SourceTools.src_CO_Experian_DL},
		{MDR.SourceTools.src_DE_Experian_DL},
		{MDR.SourceTools.src_ID_Experian_DL},
		{MDR.SourceTools.src_IL_Experian_DL},
		{MDR.SourceTools.src_KY_Experian_DL},
		{MDR.SourceTools.src_LA_Experian_DL},
		{MDR.SourceTools.src_MD_Experian_DL},
		{MDR.SourceTools.src_MS_Experian_DL},
		{MDR.SourceTools.src_ND_Experian_DL},
		{MDR.SourceTools.src_NH_Experian_DL},
		{MDR.SourceTools.src_SC_Experian_DL},
		{MDR.SourceTools.src_WV_Experian_DL},
		// {MDR.SourceTools.src_MN_RESTRICTED_DL},
		{MDR.SourceTools.src_Experian_DL},
		{MDR.SourceTools.src_Dummy_Records},
		{MDR.SourceTools.src_Dummy_Records2},
		{MDR.SourceTools.src_Daily_Utilities},
		{MDR.SourceTools.src_Dunn_Bradstreet},
		{MDR.SourceTools.src_Dunn_Bradstreet_Fein},
		// {MDR.SourceTools.src_Dunndata_Consumer},
		{MDR.SourceTools.src_EBR},
		// {MDR.SourceTools.src_Edgar},
		// {MDR.SourceTools.src_Emdeon},
		{MDR.SourceTools.src_EMerge_Boat},
		{MDR.SourceTools.src_EMerge_CCW},
		{MDR.SourceTools.src_EMerge_CCW_NY},
		{MDR.SourceTools.src_EMerge_Cens},
		{MDR.SourceTools.src_EMerge_Fish},
		{MDR.SourceTools.src_EMerge_Hunt},
		{MDR.SourceTools.src_EMerge_Master},
		// {MDR.SourceTools.src_Employee_Directories},
		{MDR.SourceTools.src_Enclarity},
		{MDR.SourceTools.src_Entiera},
		{MDR.SourceTools.src_Equifax},
		{MDR.SourceTools.src_Equifax_Business_Data},
		{MDR.SourceTools.src_Equifax_Quick},
		{MDR.SourceTools.src_Equifax_Weekly},
		// {MDR.SourceTools.src_Eq_Employer},
		{MDR.SourceTools.src_Experian_CRDB},
		{MDR.SourceTools.src_Experian_Credit_Header},
		{MDR.SourceTools.src_Experian_FEIN_Rest},
		{MDR.SourceTools.src_Experian_FEIN_Unrest},
		{MDR.SourceTools.src_Experian_Phones},
		{MDR.SourceTools.src_Fares_Deeds_from_Asrs},
		{MDR.SourceTools.src_FBNV2_BusReg},
		{MDR.SourceTools.src_FBNV2_CA_Orange_county},
		{MDR.SourceTools.src_FBNV2_CA_Santa_Clara},
		{MDR.SourceTools.src_FBNV2_CA_San_Bernadino},
		{MDR.SourceTools.src_FBNV2_CA_San_Diego},
		{MDR.SourceTools.src_FBNV2_CA_Ventura},
		{MDR.SourceTools.src_FBNV2_Experian_Direct},
		{MDR.SourceTools.src_FBNV2_FL},
		{MDR.SourceTools.src_FBNV2_Hist_Choicepoint},
		{MDR.SourceTools.src_FBNV2_INF},
		{MDR.SourceTools.src_FBNV2_New_York},
		{MDR.SourceTools.src_FBNV2_TX_Dallas},
		{MDR.SourceTools.src_FBNV2_TX_Harris},
		// {MDR.SourceTools.src_FCC_Radio_Licenses},
		// {MDR.SourceTools.src_FCRA_Corrections_record},
		{MDR.SourceTools.src_FDIC},
		// {MDR.SourceTools.src_FDIC_SOD},
		{MDR.SourceTools.src_Federal_Explosives},
		{MDR.SourceTools.src_Federal_Firearms},
		// {MDR.SourceTools.src_FL_FBN},
		{MDR.SourceTools.src_FL_Non_Profit},
		{MDR.SourceTools.src_Foreclosures},
		{MDR.SourceTools.src_Foreclosures_Delinquent},
		{MDR.SourceTools.src_Frandx},
		// {MDR.SourceTools.src_NJ_Gaming_Licenses},
		// {MDR.SourceTools.src_Garnishments},
		// {MDR.SourceTools.src_Gong_Business},
		// {MDR.SourceTools.src_Gong_Government},
		{MDR.SourceTools.src_Gong_History},
		{MDR.SourceTools.src_Gong_Neustar},
		// {MDR.SourceTools.src_Gong_phone_append},
		{MDR.SourceTools.src_GSA},
		// {MDR.SourceTools.src_GSDD},
		// {MDR.SourceTools.src_HMS_PM},
		// {MDR.SourceTools.src_HXMX},
		// {MDR.SourceTools.src_Ibehavior},
		{MDR.SourceTools.src_Impulse},
		// {MDR.SourceTools.src_Infogroup},
		{MDR.SourceTools.src_INFOUSA_ABIUS_USABIZ},
		// {MDR.SourceTools.src_INFOUSA_DEAD_COMPANIES},
		// {MDR.SourceTools.src_INFOUSA_IDEXEC},
		{MDR.SourceTools.src_Infutor_NARB},
		{MDR.SourceTools.src_InfutorCID},
		// {MDR.SourceTools.src_InfutorTRK},
		// {MDR.SourceTools.src_InfutorNarc},
		{MDR.SourceTools.src_InfutorNare},
		// {MDR.SourceTools.src_Ingenix_Sanctions},
		// {MDR.SourceTools.src_Inhouse_QSent},
		{MDR.SourceTools.src_InquiryAcclogs},
		{MDR.SourceTools.src_Insurance_Certification},
		// {MDR.SourceTools.src_Intrado},
		{MDR.SourceTools.src_IRS_5500},
		{MDR.SourceTools.src_IRS_Non_Profit},
		// {MDR.SourceTools.src_Jigsaw},
		// {MDR.SourceTools.src_LaborActions_EBSA},
		// {MDR.SourceTools.src_LaborActions_WHD},
		{MDR.SourceTools.src_Lexis_Trans_Union},
		{MDR.SourceTools.src_Liens},
		// {MDR.SourceTools.src_Liens_and_Judgments},
		{MDR.SourceTools.src_Liens_v2},
		// {MDR.SourceTools.src_Liens_v2_CA_Federal},
		{MDR.SourceTools.src_Liens_v2_Chicago_Law},
		{MDR.SourceTools.src_Liens_v2_Hogan},
		{MDR.SourceTools.src_Liens_v2_ILFDLN},
		{MDR.SourceTools.src_Liens_v2_MA},
		{MDR.SourceTools.src_Liens_v2_NYC},
		{MDR.SourceTools.src_Liens_v2_NYFDLN},
		// {MDR.SourceTools.src_Liens_v2_Service_Abstract},
		// {MDR.SourceTools.src_Liens_v2_Superior_Party},
		// {MDR.SourceTools.src_Link2Tek},
		// {MDR.SourceTools.src_CA_Liquor_Licenses},
		// {MDR.SourceTools.src_CT_Liquor_Licenses},
		// {MDR.SourceTools.src_IN_Liquor_Licenses},
		// {MDR.SourceTools.src_LA_Liquor_Licenses},
		// {MDR.SourceTools.src_OH_Liquor_Licenses},
		// {MDR.SourceTools.src_PA_Liquor_Licenses},
		// {MDR.SourceTools.src_TX_Liquor_Licenses},
		{MDR.SourceTools.src_LnPropV2_Fares_Asrs},
		{MDR.SourceTools.src_LnPropV2_Fares_Deeds},
		{MDR.SourceTools.src_LnPropV2_Lexis_Asrs},
		{MDR.SourceTools.src_LnPropV2_Lexis_Deeds_Mtgs},
		// {MDR.SourceTools.src_Lobbyists},
		{MDR.SourceTools.src_Mari_Prof_Lic},
		// {MDR.SourceTools.src_Mari_Public_Sanc},
		{MDR.SourceTools.src_Marketing_Relatives_Data},
		{MDR.SourceTools.src_Relatives_Data},
		// {MDR.SourceTools.src_Marriage},
		{MDR.SourceTools.src_MartinDale_Hubbell},
		{MDR.SourceTools.src_MediaOne},
		// {MDR.SourceTools.src_Metronet_Gateway},
		// {MDR.SourceTools.src_Miscellaneous},
		{MDR.SourceTools.src_Mixed_DPPA},
		{MDR.SourceTools.src_Mixed_Non_DPPA},
		// {MDR.SourceTools.src_Mixed_Probation},
		{MDR.SourceTools.src_Mixed_Utilities},
		// {MDR.SourceTools.src_MPRD_Individual},
		// {MDR.SourceTools.src_MMCP},
		// {MDR.SourceTools.src_NaturalDisaster_Readiness},
		// {MDR.SourceTools.src_NeustarWireless},
		// {MDR.SourceTools.src_NCOA},
		{MDR.SourceTools.src_NCPDP},
		// {MDR.SourceTools.src_NPPES},
		{MDR.SourceTools.src_OIG},
		// {MDR.SourceTools.src_One_Click_Data},
		{MDR.SourceTools.src_OSHAIR},
		// {MDR.SourceTools.src_OutwardMedia},
		{MDR.SourceTools.src_OKC_Student_List},
		{MDR.SourceTools.src_OKC_Probate},
		// {MDR.SourceTools.src_PBSA},
		// {MDR.SourceTools.src_pcnsr},
		{MDR.SourceTools.src_Phones_Plus},
		// {MDR.SourceTools.src_Phones_Accudata_OCN_LNP},
		// {MDR.SourceTools.src_Phones_Accudata_CNAM_CNM2},
		{MDR.SourceTools.src_Phones_Disconnect},
		// {MDR.SourceTools.src_Phones_Gong_History_Disconnect},
		// {MDR.SourceTools.src_PhonesPorted_TCPA_CL},
		{MDR.SourceTools.src_PhoneFraud_OTP},
		// {MDR.SourceTools.src_Phones_Lerg6},
		{MDR.SourceTools.src_Phones_LIDB},
		// {MDR.SourceTools.src_PhonesPorted_TCPA},
		// {MDR.SourceTools.src_PhonesPorted_iConectiv},
		// {MDR.SourceTools.src_PhonesPorted_iConectiv_Rng},
		// {MDR.SourceTools.src_POS},
		{MDR.SourceTools.src_Professional_License},
		// {MDR.SourceTools.src_PSS},
		// {MDR.SourceTools.src_QSent_Gateway},
		{MDR.SourceTools.src_RealSource},
		{MDR.SourceTools.src_Redbooks},
		{MDR.SourceTools.src_SalesChannel},
		{MDR.SourceTools.src_CA_Sales_Tax},
		{MDR.SourceTools.src_IA_Sales_Tax},
		{MDR.SourceTools.src_SAM_Gov_Debarred},
		{MDR.SourceTools.src_SDA},
		{MDR.SourceTools.src_SDAA},
		// {MDR.SourceTools.src_SEC_Broker_Dealer},
		{MDR.SourceTools.src_sexoffender},
		// {MDR.SourceTools.src_Sheila_Greco},
		// {MDR.SourceTools.src_SKA},
		// {MDR.SourceTools.src_FL_SO},
		// {MDR.SourceTools.src_GA_SO},
		// {MDR.SourceTools.src_MI_SO},
		// {MDR.SourceTools.src_PA_SO},
		// {MDR.SourceTools.src_UT_SO},
		// {MDR.SourceTools.src_Spoke},
		// {MDR.SourceTools.src_Targus_Gateway},
		{MDR.SourceTools.src_Targus_White_pages},
		// {MDR.SourceTools.src_Tax_practitioner},
		// {MDR.SourceTools.src_TCOA_After_Address},
		// {MDR.SourceTools.src_TCOA_Before_Address},
		// {MDR.SourceTools.src_Teletrack},
		{MDR.SourceTools.src_Thrive_LT},
		// {MDR.SourceTools.src_Thrive_LT_POE_Email},
		{MDR.SourceTools.src_Thrive_PD},
		// {MDR.SourceTools.src_Thrive_PD_POE_Email},
		{MDR.SourceTools.src_TransUnion},
		{MDR.SourceTools.src_TUCS_Ptrack},
		{MDR.SourceTools.src_TU_CreditHeader},
		{MDR.SourceTools.src_TXBUS},
		// {MDR.SourceTools.src_UCC},
		{MDR.SourceTools.src_UCCV2},
		// {MDR.SourceTools.src_UCCV2_WA_Hist},
		{MDR.SourceTools.src_US_Coastguard},
		{MDR.SourceTools.src_Utilities},
		{MDR.SourceTools.src_Util_Work_Phone},
		{MDR.SourceTools.src_ZUtilities},
		{MDR.SourceTools.src_ZUtil_Work_Phone},
		// {MDR.SourceTools.src_Daily_ZUtilities},
		{MDR.SourceTools.src_FL_Veh},
		{MDR.SourceTools.src_ID_Veh},
		{MDR.SourceTools.src_KY_Veh},
		// {MDR.SourceTools.src_MA_Veh},
		{MDR.SourceTools.src_ME_Veh},
		{MDR.SourceTools.src_MN_Veh},
		{MDR.SourceTools.src_MO_Veh},
		{MDR.SourceTools.src_MS_Veh},
		{MDR.SourceTools.src_MT_Veh},
		{MDR.SourceTools.src_NC_Veh},
		{MDR.SourceTools.src_ND_Veh},
		{MDR.SourceTools.src_NE_Veh},
		{MDR.SourceTools.src_NM_Veh},
		{MDR.SourceTools.src_NV_Veh},
		{MDR.SourceTools.src_OH_Veh},
		{MDR.SourceTools.src_TX_Veh},
		// {MDR.SourceTools.src_UT_Veh},
		{MDR.SourceTools.src_WI_Veh},
		{MDR.SourceTools.src_WY_Veh},
		{MDR.SourceTools.src_AK_Experian_Veh},
		{MDR.SourceTools.src_AL_Experian_Veh},
		{MDR.SourceTools.src_AR_Experian_Veh},
		{MDR.SourceTools.src_AZ_Experian_Veh},
		{MDR.SourceTools.src_CO_Experian_Veh},
		{MDR.SourceTools.src_CT_Experian_Veh},
		{MDR.SourceTools.src_DC_Experian_Veh},
		{MDR.SourceTools.src_DE_Experian_Veh},
		{MDR.SourceTools.src_FL_Experian_Veh},
		{MDR.SourceTools.src_GA_Experian_Veh},
		{MDR.SourceTools.src_IA_Experian_Veh},
		{MDR.SourceTools.src_ID_Experian_Veh},
		{MDR.SourceTools.src_IL_Experian_Veh},
		{MDR.SourceTools.src_KS_Experian_Veh},
		{MDR.SourceTools.src_KY_Experian_Veh},
		{MDR.SourceTools.src_LA_Experian_Veh},
		{MDR.SourceTools.src_MA_Experian_Veh},
		{MDR.SourceTools.src_MD_Experian_Veh},
		{MDR.SourceTools.src_ME_Experian_Veh},
		{MDR.SourceTools.src_MI_Experian_Veh},
		{MDR.SourceTools.src_MN_Experian_Veh},
		{MDR.SourceTools.src_MO_Experian_Veh},
		{MDR.SourceTools.src_MS_Experian_Veh},
		{MDR.SourceTools.src_MT_Experian_Veh},
		{MDR.SourceTools.src_NC_Experian_Veh},
		{MDR.SourceTools.src_ND_Experian_Veh},
		{MDR.SourceTools.src_NE_Experian_Veh},
		{MDR.SourceTools.src_NM_Experian_Veh},
		{MDR.SourceTools.src_NV_Experian_Veh},
		{MDR.SourceTools.src_NY_Experian_Veh},
		{MDR.SourceTools.src_OH_Experian_Veh},
		{MDR.SourceTools.src_OK_Experian_Veh},
		// {MDR.SourceTools.src_OR_Experian_Veh},
		{MDR.SourceTools.src_RI_Experian_Veh},
		{MDR.SourceTools.src_SC_Experian_Veh},
		{MDR.SourceTools.src_SD_Experian_Veh},
		{MDR.SourceTools.src_TN_Experian_Veh},
		{MDR.SourceTools.src_TX_Experian_Veh},
		{MDR.SourceTools.src_UT_Experian_Veh},
		{MDR.SourceTools.src_VT_Experian_Veh},
		{MDR.SourceTools.src_WA_Experian_Veh},
		{MDR.SourceTools.src_WI_Experian_Veh},
		{MDR.SourceTools.src_WY_Experian_Veh},
		{MDR.SourceTools.src_Infutor_Veh},
		{MDR.SourceTools.src_Infutor_Motorcycle_Veh},
		// {MDR.SourceTools.src_Vickers},
		{MDR.SourceTools.src_Voters_v2},
		{MDR.SourceTools.src_AK_Watercraft},
		{MDR.SourceTools.src_AL_Watercraft},
		{MDR.SourceTools.src_AR_Watercraft},
		{MDR.SourceTools.src_AZ_Watercraft},
		{MDR.SourceTools.src_CO_Watercraft},
		{MDR.SourceTools.src_CT_Watercraft},
		{MDR.SourceTools.src_FL_Watercraft},
		{MDR.SourceTools.src_GA_Watercraft},
		{MDR.SourceTools.src_IA_Watercraft},
		{MDR.SourceTools.src_IL_Watercraft},
		{MDR.SourceTools.src_KS_Watercraft},
		{MDR.SourceTools.src_KY_Watercraft},
		{MDR.SourceTools.src_MA_Watercraft},
		{MDR.SourceTools.src_MD_Watercraft},
		{MDR.SourceTools.src_ME_Watercraft},
		{MDR.SourceTools.src_MI_Watercraft},
		{MDR.SourceTools.src_MN_Watercraft},
		{MDR.SourceTools.src_MO_Watercraft},
		{MDR.SourceTools.src_MS_Watercraft},
		{MDR.SourceTools.src_MT_Watercraft},
		{MDR.SourceTools.src_NC_Watercraft},
		{MDR.SourceTools.src_ND_Watercraft},
		{MDR.SourceTools.src_NE_Watercraft},
		{MDR.SourceTools.src_NH_Watercraft},
		{MDR.SourceTools.src_NM_Watercraft},
		{MDR.SourceTools.src_NV_Watercraft},
		{MDR.SourceTools.src_NY_Watercraft},
		{MDR.SourceTools.src_OH_Watercraft},
		{MDR.SourceTools.src_OR_Watercraft},
		{MDR.SourceTools.src_SC_Watercraft},
		{MDR.SourceTools.src_TN_Watercraft},
		{MDR.SourceTools.src_TX_Watercraft},
		{MDR.SourceTools.src_UT_Watercraft},
		{MDR.SourceTools.src_VA_Watercraft},
		{MDR.SourceTools.src_WI_Watercraft},
		{MDR.SourceTools.src_WV_Watercraft},
		{MDR.SourceTools.src_WY_Watercraft},
		{MDR.SourceTools.src_WA_Watercraft},
		// {MDR.SourceTools.src_FL_Watercraft_LN},
		// {MDR.SourceTools.src_KY_Watercraft_LN},
		// {MDR.SourceTools.src_MO_Watercraft_LN},
		{MDR.SourceTools.src_Infutor_Watercraft},
		// {MDR.SourceTools.src_Whois_domains},
		{MDR.SourceTools.src_Wired_Assets_Email},
		// {MDR.SourceTools.src_Wired_Assets_Owned},
		// {MDR.SourceTools.src_Wired_Assets_Royalty},
		// {MDR.SourceTools.src_Wither_and_Die},
		{MDR.SourceTools.src_Workers_Compensation},
		{MDR.SourceTools.src_MS_Worker_Comp},
		// {MDR.SourceTools.src_OR_Worker_Comp},
		{MDR.SourceTools.src_Yellow_Pages},
		// {MDR.SourceTools.src_Zumigo_GetLineId},
		// {MDR.SourceTools.src_ZOOM},
		{MDR.SourceTools.src_BKFS_Nod},
		{MDR.SourceTools.src_BKFS_Reo},
		{MDR.SourceTools.WH_src},
		{CCW_Source_MAS},
		{Hunt_Fish_Source_MAS},
		{CityStateZip},
		{AVM},
		{CFBPSurname},
		{CFBPGeolinks},
		{Hotlist},
		{HouseHoldKeys},
		{FraudPoint3Source},
		{DoNotMail},
		{HighRiskIndustries},
		{Watchdog_NonEN_FCRA},
		{Watchdog_NonEQ_FCRA},
		{PersonContext},
		{VehicleDI},
		{CorrelationRiskGong},
		{src_Dunn_Data_Email},
		{src_MA_Census},
		{ADL}
	], Layout_Allowed_Sources);
	
	EXPORT DEFAULT_ALLOWED_SOURCES_NONFCRA := DATASET([
		{MDR.SourceTools.src_MD_Experian_DL},
		//{MDR.SourceTools.src_Phones_LIDB},
		{MDR.SourceTools.src_OIG},
		{MDR.SourceTools.src_OR_Watercraft},
		{MDR.SourceTools.src_FBNV2_BusReg},
		{MDR.SourceTools.src_Death_Tributes},
		{MDR.SourceTools.src_Cortera},
		{MDR.SourceTools.src_Best_Person},
		{MDR.SourceTools.src_NY_Corporations},
		{MDR.SourceTools.src_Dunn_Bradstreet_Fein},
		{MDR.SourceTools.src_BKFS_Reo},
		{MDR.SourceTools.src_TU_CreditHeader},
		{VehicleDI},
		{MDR.SourceTools.src_FBNV2_CA_San_Diego},
		{MDR.SourceTools.src_MI_Experian_Veh},
		{MDR.SourceTools.src_MS_Worker_Comp},
		{MDR.SourceTools.src_MN_Corporations},
		{MDR.SourceTools.src_Death_State},
		{MDR.SourceTools.src_LA_Experian_DL},
		{MDR.SourceTools.src_Death_FL},
		{MDR.SourceTools.src_WV_Watercraft},
		{MDR.SourceTools.src_Gong_History},
		{MDR.SourceTools.src_Liens_v2_NYC},
		{MDR.SourceTools.src_OH_Watercraft},
		{MDR.SourceTools.src_Foreclosures},
		{MDR.SourceTools.src_Frandx},
		{MDR.SourceTools.src_WY_Watercraft},
		{MDR.SourceTools.src_CT_Corporations},
		{MDR.SourceTools.src_TX_Corporations},
		{MDR.SourceTools.src_InfutorNare},
		{MDR.SourceTools.src_Cortera_Tradeline},
		{MDR.SourceTools.src_FL_Corporations},
		{MDR.SourceTools.src_NC_Watercraft},
		{MDR.SourceTools.src_KY_Experian_DL},
		{FraudPoint3Source},
		{MDR.SourceTools.src_AR_Corporations},
		{MDR.SourceTools.src_SD_Experian_Veh},
		{MDR.SourceTools.src_MI_DL},
		{MDR.SourceTools.src_NC_Corporations},
		{MDR.SourceTools.src_BBB_Non_Member},
		{MDR.SourceTools.src_Credit_Unions},
		{MDR.SourceTools.src_Professional_License},
		{MDR.SourceTools.src_Acquiredweb_plus},
		{MDR.SourceTools.src_NH_Corporations},
		{MDR.SourceTools.src_PA_Corporations},
		{MDR.SourceTools.src_Voters_v2},
		{MDR.SourceTools.src_EMerge_CCW},
		{MDR.SourceTools.src_Infutor_NARB},
		{MDR.SourceTools.src_VA_Corporations},
		{MDR.SourceTools.src_WY_Corporations},
		{MDR.SourceTools.src_Impulse},
		{MDR.SourceTools.src_DEA},
		{MDR.SourceTools.src_Experian_Credit_Header},
		{MDR.SourceTools.src_American_Students_List},
		{MDR.SourceTools.src_Liens_v2_Hogan},
		{MDR.SourceTools.src_Accurint_DOC},
		{MDR.SourceTools.src_ND_Veh},
		{MDR.SourceTools.src_ID_Experian_DL},
		{MDR.SourceTools.src_FL_Experian_Veh},
		{MDR.SourceTools.src_Thrive_PD},
		{MDR.SourceTools.src_Accurint_Arrest_Log},
		{MDR.SourceTools.src_OR_Corporations},
		{MDR.SourceTools.src_AK_Experian_Veh},
		{MDR.SourceTools.src_InfutorCID},
		{MDR.SourceTools.src_AL_Experian_Veh},
		{MDR.SourceTools.src_LnPropV2_Fares_Asrs},
		{CFBPGeolinks},
		{MDR.SourceTools.src_TN_Experian_Veh},
		{MDR.SourceTools.src_SDA},
		{MDR.SourceTools.src_ID_DL},
		{MDR.SourceTools.src_MartinDale_Hubbell},
		{MDR.SourceTools.src_MediaOne},
		{MDR.SourceTools.src_FBNV2_INF},
		{MDR.SourceTools.src_OKC_Student_List},
		{MDR.SourceTools.src_FBNV2_CA_Santa_Clara},
		{MDR.SourceTools.src_Liens_v2_Chicago_Law},
		{MDR.SourceTools.src_NV_DL},
		{MDR.SourceTools.src_FBNV2_TX_Harris},
		{MDR.SourceTools.src_Liens_v2},
		{MDR.SourceTools.src_DE_Experian_Veh},
		{MDR.SourceTools.src_TransUnion},
		{MDR.SourceTools.src_VA_Watercraft},
		{MDR.SourceTools.src_Business_Registration},
		{MDR.SourceTools.src_AZ_Corporations},
		{MDR.SourceTools.src_WY_DL},
		{MDR.SourceTools.src_WA_Corporations},
		{MDR.SourceTools.src_NE_Veh},
		{CorrelationRiskGong},
		{MDR.SourceTools.src_TN_DL},
		{MDR.SourceTools.src_NC_Veh},
		{MDR.SourceTools.src_Death_Obituary},
		{MDR.SourceTools.src_KY_Watercraft},
		{MDR.SourceTools.src_Death_VA},
		{MDR.SourceTools.src_Liens_v2_MA},
		{MDR.SourceTools.src_FBNV2_New_York},
		{MDR.SourceTools.src_Phones_Plus},
		{MDR.SourceTools.src_Death_MI},
		{MDR.SourceTools.src_MT_Veh},
		{MDR.SourceTools.src_Mixed_DPPA},
		{MDR.SourceTools.src_Liens_v2_NYFDLN},
		{MDR.SourceTools.src_ND_Corporations},
		{MDR.SourceTools.src_Death_OH},
		{MDR.SourceTools.src_BBB_Member},
		{MDR.SourceTools.src_Experian_Phones},
		{MDR.SourceTools.src_KS_Watercraft},
		{MDR.SourceTools.src_MD_Experian_Veh},
		{MDR.SourceTools.src_UT_Experian_Veh},
		{MDR.SourceTools.src_Infutor_Veh},
		{MDR.SourceTools.src_ZUtil_Work_Phone},
		{MDR.SourceTools.src_NY_Watercraft},
		{MDR.SourceTools.src_DC_Experian_Veh},
		{MDR.SourceTools.src_ME_DL},
		{MDR.SourceTools.src_Datagence},
		{MDR.SourceTools.src_OH_Veh},
		{MDR.SourceTools.src_Wired_Assets_Email},
		{MDR.SourceTools.src_TN_Corporations},
		{MDR.SourceTools.src_CT_Watercraft},
		{AVM},
		{MDR.SourceTools.src_EMerge_Master},
		{MDR.SourceTools.src_IA_Experian_Veh},
		{MDR.SourceTools.src_ME_Watercraft},
		{Hotlist},
		{MDR.SourceTools.src_ME_Corporations},
		{MDR.SourceTools.src_MD_Watercraft},
		{MDR.SourceTools.src_WV_Experian_DL},
		{MDR.SourceTools.src_Accurint_Crim_Court},
		{MDR.SourceTools.src_FL_DL},
		{MDR.SourceTools.src_MN_DL},
		{MDR.SourceTools.src_SalesChannel},
		{MDR.SourceTools.src_advo_valassis},
		{MDR.SourceTools.src_CA_Corporations},
		{MDR.SourceTools.src_KY_DL},
		{MDR.SourceTools.src_MS_Veh},
		{MDR.SourceTools.src_VT_Experian_Veh},
		{HouseHoldKeys},
		{MDR.SourceTools.src_ME_Experian_Veh},
		{MDR.SourceTools.src_Dummy_Records2},
		{MDR.SourceTools.src_RealSource},
		{MDR.SourceTools.src_MN_Experian_Veh},
		{MDR.SourceTools.src_IN_Corporations},
		{MDR.SourceTools.src_IA_Corporations},
		{MDR.SourceTools.src_AK_Watercraft},
		{MDR.SourceTools.src_InquiryAcclogs},
		{MDR.SourceTools.src_MO_Corporations},
		{MDR.SourceTools.src_AK_Corporations},
		{MDR.SourceTools.src_OK_Corporations},
		{CCW_Source_MAS},
		{MDR.SourceTools.src_FBNV2_CA_Orange_county},
		{MDR.SourceTools.src_Gong_Neustar},
		{MDR.SourceTools.src_AL_Watercraft},
		{MDR.SourceTools.src_DataBridge},
		{MDR.SourceTools.src_OH_Experian_Veh},
		{MDR.SourceTools.src_NY_Experian_Veh},
		{MDR.SourceTools.src_Experian_FEIN_Unrest},
		{MDR.SourceTools.src_Liens},
		{MDR.SourceTools.src_OKC_Probate},
		{MDR.SourceTools.src_AK_Perm_Fund},
		{MDR.SourceTools.src_NV_Corporations},
		{MDR.SourceTools.src_Fares_Deeds_from_Asrs},
		{MDR.SourceTools.src_Insurance_Certification},
		{MDR.SourceTools.src_KY_Experian_Veh},
		{MDR.SourceTools.src_EMerge_Cens},
		{MDR.SourceTools.src_Yellow_Pages},
		{MDR.SourceTools.src_DC_Corporations},
		{MDR.SourceTools.src_UT_Corporations},
		{MDR.SourceTools.src_WI_Experian_Veh},
		{MDR.SourceTools.src_Equifax},
		{MDR.SourceTools.src_Foreclosures_Delinquent},
		{MDR.SourceTools.src_TX_Veh},
		{MDR.SourceTools.src_NE_Experian_Veh},
		{MDR.SourceTools.src_Experian_DL},
		{MDR.SourceTools.src_OH_Corporations},
		{MDR.SourceTools.src_AZ_Experian_Veh},
		{MDR.SourceTools.src_EMerge_Fish},
		{MDR.SourceTools.src_Liens_v2_ILFDLN},
		{MDR.SourceTools.src_FBNV2_FL},
		{MDR.SourceTools.src_MD_Corporations},
		{MDR.SourceTools.src_IL_Experian_DL},
		{src_Dunn_Data_Email},
		{MDR.SourceTools.src_KY_Veh},
		{MDR.SourceTools.src_IL_Watercraft},
		{MDR.SourceTools.src_SDAA},
		{MDR.SourceTools.src_AlloyMedia_student_list},
		{MDR.SourceTools.src_INFOUSA_ABIUS_USABIZ},
		{MDR.SourceTools.src_WI_Corporations},
		{MDR.SourceTools.src_AK_Fishing_boats},
		{MDR.SourceTools.src_MN_Watercraft},
		{MDR.SourceTools.src_Consumer_Disclosure_feed},
		{MDR.SourceTools.src_AlloyMedia_consumer},
		{MDR.SourceTools.src_FL_Non_Profit},
		{MDR.SourceTools.src_IA_Watercraft},
		{MDR.SourceTools.src_MN_Veh},
		{MDR.SourceTools.src_Mari_Prof_Lic},
		{MDR.SourceTools.src_GA_Watercraft},
		{Hunt_Fish_Source_MAS},
		{MDR.SourceTools.src_WV_DL},
		{MDR.SourceTools.src_WI_Watercraft},
		{MDR.SourceTools.src_Death_MT},
		{MDR.SourceTools.src_AR_Watercraft},
		{MDR.SourceTools.src_Targus_White_pages},
		{MDR.SourceTools.src_Death_CA},
		{MDR.SourceTools.src_Experian_CRDB},
		{MDR.SourceTools.src_Infutor_Watercraft},
		{MDR.SourceTools.src_IRS_5500},
		{MDR.SourceTools.src_Equifax_Quick},
		{MDR.SourceTools.src_MO_Veh},
		{MDR.SourceTools.src_ZUtilities},
		{MDR.SourceTools.src_TX_Watercraft},
		{MDR.SourceTools.src_NM_Corporations},
		{MDR.SourceTools.src_EBR},
		{MDR.SourceTools.src_HI_Corporations},
		{MDR.SourceTools.src_RI_Experian_Veh},
		{MDR.SourceTools.src_FBNV2_Experian_Direct},
		{MDR.SourceTools.src_NH_Experian_DL},
		{MDR.SourceTools.src_MA_Corporations},
		{MDR.SourceTools.src_Dunn_Bradstreet},
		{MDR.SourceTools.src_CO_Experian_Veh},
		{MDR.SourceTools.src_Workers_Compensation},
		{MDR.SourceTools.src_Daily_Utilities},
		{MDR.SourceTools.src_EMerge_Boat},
		{MDR.SourceTools.src_KS_Experian_Veh},
		{MDR.SourceTools.src_Lexis_Trans_Union},
		{MDR.SourceTools.src_DE_Experian_DL},
		{MDR.SourceTools.src_EMerge_Hunt},
		{MDR.SourceTools.src_Accidents_ECrash},
		{MDR.SourceTools.src_CT_Experian_Veh},
		{MDR.SourceTools.src_LnPropV2_Lexis_Deeds_Mtgs},
		{MDR.SourceTools.src_Util_Work_Phone},
		{MDR.SourceTools.src_CO_Experian_DL},
		{MDR.SourceTools.src_Mixed_Utilities},
		{MDR.SourceTools.src_OSHAIR},
		{src_MA_Census},
		{MDR.SourceTools.src_Death_Master},
		{MDR.SourceTools.src_FL_Watercraft},
		{MDR.SourceTools.src_GA_Corporations},
		{MDR.SourceTools.src_OK_Experian_Veh},
		{MDR.SourceTools.src_TX_DL},
		{MDR.SourceTools.src_SC_Experian_DL},
		{MDR.SourceTools.src_IA_Sales_Tax},
		{MDR.SourceTools.src_Equifax_Business_Data},
		{MDR.SourceTools.src_Enclarity},
		{MDR.SourceTools.src_Mixed_Non_DPPA},
		{MDR.SourceTools.src_Aircrafts},
		{MDR.SourceTools.src_AZ_Watercraft},
		{MDR.SourceTools.src_FBNV2_CA_San_Bernadino},
		{MDR.SourceTools.src_TXBUS},
		{MDR.SourceTools.src_TUCS_Ptrack},
		{MDR.SourceTools.src_WA_Experian_Veh},
		{MDR.SourceTools.src_NJ_Corporations},
		{MDR.SourceTools.src_FBNV2_TX_Dallas},
		{MDR.SourceTools.src_Anchor},
		{MDR.SourceTools.src_AL_Corporations},
		{MDR.SourceTools.src_ID_Veh},
		{MDR.SourceTools.src_WY_Veh},
		{MDR.SourceTools.src_RI_Corporations},
		{MDR.SourceTools.src_VT_Corporations},
		{MDR.SourceTools.src_TX_Experian_Veh},
		{MDR.SourceTools.src_Calbus},
		{CFBPSurname},
		{MDR.SourceTools.src_IL_Corporations},
		{MDR.SourceTools.src_WA_Watercraft},
		{MDR.SourceTools.src_AR_Experian_Veh},
		{MDR.SourceTools.src_EMerge_CCW_NY},
		{MDR.SourceTools.src_ND_Experian_DL},
		{MDR.SourceTools.src_Death_GA},
		{MDR.SourceTools.src_MO_DL},
		{MDR.SourceTools.src_MS_Corporations},
		{MDR.SourceTools.src_CO_Watercraft},
		{MDR.SourceTools.src_NH_Watercraft},
		{MDR.SourceTools.src_KY_Corporations},
		{MDR.SourceTools.src_NV_Veh},
		{MDR.SourceTools.src_NCPDP},
		{MDR.SourceTools.src_SC_Corporations},
		{MDR.SourceTools.src_MA_Experian_Veh},
		{MDR.SourceTools.src_NC_DL},
		{MDR.SourceTools.src_NV_Watercraft},
		{MDR.SourceTools.src_SD_Corporations},
		{MDR.SourceTools.src_MS_Watercraft},
		{MDR.SourceTools.src_MA_DL},
		{MDR.SourceTools.src_NM_Watercraft},
		{MDR.SourceTools.src_MI_Watercraft},
		{MDR.SourceTools.src_Relatives_Data},
		{HighRiskIndustries},
		{MDR.SourceTools.src_LA_Corporations},
		{MDR.SourceTools.src_Redbooks},
		{MDR.SourceTools.src_Airmen},
		{MDR.SourceTools.src_MT_Corporations},
		{MDR.SourceTools.src_ND_Experian_Veh},
		{MDR.SourceTools.src_Marketing_Relatives_Data},
		{MDR.SourceTools.src_NE_Corporations},
		{MDR.SourceTools.src_LnPropV2_Lexis_Asrs},
		{MDR.SourceTools.src_MI_Corporations},
		{MDR.SourceTools.src_ACF},
		{MDR.SourceTools.src_Diversity_Cert},
		{MDR.SourceTools.src_LnPropV2_Fares_Deeds},
		{MDR.SourceTools.src_NM_Veh},
		{MDR.SourceTools.src_ME_Veh},
		{MDR.SourceTools.src_IRS_Non_Profit},
		{MDR.SourceTools.src_OH_DL},
		{MDR.SourceTools.src_Certegy},
		{MDR.SourceTools.src_Federal_Firearms},
		{MDR.SourceTools.src_FBNV2_CA_Ventura},
		{MDR.SourceTools.src_ND_Watercraft},
		{MDR.SourceTools.src_ID_Corporations},
		{MDR.SourceTools.src_MO_Watercraft},
		{MDR.SourceTools.src_Equifax_Weekly},
		{MDR.SourceTools.src_WY_Experian_Veh},
		{MDR.SourceTools.src_NM_Experian_Veh},
		{MDR.SourceTools.src_Utilities},
		{MDR.SourceTools.src_US_Coastguard},
		{MDR.SourceTools.src_SC_Watercraft},
		{MDR.SourceTools.src_LA_DL},
		{MDR.SourceTools.src_Thrive_LT},
		{MDR.SourceTools.src_WI_DL},
		{MDR.SourceTools.src_MS_Experian_DL},
		{MDR.SourceTools.src_UT_Watercraft},
		{MDR.SourceTools.src_Acquiredweb},
		{MDR.SourceTools.src_Death_Restricted},
		{MDR.SourceTools.src_Bankruptcy},
		{MDR.SourceTools.src_Federal_Explosives},
		{MDR.SourceTools.src_TN_Watercraft},
		{MDR.SourceTools.src_WI_Veh},
		{MDR.SourceTools.src_MO_Experian_Veh},
		{DoNotMail},
		{MDR.SourceTools.src_MA_Watercraft},
		{MDR.SourceTools.src_MS_Experian_Veh},
		{MDR.SourceTools.src_NE_Watercraft},
		{MDR.SourceTools.src_NM_DL},
		{MDR.SourceTools.src_GSA},
		{MDR.SourceTools.src_ID_Experian_Veh},
		{MDR.SourceTools.src_MT_Watercraft},
		{MDR.SourceTools.src_Experian_FEIN_Rest},
		{MDR.SourceTools.src_NV_Experian_Veh},
		{CityStateZip},
		{MDR.SourceTools.src_CT_DL},
		{MDR.SourceTools.src_NC_Experian_Veh},
		{MDR.SourceTools.src_DCA},
		{MDR.SourceTools.src_CA_Sales_Tax},
		{MDR.SourceTools.src_IL_Experian_Veh},
		{MDR.SourceTools.src_BKFS_Nod},
		{MDR.SourceTools.src_Death_NV},
		{MDR.SourceTools.src_Infutor_Motorcycle_Veh},
		{MDR.SourceTools.src_CO_Corporations},
		{MDR.SourceTools.src_SC_Experian_Veh},
		{MDR.SourceTools.src_WV_Corporations},
		{MDR.SourceTools.src_Entiera},
		{MDR.SourceTools.src_FDIC},
		{MDR.SourceTools.src_MT_Experian_Veh},
		{MDR.SourceTools.src_KS_Corporations},
		{MDR.SourceTools.src_SAM_Gov_Debarred},
		{MDR.SourceTools.src_FBNV2_Hist_Choicepoint},
		{MDR.SourceTools.src_LA_Experian_Veh},
		{MDR.SourceTools.src_UCCV2},
		{MDR.SourceTools.src_Best_Business},
		{MDR.SourceTools.src_FL_Veh},
		{MDR.SourceTools.src_OKC_Students_List},
		{MDR.SourceTools.src_GA_Experian_Veh},	
		{ADL}
	], Layout_Allowed_Sources);
	
	EXPORT DEFAULT_ALLOWED_SOURCES_FCRA := DATASET([
		{MDR.SourceTools.src_OR_Watercraft},
		{MDR.SourceTools.src_MS_Worker_Comp},
		{MDR.SourceTools.src_Death_State},
		{MDR.SourceTools.src_WV_Watercraft},
		{MDR.SourceTools.src_Gong_History},
		{MDR.SourceTools.src_OH_Watercraft},
		{MDR.SourceTools.src_WY_Watercraft},
		{MDR.SourceTools.src_NC_Watercraft},
		{MDR.SourceTools.src_Professional_License},
		{MDR.SourceTools.src_Voters_v2},
		{MDR.SourceTools.src_EMerge_CCW},
		{MDR.SourceTools.src_DEA},
		{MDR.SourceTools.src_Experian_Credit_Header},
		{MDR.SourceTools.src_American_Students_List},
		{MDR.SourceTools.src_Accurint_DOC},
		{MDR.SourceTools.src_Thrive_PD},
		{MDR.SourceTools.src_Accurint_Arrest_Log},
		{MDR.SourceTools.src_InfutorCID},
		{CFBPGeolinks},
		{MDR.SourceTools.src_MediaOne},
		{MDR.SourceTools.src_Liens_v2},
		{MDR.SourceTools.src_Liens_v2_MA},
		{MDR.SourceTools.src_Liens_v2_Hogan},
		{MDR.SourceTools.src_Liens_v2_Chicago_Law},
		{MDR.SourceTools.src_Liens_v2_ILFDLN},
		{MDR.SourceTools.src_Liens_v2_NYC},
		{MDR.SourceTools.src_Liens_v2_NYFDLN}, 
		{MDR.SourceTools.src_VA_Watercraft},
		{MDR.SourceTools.src_KY_Watercraft},
		{MDR.SourceTools.src_KS_Watercraft},
		{MDR.SourceTools.src_NY_Watercraft},
		{MDR.SourceTools.src_CT_Watercraft},
		{AVM},
		{MDR.SourceTools.src_EMerge_Master},
		{MDR.SourceTools.src_ME_Watercraft},
		{MDR.SourceTools.src_MD_Watercraft},
		{MDR.SourceTools.src_Accurint_Crim_Court},
		{MDR.SourceTools.src_SalesChannel},
		{MDR.SourceTools.src_advo_valassis},
		{MDR.SourceTools.src_AK_Watercraft},
		{MDR.SourceTools.src_InquiryAcclogs},
		{MDR.SourceTools.src_Gong_Neustar},
		{MDR.SourceTools.src_AL_Watercraft},
		{MDR.SourceTools.src_EMerge_Cens},
		{MDR.SourceTools.src_Equifax},
		{MDR.SourceTools.src_EMerge_Fish},
		{Watchdog_NonEQ_FCRA},
		{MDR.SourceTools.src_IL_Watercraft},
		{MDR.SourceTools.src_AlloyMedia_student_list},
		{MDR.SourceTools.src_AK_Fishing_boats},
		{MDR.SourceTools.src_MN_Watercraft},
		{MDR.SourceTools.src_AlloyMedia_consumer},
		{MDR.SourceTools.src_IA_Watercraft},
		{MDR.SourceTools.src_Mari_Prof_Lic},
		{MDR.SourceTools.src_GA_Watercraft},
		{MDR.SourceTools.src_WI_Watercraft},
		{MDR.SourceTools.src_AR_Watercraft},
		{MDR.SourceTools.src_Targus_White_pages},
		{MDR.SourceTools.src_Equifax_Quick},
		{MDR.SourceTools.src_TX_Watercraft},
		{MDR.SourceTools.src_EMerge_Boat},
		{MDR.SourceTools.src_EMerge_Hunt},
		{MDR.SourceTools.src_LnPropV2_Lexis_Deeds_Mtgs},
		{src_MA_Census},
		{MDR.SourceTools.src_Death_Master},
		{MDR.SourceTools.src_FL_Watercraft},
		{MDR.SourceTools.src_Aircrafts},
		{MDR.SourceTools.src_AZ_Watercraft},
		{CFBPSurname},
		{MDR.SourceTools.src_WA_Watercraft},
		{MDR.SourceTools.src_CO_Watercraft},
		{MDR.SourceTools.src_NH_Watercraft},
		{MDR.SourceTools.src_NV_Watercraft},
		{MDR.SourceTools.src_MS_Watercraft},
		{MDR.SourceTools.src_NM_Watercraft},
		{MDR.SourceTools.src_MI_Watercraft},
		{MDR.SourceTools.src_Airmen},
		{MDR.SourceTools.src_LnPropV2_Lexis_Asrs},
		{MDR.SourceTools.src_Federal_Firearms},
		{MDR.SourceTools.src_ND_Watercraft},
		{MDR.SourceTools.src_MO_Watercraft},
		{MDR.SourceTools.src_Equifax_Weekly},
		{MDR.SourceTools.src_US_Coastguard},
		{MDR.SourceTools.src_SC_Watercraft},
		{MDR.SourceTools.src_Thrive_LT},
		{MDR.SourceTools.src_UT_Watercraft},
		{MDR.SourceTools.src_Acquiredweb},
		{MDR.SourceTools.src_Death_Restricted},
		{MDR.SourceTools.src_Bankruptcy},
		{MDR.SourceTools.src_Federal_Explosives},
		{MDR.SourceTools.src_TN_Watercraft},
		{MDR.SourceTools.src_MA_Watercraft},
		{MDR.SourceTools.src_NE_Watercraft},
		{MDR.SourceTools.src_MT_Watercraft},
		{Watchdog_NonEN_FCRA},
		{MDR.SourceTools.src_Entiera},
		{CityStateZip},
		{PersonContext},
		{MDR.SourceTools.src_sexoffender}
	], Layout_Allowed_Sources);
END;
