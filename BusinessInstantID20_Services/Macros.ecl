EXPORT Macros := MODULE
	
	EXPORT mac_ReadInputIESP() := MACRO
		UNSIGNED4  _Seq                :=   1;
		STRING30   _AcctNo             := users.AccountNumber;
		
		// Company Information				
		STRING120 _CompanyName         := search.Company.CompanyName;
		STRING120 _AltCompanyName      := search.Company.AlternateCompanyName;
		STRING120 _StreetAddress1      := 
				IF( search.Company.Address.StreetAddress1 = '', 
						Address.Addr1FromComponents(search.Company.Address.StreetNumber, search.Company.Address.StreetPreDirection, search.Company.Address.StreetName, search.Company.Address.StreetSuffix, search.Company.Address.StreetPostDirection, search.Company.Address.UnitDesignation, search.Company.Address.UnitNumber),
						search.Company.Address.StreetAddress1 );
		STRING120 _StreetAddress2      := search.Company.Address.StreetAddress2;
		STRING25  _City                := search.Company.Address.City;
		STRING2   _State               := search.Company.Address.State;
		STRING9   _Zip                 := search.Company.Address.Zip5;
		STRING9   _FEIN                := search.Company.FEIN;
		STRING10  _Phone10             := search.Company.Phone;
		
		// Authorized Representative 1 Information
		STRING5   _Rep1_NameTitle      := search.AuthorizedRep1.Name.Prefix;
		STRING120 _Rep1_FullName       := search.AuthorizedRep1.Name.Full;
		STRING20  _Rep1_FirstName      := search.AuthorizedRep1.Name.First;
		STRING20  _Rep1_MiddleName     := search.AuthorizedRep1.Name.Middle;
		STRING20  _Rep1_LastName       := search.AuthorizedRep1.Name.Last;
		STRING5   _Rep1_NameSuffix     := search.AuthorizedRep1.Name.Suffix;
		STRING20  _Rep1_FormerLastName := search.AuthorizedRep1.FormerLastName;
		STRING120 _Rep1_StreetAddress1 := 
				IF( search.AuthorizedRep1.Address.StreetAddress1 = '', 
						Address.Addr1FromComponents(search.AuthorizedRep1.Address.StreetNumber, search.AuthorizedRep1.Address.StreetPreDirection, search.AuthorizedRep1.Address.StreetName, search.AuthorizedRep1.Address.StreetSuffix, search.AuthorizedRep1.Address.StreetPostDirection, search.AuthorizedRep1.Address.UnitDesignation, search.AuthorizedRep1.Address.UnitNumber),
						search.AuthorizedRep1.Address.StreetAddress1 );
		STRING120 _Rep1_StreetAddress2 := search.AuthorizedRep1.Address.StreetAddress2;
		STRING25  _Rep1_City           := search.AuthorizedRep1.Address.City;
		STRING2   _Rep1_State          := search.AuthorizedRep1.Address.State;
		STRING9   _Rep1_Zip            := search.AuthorizedRep1.Address.Zip5;
		STRING9   _Rep1_SSN            := search.AuthorizedRep1.SSN;
		STRING8   _Rep1_DateOfBirth    := iesp.ECL2ESP.t_DateToString8(search.AuthorizedRep1.DOB);
		STRING3   _Rep1_Age            := search.AuthorizedRep1.Age;
		STRING25  _Rep1_DLNumber       := search.AuthorizedRep1.DriverLicenseNumber;
		STRING2   _Rep1_DLState        := search.AuthorizedRep1.DriverLicenseState;
		STRING10  _Rep1_Phone10        := search.AuthorizedRep1.Phone;
		STRING100 _Rep1_Email          := search.AuthorizedRep1.Email;
		UNSIGNED6 _Rep1_LexID          := (UNSIGNED6)search.AuthorizedRep1.UniqueID;
		
		// Authorized Representative 2 Information
		STRING5   _Rep2_NameTitle      := search.AuthorizedRep2.Name.Prefix;
		STRING120 _Rep2_FullName       := search.AuthorizedRep2.Name.Full;
		STRING20  _Rep2_FirstName      := search.AuthorizedRep2.Name.First;
		STRING20  _Rep2_MiddleName     := search.AuthorizedRep2.Name.Middle;
		STRING20  _Rep2_LastName       := search.AuthorizedRep2.Name.Last;
		STRING5   _Rep2_NameSuffix     := search.AuthorizedRep2.Name.Suffix;
		STRING20  _Rep2_FormerLastName := search.AuthorizedRep2.FormerLastName;
		STRING120 _Rep2_StreetAddress1 := 
				IF( search.AuthorizedRep2.Address.StreetAddress1 = '', 
						Address.Addr1FromComponents(search.AuthorizedRep2.Address.StreetNumber, search.AuthorizedRep2.Address.StreetPreDirection, search.AuthorizedRep2.Address.StreetName, search.AuthorizedRep2.Address.StreetSuffix, search.AuthorizedRep2.Address.StreetPostDirection, search.AuthorizedRep2.Address.UnitDesignation, search.AuthorizedRep2.Address.UnitNumber),
						search.AuthorizedRep2.Address.StreetAddress1 );
		STRING120 _Rep2_StreetAddress2 := search.AuthorizedRep2.Address.StreetAddress2;
		STRING25  _Rep2_City           := search.AuthorizedRep2.Address.City;
		STRING2   _Rep2_State          := search.AuthorizedRep2.Address.State;
		STRING9   _Rep2_Zip            := search.AuthorizedRep2.Address.Zip5;
		STRING9   _Rep2_SSN            := search.AuthorizedRep2.SSN;
		STRING8   _Rep2_DateOfBirth    := iesp.ECL2ESP.t_DateToString8(search.AuthorizedRep2.DOB);
		STRING3   _Rep2_Age            := search.AuthorizedRep2.Age;
		STRING25  _Rep2_DLNumber       := search.AuthorizedRep2.DriverLicenseNumber;
		STRING2   _Rep2_DLState        := search.AuthorizedRep2.DriverLicenseState;
		STRING10  _Rep2_Phone10        := search.AuthorizedRep2.Phone;
		STRING100 _Rep2_Email          := search.AuthorizedRep2.Email;
		UNSIGNED6 _Rep2_LexID          := (UNSIGNED6)search.AuthorizedRep2.UniqueID;
		
		// Authorized Representative 3 Information
		STRING5   _Rep3_NameTitle      := search.AuthorizedRep3.Name.Prefix;
		STRING120 _Rep3_FullName       := search.AuthorizedRep3.Name.Full;
		STRING20  _Rep3_FirstName      := search.AuthorizedRep3.Name.First;
		STRING20  _Rep3_MiddleName     := search.AuthorizedRep3.Name.Middle;
		STRING20  _Rep3_LastName       := search.AuthorizedRep3.Name.Last;
		STRING5   _Rep3_NameSuffix     := search.AuthorizedRep3.Name.Suffix;
		STRING20  _Rep3_FormerLastName := search.AuthorizedRep3.FormerLastName;
		STRING120 _Rep3_StreetAddress1 := 
				IF( search.AuthorizedRep3.Address.StreetAddress1 = '', 
						Address.Addr1FromComponents(search.AuthorizedRep3.Address.StreetNumber, search.AuthorizedRep3.Address.StreetPreDirection, search.AuthorizedRep3.Address.StreetName, search.AuthorizedRep3.Address.StreetSuffix, search.AuthorizedRep3.Address.StreetPostDirection, search.AuthorizedRep3.Address.UnitDesignation, search.AuthorizedRep3.Address.UnitNumber),
						search.AuthorizedRep3.Address.StreetAddress1 );
		STRING120 _Rep3_StreetAddress2 := search.AuthorizedRep3.Address.StreetAddress2;
		STRING25  _Rep3_City           := search.AuthorizedRep3.Address.City;
		STRING2   _Rep3_State          := search.AuthorizedRep3.Address.State;
		STRING9   _Rep3_Zip            := search.AuthorizedRep3.Address.Zip5;
		STRING9   _Rep3_SSN            := search.AuthorizedRep3.SSN;
		STRING8   _Rep3_DateOfBirth    := iesp.ECL2ESP.t_DateToString8(search.AuthorizedRep3.DOB);
		STRING3   _Rep3_Age            := search.AuthorizedRep3.Age;
		STRING25  _Rep3_DLNumber       := search.AuthorizedRep3.DriverLicenseNumber;
		STRING2   _Rep3_DLState        := search.AuthorizedRep3.DriverLicenseState;
		STRING10  _Rep3_Phone10        := search.AuthorizedRep3.Phone;
		STRING100 _Rep3_Email          := search.AuthorizedRep3.Email;
		UNSIGNED6 _Rep3_LexID          := (UNSIGNED6)search.AuthorizedRep3.UniqueID;
		
		// Authorized Representative 4 Information
		STRING5   _Rep4_NameTitle      := search.AuthorizedRep4.Name.Prefix;
		STRING120 _Rep4_FullName       := search.AuthorizedRep4.Name.Full;
		STRING20  _Rep4_FirstName      := search.AuthorizedRep4.Name.First;
		STRING20  _Rep4_MiddleName     := search.AuthorizedRep4.Name.Middle;
		STRING20  _Rep4_LastName       := search.AuthorizedRep4.Name.Last;
		STRING5   _Rep4_NameSuffix     := search.AuthorizedRep4.Name.Suffix;
		STRING20  _Rep4_FormerLastName := search.AuthorizedRep4.FormerLastName;
		STRING120 _Rep4_StreetAddress1 := 
				IF( search.AuthorizedRep4.Address.StreetAddress1 = '', 
						Address.Addr1FromComponents(search.AuthorizedRep4.Address.StreetNumber, search.AuthorizedRep4.Address.StreetPreDirection, search.AuthorizedRep4.Address.StreetName, search.AuthorizedRep4.Address.StreetSuffix, search.AuthorizedRep4.Address.StreetPostDirection, search.AuthorizedRep4.Address.UnitDesignation, search.AuthorizedRep4.Address.UnitNumber),
						search.AuthorizedRep4.Address.StreetAddress1 );
		STRING120 _Rep4_StreetAddress2 := search.AuthorizedRep4.Address.StreetAddress2;
		STRING25  _Rep4_City           := search.AuthorizedRep4.Address.City;
		STRING2   _Rep4_State          := search.AuthorizedRep4.Address.State;
		STRING9   _Rep4_Zip            := search.AuthorizedRep4.Address.Zip5;
		STRING9   _Rep4_SSN            := search.AuthorizedRep4.SSN;
		STRING8   _Rep4_DateOfBirth    := iesp.ECL2ESP.t_DateToString8(search.AuthorizedRep4.DOB);
		STRING3   _Rep4_Age            := search.AuthorizedRep4.Age;
		STRING25  _Rep4_DLNumber       := search.AuthorizedRep4.DriverLicenseNumber;
		STRING2   _Rep4_DLState        := search.AuthorizedRep4.DriverLicenseState;
		STRING10  _Rep4_Phone10        := search.AuthorizedRep4.Phone;
		STRING100 _Rep4_Email          := search.AuthorizedRep4.Email;
		UNSIGNED6 _Rep4_LexID          := (UNSIGNED6)search.AuthorizedRep4.UniqueID;
		
		// Authorized Representative 5 Information
		STRING5   _Rep5_NameTitle      := search.AuthorizedRep5.Name.Prefix;
		STRING120 _Rep5_FullName       := search.AuthorizedRep5.Name.Full;
		STRING20  _Rep5_FirstName      := search.AuthorizedRep5.Name.First;
		STRING20  _Rep5_MiddleName     := search.AuthorizedRep5.Name.Middle;
		STRING20  _Rep5_LastName       := search.AuthorizedRep5.Name.Last;
		STRING5   _Rep5_NameSuffix     := search.AuthorizedRep5.Name.Suffix;
		STRING20  _Rep5_FormerLastName := search.AuthorizedRep5.FormerLastName;
		STRING120 _Rep5_StreetAddress1 := 
				IF( search.AuthorizedRep5.Address.StreetAddress1 = '', 
						Address.Addr1FromComponents(search.AuthorizedRep5.Address.StreetNumber, search.AuthorizedRep5.Address.StreetPreDirection, search.AuthorizedRep5.Address.StreetName, search.AuthorizedRep5.Address.StreetSuffix, search.AuthorizedRep5.Address.StreetPostDirection, search.AuthorizedRep5.Address.UnitDesignation, search.AuthorizedRep5.Address.UnitNumber),
						search.AuthorizedRep5.Address.StreetAddress1 );
		STRING120 _Rep5_StreetAddress2 := search.AuthorizedRep5.Address.StreetAddress2;
		STRING25  _Rep5_City           := search.AuthorizedRep5.Address.City;
		STRING2   _Rep5_State          := search.AuthorizedRep5.Address.State;
		STRING9   _Rep5_Zip            := search.AuthorizedRep5.Address.Zip5;
		STRING9   _Rep5_SSN            := search.AuthorizedRep5.SSN;
		STRING8   _Rep5_DateOfBirth    := iesp.ECL2ESP.t_DateToString8(search.AuthorizedRep5.DOB);
		STRING3   _Rep5_Age            := search.AuthorizedRep5.Age;
		STRING25  _Rep5_DLNumber       := search.AuthorizedRep5.DriverLicenseNumber;
		STRING2   _Rep5_DLState        := search.AuthorizedRep5.DriverLicenseState;
		STRING10  _Rep5_Phone10        := search.AuthorizedRep5.Phone;
		STRING100 _Rep5_Email          := search.AuthorizedRep5.Email;
		UNSIGNED6 _Rep5_LexID          := (UNSIGNED6)search.AuthorizedRep5.UniqueID;	
	ENDMACRO;
	
	EXPORT mac_ReadOptions() := MACRO
		// Can't have duplicate definitions of Stored with different default values, 
		// so add the default to #stored to eliminate the assignment of a default value.
		// Fixes "Duplicate definition of STORED('datarestrictionmask') with different type 
		// (use #stored to override default value)" error.
		#STORED('DPPAPurpose', Business_Risk_BIP.Constants.Default_DPPA);
		#STORED('GLBPurpose',  Business_Risk_BIP.Constants.Default_GLBA);
		#STORED('DataRestrictionMask',Business_Risk_BIP.Constants.Default_DataRestrictionMask);
		#STORED('DataPermissionMask' ,Business_Risk_BIP.Constants.Default_DataPermissionMask);
		
		UNSIGNED1 DPPAPurpose_stored      := Business_Risk_BIP.Constants.Default_DPPA                : STORED('DPPAPurpose');
		UNSIGNED1 GLBPurpose_stored       := Business_Risk_BIP.Constants.Default_GLBA                : STORED('GLBPurpose');
		STRING DataRestrictionMask_stored := Business_Risk_BIP.Constants.Default_DataRestrictionMask : STORED('DataRestrictionMask');
		STRING DataPermissionMask_stored  := Business_Risk_BIP.Constants.Default_DataPermissionMask  : STORED('DataPermissionMask');
		UNSIGNED BIID20ProductType_stored := BusinessInstantID20_Services.Types.productTypeEnum.BASE : STORED('BIID20ProductType');
		
		// Read from either the root (as Stored) or the User section in the XML Request.
		UNSIGNED1	_DPPA_Purpose        := IF(TRIM(users.DLPurpose) != ''     , (INTEGER)users.DLPurpose , DPPAPurpose_stored);
		UNSIGNED1	_GLBA_Purpose        := IF(TRIM(users.GLBPurpose) != ''    , (INTEGER)users.GLBPurpose, GLBPurpose_stored);
		STRING    _DataRestrictionMask := IF( users.DataRestrictionMask != '', users.DataRestrictionMask, DataRestrictionMask_stored );
		STRING    __DataPermissionMask := IF( users.DataPermissionMask != '' , users.DataPermissionMask , DataPermissionMask_stored );
		STRING5	  _IndustryClass       := MAP( users.IndustryClass != '' => users.IndustryClass, option.IndustryClass != '' => option.IndustryClass, Business_Risk_BIP.Constants.Default_IndustryClass );
		BOOLEAN   _TestData_Enabled    := users.TestDataEnabled OR option.TestDataEnabled;
		STRING    _TestData_TableName  := IF( users.TestDataTableName != '', users.TestDataTableName, option.TestDataTableName );

		// Read from the "option" section in the XML Request. Specify default values where necessary 
		// when no meaningful value is present.
		UNSIGNED1	_LinkSearchLevel                 := IF( option.LinkSearchLevel = 0         , Business_Risk_BIP.Constants.LinkSearch.Default         , option.LinkSearchLevel );
		UNSIGNED1	_MarketingMode                   := IF( option.MarketingMode = 0           , Business_Risk_BIP.Constants.Default_MarketingMode      , option.MarketingMode );
		UNSIGNED1	_BusShellVersion                 := IF( option.BusShellVersion = 0         , Business_Risk_BIP.Constants.BusShellVersion_v22        , option.BusShellVersion );
		STRING50	_AllowedSources                  := IF( option.AllowedSources = ''         , Business_Risk_BIP.Constants.Default_AllowedSources     , option.AllowedSources );
		UNSIGNED1 _OFAC_Version                    := IF( option.OFACVersion = 0             , BusinessInstantID20_Services.Constants.DEFAULT_OFAC_VERSION, option.OFACVersion );
		REAL      _Global_Watchlist_Threshold      := IF( option.GlobalWatchlistThreshold = 0, Business_Risk_BIP.Constants.Default_Global_Watchlist_Threshold, option.GlobalWatchlistThreshold );
		UNSIGNED6	_HistoryDate                     := IF( option.HistoryDate = 0             , 999999, option.HistoryDate );
		UNSIGNED  _BIID20ProductType               := IF( option.BIID20ProductType = 0       , BIID20ProductType_stored, option.BIID20ProductType );
		UNSIGNED1 _BIPBestAppend                   := option.BIPBestAppend;
		BOOLEAN   _DisableIntermediateShellLogging := option.OutcomeTrackingOptOut;
		BOOLEAN   _include_ofac                    := TRUE; // Always run OFAC
		BOOLEAN   _include_additional_watchlists   := _BIID20ProductType IN [BusinessInstantID20_Services.Types.productTypeEnum.COMPLIANCE, BusinessInstantID20_Services.Types.productTypeEnum.COMPLIANCE_PLUS_SBFE]; 
		DATASET(iesp.share.t_StringArrayItem) _Watchlists_Requested := option.WatchlistsRequested;
		DATASET(iesp.businessinstantid20.t_BIID20Gateway) _Gateways  := option.Gateways;
    
    STRING    _DataPermissionMask := BusinessInstantID20_Services.fn_setSBFEBitInDataPermissionMask(__DataPermissionMask, _BIID20ProductType); 
				
		// Per Product Mgmt guidance:
		//   o  turn off Gateway calls to Targus
		//   o  don't ever override the Experian Restriction
		BOOLEAN   _IncludeTargusGateway := FALSE;
		BOOLEAN   _RunTargusGateway     := FALSE;
		BOOLEAN   _OverRideExperianRestriction := option.OverRideExperianRestriction;
		
		_CompanyID := IF( users.CompanyID != ''     , users.CompanyID     , option.CompanyID );
		_Login_ID  := IF( users.LoginHistoryId != '', users.LoginHistoryId, option.LoginID );
		_DOBMask   := IF( users.DOBMask != ''       , users.DOBMask       , option.DOBMask );
		_SSNMask   := IF( users.SSNMask != ''       , users.SSNMask       , option.SSNMask );
    
		// The following #STORED( ) attributes will be read directly within 
		// BusinessInstantID20_Services.fn_GetConsumerInstantIDRecs( ):
		#STORED('CompanyID'                        , _CompanyID);
		#STORED('LoginID'                          , _Login_ID);
		#STORED('DisableCustomerNetworkOptionInCVI', option.DisableCustomerNetworkOptionInCVI);
		#STORED('DLMask'                           , users.DLMask OR option.DLMask);
		#STORED('DOBMask'                          , _DOBMask);
		#STORED('DOBMatchOptions'                  , option.DOBMatchOptions);
		#STORED('DOBRadius'                        , option.DOBRadius);
		#STORED('EnableEmergingID'                 , option.EnableEmergingID);
		#STORED('ExactAddrMatch'                   , option.ExactAddrMatch);
		#STORED('ExactDOBMatch'                    , option.ExactDOBMatch);
		#STORED('ExactDriverLicenseMatch'          , option.ExactDriverLicenseMatch);
		#STORED('ExactFirstNameMatch'              , option.ExactFirstNameMatch);
		#STORED('ExactFirstNameMatchAllowNicknames', option.ExactFirstNameMatchAllowNicknames);
		#STORED('ExactLastNameMatch'               , option.ExactLastNameMatch);
		#STORED('ExactPhoneMatch'                  , option.ExactPhoneMatch);
		#STORED('ExactSSNMatch'                    , option.ExactSSNMatch);
		#STORED('ExcludeWatchLists'                , option.ExcludeWatchLists);
		#STORED('IIDVersionOverride'               , option.IIDVersionOverride);
		#STORED('IncludeAdditionalWatchLists'      , option.IncludeAdditionalWatchLists);
		#STORED('IncludeAllRiskIndicators'         , option.IncludeAllRiskIndicators);
		#STORED('IncludeCLOverride'                , option.IncludeCLOverride);
		#STORED('IncludeDLVerification'            , option.IncludeDLVerification);
		#STORED('IncludeDOBinCVI'                  , option.IncludeDOBinCVI);
		#STORED('IncludeDPBC'                      , option.IncludeDPBC);
		#STORED('IncludeDriverLicenseInCVI'        , option.IncludeDriverLicenseInCVI);
		#STORED('IncludeMIoverride'                , option.IncludeMIoverride);
		#STORED('IncludeMSoverride'                , option.IncludeMSoverride);
		#STORED('IncludeOfac'                      , option.IncludeOfac);
		#STORED('IncludeTargusE3220Gateway'        , option.IncludeTargusE3220);
		#STORED('InstantIDVersion'                 , option.InstantIDVersion);
		#STORED('LastSeenThreshold'                , option.LastSeenThreshold);
		#STORED('NameInputOrder'                   , option.NameInputOrder);
		#STORED('OfacOnly'                         , option.OfacOnly);
		#STORED('PoBoxCompliance'                  , option.PoBoxCompliance);
		#STORED('SSNMask'                          , _SSNMask);
		#STORED('UseDOBFilter'                     , option.UseDOBFilter);
	ENDMACRO;

	EXPORT mac_ReadOptionsBatch() := MACRO
		// Can't have duplicate definitions of Stored with different default values, 
		// so add the default to #stored to eliminate the assignment of a default value.
		// Fixes "Duplicate definition of STORED('datarestrictionmask') with different type 
		// (use #stored to override default value)" error.
		#STORED('DataRestrictionMask',Business_Risk_BIP.Constants.Default_DataRestrictionMask);
		#STORED('DataPermissionMask' ,Business_Risk_BIP.Constants.Default_DataPermissionMask);
		#STORED('DPPAPurpose'        ,Business_Risk_BIP.Constants.Default_DPPA);
		#STORED('GLBPurpose'         ,Business_Risk_BIP.Constants.Default_GLBA);
		#STORED('IndustryClass'      ,Business_Risk_BIP.Constants.Default_IndustryClass);
		#STORED('OFAC_Version'       ,BusinessInstantID20_Services.Constants.DEFAULT_OFAC_VERSION);
		#STORED('Global_Watchlist_Threshold',Business_Risk_BIP.Constants.Default_Global_Watchlist_Threshold);

		UNSIGNED1 DPPAPurpose_stored      := Business_Risk_BIP.Constants.Default_DPPA                : STORED('DPPAPurpose');
		UNSIGNED1 GLBPurpose_stored       := Business_Risk_BIP.Constants.Default_GLBA                : STORED('GLBPurpose');
		STRING DataRestrictionMask_stored := Business_Risk_BIP.Constants.Default_DataRestrictionMask : STORED('DataRestrictionMask');
		STRING DataPermissionMask_stored  := Business_Risk_BIP.Constants.Default_DataPermissionMask  : STORED('DataPermissionMask');
		STRING5 IndustryClass_stored      := Business_Risk_BIP.Constants.Default_IndustryClass       : STORED('IndustryClass');
		UNSIGNED1 OFAC_Version_stored     := Business_Risk_BIP.Constants.Default_OFAC_Version        : STORED('OFAC_Version');
		REAL Global_Watchlist_Threshold_stored := Business_Risk_BIP.Constants.Default_Global_Watchlist_Threshold : STORED('Global_Watchlist_Threshold');

		_Gateways := Gateway.Configuration.Get();	// Gateways Coded in this Product: Targus

		BusinessInstantID20_Services.Types.productTypeEnum  _BIID20ProductType := BusinessInstantID20_Services.Types.productTypeEnum.BASE : STORED('BIID20ProductType');
		UNSIGNED1	_DPPA_Purpose        := DPPAPurpose_stored;
		UNSIGNED1	_GLBA_Purpose        := GLBPurpose_stored;
		STRING  	_DataRestrictionMask := DataRestrictionMask_stored;
		STRING  	_DataPermissionMask  := BusinessInstantID20_Services.fn_setSBFEBitInDataPermissionMask(DataPermissionMask_stored, _BIID20ProductType);
		STRING5	  _IndustryClass       := STD.Str.ToUpperCase(TRIM( IndustryClass_stored, LEFT, RIGHT ));
		UNSIGNED6	_HistoryDate         := 999999 : STORED('HistoryDate');
		UNSIGNED1	_LinkSearchLevel     := Business_Risk_BIP.Constants.LinkSearch.Default : STORED('LinkSearchLevel');
		UNSIGNED1	_MarketingMode       := Business_Risk_BIP.Constants.Default_MarketingMode : STORED('MarketingMode');
		UNSIGNED1	_BusShellVersion     := Business_Risk_BIP.Constants.BusShellVersion_v22 : STORED('BusShellVersion');
		STRING50	_AllowedSources      := Business_Risk_BIP.Constants.Default_AllowedSources : STORED('AllowedSources');
		UNSIGNED1 _BIPBestAppend       := Business_Risk_BIP.Constants.BIPBestAppend.Default : STORED('BIPBestAppend');
		UNSIGNED1 _OFAC_Version        := OFAC_Version_stored;
		// Per Product Mgmt guidance, turn off Gateway calls to Targus.
		BOOLEAN   _IncludeTargusGateway          := FALSE; //  : STORED('IncludeTargusGateway');
		BOOLEAN   _RunTargusGateway              := FALSE : STORED('RunTargusGatewayAnywayForTesting');
		BOOLEAN   _OverRideExperianRestriction   := FALSE : STORED('OverRideExperianRestriction');
		REAL      _Global_Watchlist_Threshold    := Global_Watchlist_Threshold_stored;
		BOOLEAN		_include_ofac                  := TRUE; // Always run OFAC
		BOOLEAN   _DisableIntermediateShellLogging := TRUE;
		BOOLEAN   _include_additional_watchlists := _BIID20ProductType IN [BusinessInstantID20_Services.Types.productTypeEnum.COMPLIANCE, BusinessInstantID20_Services.Types.productTypeEnum.COMPLIANCE_PLUS_SBFE];
		BOOLEAN   _ReturnDetailedRoyalties := FALSE : STORED('ReturnDetailedRoyalties');
		
		// The following attributes are included in the service interface by requirement, but aren't used yet.
		BOOLEAN   _IncludeBridgerXG5Gateway := FALSE : STORED('IncludeBridgerXG5Gateway');
		STRING20  _ModelName1 := '' : STORED('ModelName1');
		STRING20  _ModelName2 := '' : STORED('ModelName2');
		STRING20  _ModelName3 := '' : STORED('ModelName3');
		STRING20  _ModelName4 := '' : STORED('ModelName4');
		STRING20  _ModelName5 := '' : STORED('ModelName5');
	ENDMACRO;
	
	EXPORT mac_LoadInput() := MACRO
		BusinessInstantID20_Services.layouts.InputCompanyAndAuthRepInfo xfm_LoadInput := TRANSFORM
			SELF.Seq            := _Seq;
			SELF.AcctNo         := _AcctNo;		
			SELF.HistoryDate    := _HistoryDate;
			SELF.CompanyName    := _CompanyName;
			SELF.AltCompanyName := _AltCompanyName;
			SELF.StreetAddress1 := _StreetAddress1;
			SELF.StreetAddress2 := _StreetAddress2;
			SELF.City           := _City;
			SELF.State          := _State;
			SELF.Zip            := _Zip;
			SELF.FEIN           := _FEIN;
			SELF.Phone10        := _Phone10;
			SELF.Fax_Number     := '';
			SELF.AuthReps := 
					DATASET(
						[
							{ 1,_Rep1_NameTitle,_Rep1_FullName,_Rep1_FirstName,_Rep1_MiddleName,_Rep1_LastName,_Rep1_NameSuffix,_Rep1_FormerLastName,_Rep1_StreetAddress1,_Rep1_StreetAddress2,_Rep1_City,_Rep1_State,_Rep1_Zip,_Rep1_SSN,_Rep1_DateOfBirth,_Rep1_Age,_Rep1_DLNumber,_Rep1_DLState,_Rep1_Phone10,_Rep1_Email,_Rep1_LexID },
							{ 2,_Rep2_NameTitle,_Rep2_FullName,_Rep2_FirstName,_Rep2_MiddleName,_Rep2_LastName,_Rep2_NameSuffix,_Rep2_FormerLastName,_Rep2_StreetAddress1,_Rep2_StreetAddress2,_Rep2_City,_Rep2_State,_Rep2_Zip,_Rep2_SSN,_Rep2_DateOfBirth,_Rep2_Age,_Rep2_DLNumber,_Rep2_DLState,_Rep2_Phone10,_Rep2_Email,_Rep2_LexID },
							{ 3,_Rep3_NameTitle,_Rep3_FullName,_Rep3_FirstName,_Rep3_MiddleName,_Rep3_LastName,_Rep3_NameSuffix,_Rep3_FormerLastName,_Rep3_StreetAddress1,_Rep3_StreetAddress2,_Rep3_City,_Rep3_State,_Rep3_Zip,_Rep3_SSN,_Rep3_DateOfBirth,_Rep3_Age,_Rep3_DLNumber,_Rep3_DLState,_Rep3_Phone10,_Rep3_Email,_Rep3_LexID },
							{ 4,_Rep4_NameTitle,_Rep4_FullName,_Rep4_FirstName,_Rep4_MiddleName,_Rep4_LastName,_Rep4_NameSuffix,_Rep4_FormerLastName,_Rep4_StreetAddress1,_Rep4_StreetAddress2,_Rep4_City,_Rep4_State,_Rep4_Zip,_Rep4_SSN,_Rep4_DateOfBirth,_Rep4_Age,_Rep4_DLNumber,_Rep4_DLState,_Rep4_Phone10,_Rep4_Email,_Rep4_LexID },
							{ 5,_Rep5_NameTitle,_Rep5_FullName,_Rep5_FirstName,_Rep5_MiddleName,_Rep5_LastName,_Rep5_NameSuffix,_Rep5_FormerLastName,_Rep5_StreetAddress1,_Rep5_StreetAddress2,_Rep5_City,_Rep5_State,_Rep5_Zip,_Rep5_SSN,_Rep5_DateOfBirth,_Rep5_Age,_Rep5_DLNumber,_Rep5_DLState,_Rep5_Phone10,_Rep5_Email,_Rep5_LexID }
						],
						BusinessInstantID20_Services.Layouts.InputAuthRepInfo
					);
		END;
	ENDMACRO;
	
	EXPORT mac_AppendAddrData() := MACRO
		SELF.Prim_Range  := mod_Addr.Prim_Range;
		SELF.Predir      := mod_Addr.Predir;
		SELF.Prim_Name   := mod_Addr.Prim_Name;
		SELF.Addr_Suffix := mod_Addr.Addr_Suffix;
		SELF.Postdir     := mod_Addr.Postdir;
		SELF.Unit_Desig  := mod_Addr.Unit_Desig;
		SELF.Sec_Range   := mod_Addr.Sec_Range;
		SELF.P_City_Name := mod_Addr.P_City_Name;
		SELF.V_City_Name := mod_Addr.V_City_Name;
		SELF.St          := mod_Addr.St;
		SELF.Zip5        := mod_Addr.Zip;
		SELF.Zip4        := mod_Addr.Zip4;
		SELF.Lat         := mod_Addr.Geo_Lat;
		SELF.Long        := mod_Addr.Geo_Long;
		SELF.Addr_Type   := mod_Addr.Rec_Type;
		SELF.Addr_Status := mod_Addr.Err_Stat;
		SELF.County      := _CleanAddr[143..145];  // Address.CleanFields(clean_addr).county returns the full 5 character fips, we only want the county fips
		SELF.Geo_Block   := mod_Addr.Geo_Blk;			
	ENDMACRO;	
	
END;