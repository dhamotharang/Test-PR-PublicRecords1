//--INFO-- Contains InsurView2 Attributes, version 5.0 and higher

/*--SOAP--
<message name="FcraInsurView2_Service">
		<part name="FCRAInsurView2AttributesRequest" type="tns:XmlDataSet" cols="80"
  	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
		<part name="gateways" type="tns:XmlDataSet" cols="110" rows="4"/>
</message>
*/

IMPORT Risk_Reporting, iesp, gateway, risk_indicators, std, Inquiry_AccLogs, Risk_Reporting;

export FcraInsurView2_Service := MACRO

  // Can't have duplicate definitions of Stored with different default values, 
	// so add the default to #stored to eliminate the assignment of a default value.
	#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);
	#stored('DataPermissionMask',risk_indicators.iid_constants.default_DataPermission);
	
	#WEBSERVICE(FIELDS(
		'FCRAInsurView2AttributesRequest',
		'HistoryDateYYYYMM',
		'gateways',
		'DataRestrictionMask',
		'DataPermissionMask'	
	));

/* ***************************************
	 *             Grab Input:             *
   *************************************** */
  requestIn := DATASET([], iesp.fcrainsurview2attributes.t_FCRAInsurView2AttributesRequest)  	: STORED('FCRAInsurView2AttributesRequest', FEW);
	
  firstRow := requestIn[1] : INDEPENDENT; // Since this is realtime and not batch, we only have one row on input.
	search := GLOBAL(firstRow.SearchBy);
	option := GLOBAL(firstRow.Options);
	users := GLOBAL(firstRow.User);
	context := GLOBAL(firstRow.TransactionContext);
	string20 HistoryDateYYYYMM := '999999' : STORED('HistoryDateYYYYMM');
	
/* **********************************************
	 *  Fields needed for improved Scout Logging  *
	 **********************************************/
	string32 _LoginID               := ''	: STORED('_LoginID');
	outofbandCompanyID							:= '' : STORED('_CompanyID');
	string20 CompanyID              := if(users.CompanyId != '', users.CompanyId, outofbandCompanyID);
	string20 FunctionName           := '' : STORED('_LogFunctionName');
	string50 ESPMethod              := '' : STORED('_ESPMethodName');
	string10 InterfaceVersion       := '' : STORED('_ESPClientInterfaceVersion');
	string5 DeliveryMethod          := '' : STORED('_DeliveryMethod');
	string5 DeathMasterPurpose      := '' : STORED('__deathmasterpurpose');
	outofbandssnmask                := '' : STORED('SSNMask');
	STRING6 SSNMask                 := if(users.SSNMask != '', users.SSNMask, outofbandssnmask);
	outofbanddobmask                := '' : STORED('DOBMask');
	STRING6 DOBMask                 := if(users.DOBMask != '', users.DOBMask, outofbanddobmask);
	BOOLEAN DLMask                  := users.DLMask;
	BOOLEAN ExcludeDMVPII           := users.ExcludeDMVPII;
	BOOLEAN ArchiveOptIn            := False : STORED('instantidarchivingoptin');
	BOOLEAN DisableOutcomeTracking := Users.OutcomeTrackingOptOut;

	//Look up the industry by the company ID.
	Industry_Search := Inquiry_AccLogs.Key_Inquiry_industry_use_vertical_login(TRUE)(s_company_id = CompanyID and s_product_id = (String)Risk_Reporting.ProductID.ISS_FcraInsurView__Service);
/* ************* End Scout Fields **************/

/* ***************************************
	 *           Set Search By:            *
   *************************************** */
	// Address
	STRING28 streetName := search.Address.StreetName;
	STRING10 streetNumber := search.Address.StreetNumber;
	STRING2 streetPreDirection := search.Address.StreetPreDirection;
	STRING2 streetPostDirection := search.Address.StreetPostDirection;
	STRING4 streetSuffix := search.Address.StreetSuffix;
	STRING8 UnitNumber := search.Address.UnitNumber;
	STRING10 UnitDesig := search.Address.UnitDesignation;
	STRING60 tempStreetAddr := Address.Addr1FromComponents(streetNumber, StreetPreDirection,	streetName, StreetSuffix, StreetPostDirection, UnitDesig, UnitNumber);
	STRING60 in_streetAddress1 := IF(search.Address.StreetAddress1='', tempStreetAddr, search.Address.StreetAddress1);
	STRING60 in_streetAddress2 := search.Address.StreetAddress2;
	STRING120 streetAddr := TRIM(in_streetAddress1) + ' ' + TRIM(in_streetAddress2);
	STRING25 City := search.Address.City;
	STRING2 State := search.Address.State;
	STRING5 Zip := search.Address.Zip5;
	STRING18 County := search.Address.County;
	// Other PII
		tmpDOB := iesp.ECL2ESP.DateToString(search.DOB);
	STRING8 DateOfBirth :=  IF(tmpDOB = '00000000', '', tmpDOB);
	STRING9 SSN := search.SSN;
	STRING10 HomePhone := search.HomePhone;
	STRING10 WorkPhone := search.WorkPhone;
	STRING50 Email := search.Email;
	STRING15 DLNumber := search.DriverLicenseNumber;
	STRING2 DLState := search.DriverLicenseState;
	string12 LexID := search.UniqueId;
	
