IMPORT AutoKeyI, BIPV2, Business_Risk_BIP, Gateway, iesp, MDR, Risk_Indicators, UT;

EXPORT Constants := MODULE
	EXPORT LinkSearch := ENUM(
													Default = 0,	// 0 = Use Search Levels Set Per Attribute
													PowID,				// 1 = Universally Use PowID for Attributes
													ProxID,				// 2 = Universally Use ProxID for Attributes
													SeleID,				// 3 = Universally Use SeleID for Attributes
													OrgID,				// 4 = Universally Use OrgID for Attributes
													UltID					// 5 = Universally Use UltID for Attributes
													);
	
	EXPORT BIPBestAppend := ENUM(
													Default = 0, 				// 0 = No Best BIP Append
													AllBlankFields,			// 1 = Fill in any fields from the best BIP data that are currently blank, keep populated fields
													OverwriteWithBest		// 2 = Overwrite whatever was passed in with whatever we think is the best data
													);
	
	EXPORT UltIDSet := [LinkSearch.UltID];
	EXPORT UltOrgIDSet := UltIDSet + [LinkSearch.OrgID];
	EXPORT UltOrgSeleIDSet := UltOrgIDSet + [LinkSearch.SeleID, LinkSearch.Default];
	EXPORT UltOrgSeleProxIDSet := UltOrgSeleIDSet + [LinkSearch.ProxID];
	
	EXPORT FetchAll											:= BIPV2.IDconstants.Fetch_Level_UltID;		// By fetching all records at the Highest ID's you automatically get all records for child (lower) ID's
	EXPORT FetchPowID										:= BIPV2.IDconstants.Fetch_Level_PowID;		// 'W' - Pow
	EXPORT FetchProxID									:= BIPV2.IDconstants.Fetch_Level_ProxID;	// 'P' - Pow + Prox
	EXPORT FetchSeleID									:= BIPV2.IDconstants.Fetch_Level_SeleID;	// 'S' - Pow + Prox + Sele
	EXPORT FetchOrgID										:= BIPV2.IDconstants.Fetch_Level_OrgID;		// 'O' - Pow + Prox + Sele + Org
	EXPORT FetchUltID										:= BIPV2.IDconstants.Fetch_Level_UltID;		// 'U' - Pow + Prox + Sele + Org + Ult
	
	EXPORT Default_DPPA									:= 0;
	EXPORT Default_GLBA									:= 0;
	EXPORT Default_DataRestrictionMask	:= Risk_Indicators.iid_constants.default_DataRestriction;
	EXPORT Default_DataPermissionMask		:= Risk_Indicators.iid_constants.default_DataPermission;
	EXPORT Default_OFAC_Version					:= 3;
	EXPORT Default_Global_Watchlist_Threshold := 0.84;
	EXPORT Default_Watchlists_Requested := DATASET([], iesp.Share.t_StringArrayItem);
	EXPORT Default_Gateways_Requested   := DATASET([], Gateway.Layouts.Config);
	EXPORT Default_IndustryClass				:= ''; // UTILI indicates a Utility company, and Utility data must be blanked out
	EXPORT STRING6 Default_SSNMask      := '';
  
	EXPORT Default_BusShellVersion			:= 21; // Default Business Shell Version is v2.1: Business Shell with SBFE enhancement attributes. This is what SBA uses.
	EXPORT BusShellVersion_v20					:= 20; // Business Shell v2.0: Original business shell and original SBFE attributes
	EXPORT BusShellVersion_v21					:= 21; // Business Shell v2.1: Business Shell with SBFE enhancement attributes. This is what SBA uses.
	EXPORT BusShellVersion_v22					:= 22; // Business Shell v2.2: Business Shell with SBFE enhancement attributes and Business Shell Enhancement attributes.
	EXPORT BusShellVersion_v30					:= 30; // Business Shell v3.0: Business Shell v2.2 with Cortera data and enhancement attributes.

	EXPORT RESTRICTED_SET := ['0',''];
	EXPORT BVI_NOHIT_VALUES := ['','0'];
	EXPORT BVI_DESC_KEY_NOHIT_VALUES := ['311','411','412'];
	EXPORT SUPPRESSABLE_RISK_CODES := ['10','11','12','13','14','15','16','18','23','24','25','29','36','38','39','40','41','42','47','48','49','50'];

	EXPORT Default_MarketingMode				:= 0; // Default to OFF.  When ON (> 0) this disables several shell sources
	EXPORT Default_AllowedSources				:= ''; // Default to blank.  This allows for 'DNBDMI' data to be turned on, which can only be used for research purposes at the moment - NO CUSTOMERS CAN USE
	EXPORT AllowDNBDMI									:= 'DNBDMI'; // This is what must be passed in under AllowedSources to turn on DNB DMI data
	
	EXPORT FieldDelimiter								:= ','; // Comma delimited fields
	EXPORT MissingDate									:= '0'; // Populate missing dates (0 dates) with this instead
	EXPORT NinesDate										:= '999999'; // Use this to ensure MIN(dates) works, set 0 dates to all 9's and then MIN.
	EXPORT NinesDateTime								:= '999999999999'; // Same idea as above.
	
	EXPORT OneMonth											:= 30;
	EXPORT TwoMonths										:= 61; // 60.83 days is approximately 2 months, rounded up to 61
	EXPORT ThreeMonths									:= 92; // 91.31 days is approximately 3 months, rounded up to 92
	EXPORT SixMonths										:= 183; // 182.63 days is approximately 6 months, rounded up to 183
	EXPORT OneYear											:= 365;
	EXPORT TwoYear											:= 731;
	EXPORT FirstSBFELoadDate						:= '20151012';
	
  EXPORT MAX_OFAC_VERSION             := 4;
  
	// Various JOIN condition limits
	EXPORT Limit_BusHeader							:= 25000; // Default for Business Header kFetch
	EXPORT Limit_Assessments						:= 15000; // Maximum number of assessments allowed
	EXPORT Limit_Deeds									:= 15000; // Maximum number of deeds allowed
	EXPORT Limit_Property								:= 15000; // Maximum number of property records allowed
	EXPORT Limit_Inquiries							:= 5000; // Maximum number of Inquiry records allowed
	EXPORT Limit_SBFE							      := 10000; // Maximum number of SBFE records allowed
	EXPORT Limit_SBFE_LinkIds						:= 1500; //Maximum number of SBFE LinkId records allowed
	EXPORT Limit_Default								:= 2000; // Default Limit
	
	EXPORT DefaultJoinType							:= BIPV2.IDconstants.JoinTypes.LimitTransformJoin; // Performs a LIMIT(n, SKIP) in the kFetch2's to improve speed for large joins
	
	EXPORT LimitExceededErrorCode				:= (STRING)AutoKeyI.errorcodes._codes.TOO_MANY_SUBJECTS;
	
	EXPORT SIC													:= 'SIC'; // Constant indicating an SIC industry search
	EXPORT NAIC													:= 'NAIC'; // Constant indicating an NAIC industry search

	// Possible InputIDMatchCategory Values
	EXPORT Category_None := '0 NONE';
	EXPORT Category_Defunct := '1 DEFUNCT';
	EXPORT Category_Inactive := '2 INACTIVE';
	EXPORT Category_SingleSource := '3 SINGLE SOURCE';
	EXPORT Category_TrustedSingle := '4 SINGLE TRUSTED';
	EXPORT Category_TrustedSource := '5 TRUSTED SOURCE';
	EXPORT Category_DualCore := '6 DUAL CORE';
	EXPORT Category_TriCore := '7 TRI CORE';
	EXPORT Category_SBFESingle := '8 SINGLE SBFE';
	EXPORT Category_LargeBus := '9 LARGE BUSINESS';
	
	// Source codes as determined by the modeling team
	EXPORT Src_ACF											:= 'CF';
	EXPORT Src_Aircrafts								:= 'AR';
	EXPORT Src_AMS											:= 'SJ';
	EXPORT Src_Atf											:= 'F';
	EXPORT Src_Bankruptcy								:= 'BA';
	EXPORT Src_Bankruptcy_Attorney			:= 'BY';
	EXPORT Src_BBB_Member								:= 'BM';
	EXPORT Src_BBB_Non_Member						:= 'BN';
	EXPORT Src_Bureau										:= 'ER';
	EXPORT Src_Business_Credit					:= 'BC';
	EXPORT Src_BusinessRegistration			:= 'BR';
	EXPORT Src_CalBus										:= 'C#';
	EXPORT Src_CA_Sales_Tax							:= 'FT';
	EXPORT Src_CLIA											:= 'QR';
	EXPORT Src_CorpV2										:= 'C';
	EXPORT Src_CrashCarrier							:= 'KC';
	EXPORT Src_CreditUnions							:= 'CU';
	EXPORT Src_DCA											:= 'DF';
	EXPORT Src_DEA											:= 'DA';
	EXPORT Src_Diversity_Cert						:= 'WB';
	EXPORT Src_DunnBradstreet						:= 'D';
	EXPORT Src_DunnBradstreetFEIN				:= 'DN';
	EXPORT Src_Edgar										:= 'E';
	EXPORT Src_Employee_Directories			:= 'EY';
	EXPORT Src_ExperianCRDB							:= 'Q3';
	EXPORT Src_ExperianFEIN							:= 'EF';
	EXPORT Src_FBN											:= 'FB';
	EXPORT Src_FCC_Radio_Licenses				:= 'FK';
	EXPORT Src_FDIC											:= 'FI';
	EXPORT Src_Foreclosures             := 'FR';
	EXPORT Src_Frandx										:= 'L0';
	EXPORT Src_Garnishments							:= 'GR';
	EXPORT Src_Gong											:= 'GB';
	EXPORT Src_GSA											:= 'H7';
	EXPORT Src_IA_Sales_Tax							:= 'IT';
	EXPORT Src_INFOUSA_ABIUS_USABIZ			:= 'IA';
	EXPORT Src_INFOUSA_DEAD_COMPANIES		:= 'IC';
	EXPORT Src_Ingenix_Sanctions				:= 'IP';
	EXPORT Src_Insurance_Certification	:= 'IS';
	EXPORT Src_IRS5500									:= 'I';
	EXPORT Src_IRS_Non_Profit						:= 'IN';
	EXPORT Src_LaborActions_WHD					:= 'WX';
	EXPORT Src_Liens										:= 'L2';
	EXPORT Src_MartinDale_Hubbell				:= 'MH';
	EXPORT Src_MS_Worker_Comp						:= 'MW';
	EXPORT Src_NaturalDisaster_Readiness:= 'NR';
	EXPORT Src_NCPDP										:= 'J2';
	EXPORT Src_NPPES										:= 'NP';
	EXPORT Src_OIG											:= 'ZO';
	EXPORT Src_OR_Worker_Comp						:= 'WC';
	EXPORT Src_OSHA											:= 'OS';
	EXPORT Src_PhonesPlus								:= 'PP';
	EXPORT Src_Prolic										:= 'PL';
	EXPORT Src_Property									:= 'P';
	EXPORT Src_SDAA										  := 'SA';
	EXPORT Src_SEC_Broker_Dealer				:= 'SB';
	EXPORT Src_Sheila_Greco							:= 'SG';
	EXPORT Src_SKA											:= 'SK';
	EXPORT Src_Spoke										:= 'SP';
	EXPORT Src_Targus_Gateway           := 'TG';
	EXPORT Src_TXBUS										:= 'TX';
	EXPORT Src_UCC											:= 'U2';
	EXPORT Src_Utility_sources					:= 'UT';
	EXPORT Src_Vehicles									:= 'V2';
	EXPORT Src_Vickers									:= 'V';
	EXPORT Src_Watercraft								:= 'WA';
	EXPORT Src_Workers_Compensation			:= 'WK';
	EXPORT Src_Yellow_Pages							:= 'Y';

	EXPORT Set_Assets := [Src_Aircrafts, Src_Vehicles, Src_Watercraft];
	EXPORT Set_Bankruptcy := [Src_Bankruptcy];
	EXPORT Set_Bureau := [Src_DunnBradstreet, Src_DunnBradstreetFEIN, Src_Bureau, Src_ExperianFEIN, Src_ExperianCRDB];
	EXPORT Set_Federal := [Src_FDIC, Src_IRS5500, Src_IRS_Non_Profit, Src_OSHA];
	EXPORT Set_Lien := [Src_Liens];
	EXPORT Set_Phones := [Src_Gong, Src_PhonesPlus, Src_Yellow_Pages, Src_Targus_Gateway];
	EXPORT Set_Property := [Src_Property];
	EXPORT Set_Registrations := [Src_BBB_Member, Src_BBB_Non_Member];
	EXPORT Set_SOS := [Src_BusinessRegistration, Src_CorpV2, Src_DCA];
	EXPORT Set_UCC := [Src_UCC];
	
	EXPORT Set_Derog := [Src_Liens, Src_Bankruptcy];
	EXPORT Set_NonDerog := [Src_BusinessRegistration, Src_CorpV2, Src_DunnBradstreet, Src_DunnBradstreetFEIN, 
													Src_Bureau, Src_ExperianFEIN, Src_DCA, Src_UCC, Src_Aircrafts, Src_ExperianCRDB, 
													Src_FDIC, Src_IRS5500, Src_IRS_Non_Profit, Src_Vehicles, Src_Property, Src_Watercraft, 
													Src_Yellow_Pages, Src_Gong];
	
	EXPORT Set_PublicRecords := Set_Assets + Set_Bankruptcy + Set_Federal + Set_Lien + Set_Property + Set_Registrations + Set_UCC;
	
	SHARED LayoutSources := RECORD
		STRING2 Source := '';
	END;
	
	// This dataset contains Experian sources that must be filtered out for the following Scoring products:
	//   o   Small Business Attributes
	//   o   Small Business Attributes with SBFE Data
	//   o   Small Business Credit Score with SBFE Data
	//   o   Small Business Blended Credit Score with SBFE Data
	//   o   Small Business Risk Score
	EXPORT ExperianRestrictedSources := DATASET([
						{MDR.sourceTools.src_EBR},
						{MDR.SourceTools.src_Experian_CRDB}
						], LayoutSources);
  
  EXPORT SetExperianRestrictedSources := SET(ExperianRestrictedSources, source);
    
	// This dataset contains sources that must be filtered out when "Marketing Mode" is enabled for the shell - beyond this list Inquiries data must also be filtered out						
	EXPORT MarketingRestrictedSources := DATASET([
						{MDR.sourceTools.src_Business_Credit},
						{MDR.SourceTools.src_Business_Registration},
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
						{MDR.SourceTools.src_FBNV2_BusReg},
						{MDR.SourceTools.src_DCA},
						{MDR.SourceTools.src_Dunn_Bradstreet},
						{MDR.SourceTools.src_FDIC},
						{MDR.SourceTools.src_INFOUSA_IDEXEC},
						{MDR.SourceTools.src_INFOUSA_DEAD_COMPANIES},
						{MDR.SourceTools.src_INFOUSA_ABIUS_USABIZ},
						{MDR.SourceTools.src_IRS_Non_Profit},
						{MDR.SourceTools.src_SDA},
						{MDR.SourceTools.src_SDAA},
						{MDR.SourceTools.src_EBR},
						{MDR.SourceTools.src_SKA},
						{MDR.SourceTools.src_Frandx},
						{MDR.SourceTools.src_IN_Liquor_Licenses},
						{MDR.SourceTools.src_Redbooks},
						{MDR.SourceTools.src_ACF},
						{MDR.SourceTools.src_Spoke},
						{MDR.SourceTools.src_MartinDale_Hubbell},
						{MDR.SourceTools.src_LaborActions_WHD},
						{MDR.SourceTools.src_SEC_Broker_Dealer},
						{MDR.SourceTools.src_Workers_Compensation},
						{MDR.SourceTools.src_MS_Worker_Comp},
						{MDR.SourceTools.src_NaturalDisaster_Readiness},
						{MDR.SourceTools.src_Vickers},
						{MDR.SourceTools.src_One_Click_Data},
						{MDR.SourceTools.src_Teletrack},
						{MDR.SourceTools.src_Employee_Directories},
						{MDR.SourceTools.src_Thrive_LT},
						{MDR.SourceTools.src_Thrive_LT_POE_Email},
						{MDR.SourceTools.src_Thrive_PD},
						{MDR.SourceTools.src_Thrive_PD_POE_Email},
						{MDR.SourceTools.src_LaborActions_EBSA},
						{MDR.SourceTools.src_FDIC_SOD},
						{MDR.SourceTools.src_ACA},				//Added (and those following) 01/09/2017
						{MDR.SourceTools.src_AK_Fishing_boats},
						{MDR.SourceTools.src_AR_Experian_Veh},
						{MDR.SourceTools.src_AZ_Experian_Veh},
						{MDR.SourceTools.src_CT_DL},
						{MDR.SourceTools.src_Calbus},
						{MDR.SourceTools.src_Certegy},
						{MDR.SourceTools.src_Credit_Unions},
						{MDR.SourceTools.src_Death_CA},
						{MDR.SourceTools.src_Death_FL},
						{MDR.SourceTools.src_Death_GA},
						{MDR.SourceTools.src_Death_MI},
						{MDR.SourceTools.src_Death_MT},
						{MDR.SourceTools.src_Death_OH},
						{MDR.SourceTools.src_Death_VA},
						{MDR.SourceTools.src_EMerge_Cens},
						{MDR.SourceTools.src_EMerge_Master},
						{MDR.SourceTools.src_Eq_Employer},
						{MDR.SourceTools.src_Experian_CRDB},
						{MDR.SourceTools.src_Experian_Credit_Header},
						{MDR.SourceTools.src_Experian_FEIN_Rest},
						{MDR.SourceTools.src_Experian_FEIN_Unrest},
						{MDR.SourceTools.src_FL_DL},
						{MDR.SourceTools.src_FL_Veh},
						{MDR.SourceTools.src_Fares_Deeds_from_Asrs},
						{MDR.SourceTools.src_Federal_Explosives},
						{MDR.SourceTools.src_Federal_Firearms},
						{MDR.SourceTools.src_GA_Experian_Veh},
						{MDR.SourceTools.src_Gong_Government},
						{MDR.SourceTools.src_Gong_History},
						{MDR.SourceTools.src_IA_Experian_Veh},
						{MDR.SourceTools.src_ID_Experian_Veh},
						{MDR.SourceTools.src_KS_Experian_Veh},
						{MDR.SourceTools.src_KY_Experian_DL},
						{MDR.SourceTools.src_KY_Veh},
						{MDR.SourceTools.src_LA_DL},
						{MDR.SourceTools.src_Liens_v2_Chicago_Law},
						{MDR.SourceTools.src_ME_Experian_Veh},
						{MDR.SourceTools.src_MI_DL},
						{MDR.SourceTools.src_MN_Experian_Veh},
						{MDR.SourceTools.src_MO_DL},
						{MDR.SourceTools.src_MO_Watercraft},
						{MDR.SourceTools.src_NC_DL},
						{MDR.SourceTools.src_NC_Experian_Veh},
						{MDR.SourceTools.src_ND_Veh},
						{MDR.SourceTools.src_NE_Experian_Veh},
						{MDR.SourceTools.src_NM_DL},
						{MDR.SourceTools.src_NM_Veh},
						{MDR.SourceTools.src_OH_Veh},
						{MDR.SourceTools.src_Phones_Plus},
						{MDR.SourceTools.src_Professional_License},
						{MDR.SourceTools.src_RI_Experian_Veh},
						{MDR.SourceTools.src_SD_Experian_Veh},
						{MDR.SourceTools.src_Sheila_Greco},
						{MDR.SourceTools.src_TU_CreditHeader},
						{MDR.SourceTools.src_TX_Experian_Veh},
						{MDR.SourceTools.src_Util_Work_Phone},
						{MDR.SourceTools.src_Utilities},
						{MDR.SourceTools.src_VT_Experian_Veh},
						{MDR.SourceTools.src_Voters_v2},
						{MDR.SourceTools.src_WA_Experian_Veh},
						{MDR.SourceTools.src_WV_DL},
						{MDR.SourceTools.src_WY_Veh},
						{MDR.SourceTools.src_Whois_domains},
						{MDR.SourceTools.src_ZUtil_Work_Phone},
						{MDR.SourceTools.src_ZUtilities}				//End add from 01/09/2017
						], LayoutSources);
	
	// This is used by key_AllowedSources to build a key.  The key provides a way to add new sources to the shell
	// without requiring code changes.  It will only require that the list below be modified and a new version of 
	// the key file will then need to be re-built.
	export AllowedSources	:= DATASET([
												{MDR.sourceTools.src_Business_Credit,           'A'}, // BC
												{MDR.sourceTools.src_Business_Registration,			'A'}, // BR
												{MDR.sourceTools.src_AK_Corporations,      		 	'A'}, // C)
												{MDR.sourceTools.src_AL_Corporations, 					'A'}, // C(
												{MDR.sourceTools.src_AR_Corporations,						'A'}, // C+
												{MDR.sourceTools.src_AZ_Corporations,						'A'}, // C*
												{MDR.sourceTools.src_CA_Corporations,						'A'}, // C,
												{MDR.sourceTools.src_CO_Corporations,						'A'}, // C-
												{MDR.sourceTools.src_CT_Corporations,						'A'}, // C.
												{MDR.sourceTools.src_DC_Corporations,						'A'}, // C/
												{MDR.sourceTools.src_FL_Corporations,						'A'}, // C0
												{MDR.sourceTools.src_GA_Corporations,						'A'}, // C1
												{MDR.sourceTools.src_HI_Corporations,						'A'}, // C2
												{MDR.sourceTools.src_IA_Corporations,						'A'}, // C6
												{MDR.sourceTools.src_ID_Corporations,						'A'}, // C3
												{MDR.sourceTools.src_IL_Corporations,						'A'}, // C4
												{MDR.sourceTools.src_IN_Corporations,						'A'}, // C5
												{MDR.sourceTools.src_KS_Corporations,						'A'}, // C7
												{MDR.sourceTools.src_KY_Corporations,						'A'}, // C8
												{MDR.sourceTools.src_LA_Corporations,						'A'}, // C9
												{MDR.sourceTools.src_MA_Corporations,						'A'}, // C<
												{MDR.sourceTools.src_MD_Corporations,						'A'}, // C;
												{MDR.sourceTools.src_ME_Corporations,						'A'}, // C:
												{MDR.sourceTools.src_MI_Corporations,						'A'}, // C=
												{MDR.sourceTools.src_MN_Corporations,						'A'}, // C>
												{MDR.sourceTools.src_MO_Corporations,						'A'}, // C@
												{MDR.sourceTools.src_MS_Corporations,						'A'}, // C?
												{MDR.sourceTools.src_MT_Corporations,						'A'}, // C[
												{MDR.sourceTools.src_NC_Corporations,						'A'}, // C|
												{MDR.sourceTools.src_ND_Corporations,						'A'}, // C}
												{MDR.sourceTools.src_NE_Corporations,						'A'}, // C\
												{MDR.sourceTools.src_NH_Corporations,						'A'}, // C^
												{MDR.sourceTools.src_NJ_Corporations,						'A'}, // C_
												{MDR.sourceTools.src_NM_Corporations,						'A'}, // C'
												{MDR.sourceTools.src_NV_Corporations,						'A'}, // C]
												{MDR.sourceTools.src_NY_Corporations,						'A'}, // C{
												{MDR.sourceTools.src_OH_Corporations,						'A'}, // C~
												{MDR.sourceTools.src_OK_Corporations,						'A'}, // CA
												{MDR.sourceTools.src_OR_Corporations,						'A'}, // CB
												{MDR.sourceTools.src_PA_Corporations,						'A'}, // CH
												{MDR.sourceTools.src_RI_Corporations,						'A'}, // CI
												{MDR.sourceTools.src_SC_Corporations,						'A'}, // CJ
												{MDR.sourceTools.src_SD_Corporations,						'A'}, // CK
												{MDR.sourceTools.src_TN_Corporations,						'A'}, // CM
												{MDR.sourceTools.src_TX_Corporations,						'A'}, // CN
												{MDR.sourceTools.src_UT_Corporations,						'A'}, // CP
												{MDR.sourceTools.src_VA_Corporations,						'A'}, // CR
												{MDR.sourceTools.src_VT_Corporations,						'A'}, // CQ
												{MDR.sourceTools.src_WA_Corporations,						'A'}, // CS
												{MDR.sourceTools.src_WI_Corporations,						'A'}, // CX
												{MDR.sourceTools.src_WV_Corporations,						'A'}, // CV
												{MDR.sourceTools.src_WV_Hist_Corporations,			'A'}, // C!
												{MDR.sourceTools.src_WY_Corporations,						'A'}, // CZ
												{MDR.SourceTools.src_Cortera,										'A'}, // RR
												{MDR.sourceTools.src_Dunn_Bradstreet,						'A'}, // D
												{MDR.sourceTools.src_Dunn_Bradstreet_Fein,			'A'}, // DN
												{MDR.sourceTools.src_EBR,												'A'}, // ER
												{MDR.sourceTools.src_FBNV2_BusReg,							'A'}, // FH
												{MDR.sourceTools.src_FBNV2_CA_Orange_county,		'A'}, // GF
												{MDR.sourceTools.src_FBNV2_CA_Santa_Clara,			'A'}, // ZF
												{MDR.sourceTools.src_FBNV2_CA_San_Bernadino,		'A'}, // BF
												{MDR.sourceTools.src_FBNV2_CA_San_Diego,  			'A'}, // EF
												{MDR.sourceTools.src_FBNV2_CA_Ventura,	    		'A'}, // VF
												{MDR.sourceTools.src_FBNV2_Experian_Direct,			'A'}, // TF
												{MDR.sourceTools.src_FBNV2_FL,									'A'}, // WF
												{MDR.sourceTools.src_FBNV2_Hist_Choicepoint,		'A'}, // PF
												{MDR.sourceTools.src_FBNV2_INF,									'A'}, // UF
												{MDR.sourceTools.src_FBNV2_New_York,						'A'}, // YF
												{MDR.sourceTools.src_FBNV2_TX_Dallas,						'A'}, // XF
												{MDR.sourceTools.src_FBNV2_TX_Harris,						'A'}, // HF
												{MDR.sourceTools.src_Frandx,										'A'}, // L0
												{MDR.sourceTools.src_Liens,											'A'}, // LI
												{MDR.sourceTools.src_Liens_and_Judgments,				'A'}, // LJ
												{MDR.sourceTools.src_Liens_v2,									'A'}, // L2
												{MDR.sourceTools.src_Liens_v2_CA_Federal,				'A'}, // LF
												{MDR.sourceTools.src_Liens_v2_Hogan,						'A'}, // LH
												{MDR.sourceTools.src_Liens_v2_ILFDLN,						'A'}, // LD
												{MDR.sourceTools.src_Liens_v2_MA,								'A'}, // LM
												{MDR.sourceTools.src_Liens_v2_NYC,							'A'}, // LN
												{MDR.sourceTools.src_Liens_v2_NYFDLN,						'A'}, // LY
												{MDR.sourceTools.src_Liens_v2_Service_Abstract, 'A'}, // LS
												{MDR.sourceTools.src_Liens_v2_Superior_Party,   'A'}, // LU
												{MDR.sourceTools.src_DCA,												'A'}, // DF
												{MDR.sourceTools.src_UCC,												'A'}, // U
												{MDR.sourceTools.src_UCCV2,											'A'}, // U2
												{MDR.sourceTools.src_UCCV2_WA_Hist,							'A'}, // UH
												{MDR.sourceTools.src_Aircrafts,									'B'}, // AR
												{MDR.sourceTools.src_Bankruptcy,								'B'}, // BA
												{MDR.sourceTools.src_BBB_Member,								'B'}, // BM
												{MDR.sourceTools.src_BBB_Non_Member,						'B'}, // BN
												{MDR.sourceTools.src_Calbus,										'B'}, // C#
												{MDR.sourceTools.src_Credit_Unions,							'B'}, // CU
												{MDR.sourceTools.src_DEA,												'B'}, // DA
												{MDR.sourceTools.src_Experian_CRDB,							'B'}, // Q3
												{MDR.sourceTools.src_Experian_FEIN_Rest,				'B'}, // E5
												{MDR.sourceTools.src_Experian_FEIN_Unrest,			'B'}, // E6
												{MDR.sourceTools.src_FDIC,											'B'}, // FI
												{MDR.sourceTools.src_IRS_5500,									'B'}, // I
												{MDR.sourceTools.src_IRS_Non_Profit,						'B'}, // IN
												{MDR.sourceTools.src_FL_Veh,										'B'}, // FV
												{MDR.sourceTools.src_ID_Veh,										'B'}, // IV
												{MDR.sourceTools.src_KY_Veh,										'B'}, // KV
												{MDR.sourceTools.src_ME_Veh,										'B'}, // AV
												{MDR.sourceTools.src_MN_Veh,										'B'}, // NV
												{MDR.sourceTools.src_MO_Veh,										'B'}, // SV
												{MDR.sourceTools.src_MS_Veh,										'B'}, // MV
												{MDR.sourceTools.src_MT_Veh,										'B'}, // LV
												{MDR.sourceTools.src_NC_Veh,										'B'}, // RV
												{MDR.sourceTools.src_ND_Veh,										'B'}, // PV
												{MDR.sourceTools.src_NE_Veh,										'B'}, // EV
												{MDR.sourceTools.src_NM_Veh,										'B'}, // XV
												{MDR.sourceTools.src_NV_Veh,										'B'}, // QV
												{MDR.sourceTools.src_OH_Veh,										'B'}, // OV
												{MDR.sourceTools.src_TX_Veh,										'B'}, // TV
												{MDR.sourceTools.src_UT_Veh,										'B'}, // UV
												{MDR.sourceTools.src_WI_Veh,										'B'}, // WV
												{MDR.sourceTools.src_WY_Veh,										'B'}, // YV
												{MDR.sourceTools.src_AK_Experian_Veh,						'B'}, // AE
												{MDR.sourceTools.src_AL_Experian_Veh,						'B'}, // BE
												{MDR.sourceTools.src_AR_Experian_Veh,						'B'}, // 71   DF-16817
												{MDR.sourceTools.src_AZ_Experian_Veh,						'B'}, // 73		DF-16817
												{MDR.sourceTools.src_CO_Experian_Veh,						'B'}, // EE
												{MDR.sourceTools.src_CT_Experian_Veh,						'B'}, // CE
												{MDR.sourceTools.src_DC_Experian_Veh,						'B'}, // &E
												{MDR.sourceTools.src_DE_Experian_Veh,						'B'}, // $E
												{MDR.sourceTools.src_FL_Experian_Veh,						'B'}, // GE
												{MDR.sourceTools.src_GA_Experian_Veh,						'B'}, // M		DF-16817
												{MDR.sourceTools.src_IA_Experian_Veh,						'B'}, // 74		DF-16817
												{MDR.sourceTools.src_ID_Experian_Veh,						'B'}, // JE
												{MDR.sourceTools.src_IL_Experian_Veh,						'B'}, // IE
												{MDR.sourceTools.src_KS_Experian_Veh,						'B'}, // 75		DF-16817
												{MDR.sourceTools.src_KY_Experian_Veh,						'B'}, // KE
												{MDR.sourceTools.src_LA_Experian_Veh,						'B'}, // LE
												{MDR.sourceTools.src_MA_Experian_Veh,						'B'}, // NE
												{MDR.sourceTools.src_MD_Experian_Veh,						'B'}, // ME
												{MDR.sourceTools.src_ME_Experian_Veh,						'B'}, // RE
												{MDR.sourceTools.src_MI_Experian_Veh,						'B'}, // PE
												{MDR.sourceTools.src_MN_Experian_Veh,						'B'}, // VE
												{MDR.sourceTools.src_MO_Experian_Veh,						'B'}, // YE
												{MDR.sourceTools.src_MS_Experian_Veh,						'B'}, // XE
												{MDR.sourceTools.src_MT_Experian_Veh,						'B'}, // ZE
												{MDR.sourceTools.src_NC_Experian_Veh,						'B'}, // 76		DF-16817
												{MDR.sourceTools.src_ND_Experian_Veh,						'B'}, // @E
												{MDR.sourceTools.src_NE_Experian_Veh,						'B'}, // HE
												{MDR.sourceTools.src_NM_Experian_Veh,						'B'}, // +E
												{MDR.sourceTools.src_NV_Experian_Veh,						'B'}, // ?E
												{MDR.sourceTools.src_NY_Experian_Veh,						'B'}, // QE
												{MDR.sourceTools.src_OH_Experian_Veh,						'B'}, // !E
												{MDR.sourceTools.src_OK_Experian_Veh,						'B'}, // OE
												{MDR.sourceTools.src_OR_Experian_Veh,						'B'}, // =E
												{MDR.sourceTools.src_RI_Experian_Veh,						'B'}, // 77		DF-16817
												{MDR.sourceTools.src_SC_Experian_Veh,						'B'}, // SE
												{MDR.sourceTools.src_SD_Experian_Veh,						'B'}, // 70		DF-16817
												{MDR.sourceTools.src_TN_Experian_Veh,						'B'}, // TE
												{MDR.sourceTools.src_TX_Experian_Veh,						'B'}, // .E
												{MDR.sourceTools.src_UT_Experian_Veh,						'B'}, // UE
												{MDR.sourceTools.src_VT_Experian_Veh,						'B'}, // 79		DF-16817
												{MDR.sourceTools.src_WA_Experian_Veh,						'B'}, // YH		DF-16817
												{MDR.sourceTools.src_WI_Experian_Veh,						'B'}, // WE
												{MDR.sourceTools.src_WY_Experian_Veh,						'B'}, // #E
												{MDR.sourceTools.src_OSHAIR,										'B'}, // OS
												{MDR.sourceTools.src_Professional_License,			'B'}, // PL
												{MDR.sourceTools.src_LnPropV2_Fares_Asrs,				'B'}, // FA
												{MDR.sourceTools.src_LnPropV2_Fares_Deeds,			'B'}, // FP
												{MDR.sourceTools.src_LnPropV2_Lexis_Asrs,				'B'}, // LA
												{MDR.sourceTools.src_LnPropV2_Lexis_Deeds_Mtgs, 'B'}, // LP
												{MDR.sourceTools.src_SKA,												'B'}, // SK
												{MDR.sourceTools.src_TXBUS,											'B'}, // TX
												{MDR.sourceTools.src_INFOUSA_ABIUS_USABIZ,			'B'}, // IA
												{MDR.sourceTools.src_AK_Watercraft,							'B'}, // #W
												{MDR.sourceTools.src_AL_Watercraft,							'B'}, // LW
												{MDR.sourceTools.src_AR_Watercraft,							'B'}, // RW
												{MDR.sourceTools.src_AZ_Watercraft,							'B'}, // ZW
												{MDR.sourceTools.src_CO_Watercraft,							'B'}, // CW
												{MDR.sourceTools.src_CT_Watercraft,							'B'}, // EW
												{MDR.sourceTools.src_FL_Watercraft,							'B'}, // FW
												{MDR.sourceTools.src_GA_Watercraft,							'B'}, // GW
												{MDR.sourceTools.src_IA_Watercraft,							'B'}, // IW
												{MDR.sourceTools.src_IL_Watercraft,							'B'}, // PW
												{MDR.sourceTools.src_KS_Watercraft,							'B'}, // HW
												{MDR.sourceTools.src_KY_Watercraft,							'B'}, // KW
												{MDR.sourceTools.src_MA_Watercraft,							'B'}, // JW
												{MDR.sourceTools.src_MD_Watercraft,							'B'}, // DW
												{MDR.sourceTools.src_ME_Watercraft,							'B'}, // QW
												{MDR.sourceTools.src_MI_Watercraft,							'B'}, // XW
												{MDR.sourceTools.src_MN_Watercraft,							'B'}, // 1W
												{MDR.sourceTools.src_MO_Watercraft,							'B'}, // BW
												{MDR.sourceTools.src_MS_Watercraft,							'B'}, // 2W
												{MDR.sourceTools.src_MT_Watercraft,							'B'}, // 3W
												{MDR.sourceTools.src_NC_Watercraft,							'B'}, // NW
												{MDR.sourceTools.src_ND_Watercraft,							'B'}, // 4W
												{MDR.sourceTools.src_NE_Watercraft,							'B'}, // 5W
												{MDR.sourceTools.src_NH_Watercraft,							'B'}, // 6W 
												{MDR.sourceTools.src_NV_Watercraft,							'B'}, // 7W
												{MDR.sourceTools.src_NY_Watercraft,							'B'}, // YW
												{MDR.sourceTools.src_OH_Watercraft,							'B'}, // OW
												{MDR.sourceTools.src_OR_Watercraft,							'B'}, // 8W
												{MDR.sourceTools.src_SC_Watercraft,							'B'}, // SW
												{MDR.sourceTools.src_TN_Watercraft,							'B'}, // TW
												{MDR.sourceTools.src_TX_Watercraft,							'B'}, // [W
												{MDR.sourceTools.src_UT_Watercraft,							'B'}, // 9W
												{MDR.sourceTools.src_VA_Watercraft,							'B'}, // VW
												{MDR.sourceTools.src_WI_Watercraft,							'B'}, // WW
												{MDR.sourceTools.src_WV_Watercraft,							'B'}, // !W
												{MDR.sourceTools.src_WY_Watercraft,							'B'}, // @W
												{MDR.sourceTools.src_WA_Watercraft,							'B'}, // %W
												{MDR.sourceTools.src_FL_Watercraft_LN,					'B'}, // (W
												{MDR.sourceTools.src_KY_Watercraft_LN,					'B'}, // $W
												{MDR.sourceTools.src_MO_Watercraft_LN,					'B'}, // )W
												{MDR.sourceTools.src_Yellow_Pages,							'B'}, // Y
												{MDR.sourceTools.src_INFOUSA_DEAD_COMPANIES,		'C'}, // IC
												{MDR.sourceTools.src_Diversity_Cert,						'C'}, // WB
												{MDR.sourceTools.src_FCC_Radio_Licenses,				'C'}, // FK
												{MDR.sourceTools.src_GSA,												'C'}, // H7
												{MDR.sourceTools.src_Gong_Business,							'C'}, // GB
												{MDR.sourceTools.src_Gong_Government,						'C'}, // GG
												{MDR.SourceTools.src_Gong_History,							'C'}, // GO
												{MDR.sourceTools.src_LaborActions_WHD,					'C'}, // WX
												{MDR.sourceTools.src_SEC_Broker_Dealer,					'C'}, // SB
												{MDR.sourceTools.src_Workers_Compensation,			'C'}, // WK
												{MDR.sourceTools.src_ACF,												'C'}, // CF
												{MDR.sourceTools.src_AMS,												'C'}, // SJ
												{MDR.sourceTools.src_Federal_Explosives,				'C'}, // FE
												{MDR.sourceTools.src_Federal_Firearms,					'C'}, // FF
												{MDR.sourceTools.src_Bankruptcy_Attorney,				'C'}, // BY
												{MDR.sourceTools.src_Ingenix_Sanctions,					'C'}, // IP
												{MDR.sourceTools.src_CA_Sales_Tax,							'C'}, // FT
												{MDR.sourceTools.src_CLIA,											'C'}, // QR
												{MDR.sourceTools.src_Edgar,											'C'}, // E
												{MDR.sourceTools.src_Employee_Directories,			'C'}, // EY
												//{MDR.sourceTools.src_FDIC,									'C'}, // FI  already listed under source class 'B'
												{MDR.sourceTools.src_Foreclosures,							'C'}, // FR
												{MDR.sourceTools.src_Foreclosures_Delinquent,		'C'}, // NT
												{MDR.sourceTools.src_Garnishments,							'C'}, // GR
												{MDR.sourceTools.src_Insurance_Certification,		'C'}, // IS
												{MDR.sourceTools.src_IA_Sales_Tax,							'C'}, // IT
												{MDR.sourceTools.src_MartinDale_Hubbell,				'C'}, // MH
												{MDR.sourceTools.src_MS_Worker_Comp,						'C'}, // MW
												{MDR.sourceTools.src_NaturalDisaster_Readiness, 'C'}, // NR
												{MDR.sourceTools.src_NCPDP,											'C'}, // J2
												{MDR.sourceTools.src_NPPES,											'C'}, // NP
												{MDR.sourceTools.src_OIG,												'C'}, // ZO
												{MDR.sourceTools.src_OR_Worker_Comp,						'C'}, // WC
												{MDR.sourceTools.src_CrashCarrier,							'C'}, // KC
												{MDR.sourceTools.src_SDA,												'C'}, // SA
												{MDR.sourceTools.src_SDAA,											'C'}, // AA
												{MDR.sourceTools.src_Sheila_Greco,							'C'}, // SG
												{MDR.sourceTools.src_Spoke,											'C'}, // SP
												{MDR.sourceTools.src_Utilities,									'C'}, // UT
												{MDR.sourceTools.src_ZUtilities,								'C'}, // ZT
												{MDR.sourceTools.src_ZUtil_Work_Phone,					'C'}, // ZK
												{MDR.sourceTools.src_Daily_ZUtilities,					'C'}, // ZU
												{MDR.sourceTools.src_Vickers,										'C'}  // V
												], Layout_AllowedSources);
end;