//RiskView.Search_Service
/*--SOAP--
<message name="RiskView Search_Service">
	<part name="RiskView2Request" type="tns:XmlDataSet" cols="110" rows="75"/>
	<part name="HistoryDateTimeStamp" type="xsd:string"/>
	<part name="gateways" type="tns:XmlDataSet" cols="110" rows="10"/>
	<part name="SSNMask" type="xsd:string"/>
	<part name="DLMask"	type="xsd:string"/>
	<part name="DOBMask" type="xsd:string"/>
	<part name="RetainInputDID" type="xsd:boolean"/>

<part name="_TransactionId" type="xsd:string"/>
<part name="_CompanyId" type="xsd:string"/>

</message>
*/
/*--INFO-- Contains RiskView Alerts, Scores, Attributes, Report version 5.0 and higher */

IMPORT Risk_Reporting, iesp, gateway, risk_indicators, std, Inquiry_AccLogs, RiskView, Royalty, Address;

export Search_Service := MACRO

  // Can't have duplicate definitions of Stored with different default values, 
	// so add the default to #stored to eliminate the assignment of a default value.
	#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);
	#stored('DataPermissionMask',risk_indicators.iid_constants.default_DataPermission);
	#stored('RVCheckingSubscriberId', 0);
  
#WEBSERVICE(FIELDS(
		'RiskView2Request',
		'HistoryDateTimeStamp',
		'gateways',
		'DataRestrictionMask',
		'DataPermissionMask',
		'SSNMask',
		'DLMask',
		'DOBMask',
		'RetainInputDID',
    'RVCheckingSubscriberId',
    '_TransactionID',
		'_CompanyID'
		
	));

/* ***************************************
	 *             Grab Input:             *
   *************************************** */
  requestIn := DATASET([], iesp.riskview2.t_RiskView2Request)  	: STORED('RiskView2Request', FEW);
  firstRow := requestIn[1] : INDEPENDENT; // Since this is realtime and not batch, we only have one row on input.
	search := GLOBAL(firstRow.SearchBy);
	option := GLOBAL(firstRow.Options);
	users := GLOBAL(firstRow.User);
	context := GLOBAL(firstRow.TransactionContext);
	
