IMPORT Business_Risk_BIP, MDR, STD, BIPV2;

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
  EXPORT INTEGER BUSINESS_HEADER_LIMIT := 50000;
  EXPORT INTEGER CORTERA_TRADELINE_LIMIT := 25000;
  
  // This is the set of explicitly Allowed Sources for use within the Analytic Library.  If a record doesn't belong to one of these sources, it will be blocked from usage
  // TODO: KS-1968 - Define the set of ALLOWED_SOURCES.
  EXPORT SET OF STRING2 ALLOWED_SOURCES := [];
  
  // This is a set of the explicitly allowed Marketing Sources for use within the Analytic Library.  If a record doesn't belong to one of these sources, it will be blocked from usage in Marketing Products
  EXPORT SET OF STRING2 ALLOWED_MARKETING_SOURCES := 
	MDR.SourceTools.set_Marketing_Veh + 
	MDR.SourceTools.set_Marketing_WC + 
	MDR.SourceTools.set_Marketing_Corp + 
	MDR.SourceTools.set_Marketing_FBN + 
	MDR.SourceTools.set_Marketing_Header + 
	MDR.SourceTools.set_Marketing_Restricted;

	EXPORT FraudPoint3Source := '$F'; //FDN data - FD, FN, DN, were all taken in MDR
	
	EXPORT VALIDATE_YEAR_RANGE_LOW_DOB := 1800;
	EXPORT VALIDATE_YEAR_RANGE_HIGH_DOB := ((INTEGER)(((STRING8)STD.Date.Today())[1..4]) + 100);
	
	EXPORT VALIDATE_YEAR_RANGE_LOW_ARCHIVEDATE := ((INTEGER)(((STRING8)STD.Date.Today())[1..4]) - 120);
	EXPORT VALIDATE_YEAR_RANGE_HIGH_ARCHIVEDATE := (INTEGER)(((STRING8)STD.Date.Today())[1..4]);		

	// Generic marketing restrictions for UCCV2 keys	
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
	

	
	END;