/* ***************************************
	 *             Set Options:            *
   *************************************** */
	boolean OutputConsumerStatements := option.FFDOptionsMask[1] = '1';// this is coming from options tag now instead of out-of-band boolean option we had originally

	
	
	string intended_purpose := trim(option.IntendedPurpose);
	string	AttributesVersionRequest := trim(option.AttributesVersionRequest);
	string20 HistoryDateTimeStamp := '' : STORED('HistoryDateTimeStamp');
	boolean Allow10YearBankruptcy := option.Allow10YearBankruptcy;
	boolean IncludeLnJ := option.IncludeLiensJudgmentsReport;
	boolean IncludeRecordsWithSSN := option.LiensJudgmentsReportOptions.IncludeRecordsWithSSN;
	boolean IncludeBureauRecs := option.LiensJudgmentsReportOptions.IncludeBureauRecs;
 integer ReportingPeriod := if(option.LiensJudgmentsReportOptions.ReportingPeriod = 0, 84, 
                               option.LiensJudgmentsReportOptions.ReportingPeriod);
	
	//Default the options to be ON which is '1'. If excluded, then change to 0
	string tmpFilterLienTypes := Risk_Indicators.iid_constants.LnJDefault;

	boolean ExcludeCityTaxLiens := option.LiensJudgmentsReportOptions.ExcludeCityTaxLiens;
	boolean ExcludeCountyTaxLiens := option.LiensJudgmentsReportOptions.ExcludeCountyTaxLiens;
	boolean ExcludeStateTaxWarrants := option.LiensJudgmentsReportOptions.ExcludeStateTaxWarrants;
	boolean ExcludeStateTaxLiens := option.LiensJudgmentsReportOptions.ExcludeStateTaxLiens;
	boolean ExcludeFederalTaxLiens := option.LiensJudgmentsReportOptions.ExcludeFederalTaxLiens;
	boolean ExcludeOtherLiens := option.LiensJudgmentsReportOptions.ExcludeOtherLiens;
	boolean ExcludeJudgments := option.LiensJudgmentsReportOptions.ExcludeJudgments;
	boolean ExcludeEvictions := option.LiensJudgmentsReportOptions.ExcludeEvictions;
	
	// if the boolean flag is true, use the boolean flags
	// if the boolean flag is not true, then check to ensure the user didn't enter a FilterlienType
		
	tmpCityFltr := if(ExcludeCityTaxLiens, '0', tmpFilterLienTypes[1..1]);
	tmpCountyFltr := if(ExcludeCountyTaxLiens, '0', tmpFilterLienTypes[2..2]);
	tmpStateWarrantFltr := if(ExcludeStateTaxWarrants, '0', tmpFilterLienTypes[3..3]);
	tmpStateFltr :=  if(ExcludeStateTaxLiens, '0', tmpFilterLienTypes[4..4]);
	tmpFedFltr := if(ExcludeFederalTaxLiens, '0', tmpFilterLienTypes[5..5]);
	tmpLiensFltr := if(ExcludeOtherLiens,'0', tmpFilterLienTypes[6..6]);
	tmpJdgmtsFltr := if(ExcludeJudgments, '0', tmpFilterLienTypes[7..7]);
	tmpEvictionsFltr := if(ExcludeEvictions, '0', tmpFilterLienTypes[8..8]);
		//We now have boolean options for each of these filters. We built the code to use a bit (string)
		//saying which ones they want and which ones they want to filter. I take the boolean flags and 
		//turn them into the string the code is expecting. FlagLiensOptions in constants will convert to 
		//the BS options in the search_function.
	FilterLienTypes := tmpCityFltr + 
		tmpCountyFltr +
		tmpStateWarrantFltr +
		tmpStateFltr + 
		tmpFedFltr +
		tmpLiensFltr +
		tmpJdgmtsFltr +
		tmpEvictionsFltr;
		
	boolean RetainInputDID := false		: stored('RetainInputDID');		// to be used by modelers in R&D mode
	
	gateways_in := Gateway.Configuration.Get();
	Gateway.Layouts.Config gw_switch(gateways_in le) := TRANSFORM
		SELF.servicename := le.servicename;
		SELF.url := IF(le.servicename IN ['targus'], '', le.url); // Don't allow Targus Gateway
		SELF := le;
	END;
	gateways := PROJECT(gateways_in, gw_switch(LEFT));
	
	#stored('DisableBocaShellLogging', DisableOutcomeTracking);

/* ***************************************
	 *           Set User Values:          *
   *************************************** */

  STRING outOfBandDataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
  STRING50 DataRestriction := IF(TRIM(users.DataRestrictionMask) <> '', users.DataRestrictionMask, outOfBandDataRestriction);

	STRING outOfBandDataPermission := '0000000000' : STORED('DataPermissionMask');
  STRING DataPermission := MAP(TRIM(users.DataPermissionMask) <> '' => users.DataPermissionMask,
                                  TRIM(outOfBandDataPermission) <> ''  => outOfBandDataPermission,
                                                                           Risk_Indicators.iid_constants.default_DataPermission);

  STRING20 AccountNumber := users.AccountNumber;
	BOOLEAN TestDataEnabled := users.TestDataEnabled;
	STRING32 TestDataTableName := StringLib.StringToUpperCase(TRIM(users.TestDataTableName, LEFT, RIGHT));
	
  STRING20 EndUserCompanyName 		:= context.MLAGatewayInfo.UserCompanyName;
  STRING20 CustomerNumber					:= context.MLAGatewayInfo.CustomerNumber ;
  STRING20 SecurityCode 					:= context.MLAGatewayInfo.SecurityCode  ;
	
