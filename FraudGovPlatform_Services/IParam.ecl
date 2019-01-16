IMPORT BatchShare, FraudShared, Gateway, risk_indicators, riskwise, UT;

EXPORT IParam := MODULE
  
  EXPORT BatchParams := INTERFACE (BatchShare.IParam.BatchParams)
		EXPORT boolean   AppendBest := true;
		EXPORT boolean   TestVelocityRules := false;
		EXPORT boolean   IsOnline := false;
		EXPORT boolean 	 UseAllSearchFields;
		EXPORT string60  ReportEntityType;
		EXPORT UNSIGNED3 DIDScoreThreshold;
		EXPORT unsigned6 GlobalCompanyId;	// company (agency)
		EXPORT unsigned2 IndustryType;	// company (agency) program code i.e. 1292, 1321 etc..
		EXPORT string 	 IndustryTypeName; // company (agency) program code i.e. SNAP, UNEMPLOYMENT, MEDICAID, etc..
		EXPORT unsigned6 ProductCode;
		EXPORT string    AgencyVerticalType;	// agency vertical type i.e. Tax, Health, Labor, etc..
		EXPORT string18  AgencyCounty;	// agency location
		EXPORT string2   AgencyState;	// agency location
		EXPORT DATASET	(Gateway.Layouts.Config)	Gateways := dataset ([], Gateway.Layouts.Config);
		EXPORT integer 	 MaxVelocities;
		EXPORT integer 	 MaxKnownFrauds;
		EXPORT string		 FraudPlatform;
		EXPORT boolean   ReturnDetailedRoyalties;
		EXPORT string6 	 DOBMask := 'NONE';
		
		//InstantID
		EXPORT boolean IIDVersionOverride;
		EXPORT string1 IIDVersion := '0';
		EXPORT boolean EnableEmergingID;
		EXPORT unsigned1 lowestAllowedVersion;	
		EXPORT unsigned1 maxAllowedVersion;
		EXPORT boolean IsInstantID;
		EXPORT DATASET(riskwise.layouts.reasoncode_settings) reasoncode_settings;
		EXPORT boolean IsPOBoxCompliant;
		EXPORT DATASET(riskwise.layouts.actioncode_settings) actioncode_settings ;
		EXPORT boolean IncludeDPBC;
		EXPORT boolean IncludeMIoverride;
		EXPORT boolean IncludeDOBinCVI;
		EXPORT boolean IncludeDriverLicenseInCVI;
		EXPORT boolean DisableInquiriesInCVI;
		EXPORT boolean IncludeDLverification;
		EXPORT boolean IncludeMSoverride;
		EXPORT boolean IncludeCLoverride;
		EXPORT boolean   IncludeAllRiskIndicators;
		EXPORT unsigned1 NumReturnCodes;
		EXPORT boolean OFAC;
		EXPORT boolean	IncludeTargus;	
		EXPORT boolean IncludeTargus3220;
		EXPORT boolean ln_branded_value;
		EXPORT unsigned1 RedFlag_version;		
		EXPORT unsigned actualIIDVersion;
		EXPORT	unsigned3 history_date;			
		EXPORT string3 NameInputOrder;
		EXPORT string20 search_type;
  END;

  // **************************************************************************************
  //   This is where the service options should be read from #store.
  //   The module parameter should be passed along to the underlying attributes.
  // **************************************************************************************      
	EXPORT getBatchParams() := FUNCTION

		IndustryType_Name := '' : STORED('IndustryTypeName');
		IndustryTypeCode := FraudShared.Key_MbsFdnIndType(FraudGovPlatform_Services.Constants.FRAUD_PLATFORM)
																			(keyed(description = ut.CleanSpacesAndUpper(IndustryType_Name)))[1].ind_type;
		
		base_params := BatchShare.IParam.getBatchParams();
		in_mod := MODULE(PROJECT(base_params, BatchParams, OPT))
			EXPORT boolean   TestVelocityRules	:= false: STORED('TestVelocityRules'); // this option is internal to roxie. added to toggle between test/actual velocity rules. 
			EXPORT boolean   AppendBest 				:= true	: STORED('AppendBest');
			EXPORT boolean   IsOnline 					:= false: STORED('IsOnline');
			EXPORT boolean   UseAllSearchFields := false: STORED('UseAllSearchFields');
			EXPORT string60  ReportEntityType 	:= ''		: STORED('ReportEntityType');
			EXPORT unsigned3 DIDScoreThreshold  := 80		: STORED('DIDScoreThreshold');
			EXPORT unsigned6 GlobalCompanyId    := 0		: STORED('GlobalCompanyId');
			EXPORT unsigned2 IndustryType       := IndustryTypeCode;
			EXPORT string 	 IndustryTypeName   := IndustryType_Name;
			EXPORT unsigned6 ProductCode        := 0		: STORED('ProductCode');
			EXPORT string 	 AgencyVerticalType := ''		: STORED('AgencyVerticalType');
			EXPORT string18  AgencyCounty       := ''		: STORED('AgencyCounty');
			EXPORT string2   AgencyState        := ''		: STORED('AgencyState');
			EXPORT integer   MaxVelocities      := FraudGovPlatform_Services.Constants.MAX_VELOCITIES : STORED('MaxVelocities');
			EXPORT integer   MaxKnownFrauds     := FraudGovPlatform_Services.Constants.MAX_KNOWN_FRAUDS : STORED('MaxKnownFrauds');
			EXPORT string    FraudPlatform			:= FraudGovPlatform_Services.Constants.FRAUD_PLATFORM : STORED('FraudPlatform');
			EXPORT BOOLEAN   ReturnDetailedRoyalties := false : STORED('ReturnDetailedRoyalties');
			EXPORT DATASET(Gateway.Layouts.Config) Gateways	:= 	dataset ([], Gateway.Layouts.Config) : STORED('Gateways');
			EXPORT string6 	 DOBMask := 'NONE' : STORED('DOBMask');

			//InstantID
			EXPORT boolean IIDVersionOverride := FALSE	: STORED('IIDVersionOverride');	// back office tag that, if true, allows a version lower than the lowestAllowedVersion
			EXPORT string1 IIDVersion := '0' : STORED('InstantIDVersion');	// this is passed in by the customer, if nothing passed in, then 0
			EXPORT boolean EnableEmergingID := FALSE : stored('EnableEmergingID');

			EXPORT unsigned1 lowestAllowedVersion := FraudGovPlatform_Services.Constants.lowestAllowedVersion;	// lowest allowed version according to product, unless the IIDVersionOveride is true
			EXPORT unsigned1 maxAllowedVersion := FraudGovPlatform_Services.Constants.lowestAllowedVersion;	// maximum allowed version as of 1/28/2014

			EXPORT actualIIDVersion := MAP(	(unsigned1)IIDVersion > maxAllowedVersion => 99,	// they asked for a version that doesn't exist
																			IIDVersionOverride = false => MIN(MAX((unsigned1)IIDversion, lowestAllowedVersion), maxAllowedVersion),	// choose the higher of the allowed or asked for because they can't override lowestAllowedVersion, however, don't let them pick a version that is higher than the highest one we currently support
																			(unsigned1)IIDversion); // they can override, give them whatever they asked for
			EXPORT boolean IsInstantID := FraudGovPlatform_Services.Constants.IsInstantID;
			EXPORT DATASET(riskwise.layouts.reasoncode_settings) reasoncode_settings := DATASET([{IsInstantID, actualIIDVersion, EnableEmergingID}],riskwise.layouts.reasoncode_settings);
			EXPORT boolean IsPOBoxCompliant := false : STORED('PoBoxCompliance');
			EXPORT DATASET(riskwise.layouts.actioncode_settings) actioncode_settings := DATASET([{IsPOBoxCompliant, IsInstantID}],riskwise.layouts.actioncode_settings);

			EXPORT boolean IncludeDPBC := false : STORED('IncludeDPBC');
			EXPORT boolean IncludeMIoverride := false : STORED('IncludeMIoverride');
			EXPORT boolean IncludeDOBinCVI := false: STORED('IncludeDOBInCVI');
			EXPORT boolean IncludeDriverLicenseInCVI := false	: STORED('IncludeDriverLicenseInCVI');
			EXPORT boolean DisableInquiriesInCVI := false	: STORED('DisableInquiriesInCVI');

			EXPORT boolean IncludeDLverification := false : STORED('IncludeDLverification');
			EXPORT boolean IncludeMSoverride := false : STORED('IncludeMSoverride');
			EXPORT boolean IncludeCLoverride := false : STORED('IncludeCLoverride');
			EXPORT boolean   IncludeAllRiskIndicators := false	: STORED('IncludeAllRiskIndicators');
			EXPORT unsigned1 NumReturnCodes := IF(IncludeAllRiskIndicators, 20, risk_indicators.iid_constants.DefaultNumCodes);
			EXPORT boolean OFAC := FraudGovPlatform_Services.Constants.ofac;
			EXPORT boolean	IncludeTargus := TRUE	: STORED('Targus');	
			EXPORT boolean IncludeTargus3220 := FALSE : STORED('IncludeTargusE3220');
			EXPORT boolean ln_branded_value := FALSE : STORED('LnBranded');
			EXPORT unsigned1 RedFlag_version := 1 : STORED('RedFlag_version');		
			EXPORT	unsigned3 history_date := 999999 : STORED('HistoryDateYYYYMM');			
			EXPORT string3 NameInputOrder := '' : STORED('NameInputOrder');	// sequence of name (FML = First/Middle/Last, LFM = Last/First/Middle) if not specified, uses default name parser
			EXPORT string20 search_type := 'BOTH' : STORED('search_type');
			
			//Following fields are specific to FraudGovPlatform_Services.SearchService.
			EXPORT string10 ProgramCode := '' : STORED('ProgramCode');
			EXPORT string20 HouseholdId := '' : STORED('HouseholdId');
			EXPORT string25 MACAddress 	:= '': STORED('MACAddress');
			EXPORT string12 AmountMin := '' : STORED('AmountMin');
			EXPORT string12 AmountMax := '' : STORED('AmountMax');
			EXPORT string100 BankName := '' : STORED('BankName');
			EXPORT string25 ISPName 	:= ''   : STORED('ISPName');
			EXPORT string20 CustomerPersonId := '' : STORED('CustomerPersonId');
			EXPORT string8 TransactionStartDate := '' : STORED('TransactionStartDate');
			EXPORT string8 TransactionEndDate := '' : STORED('TransactionEndDate');
			EXPORT string20 DeviceSerialNumber := '' : STORED('DeviceSerialNumber');
		END;
		
		RETURN in_mod;
	END;  
END;