/* **********************************************
	 *  Fields needed for improved Scout Logging  *
	 **********************************************/
	string32 _LoginID               := ''	: STORED('_LoginID');
	outofbandCompanyID							:= '' : STORED('_CompanyID');
	outofbandTransactionID          := '' : STORED('_TransactionID');
	string20 CompanyID              := if(users.CompanyId != '', users.CompanyId, outofbandCompanyID);
	string20 FunctionName           := '' : STORED('_LogFunctionName');
	string50 ESPMethod              := '' : STORED('_ESPMethodName');
	string10 InterfaceVersion       := '' : STORED('_ESPClientInterfaceVersion');
	string5 DeliveryMethod          := '' : STORED('_DeliveryMethod');
	string5 DeathMasterPurpose      := '' : STORED('__deathmasterpurpose');
	STRING6 SSNMask                 := 'NONE'	: stored('SSNMask');
	STRING6 DOBMask                 := 'NONE'	: stored('DOBMask');
	BOOLEAN DLMask                  := false	: stored('DLMask');	
	BOOLEAN ExcludeDMVPII           := users.ExcludeDMVPII;
	BOOLEAN DisableOutcomeTracking  := False : STORED('OutcomeTrackingOptOut');
	BOOLEAN ArchiveOptIn            := False : STORED('instantidarchivingoptin');

	//Look up the industry by the company ID.
	Industry_Search := Inquiry_AccLogs.Key_Inquiry_industry_use_vertical_login(TRUE)(s_company_id = CompanyID and s_product_id = (String)Risk_Reporting.ProductID.RiskView__Search_Service);
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
	STRING4 SSNLast4 := search.SSNLast4;
  STRING9 SSN := if(search.SSN = '' and SSNLast4 <> '', SSNLast4, search.SSN);
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

	STRING auto_model_name := STD.Str.ToLowerCase(option.IncludeModels.Names(STD.Str.ToLowerCase(value[1..9])='rva1503_0')[1].value);
	STRING bankcard_model_name := STD.Str.ToLowerCase(option.IncludeModels.Names(STD.Str.ToLowerCase(value[1..9])='rvb1503_0')[1].value);
	STRING Short_term_lending_model_name := STD.Str.ToLowerCase(option.IncludeModels.Names(STD.Str.ToLowerCase(value[1..9])='rvg1502_0')[1].value);
	STRING Telecommunications_model_name := STD.Str.ToLowerCase(option.IncludeModels.Names(STD.Str.ToLowerCase(value[1..9])='rvt1503_0')[1].value);	
	STRING Crossindustry_model_name := STD.Str.ToLowerCase(option.IncludeModels.Names(STD.Str.ToLowerCase(value[1..9])='rvs1706_0')[1].value);	
	
	ds_flagship_models := dataset([{auto_model_name}, {bankcard_model_name}, {short_term_lending_model_name}, {telecommunications_model_name}, {Crossindustry_model_name}], {string flagship_names}) : global;
	STRING custom_model_name 	:= STD.Str.ToLowerCase(option.IncludeModels.Names(STD.Str.ToLowerCase(value) not in set(ds_flagship_models, flagship_names) )[1].value);
	ds_flagship_plus_custom   := ds_flagship_models + dataset([{custom_model_name}], {string flagship_names}) : global;
	STRING custom2_model_name := STD.Str.ToLowerCase(option.IncludeModels.Names(STD.Str.ToLowerCase(value) not in set(ds_flagship_plus_custom, flagship_names) )[1].value);
	ds_flagship_plus_custom2  := ds_flagship_plus_custom + dataset([{custom2_model_name}], {string flagship_names}) : global;
	STRING custom3_model_name := STD.Str.ToLowerCase(option.IncludeModels.Names(STD.Str.ToLowerCase(value) not in set(ds_flagship_plus_custom2, flagship_names) )[1].value);
	ds_flagship_plus_custom3  := ds_flagship_plus_custom2 + dataset([{custom3_model_name}], {string flagship_names}) : global;
	STRING custom4_model_name := STD.Str.ToLowerCase(option.IncludeModels.Names(STD.Str.ToLowerCase(value) not in set(ds_flagship_plus_custom3, flagship_names) )[1].value);
	ds_flagship_plus_custom4  := ds_flagship_plus_custom3 + dataset([{custom4_model_name}], {string flagship_names}) : global;
	STRING custom5_model_name := STD.Str.ToLowerCase(option.IncludeModels.Names(STD.Str.ToLowerCase(value) not in set(ds_flagship_plus_custom4, flagship_names) )[1].value);
	
	string intended_purpose := trim(option.IntendedPurpose);
	string	AttributesVersionRequest := trim(option.AttributesVersionRequest);
	string prescreen_score_threshold := option.IncludeModels.ModelOptions(STD.Str.ToLowerCase(OptionName)='prescreen_score_threshold')[1].OptionValue;
	boolean exception_score_reason := option.IncludeModels.ModelOptions(STD.Str.ToLowerCase(OptionName)='exception_score_reason')[1].OptionValue='1'; // T-Mobile option only - default to false
	boolean isCalifornia_in_person := option.IncludeModels.ModelOptions(STD.Str.ToLowerCase(OptionName)='inpersonapplicant')[1].OptionValue='1';  // defaults to false unless there is an option passed in to turn it on
	boolean run_riskview_report := option.IncludeReport;
	string20 HistoryDateTimeStamp := '' : STORED('HistoryDateTimeStamp');
	
	boolean IncludeLnJ := option.IncludeLiensJudgmentsReport;
	boolean IncludeStatusRefreshChecks := option.IncludeStatusRefreshChecks;
	boolean IncludeRecordsWithSSN := option.LiensJudgmentsReportOptions.IncludeRecordsWithSSN;
	boolean IncludeBureauRecs := option.LiensJudgmentsReportOptions.IncludeBureauRecs;
 integer ReportingPeriod := if(option.LiensJudgmentsReportOptions.ReportingPeriod = 0, 84, 
                               option.LiensJudgmentsReportOptions.ReportingPeriod);
	
	//Default the options to be ON which is '1'. If excluded, then change to 0
	string tmpFilterLienTypes := Risk_Indicators.iid_constants.LnJDefault;

	// JuLi exclusion options
	boolean ExcludeCityTaxLiens := option.LiensJudgmentsReportOptions.ExcludeCityTaxLiens;
	boolean ExcludeCountyTaxLiens := option.LiensJudgmentsReportOptions.ExcludeCountyTaxLiens;
	boolean ExcludeStateTaxWarrants := option.LiensJudgmentsReportOptions.ExcludeStateTaxWarrants;
	boolean ExcludeStateTaxLiens := option.LiensJudgmentsReportOptions.ExcludeStateTaxLiens;
	boolean ExcludeFederalTaxLiens := option.LiensJudgmentsReportOptions.ExcludeFederalTaxLiens;
	boolean ExcludeOtherLiens := option.LiensJudgmentsReportOptions.ExcludeOtherLiens;
	boolean ExcludeJudgments := option.LiensJudgmentsReportOptions.ExcludeJudgments;
	boolean ExcludeEvictions := option.LiensJudgmentsReportOptions.ExcludeEvictions;
	boolean ExcludeReleasedCases := option.LiensJudgmentsReportOptions.ExcludeReleasedCases;
	unsigned6 MinimumAmount := MIN(option.LiensJudgmentsReportOptions.MinimumAmount, 999999999);
	dataset(iesp.share.t_StringArrayItem) ExcludeStates := option.LiensJudgmentsReportOptions.ExcludeStates;
	dataset(iesp.share.t_StringArrayItem) ExcludeReportingSources := option.LiensJudgmentsReportOptions.ExcludeReportingSources;
	boolean AttributesOnly := option.LiensJudgmentsReportOptions.AttributesOnly;
    boolean ExcludeStatusRefresh := option.LiensJudgmentsReportOptions.ExcludeStatusRefresh;
    string32 DeferredTransactionID := option.LiensJudgmentsReportOptions.DeferredTransactionID;
    string5 StatusRefreshWaitPeriod := option.LiensJudgmentsReportOptions.StatusRefreshWaitPeriod;
    DeferredTransactionIDs := IF(DeferredTransactionID <> '', DATASET([DeferredTransactionID], {STRING32 DeferredTransactionID}), DATASET([], {STRING32 DeferredTransactionID}));
	
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
	tmpReleasedCasesFltr := if(ExcludeReleasedCases, '0', tmpFilterLienTypes[9..9]);
	tmpAttributesOnlyFltr := if(AttributesOnly, '0', tmpFilterLienTypes[10..10]);
    tmpExcludeStatusRefresh := if(ExcludeStatusRefresh, '0', tmpFilterLienTypes[11..11]);
	
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
		tmpEvictionsFltr +
		tmpReleasedCasesFltr +
		tmpAttributesOnlyFltr +
        tmpExcludeStatusRefresh;
		
	boolean RetainInputDID := false		: stored('RetainInputDID');		// to be used by modelers in R&D mode
  
  //Used only by Checking Indicators
  Integer outOfBandSubscriberId := 0 : stored('RVCheckingSubscriberId');
  INTEGER8 SubscriberId := IF(option.RVCheckingSubscriberId <> 0, option.RVCheckingSubscriberId, outOfBandSubscriberId);
	
  // Check if any IDA models are requested.
  IDA_model_check :=  auto_model_name IN RiskView.Constants.valid_IDA_models OR 
                      bankcard_model_name IN RiskView.Constants.valid_IDA_models OR  
                      Short_term_lending_model_name IN RiskView.Constants.valid_IDA_models OR  
                      Telecommunications_model_name IN RiskView.Constants.valid_IDA_models OR  
                      Crossindustry_model_name IN RiskView.Constants.valid_IDA_models OR  
                      Custom_model_name IN RiskView.Constants.valid_IDA_models OR 
                      Custom2_model_name IN RiskView.Constants.valid_IDA_models OR 
                      Custom3_model_name IN RiskView.Constants.valid_IDA_models OR 
                      Custom4_model_name IN RiskView.Constants.valid_IDA_models OR 
                      Custom5_model_name IN RiskView.Constants.valid_IDA_models;
 
	gateways_in := Gateway.Configuration.Get();
  
	Gateway.Layouts.Config gw_switch(gateways_in le) := TRANSFORM
    service_name := STD.STR.ToLowerCase(le.servicename);
  
		SELF.servicename := Map( service_name IN [Risk_Indicators.iid_constants.idareport,
                                              Risk_Indicators.iid_constants.idareportUAT,
                                              Risk_Indicators.iid_constants.idareportRetro] AND ~IDA_model_check => '', 
                                                                                                                      le.servicename);

		SELF.url := Map(service_name IN ['targus']                                                          => '',// Don't allow Targus Gateway
                    service_name IN [Risk_Indicators.iid_constants.idareport,
                                     Risk_Indicators.iid_constants.idareportUAT,
                                     Risk_Indicators.iid_constants.idareportRetro] AND ~IDA_model_check => '',
                                                                                                           le.url); 
    self.properties := if(service_name IN ['first_data'], dataset([transform(Gateway.Layouts.ConfigProperties,
                        self.name := 'SubscriberId';
                        self.val := (string8)SubscriberId;)]),
    Dataset([], Gateway.Layouts.ConfigProperties));
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
	STRING32 TestDataTableName := STD.Str.ToUpperCase(TRIM(users.TestDataTableName, LEFT, RIGHT));
  
  //Needed for IDA gateway calls AppID is a mandatory field for IDA
  //Use QueryID if populated, otherwise use the TransactionID
  STRING50 IDA_AppID := IF(users.QueryID != '', users.QueryID, outofbandTransactionID);
	
  //Used only by MLA
  STRING20 EndUserCompanyName 		:= context.MLAGatewayInfo.EndUserCompanyName;
  STRING20 CustomerNumber					:= context.MLAGatewayInfo.CustomerNumber ;
  STRING20 SecurityCode 					:= context.MLAGatewayInfo.SecurityCode  ;

