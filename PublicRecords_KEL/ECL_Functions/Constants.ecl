IMPORT Business_Risk_BIP, MDR, STD, BIPV2, Header;

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
  
	EXPORT INTEGER DEFAULT_JOIN_LIMIT := 10000;
	EXPORT INTEGER DEFAULT_JOIN_LIMIT_SLIM := 2000;
	EXPORT INTEGER BUSINESS_HEADER_LIMIT := 25000;
	EXPORT INTEGER BUSINESS_HEADER_CONTACT_LIMIT := 20000;
	EXPORT INTEGER CORTERA_TRADELINE_LIMIT := 25000;
	EXPORT INTEGER UCC_JOIN_LIMIT := 1000;
	EXPORT INTEGER PROPERTY_DID_JOIN_LIMIT := 2000;
	EXPORT INTEGER PROPERTY_ADDRESS_JOIN_LIMIT := 7500;
	EXPORT INTEGER VEHICLE_JOIN_LIMIT := 5000;
	EXPORT INTEGER REL_HHID_Join_LIMIT := 100;
	EXPORT INTEGER Limit_Inquiries := 1000;
	EXPORT INTEGER Limit_Inquiries_Kfetch := 5000;

	EXPORT INTEGER PROPERTY_JOIN_LIMIT := 10;
	EXPORT INTEGER PROPERTY_SEARCH_FID_JOIN_LIMIT := 50;
		
	// This is the set of explicitly Allowed Sources for use within the Analytic Library.  If a record doesn't belong to one of these sources, it will be blocked from usage
	// TODO: KS-1968 - Define the set of ALLOWED_SOURCES.
	EXPORT SET OF STRING2 ALLOWED_SOURCES := [];
	
	//These were made up by MAS
	EXPORT CCW_Source_MAS :=	'CCW';//conceal carry
	EXPORT Hunt_Fish_Source_MAS :=	'HFL'; //hunthing fishing license
	EXPORT CityStateZip :=	'CSZ';
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

END;