/* ***************************************
	 *           Package Input:            *
   *************************************** */
	riskview.layouts.layout_riskview_input intoInput() := TRANSFORM	
	// Sequence - This is hidden from the ESP to be used by the ECL Developers for testing purposes	
		SELF.Seq := (integer)search.seq;
		self.unparsedfullname := search.name.full;
		SELF.Name_First := search.Name.First;
		SELF.name_middle := search.Name.Middle;
		SELF.name_last := search.Name.Last;
		SELF.name_suffix := search.Name.Suffix;
		SELF.street_addr   := streetAddr;
		SELF.p_City_name  := City;
		SELF.St        := State;
		SELF.Z5          := Zip;
		SELF.DOB := DateOfBirth;
		SELF.SSN := SSN;
		SELF.home_phone := HomePhone;
		SELF.work_phone := WorkPhone;
		SELF.Email := Email;
		SELF.DL_Number := DLNumber;
		SELF.DL_State := DLState;
		SELF.AcctNo := AccountNumber;
		self.LexID := LexID; 		
		self.HistoryDateTimeStamp := HistoryDateTimeStamp;
		SELF := [];
	END;

	packagedInput := DATASET([intoInput()]);

/* ***************************************
	 *            Validate Input:          *
   *************************************** */
// a.	First Name, Last Name, Street Address, Zip
// b. First Name, Last Name, Street Address, City, State
// c.	First Name, Last Name, SSN
// d. LexID
error_message := 'Error - Minimum input fields required: First Name, Last Name, Address, and Zip or City and State; LexID only; or First Name, Last Name, and SSN';

// Brad wants to keep error message stating just first/last name, but also allow user to use unparsedfullname field in place of first/last fields if they want
rpt_period_error_message := 'Error - Input Value for ReportingPeriod must be 1 - 84 months.';
            
input_ok := if((( 
							((trim(packagedInput[1].name_first)<>'' and trim(packagedInput[1].name_last)<>'') or trim(packagedInput[1].unparsedfullname)<>'') and  	// name check
							(trim(packagedInput[1].ssn)<>'' or   																																																		// ssn check
								( trim(packagedInput[1].street_addr)<>'' and 																																													// address check
								(trim(packagedInput[1].z5)<>'' OR (trim(packagedInput[1].p_city_name)<>'' AND trim(packagedInput[1].St)<>'')))												// zip or city/state check
							)
								) or
							(unsigned)packagedInput[1].LexID <> 0), true, false);
		//output(input_ok);				
/* ***************************************
	 *      Gather Attributes/Scores:      * 
   *************************************** */
	search_results_temp := ungroup(
	riskview.Search_Function(packagedInput,
		gateways,
		DataRestriction, 
		AttributesVersionRequest,
    //  Models are set to blank for Insurance only
    // Commented out fields are removed from top
		'',   //auto_model_name, 
		'',   //bankcard_model_name, 
		'',   //Short_term_lending_model_name, 
		'',   //Telecommunications_model_name, 
		'',   // Crossindustry_model_name, 
		'',   // Custom_model_name,
		'',   // Custom2_model_name,
		'',   // Custom3_model_name,
		'',   // Custom4_model_name,
		'',   // Custom5_model_name,
		intended_purpose,
		'', // prescreen_score_threshold, 
		FALSE, // isCalifornia_in_person,
		riskview.constants.online,
		FALSE, // run_riskview_report,//riskview.constants.no_riskview_report // don't run report in initial deployment
		DataPermission,
		SSNMask,
		DOBMask,
		DLMask,
		FilterLienTypes, 
		EndUserCompanyName,
		CustomerNumber,
		SecurityCode, 
		IncludeRecordsWithSSN,
	  IncludeBureauRecs, 
		ReportingPeriod, 
		IncludeLnJ,
		RetainInputDID,
    // This one is set to False by default
		FALSE,// exception_score_reason,
    TRUE, // InsuranceMode flag for Insurance purpose only.  
		Allow10YearBankruptcy //Insurance Allow bankruptcy records up to 10 years if TRUE.  Default is 7 years for insurance.
    )
    );
  
  search_results := ungroup(search_results_temp);	


 OUTPUT(search_results);