/* ***************************************
	 *           Package Input:            *
   *************************************** */
	packagedInput := DATASET([TRANSFORM(riskview.layouts.layout_riskview_input,
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
		self.Custom_Inputs := option.IncludeModels.ModelOptions;
		SELF := [];)]);	
	
	packagedTestseedInput := DATASET([TRANSFORM(Risk_Indicators.Layout_Input,
		SELF.seq := (integer)search.seq;	// Sequence - This is to be used by the ECL Developers for testing purposes	
		SELF.fname := STD.Str.ToUpperCase(search.Name.First);
		SELF.lname := STD.Str.ToUpperCase(search.Name.Last);
		SELF.ssn := SSN;
		SELF.in_zipCode := Zip;
		SELF.phone10 := HomePhone;
		SELF := [];)]);

/* ***************************************
	 *            Validate Input:          *
   *************************************** */
// a.	First Name, Last Name, Street Address, Zip
// b. First Name, Last Name, Street Address, City, State
// c.	First Name, Last Name, SSN
// d. LexID

// MLA alert requested by itself (no scores, attributes, report) 
MLA_alone				:= custom_model_name = 'mla1608_0' AND auto_model_name = '' AND bankcard_model_name = '' AND 
									 Short_term_lending_model_name = '' AND Telecommunications_model_name = '' AND Crossindustry_model_name ='' AND AttributesVersionRequest = '' AND
									 custom2_model_name = '' AND custom3_model_name = '' AND custom4_model_name = '' AND custom5_model_name = '' AND
									 ~run_riskview_report;

