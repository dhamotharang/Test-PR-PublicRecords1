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

	EXPORT INTEGER PROPERTY_JOIN_LIMIT := 10;
	EXPORT INTEGER PROPERTY_SEARCH_FID_JOIN_LIMIT := 50;
		
	// This is the set of explicitly Allowed Sources for use within the Analytic Library.  If a record doesn't belong to one of these sources, it will be blocked from usage
	// TODO: KS-1968 - Define the set of ALLOWED_SOURCES.
	EXPORT SET OF STRING2 ALLOWED_SOURCES := [];
  
	
	// This is a set of the explicitly allowed Marketing Sources for use within the Analytic Library.  If a record doesn't belong to one of these sources, it will be blocked from usage in Marketing Products
	EXPORT SET OF STRING2 ALLOWED_MARKETING_SOURCES :=	
	//additional rules ucc,marketing relatives are applied in fn_kel_dpmbitmap & FDC
	//these 2 keys are no in codesv3 as of 3/23/2020 DF-26237 will add ucc market sources later 
	[MDR.SourceTools.src_UCCV2] + 	
	[MDR.sourceTools.src_Marketing_Relatives_Data]+	
	[MDR.SourceTools.src_Best_Person]+
	[MDR.SourceTools.src_Cortera_Tradeline];//royalties!

	
	EXPORT FraudPoint3Source := '$F'; //FDN data - FD, FN, DN, were all taken in MDR
	
	EXPORT VALIDATE_YEAR_RANGE_LOW_DOB := 1800;
	EXPORT VALIDATE_YEAR_RANGE_HIGH_DOB := ((INTEGER)(((STRING8)STD.Date.Today())[1..4]) + 100);
	
	EXPORT VALIDATE_YEAR_RANGE_LOW_ARCHIVEDATE := ((INTEGER)(((STRING8)STD.Date.Today())[1..4]) - 120);
	EXPORT VALIDATE_YEAR_RANGE_HIGH_ARCHIVEDATE := (INTEGER)(((STRING8)STD.Date.Today())[1..4]);		

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
						
	END;