//***************************-----------------------*******************************//
  iesp.fcrainsurview2attributes.t_FCRAInsurView2Attributes xViewAttr (riskview.layouts.layout_riskview5_search_results VA) := TRANSFORM
  
    SELF.InputDataCheckFlags.InputProvidedFirstName := VA.InputProvidedFirstName;
    SELF.InputDataCheckFlags.InputProvidedLastName  := VA.InputProvidedLastName;
    SELF.InputDataCheckFlags.InputProvidedStreetAddress := VA.InputProvidedStreetAddress;
    SELF.InputDataCheckFlags.InputProvidedCity          := VA.InputProvidedCity;
    SELF.InputDataCheckFlags.InputProvidedState := VA.InputProvidedState;
    SELF.InputDataCheckFlags.InputProvidedZipCode := VA.InputProvidedZipCode;
    SELF.InputDataCheckFlags.InputProvidedSSN := VA.InputProvidedSSN;
    SELF.InputDataCheckFlags.InputProvidedDateofBirth := VA.InputProvidedDateofBirth;
    SELF.InputDataCheckFlags.InputProvidedPhone := VA.InputProvidedPhone;
    SELF.InputDataCheckFlags.InputProvidedLexID := VA.InputProvidedLexID;
    
    SELF.SubjectSource.SubjectRecordTimeOldest := VA.SubjectRecordTimeOldest;
    SELF.SubjectSource.SubjectRecordTimeNewest := VA.SubjectRecordTimeNewest;
    SELF.SubjectSource.SubjectNewestRecord12Month := VA.SubjectNewestRecord12Month;
    SELF.SubjectSource.SubjectActivityIndex03Month := VA.SubjectActivityIndex03Month;
    SELF.SubjectSource.SubjectActivityIndex06Month := VA.SubjectActivityIndex06Month;
    SELF.SubjectSource.SubjectActivityIndex12Month := VA.SubjectActivityIndex12Month;
    SELF.SubjectSource.SubjectAge := VA.SubjectAge;
    SELF.SubjectSource.SubjectDeceased := VA.SubjectDeceased;
    SELF.SubjectSource.SubjectSSNCount := VA.SubjectSSNCount;
    SELF.SubjectSource.SubjectStabilityIndex := VA.SubjectStabilityIndex;
    SELF.SubjectSource.SubjectStabilityPrimaryFactor := VA.SubjectStabilityPrimaryFactor;
    SELF.SubjectSource.SubjectAbilityIndex := VA.SubjectAbilityIndex;
    SELF.SubjectSource.SubjectAbilityPrimaryFactor := VA.SubjectAbilityPrimaryFactor;
    SELF.SubjectSource.SubjectWillingnessIndex := VA.SubjectWillingnessIndex;
    SELF.SubjectSource.SubjectWillingnessPrimaryFactor := VA.SubjectWillingnessPrimaryFactor;
    
    SELF.SubjectConfirmation.ConfirmationSubjectFound := VA.ConfirmationSubjectFound;
    SELF.SubjectConfirmation.ConfirmationInputName := VA.ConfirmationInputName;
    SELF.SubjectConfirmation.ConfirmationInputDOB := VA.ConfirmationInputDOB;
    SELF.SubjectConfirmation.ConfirmationInputSSN := VA.ConfirmationInputSSN;
    SELF.SubjectConfirmation.ConfirmationInputAddress := VA.ConfirmationInputAddress;
    
    SELF.SourceRecordActivity.SourceNonDerogProfileIndex := VA.SourceNonDerogProfileIndex;
    SELF.SourceRecordActivity.SourceNonDerogCount := VA.SourceNonDerogCount;
    SELF.SourceRecordActivity.SourceNonDerogCount03Month := VA.SourceNonDerogCount03Month;
    SELF.SourceRecordActivity.SourceNonDerogCount06Month := VA.SourceNonDerogCount06Month;
    SELF.SourceRecordActivity.SourceNonDerogCount12Month := VA.SourceNonDerogCount12Month;
    SELF.SourceRecordActivity.SourceCredHeaderTimeOldest := VA.SourceCredHeaderTimeOldest;
    SELF.SourceRecordActivity.SourceCredHeaderTimeNewest := VA.SourceCredHeaderTimeNewest;
    SELF.SourceRecordActivity.SourceVoterRegistration := VA.SourceVoterRegistration;
    
    SELF.SSNCharacteristics.SSNSubjectCount := VA.SSNSubjectCount;
    SELF.SSNCharacteristics.SSNDeceased := VA.SSNDeceased;
    SELF.SSNCharacteristics.SSNDateLowIssued := VA.SSNDateLowIssued;
    SELF.SSNCharacteristics.SSNProblems := VA.SSNProblems;
    
    SELF.AddressCharacteristics.AddrOnFileCount := VA.AddrOnFileCount;
    SELF.AddressCharacteristics.AddrOnFileCorrectional := VA.AddrOnFileCorrectional;
    SELF.AddressCharacteristics.AddrOnFileCollege := VA.AddrOnFileCollege;
    SELF.AddressCharacteristics.AddrOnFileHighRisk := VA.AddrOnFileHighRisk;
    SELF.AddressCharacteristics.AddrInputTimeOldest := VA.AddrInputTimeOldest;
    SELF.AddressCharacteristics.AddrInputTimeNewest := VA.AddrInputTimeNewest;
    SELF.AddressCharacteristics.AddrInputLengthOfRes := VA.AddrInputLengthOfRes;
    SELF.AddressCharacteristics.AddrInputSubjectCount := VA.AddrInputSubjectCount;
    SELF.AddressCharacteristics.AddrInputMatchIndex := VA.AddrInputMatchIndex;
    SELF.AddressCharacteristics.AddrInputSubjectOwned := VA.AddrInputSubjectOwned;
    SELF.AddressCharacteristics.AddrInputDeedMailing := VA.AddrInputDeedMailing;
    SELF.AddressCharacteristics.AddrInputOwnershipIndex := VA.AddrInputOwnershipIndex;
    SELF.AddressCharacteristics.AddrInputPhoneService := VA.AddrInputPhoneService;
    SELF.AddressCharacteristics.AddrInputPhoneCount := VA.AddrInputPhoneCount;
    SELF.AddressCharacteristics.AddrInputDwellType := VA.AddrInputDwellType;
    SELF.AddressCharacteristics.AddrInputDwellTypeIndex := VA.AddrInputDwellTypeIndex;
    SELF.AddressCharacteristics.AddrInputDelivery := VA.AddrInputDelivery;
    SELF.AddressCharacteristics.AddrInputTimeLastSale := VA.AddrInputTimeLastSale;
    SELF.AddressCharacteristics.AddrInputLastSalePrice := VA.AddrInputLastSalePrice;
    SELF.AddressCharacteristics.AddrInputTaxValue := VA.AddrInputTaxValue;
    SELF.AddressCharacteristics.AddrInputTaxYr := VA.AddrInputTaxYr;
    SELF.AddressCharacteristics.AddrInputTaxMarketValue := VA.AddrInputTaxMarketValue;
    SELF.AddressCharacteristics.AddrInputAVMValue := VA.AddrInputAVMValue;
    SELF.AddressCharacteristics.AddrInputAVMValue12Month := VA.AddrInputAVMValue12Month;
    SELF.AddressCharacteristics.AddrInputAVMValue60Month := VA.AddrInputAVMValue60Month;
    SELF.AddressCharacteristics.AddrInputAVMRatio12MonthPrior := VA.AddrInputAVMRatio12MonthPrior;
    SELF.AddressCharacteristics.AddrInputAVMRatio60MonthPrior := VA.AddrInputAVMRatio60MonthPrior;
    SELF.AddressCharacteristics.AddrInputCountyRatio := VA.AddrInputCountyRatio;
    SELF.AddressCharacteristics.AddrInputTractRatio := VA.AddrInputTractRatio;
    SELF.AddressCharacteristics.AddrInputBlockRatio := VA.AddrInputBlockRatio;
    SELF.AddressCharacteristics.AddrInputProblems := VA.AddrInputProblems;
    SELF.AddressCharacteristics.AddrCurrentTimeOldest := VA.AddrCurrentTimeOldest;
    SELF.AddressCharacteristics.AddrCurrentTimeNewest := VA.AddrCurrentTimeNewest;
    SELF.AddressCharacteristics.AddrCurrentLengthOfRes := VA.AddrCurrentLengthOfRes;
    SELF.AddressCharacteristics.AddrCurrentSubjectOwned := VA.AddrCurrentSubjectOwned;
    SELF.AddressCharacteristics.AddrCurrentDeedMailing := VA.AddrCurrentDeedMailing;
    SELF.AddressCharacteristics.AddrCurrentOwnershipIndex := VA.AddrCurrentOwnershipIndex;
    SELF.AddressCharacteristics.AddrCurrentPhoneService := VA.AddrCurrentPhoneService;
    SELF.AddressCharacteristics.AddrCurrentDwellType := VA.AddrCurrentDwellType;
    SELF.AddressCharacteristics.AddrCurrentDwellTypeIndex := VA.AddrCurrentDwellTypeIndex;
    SELF.AddressCharacteristics.AddrCurrentTimeLastSale := VA.AddrCurrentTimeLastSale;
    SELF.AddressCharacteristics.AddrCurrentLastSalesPrice := VA.AddrCurrentLastSalesPrice;
    SELF.AddressCharacteristics.AddrCurrentTaxValue := VA.AddrCurrentTaxValue;
    SELF.AddressCharacteristics.AddrCurrentTaxYr := VA.AddrCurrentTaxYr;
    SELF.AddressCharacteristics.AddrCurrentTaxMarketValue := VA.AddrCurrentTaxMarketValue;
    SELF.AddressCharacteristics.AddrCurrentAVMValue := VA.AddrCurrentAVMValue;
    SELF.AddressCharacteristics.AddrCurrentAVMValue12Month := VA.AddrCurrentAVMValue12Month;
    SELF.AddressCharacteristics.AddrCurrentAVMRatio12MonthPrior := VA.AddrCurrentAVMRatio12MonthPrior;
    SELF.AddressCharacteristics.AddrCurrentAVMValue60Month := VA.AddrCurrentAVMValue60Month;
    SELF.AddressCharacteristics.AddrCurrentAVMRatio60MonthPrior := VA.AddrCurrentAVMRatio60MonthPrior;
    SELF.AddressCharacteristics.AddrCurrentCountyRatio := VA.AddrCurrentCountyRatio;
    SELF.AddressCharacteristics.AddrCurrentTractRatio := VA.AddrCurrentTractRatio;
    SELF.AddressCharacteristics.AddrCurrentBlockRatio := VA.AddrCurrentBlockRatio;
    SELF.AddressCharacteristics.AddrCurrentCorrectional := VA.AddrCurrentCorrectional;
    SELF.AddressCharacteristics.AddrPreviousTimeOldest := VA.AddrPreviousTimeOldest;
    SELF.AddressCharacteristics.AddrPreviousTimeNewest := VA.AddrPreviousTimeNewest;
    SELF.AddressCharacteristics.AddrPreviousLengthOfRes := VA.AddrPreviousLengthOfRes;
    SELF.AddressCharacteristics.AddrPreviousSubjectOwned := VA.AddrPreviousSubjectOwned;
    SELF.AddressCharacteristics.AddrPreviousOwnershipIndex := VA.AddrPreviousOwnershipIndex;
    SELF.AddressCharacteristics.AddrPreviousDwellType := VA.AddrPreviousDwellType;
    SELF.AddressCharacteristics.AddrPreviousDwellTypeIndex := VA.AddrPreviousDwellTypeIndex;
    SELF.AddressCharacteristics.AddrPreviousCorrectional := VA.AddrPreviousCorrectional;
    
   
    SELF.AddressHistory.AddrStabilityIndex := VA.AddrStabilityIndex;
    SELF.AddressHistory.AddrChangeCount03Month := VA.AddrChangeCount03Month;
    SELF.AddressHistory.AddrChangeCount06Month := VA.AddrChangeCount06Month;
    SELF.AddressHistory.AddrChangeCount12Month := VA.AddrChangeCount12Month;
    SELF.AddressHistory.AddrChangeCount24Month := VA.AddrChangeCount24Month;
    SELF.AddressHistory.AddrChangeCount60Month := VA.AddrChangeCount60Month;
    SELF.AddressHistory.AddrLastMoveTaxRatioDiff := VA.AddrLastMoveTaxRatioDiff;
    SELF.AddressHistory.AddrLastMoveEconTrajectory := VA.AddrLastMoveEconTrajectory;
    SELF.AddressHistory.AddrLastMoveEconTrajectoryIndex := VA.AddrLastMoveEconTrajectoryIndex;
    
    SELF.PhoneCharacteristics.PhoneInputProblems := VA.PhoneInputProblems;
    SELF.PhoneCharacteristics.PhoneInputSubjectCount := VA.PhoneInputSubjectCount;
    SELF.PhoneCharacteristics.PhoneInputMobile := VA.PhoneInputMobile;
    
    SELF.Education.EducationAttendance := VA.EducationAttendance;
    SELF.Education.EducationEvidence := VA.EducationEvidence;
    SELF.Education.EducationProgramAttended := VA.EducationProgramAttended;
    SELF.Education.EducationInstitutionPrivate := VA.EducationInstitutionPrivate;
    SELF.Education.EducationInstitutionRating := VA.EducationInstitutionRating;
    
    SELF.BusinessAssociation.BusinessAssociation := VA.BusinessAssociation;
    SELF.BusinessAssociation.BusinessAssociationIndex := VA.BusinessAssociationIndex;
    SELF.BusinessAssociation.BusinessAssociationTimeOldest := VA.BusinessAssociationTimeOldest;
    SELF.BusinessAssociation.BusinessTitleLeadership := VA.BusinessTitleLeadership;
    
    
    SELF.ProfessionalLicense.ProfLicCount := VA.ProfLicCount;
    SELF.ProfessionalLicense.ProfLicTypeCategory := VA.ProfLicTypeCategory;
    
    SELF.Asset.AssetIndex := VA.AssetIndex;
    SELF.Asset.AssetIndexPrimaryFactor := VA.AssetIndexPrimaryFactor;
    SELF.Asset.AssetOwnership := VA.AssetOwnership;
    SELF.Asset.AssetProp := VA.AssetProp;
    SELF.Asset.AssetPropIndex := VA.AssetPropIndex;
    SELF.Asset.AssetPropEverCount := VA.AssetPropEverCount;
    SELF.Asset.AssetPropCurrentCount := VA.AssetPropCurrentCount;
    SELF.Asset.AssetPropCurrentTaxTotal := VA.AssetPropCurrentTaxTotal;
    SELF.Asset.AssetPropPurchaseCount12Month := VA.AssetPropPurchaseCount12Month;
    SELF.Asset.AssetPropPurchaseTimeOldest := VA.AssetPropPurchaseTimeOldest;
    SELF.Asset.AssetPropPurchaseTimeNewest := VA.AssetPropPurchaseTimeNewest;
    SELF.Asset.AssetPropNewestMortgageType := VA.AssetPropNewestMortgageType;
    SELF.Asset.AssetPropEverSoldCount := VA.AssetPropEverSoldCount;
    SELF.Asset.AssetPropSoldCount12Month := VA.AssetPropSoldCount12Month;
    SELF.Asset.AssetPropSaleTimeOldest := VA.AssetPropSaleTimeOldest;
    SELF.Asset.AssetPropSaleTimeNewest := VA.AssetPropSaleTimeNewest;
    SELF.Asset.AssetPropNewestSalePrice := VA.AssetPropNewestSalePrice;
    SELF.Asset.AssetPropSalePurchaseRatio := VA.AssetPropSalePurchaseRatio;
    SELF.Asset.AssetPersonal := VA.AssetPersonal;
    SELF.Asset.AssetPersonalCount := VA.AssetPersonalCount;
    
    SELF.PurchaseActivity.PurchaseActivityIndex := VA.PurchaseActivityIndex;
    SELF.PurchaseActivity.PurchaseActivityCount := VA.PurchaseActivityCount;
    SELF.PurchaseActivity.PurchaseActivityDollarTotal := VA.PurchaseActivityDollarTotal;
    
    SELF.DerogatoryPublicRecords.DerogSeverityIndex := VA.DerogSeverityIndex;
    SELF.DerogatoryPublicRecords.DerogCount := VA.DerogCount;
    SELF.DerogatoryPublicRecords.DerogCount12Month := VA.DerogCount12Month;
    SELF.DerogatoryPublicRecords.DerogTimeNewest := VA.DerogTimeNewest;
    
    SELF.CriminalRecords.CriminalFelonyCount := VA.CriminalFelonyCount;
    SELF.CriminalRecords.CriminalFelonyCount12Month := VA.CriminalFelonyCount12Month;
    SELF.CriminalRecords.CriminalFelonyTimeNewest := VA.CriminalFelonyTimeNewest;
    SELF.CriminalRecords.CriminalNonFelonyCount := VA.CriminalNonFelonyCount;
    SELF.CriminalRecords.CriminalNonFelonyCount12Month := VA.CriminalNonFelonyCount12Month;
    SELF.CriminalRecords.CriminalNonFelonyTimeNewest := VA.CriminalNonFelonyTimeNewest;
   
    SELF.EvictionRecords.EvictionCount := VA.EvictionCount;
    SELF.EvictionRecords.EvictionCount12Month := VA.EvictionCount12Month;
    SELF.EvictionRecords.EvictionTimeNewest := VA.EvictionTimeNewest;
    
    SELF.TaxLienAndCourtJudgmentRecords.LienJudgmentSeverityIndex := VA.LienJudgmentSeverityIndex;
    SELF.TaxLienAndCourtJudgmentRecords.LienJudgmentCount := VA.LienJudgmentCount;
    SELF.TaxLienAndCourtJudgmentRecords.LienJudgmentCount12Month := VA.LienJudgmentCount12Month;
    SELF.TaxLienAndCourtJudgmentRecords.LienJudgmentSmallClaimsCount := VA.LienJudgmentSmallClaimsCount;
    SELF.TaxLienAndCourtJudgmentRecords.LienJudgmentCourtCount := VA.LienJudgmentCourtCount;
    SELF.TaxLienAndCourtJudgmentRecords.LienJudgmentTaxCount := VA.LienJudgmentTaxCount;
    SELF.TaxLienAndCourtJudgmentRecords.LienJudgmentForeclosureCount := VA.LienJudgmentForeclosureCount;
    SELF.TaxLienAndCourtJudgmentRecords.LienJudgmentOtherCount := VA.LienJudgmentOtherCount;
    SELF.TaxLienAndCourtJudgmentRecords.LienJudgmentTimeNewest := VA.LienJudgmentTimeNewest;
    SELF.TaxLienAndCourtJudgmentRecords.LienJudgmentDollarTotal := VA.LienJudgmentDollarTotal;
    
    SELF.BankruptcyRecords.BankruptcyCount := VA.BankruptcyCount;
    SELF.BankruptcyRecords.BankruptcyCount24Month := VA.BankruptcyCount24Month;
    SELF.BankruptcyRecords.BankruptcyTimeNewest := VA.BankruptcyTimeNewest;
    SELF.BankruptcyRecords.BankruptcyChapter := VA.BankruptcyChapter;
    SELF.BankruptcyRecords.BankruptcyStatus := VA.BankruptcyStatus;
    SELF.BankruptcyRecords.BankruptcyDismissed24Month := VA.BankruptcyDismissed24Month;
    
    SELF.ShortTermLoanSolicitationRecords.ShortTermLoanRequest := VA.ShortTermLoanRequest;
    SELF.ShortTermLoanSolicitationRecords.ShortTermLoanRequest12Month := VA.ShortTermLoanRequest12Month;
    SELF.ShortTermLoanSolicitationRecords.ShortTermLoanRequest24Month := VA.ShortTermLoanRequest24Month;
    
    SELF.InquiryActivity.InquiryAuto12Month := VA.InquiryAuto12Month;
    SELF.InquiryActivity.InquiryBanking12Month := VA.InquiryBanking12Month;
    SELF.InquiryActivity.InquiryTelcom12Month := VA.InquiryTelcom12Month;
    SELF.InquiryActivity.InquiryNonShortTerm12Month := VA.InquiryNonShortTerm12Month;
    SELF.InquiryActivity.InquiryShortTerm12Month := VA.InquiryShortTerm12Month;
    SELF.InquiryActivity.InquiryCollections12Month := VA.InquiryCollections12Month;
    
    SELF.ConsumerAlert.AlertRegulatoryCondition := VA.AlertRegulatoryCondition;
    
    SELF.LiensAndJudgmentsReport.LnJEvictionTimeNewest := VA.LnJEvictionTimeNewest;
    SELF.LiensAndJudgmentsReport.LnJEvictionTotalCount := VA.LnJEvictionTotalCount;
    SELF.LiensAndJudgmentsReport.LnJEvictionTotalCount12Month := VA.LnJEvictionTotalCount12Month;
    SELF.LiensAndJudgmentsReport.LnJJudgmentCount := VA.LnJJudgmentCount;
    SELF.LiensAndJudgmentsReport.LnJJudgmentCourtCount := VA.LnJJudgmentCourtCount;
    SELF.LiensAndJudgmentsReport.LnJJudgmentDollarTotal := VA.LnJJudgmentDollarTotal;
    SELF.LiensAndJudgmentsReport.LnJJudgmentForeclosureCount := VA.LnJJudgmentForeclosureCount;
    SELF.LiensAndJudgmentsReport.LnJJudgmentSmallClaimsCount := VA.LnJJudgmentSmallClaimsCount;
    SELF.LiensAndJudgmentsReport.LnJJudgementTimeNewest := VA.LnjJudgmentTimeNewest;
    SELF.LiensAndJudgmentsReport.LnJLienCount := VA.LnJLienCount;
    SELF.LiensAndJudgmentsReport.LnJLienDollarTotal := VA.LnJLienDollarTotal;
    SELF.LiensAndJudgmentsReport.LnJLienJudgmentCount := VA.LnJLienJudgmentCount;
    SELF.LiensAndJudgmentsReport.LnJLienJudgmentCount12Month := VA.LnJLienJudgmentCount12Month;
    SELF.LiensAndJudgmentsReport.LnJLienJudgmentDollarTotal := VA.LnJLienJudgmentDollarTotal;
    SELF.LiensAndJudgmentsReport.LnJLienJudgmentOtherCount := VA.LnJLienJudgmentOtherCount;
    SELF.LiensAndJudgmentsReport.LnJLienJudgmentSeverityIndex := VA.LnJLienJudgmentSeverityIndex;
    SELF.LiensAndJudgmentsReport.LnJLienJudgmentTimeNewest := VA.LnJLienJudgmentTimeNewest;
    SELF.LiensAndJudgmentsReport.LnJLienTaxCount := VA.LnJLienTaxCount;
    SELF.LiensAndJudgmentsReport.LnJLienTaxDollarTotal := VA.LnJLienTaxDollarTotal;
    SELF.LiensAndJudgmentsReport.LnJLienTaxFederalCount := VA.LnJLienTaxFederalCount;
    SELF.LiensAndJudgmentsReport.LnJLienTaxFederalDollarTotal := VA.LnJLienTaxFederalDollarTotal;
    SELF.LiensAndJudgmentsReport.LnJLienTaxFederalTimeNewest := VA.LnJLienTaxFederalTimeNewest;
    SELF.LiensAndJudgmentsReport.LnJLienTaxStateCount := VA.LnJLienTaxStateCount;
    SELF.LiensAndJudgmentsReport.LnJLienTaxStateDollarTotal := VA.LnJLienTaxStateDollarTotal;
    SELF.LiensAndJudgmentsReport.LnJLienTaxStateTimeNewest := VA.LnJLienTaxStateTimeNewest;
    SELF.LiensAndJudgmentsReport.LnJLienTimeNewest := VA.LnJLienTimeNewest;
    SELF.LiensAndJudgmentsReport.LnJLienTaxTimeNewest := VA.LnJLienTaxTimeNewest;

  END;
  
  