// Brad wants to keep error message stating just first/last name, but also allow user to use unparsedfullname field in place of first/last fields if they want
min_error_message          := 'Error - Minimum input fields required: First Name, Last Name, Address, and Zip or City and State; LexID only; or First Name, Last Name, and SSN';
no_lexid_min_error_message := 'Error - Minimum input fields required: First Name, Last Name, Address, and Zip or City and State; or First Name, Last Name, and SSN';
rpt_period_error_message   := 'Error - Input Value for ReportingPeriod must be 1 - 84 months.';
attr_only_error_message    := 'Error - The AttributesOnly option cannot be selected with the ExcludeReleasedCases option.';

Standard_min_check := (((TRIM(packagedInput[1].name_first)<>'' AND TRIM(packagedInput[1].name_last)<>'') OR TRIM(packagedInput[1].unparsedfullname)<>'') AND  // name check
							           (TRIM(packagedInput[1].ssn)<>'' OR                                                                                                   // ssn check
								           ( TRIM(packagedInput[1].street_addr)<>'' AND                                                                                       // address check
								           (TRIM(packagedInput[1].z5)<>'' OR (TRIM(packagedInput[1].p_city_name)<>'' AND TRIM(packagedInput[1].St)<>'')))));                  // zip or city/state check
							
check_valid_input := IF((Standard_min_check
                          OR
							          (MLA_alone) //if MLA requested by itself, bypass Riskview minimum input checks here.
							            OR
							          (unsigned)packagedInput[1].LexID <> 0), TRUE, FALSE);


Non_lexid_min_check := IF(IDA_model_check, 
                          IF(Standard_min_check, TRUE, FALSE),
                          TRUE); //Only go into this check if there is an IDA model, then lexid only is not a valid minimum input
                 

input_ok := map(AttributesOnly AND ExcludeReleasedCases                               => ERROR(301,attr_only_error_message),
                ~Non_lexid_min_check                                                  => ERROR(301,no_lexid_min_error_message), // Some models do not support LexID only as minimum input
                check_valid_input and (ReportingPeriod > 0 and ReportingPeriod <= 84) => true,
                check_valid_input and (ReportingPeriod <= 0 or ReportingPeriod > 84)  => ERROR(301,rpt_period_error_message), // Reporting period must be within 0 - 84.
                                                                                         ERROR(301,min_error_message)         // if anything else is wrong, give the other error messages first priority.
               );

		// output(input_ok);						
/* ***************************************
	 *      Gather Attributes/Scores:      *
   *************************************** */

search_results_temp := ungroup(
            riskview.Search_Function(packagedInput,
              gateways,
              DataRestriction,
              AttributesVersionRequest, 
              auto_model_name, 
              bankcard_model_name, 
              Short_term_lending_model_name, 
              Telecommunications_model_name, 
              Crossindustry_model_name, 
              Custom_model_name,
              Custom2_model_name,
              Custom3_model_name,
              Custom4_model_name,
              Custom5_model_name,
              intended_purpose,
              prescreen_score_threshold, 
              isCalifornia_in_person,
              riskview.constants.online,
              run_riskview_report,//riskview.constants.no_riskview_report // don't run report in initial deployment
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
              exception_score_reason,
              MinimumAmount := MinimumAmount,
              ExcludeStates := ExcludeStates,
              ExcludeReportingSources := ExcludeReportingSources,
              IncludeStatusRefreshChecks := IncludeStatusRefreshChecks,
              DeferredTransactionIDs := DeferredTransactionIDs,
              StatusRefreshWaitPeriod := StatusRefreshWaitPeriod,
              IsBatch := FALSE,
              CompanyID := CompanyID,
              TransactionID := outofbandTransactionID,
              IDA_AppID := IDA_AppID
      		) 
      	);
  
	#if(Riskview.Constants.TurnOnValidation) // If TRUE, output the model results directly
		output(search_results_temp, named('Results'));
	#else // Else, this is a normal transaction and should be formatted for output appropriately
	 //search_results := ungroup(search_results_temp);
	search_results := ungroup(
		IF(TestDataEnabled, 
		RiskView.TestSeed_Function(packagedTestseedInput, 
				TestDataTableName, 
				AttributesVersionRequest, 
				auto_model_name, 
				bankcard_model_name, 
				Short_term_lending_model_name, 
				Telecommunications_model_name, 
				Crossindustry_model_name, 
				Custom_model_name,
				Custom2_model_name,
				Custom3_model_name,
				Custom4_model_name,
				Custom5_model_name,
				intended_purpose,
				prescreen_score_threshold,
				run_riskview_report,
				includeLnj),	// TestSeed Values
		  search_results_temp
	 )
   );						

  // Convert Search Results to name/value pairs for ESDL:  
	Riskviewattrs_namevaluePairs :=  RiskView.functions.Format_riskview_attrs(search_results, AttributesVersionRequest);  

  // Convert Model Results to ESDL:
	modelResults := normalize(	search_results , 9, RiskView.Transforms.intoModel(LEFT, counter)	)(name<>'');
	
  // Convert Search Results to alert code/description pairs for ESDL:
	nameValuePairsAlerts :=  NORMALIZE(search_results, 10, RiskView.Transforms.norm_alerts(LEFT, COUNTER))(code<>'');

  // Convert Search Results to Lien/Judgement name/value pairs for ESDL:
	LnJReport := NORMALIZE(search_results, 27, RiskView.Transforms.norm_LnJ(LEFT, COUNTER))(trim(value)<>'');


	LnJ_liens := project(search_results[1].LnJliens, 
		transform(iesp.riskview2.t_RiskView2LiensJudgmentsReportForLien,
			self.seq := (string) left.seq;
			self.RecordID := left.orig_RMSID;
			self.DateFiled := iesp.ECL2ESP.toDate((integer)left.DateFiled);
			self.ReleaseDate := iesp.ECL2ESP.toDate((integer)left.ReleaseDate);
			self.DateLastSeen := iesp.ECL2ESP.toDate((integer)left.DateLastSeen);
      self.DefendantAddress.StreetAddress1 := left.StreetAddress1;
      self.DefendantAddress.StreetAddress2 := left.StreetAddress2;
      self.DefendantAddress.City := left.City;
      self.DefendantAddress.State := left.State;
      self.DefendantAddress.Zip5 := left.Zip5;
			self := left;
			self := [];
		));
	LnJ_jdgmts := project(search_results[1].LnJJudgments, 
		transform(iesp.riskview2.t_RiskView2LiensJudgmentsReportForJudgement,
			self.seq := (string) left.seq;
			self.RecordID := left.orig_RMSID;
			self.DateFiled := iesp.ECL2ESP.toDate((integer)left.DateFiled);
			self.ReleaseDate := iesp.ECL2ESP.toDate((integer)left.ReleaseDate);
			self.DateLastSeen := iesp.ECL2ESP.toDate((integer)left.DateLastSeen);
      self.DefendantAddress.StreetAddress1 := left.StreetAddress1;
      self.DefendantAddress.StreetAddress2 := left.StreetAddress2;
      self.DefendantAddress.City := left.City;
      self.DefendantAddress.State := left.State;
      self.DefendantAddress.Zip5 := left.Zip5;
			self := left;
			self := [];
		));
	
	valid_riskview_xml_response := project(search_results,
		transform(iesp.riskview2.t_RiskView2Response,
                suppress_condition := IF((STD.Str.ToLowerCase(LEFT.Message) = STD.Str.ToLowerCase(Riskview.Constants.Deferred_request_desc) OR STD.Str.ToLowerCase(LEFT.Exception_Code) = STD.Str.ToLowerCase(Riskview.Constants.DTEError) OR STD.Str.ToLowerCase(LEFT.Exception_Code) = STD.Str.ToLowerCase(Riskview.Constants.OKCError)) AND ExcludeStatusRefresh = FALSE AND IncludeStatusRefreshChecks = TRUE, TRUE, FALSE);
				self.Result.UniqueId := IF(~suppress_condition, LEFT.LexID, '');
				self.Result.InputEcho := search;
				self.Result.Models := IF(~suppress_condition, modelResults);
                self.Result.AttributesGroup.name := STD.Str.ToUpperCase(AttributesVersionRequest);
                self.Result.AttributesGroup.attributes := IF(~suppress_condition, Riskviewattrs_namevaluePairs);
				self.Result.Alerts := nameValuePairsAlerts;
				// self.Result.Report.ConsumerStatement := left.ConsumerStatementText;
				self.Result.LiensJudgmentsReports.Summary := IF(IncludeLNJ AND ~AttributesOnly AND ~suppress_condition, left.report.summary);
				self.Result.Report := IF(run_riskview_report AND ~suppress_condition, left.report);
				
				self.Result.ConsumerStatements := if(OutputConsumerStatements AND ~suppress_condition, left.ConsumerStatements);
				self.Result.LiensJudgmentsReports.Liens := IF(~AttributesOnly AND ~suppress_condition, LnJ_liens);
				self.Result.LiensJudgmentsReports.Judgments := IF(~AttributesOnly AND ~suppress_condition, LnJ_jdgmts);
				self.Result.LiensJudgmentsReports.LnJAttributes := IF(~suppress_condition, LnJReport);
        // for inquiry logging, populate the consumer section with the DID and input fields
        // don't log the lexid if the person got a noscore
                self.Result.Consumer.LexID := if(riskview.constants.noScoreAlert in [left.Alert1,left.Alert2,left.Alert3,left.Alert4,left.Alert5,left.Alert6,left.Alert7,left.Alert8,left.Alert9,left.Alert10] OR suppress_condition, '', left.LexID);
                searchDOB := iesp.ECL2ESP.t_DateToString8(search.DOB);
                SELF.Result.Consumer.Inquiry.DOB := IF((UNSIGNED)searchDOB > 0 AND ~suppress_condition, searchDOB, '');
                self.Result.Consumer.Inquiry.Phone10 := IF(~suppress_condition, search.HomePhone, '');
                self.Result.Consumer.Inquiry := IF(~suppress_condition, search);      

				//For MLA, we need to populate the exception area of the result if there was an error flagged in the MLA process.  The
				//Exception_code field will contain the error code...use it to look up the description and format the exception record.
			   ds_excep_blank := DATASET([], iesp.share.t_WsException); 
				
			   ds_excep := DATASET([{'Roxie', 
															 left.Exception_code,  
															 '', 									
															 RiskView.Constants.MLA_error_desc(left.Exception_code)}], iesp.share.t_WsException);
                               
               ds_excep_Checking_Indicators:= DATASET([{'Roxie', 
															 left.Exception_code,  
															 '', 									
															 RiskView.Constants.Checking_Indicator_error_desc(left.Exception_code)}], iesp.share.t_WsException);
                               
               ds_excep_status_refresh := DATASET([{'Roxie', 
                                                             IF(left.Exception_code = Riskview.Constants.OKCError, '22', left.Exception_code),
                                                             '', 									
                                                             RiskView.Constants.StatusRefresh_error_desc}], iesp.share.t_WsException); 
               ds_excep_DTE := DATASET([{'Roxie', 
                                                             IF(left.Exception_code = Riskview.Constants.DTEError, '41', left.Exception_code),
                                                             '', 									
                                                             RiskView.Constants.DTE_error_desc}], iesp.share.t_WsException);

              SELF._Header.Exceptions := map((custom_model_name  = 'mla1608_0' or custom2_model_name = 'mla1608_0' or 
																			  custom3_model_name = 'mla1608_0' or custom4_model_name = 'mla1608_0' or 
																			  custom5_model_name = 'mla1608_0') and left.Exception_code <> '' => ds_excep,
                                        STD.Str.ToLowerCase(AttributesVersionRequest) = RiskView.Constants.checking_indicators_attribute_request and left.Exception_code <> '' => ds_excep_Checking_Indicators,
                                        IncludeStatusRefreshChecks = TRUE AND COUNT(DeferredTransactionIDs) = 0 AND LEFT.Exception_Code <> '' => ds_excep_status_refresh,
                                        IncludeStatusRefreshChecks = TRUE AND COUNT(DeferredTransactionIDs) <> 0 AND LEFT.Exception_Code <> '' => ds_excep_DTE,
																			  ds_excep_blank);
              SELF.result.fdcheckingindicator := left.FDGatewayCalled;
              SELF._Header.Status := (INTEGER)left.Status_Code;
              SELF._Header.Message := left.Message;
              SELF._Header.TransactionID := left.TransactionID;
              SELF._Header := [];
	));