//*********************************************************************************************************//
	valid_insurview_xml_response := project(search_results,
		transform(iesp.fcrainsurview2attributes.t_FCRAInsurView2AttributesResponse,
				self.Result.UniqueId := LEFT.LexID;
				self.Result.InputEcho := search;
				self.Result.ConsumerStatements := if(OutputConsumerStatements, left.ConsumerStatements);

        
        // for inquiry logging, populate the consumer section with the DID and input fields
        // don't log the lexid if the person got a noscore
        self.Result.Consumer.LexID := if(riskview.constants.noScoreAlert in [left.Alert1,left.Alert2,left.Alert3,left.Alert4,left.Alert5,left.Alert6,left.Alert7,left.Alert8,left.Alert9,left.Alert10], '', left.LexID);
        searchDOB := iesp.ECL2ESP.t_DateToString8(search.DOB);
		    SELF.Result.Consumer.Inquiry.DOB := IF((UNSIGNED)searchDOB > 0, searchDOB, '');
        self.Result.Consumer.Inquiry.Phone10 := search.HomePhone;
        self.Result.Consumer.Inquiry := search; 
        
        SELF.Result.InsurView2Attributes := ROW(xViewAttr(LEFT));


				//For MLA, we need to populate the exception area of the result if there was an error flagged in the MLA process.  The
				//Exception_code field will contain the error code...use it to look up the description and format the exception record.
				ds_excep_blank := DATASET([], iesp.share.t_WsException); 
				
				ds_excep := DATASET([{'Roxie', 
															 left.Exception_code,  
															 '', 									
															 RiskView.Constants.get_error_desc(left.Exception_code)}], iesp.share.t_WsException); 

				SELF._Header.Exceptions := ds_excep_blank;

				SELF._Header := [];
	));