invalid_input_xml_response := project(search_results,
		transform(iesp.riskview2.t_RiskView2Response,
				self.Result.InputEcho := search;
				SELF := [];
	));

riskview_xml := if(input_ok, valid_riskview_xml_response, invalid_input_xml_response);		

output( riskview_xml, named( 'Results' ) );
// output(LnJ_liens, named('LnJ_liens'));
// output(LnJ_jdgmts, named('LnJ_jdgmts'));
// output(LnJReport, named('LnJReport'));
MLA_royalties := IF(TestDataEnabled, Royalty.RoyaltyMLA.GetNoRoyalties(), Royalty.RoyaltyMLA.GetOnlineRoyalties(search_results_temp));
First_Data_Royalties := IF(TestDataEnabled, Royalty.RoyaltyFirst_Data.GetNoRoyalties(), Royalty.RoyaltyFirst_Data.GetOnlineRoyalties(search_results_temp));
FinalRoyalties := MLA_royalties + First_Data_Royalties;

OUTPUT(FinalRoyalties, NAMED('RoyaltySet'));

// ****************************** temporarily turn off intermediate logging in Riskview to see how much latency improves ****************************

// intermediateLog := DATASET([], Risk_Reporting.Layouts.LOG_Boca_Shell) : STORED('Intermediate_Log');

// Note: All intermediate logs must have the following name schema:
// Starts with 'LOG_' (Upper case is important!!)
// Middle part is the database name, in this case: 'log__mbs__fcra'
// Must end with '_intermediate__log'

// OUTPUT( intermediateLog, NAMED('LOG_log__mbs__fcra_intermediate__log'));
// ****************************** temporarily turn off intermediate logging in Riskview to see how much latency improves ****************************

//Log to Deltabase
Deltabase_Logging_prep := project(riskview_xml, transform(Risk_Reporting.Layouts.LOG_Deltabase_Layout_Record,
																												 self.company_id := (Integer)CompanyID,
																												 self.login_id := _LoginID,
																												 self.product_id := Risk_Reporting.ProductID.RiskView__Search_Service,
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
																												 model_count := count(option.IncludeModels.Names);
																												 self.i_model_name_1 := if(model_count >= 1, option.IncludeModels.Names[1].value, ''),
																												 //Check to see if there were models requested
																												 extra_score := model_count > 1;
																												 self.i_model_name_2 := IF(extra_score, option.IncludeModels.Names[2].value, ''),
																												 self.o_score_1    := IF(model_count != 0, (String)left.Result.Models[1].Scores[1].Value, ''),
																												 self.o_reason_1_1 := IF(model_count != 0, left.Result.Models[1].Scores[1].ScoreReasons[1].ReasonCode, ''),
																												 self.o_reason_1_2 := IF(model_count != 0, left.Result.Models[1].Scores[1].ScoreReasons[2].ReasonCode, ''),
																												 self.o_reason_1_3 := IF(model_count != 0, left.Result.Models[1].Scores[1].ScoreReasons[3].ReasonCode, ''),
																												 self.o_reason_1_4 := IF(model_count != 0, left.Result.Models[1].Scores[1].ScoreReasons[4].ReasonCode, ''),
																												 self.o_reason_1_5 := IF(model_count != 0, left.Result.Models[1].Scores[1].ScoreReasons[5].ReasonCode, ''),
																												 self.o_reason_1_6 := IF(model_count != 0, left.Result.Models[1].Scores[1].ScoreReasons[6].ReasonCode, ''),
																												 self.o_score_2    := IF(extra_score, (String)left.Result.Models[2].Scores[1].Value, ''),
																												 self.o_reason_2_1 := IF(extra_score, left.Result.Models[2].Scores[1].ScoreReasons[1].ReasonCode, ''),
																												 self.o_reason_2_2 := IF(extra_score, left.Result.Models[2].Scores[1].ScoreReasons[2].ReasonCode, ''),
																												 self.o_reason_2_3 := IF(extra_score, left.Result.Models[2].Scores[1].ScoreReasons[3].ReasonCode, ''),
																												 self.o_reason_2_4 := IF(extra_score, left.Result.Models[2].Scores[1].ScoreReasons[4].ReasonCode, ''),
																												 self.o_reason_2_5 := IF(extra_score, left.Result.Models[2].Scores[1].ScoreReasons[5].ReasonCode, ''),
																												 self.o_reason_2_6 := IF(extra_score, left.Result.Models[2].Scores[1].ScoreReasons[6].ReasonCode, ''),
																												 self.o_lexid      := (Integer)left.Result.UniqueId,
																												 self := left,
																												 self := [] ));
Deltabase_Logging := DATASET([{Deltabase_Logging_prep}], Risk_Reporting.Layouts.LOG_Deltabase_Layout);
// #stored('Deltabase_Log', Deltabase_Logging);

suppress_condition := IF(riskview_xml[1].Result.Consumer.Inquiry = ROW([], iesp.share_fcra.t_FcraConsumerInquiry) AND ExcludeStatusRefresh = FALSE AND IncludeStatusRefreshChecks = TRUE, TRUE, FALSE);
//Improved Scout Logging
IF(~DisableOutcomeTracking and ~TestDataEnabled AND ~suppress_condition, OUTPUT(Deltabase_Logging, NAMED('LOG_log__mbs__fcra_transaction__log__scout')));

#end