//****************-------------+*************************************

invalid_input_xml_response := project(search_results,
		transform(iesp.fcrainsurview2attributes.t_FCRAInsurView2AttributesResponse,
				self.Result.InputEcho := search;
				self._Header.Status := -1;
				self._Header.Message := error_message;
				SELF := [];
	));

insurview_xml := if(input_ok, valid_insurview_xml_response, invalid_input_xml_response);

output( insurview_xml, named( 'Results' ) );

//Log to Deltabase
Deltabase_Logging_prep := project(insurview_xml, transform(Risk_Reporting.Layouts.LOG_Deltabase_Layout_Record,
																												 self.company_id := (Integer)CompanyID,
																												 self.login_id := _LoginID,
																												 self.product_id := Risk_Reporting.ProductID.ISS_FcraInsurView__Service,
																												 self.function_name := FunctionName,
																												 self.esp_method := ESPMethod,
																												 self.interface_version := InterfaceVersion,
																												 self.delivery_method := DeliveryMethod,
																												 self.date_added := (STRING8)Std.Date.Today(),
																												 self.death_master_purpose := DeathMasterPurpose,
																												 self.ssn_mask := SSNMask,
																												 self.dob_mask := DOBMask,
																												 self.dl_mask := (String)(Integer)DLMask,
																												 self.exclude_dmv_pii := (String)(Integer)ExcludeDMVPII,
																												 self.scout_opt_out := (String)(Integer)DisableOutcomeTracking,
																												 self.archive_opt_in := (String)(Integer)ArchiveOptIn,
                                                         self.glb := (Integer)users.GLBPurpose,
                                                         self.dppa := (Integer)users.DLPurpose,
																												 self.data_restriction_mask := DataRestriction,
																												 self.data_permission_mask := DataPermission,
																												 self.industry := Industry_Search[1].Industry,
																												 self.i_attributes_name := AttributesVersionRequest,
																												 self.i_ssn := search.SSN,
                                                         self.i_dob := DateOfBirth,
                                                         self.i_name_full := search.Name.Full,
																												 self.i_name_first := search.Name.First,
																												 self.i_name_last := search.Name.Last,
																												 self.i_lexid := (Integer)search.UniqueId, 
																												 self.i_address := streetAddr,
																												 self.i_city := search.Address.City,
																												 self.i_state := search.Address.State,
																												 self.i_zip := search.Address.Zip5,
																												 self.i_dl := search.DriverLicenseNumber,
																												 self.i_dl_state := search.DriverLicenseState,
                                                         self.i_home_phone := HomePhone,
                                                         self.i_work_phone := WorkPhone,
																												 self.o_lexid      := (Integer)left.Result.UniqueId,
																												 self := left,
																												 self := [] ));
Deltabase_Logging := DATASET([{Deltabase_Logging_prep}], Risk_Reporting.Layouts.LOG_Deltabase_Layout);
// #stored('Deltabase_Log', Deltabase_Logging);

//Improved Scout Logging
IF(~DisableOutcomeTracking and ~TestDataEnabled, OUTPUT(Deltabase_Logging, NAMED('LOG_log__mbs__fcra_transaction__log__scout')));

ENDMACRO;