/*--HELP-- 
<pre>
&lt;RiskView2Request&gt;
  &lt;Row&gt;
    &lt;SearchBy&gt;
      &lt;UniqueID&gt;&lt;/UniqueID&gt;
      &lt;Name&gt;
        &lt;Full&gt;&lt;/Full&gt;
        &lt;Prefix&gt;&lt;/Prefix&gt;
        &lt;First&gt;&lt;/First&gt;
        &lt;Middle&gt;&lt;/Middle&gt;
        &lt;Last&gt;&lt;/Last&gt;
        &lt;Suffix&gt;&lt;/Suffix&gt;
      &lt;/Name&gt;
      &lt;Address&gt;
        &lt;StreetAddress1&gt;&lt;/StreetAddress1&gt;
        &lt;City&gt;&lt;/City&gt;
        &lt;State&gt;&lt;/State&gt;
        &lt;Zip5&gt;&lt;/Zip5&gt;
        &lt;County&gt;&lt;/County&gt;
        &lt;StreetNumber&gt;&lt;/StreetNumber&gt;
        &lt;StreetPreDirection&gt;&lt;/StreetPreDirection&gt;
        &lt;StreetName&gt;&lt;/StreetName&gt;
        &lt;StreetSuffix&gt;&lt;/StreetSuffix&gt;
        &lt;StreetPostDirection&gt;&lt;/StreetPostDirection&gt;
        &lt;UnitNumber&gt;&lt;/UnitNumber&gt;
        &lt;UnitDesignation&gt;&lt;/UnitDesignation&gt;
      &lt;/Address&gt;
      &lt;DOB&gt;
        &lt;Year&gt;&lt;/Year&gt;
        &lt;Month&gt;&lt;/Month&gt;
        &lt;Day&gt;&lt;/Day&gt;
      &lt;/DOB&gt;
      &lt;SSN&gt;&lt;/SSN&gt;
      &lt;HomePhone&gt;&lt;/HomePhone&gt;
      &lt;WorkPhone&gt;&lt;/WorkPhone&gt;
      &lt;DriverLicenseNumber&gt;&lt;/DriverLicenseNumber&gt;
      &lt;DriverLicenseState&gt;&lt;/DriverLicenseState&gt;
    &lt;/SearchBy&gt;  
    &lt;Options&gt;
      &lt;AttributesVersionRequest&gt;RiskViewAttrV5&lt;/AttributesVersionRequest&gt;
      &lt;IntendedPurpose&gt;&lt;/IntendedPurpose&gt;
      &lt;IncludeReport&gt;&lt;/IncludeReport&gt;
      &lt;IncludeModels&gt;
       &lt;Names&gt;
         &lt;Name&gt;&lt;/Name&gt;
       &lt;/Names&gt;
       &lt;ModelOptions&gt;
        &lt;ModelOption&gt;
         &lt;OptionName&gt;inpersonapplicant&lt;/OptionName&gt;
         &lt;OptionValue&gt;0&lt;/OptionValue&gt;
        &lt;/ModelOption&gt;
       &lt;/ModelOptions&gt;
     &lt;/IncludeModels&gt;
		&lt;FFDOptionsMask&gt;&lt;/FFDOptionsMask&gt;
		&lt;IncludeLiensJudgmentsReport&gt;&lt;/IncludeLiensJudgmentsReport&gt;
		&lt;LiensJudgmentsReportOptions&gt;
		 &lt;IncludeRecordsWithSSN&gt;&lt;/IncludeRecordsWithSSN&gt;
		 &lt;IncludeBureauRecs&gt;&lt;/IncludeBureauRecs&gt;
   &lt;ReportingPeriod&gt;&lt;/ReportingPeriod&gt;
		 &lt;ExcludeCityTaxLiens&gt;&lt;/ExcludeCityTaxLiens&gt;
		 &lt;ExcludeCountyTaxLiens&gt;&lt;/ExcludeCountyTaxLiens&gt;
		 &lt;ExcludeStateTaxWarrants&gt;&lt;/ExcludeStateTaxWarrants&gt;
		 &lt;ExcludeStateTaxLiens&gt;&lt;/ExcludeStateTaxLiens&gt;
		 &lt;ExcludeFederalTaxLiens&gt;&lt;/ExcludeFederalTaxLiens&gt;
		 &lt;ExcludeOtherLiens&gt;&lt;/ExcludeOtherLiens&gt;
		 &lt;ExcludeJudgments&gt;&lt;/ExcludeJudgments&gt;
		 &lt;ExcludeEvictions&gt;&lt;/ExcludeEvictions&gt;
    &lt;/LiensJudgmentsReportOptions&gt
    &lt;/Options&gt;
    &lt;User&gt;
      &lt;ReferenceCode&gt;&lt;/ReferenceCode&gt;
      &lt;BillingCode&gt;&lt;/BillingCode&gt;
      &lt;QueryId&gt;&lt;/QueryId&gt;
      &lt;AccountNumber&gt;&lt;/AccountNumber&gt;
      &lt;GLBPurpose&gt;5&lt;/GLBPurpose&gt;
      &lt;DLPurpose&gt;0&lt;/DLPurpose&gt;
      &lt;DataRestrictionMask&gt;&lt;/DataRestrictionMask&gt; 
      &lt;DataPermissionMask&gt;&lt;/DataPermissionMask&gt; 
      &lt;TestDataEnabled&gt;0&lt;/TestDataEnabled&gt; 
      &lt;TestDataTableName&gt;&lt;/TestDataTableName&gt; 
    &lt;/User&gt;
  &lt;/Row&gt;
&lt;/RiskView2Request&gt;
</pre>
*/
 
ENDMACRO;
